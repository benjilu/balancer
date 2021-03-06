

balancer <- function(X, trt, y=NULL,
                     Z=NULL, V=NULL,
                     type=c("att", "subgrp", "subgrp_multi"),
                     link=c("logit", "linear", "pos-linear", "pos-enet", "posenet"),
                     regularizer=c(NULL, "l1", "grpl1", "l2", "ridge", "linf", "nuc",
                                   "l1_all", "l1_nuc"),
                     lambda=NULL, nlambda=20, lambda.min.ratio=1e-3,
                     interact=F, normalized=TRUE, alpha=1, Q=NULL,
                     ipw_weights=NULL, mu0=NULL,
                     opts=list()) {
    #' Find Balancing weights by solving the dual optimization problem
    #' @param X n x d matrix of covariates
    #' @param trt Vector of treatment status indicators
    #' @param y Vector of outcomes to estimate effect(s). If NULL then only return weights
    #' @param Z Vector of subgroup indicators or observed indicators
    #' @param V Group level covariates
    #' @param type Find balancing weights for ATT, subgroup ATTs,
    #'             subgroup ATTs with multilevel p-score, multilevel observational studies,
    #'             ATT with missing outcomes, and heterogeneous effects
    #' @param link Link function for weights
    #' @param regularizer Dual of balance criterion
    #' @param lambda Regularization hyperparameter
    #' @param nlambda Number of hyperparameters to consider
    #' @param lambda.min.ratio Smallest value of hyperparam to consider, as proportion of smallest
    #'                         value that gives the reference weights
    #' @param interact Whether to interact group and individual level covariates
    #' @param normalized Whether to normalize the weights
    #' @param alpha Elastic net parameter \eqn{\frac{1-\alpha}{2}\|\beta\|_2^2 + \alpha\|\beta\|_1}, defaults to 1
    #' @param Q Matrix for generalized ridge, if null then use inverse covariance matrix
    #' @param ipw_weights Separately estimated IPW weights to measure dispersion against, default is NULL
    #' @param mu0 Optional estimates of the potential outcome under control, default is NULL
    #' @param opts Optimization options
    #'        \itemize{
    #'          \item{MAX_ITERS }{Maximum number of iterations to run}
    #'          \item{EPS }{Error rolerance}
    #'          \item{alpha }{Elastic net parameter}}
    #'
    #' @return \itemize{
    #'          \item{theta }{Estimated dual propensity score parameters}
    #'          \item{weights }{Estimated primal weights}
    #'          \item{imbalance }{Imbalance in covariates}}
    #' @export

    ## map string args to actual params
    params <- map_to_param(X, link, regularizer, ipw_weights, normalized, Q, alpha)
    weightfunc <- params[[1]]
    weightptr <- params[[2]]
    proxfunc <- params[[3]]
    balancefunc <- params[[4]]
    prox_opts <- params[[5]]

    
    prep <- preprocess(X, trt, ipw_weights, type, link, normalized)
    X <- prep$X
    ipw_weights <- prep$ipw_weights


    if(type == "att") {
        out <- balancer_att(X, trt, y, weightfunc, weightptr,
                            proxfunc, balancefunc, lambda,
                            nlambda, lambda.min.ratio,
                            ipw_weights, mu0, opts, prox_opts)
    } ## else if(type == "subgrp") {
    ##     out <- balancer_subgrp(X, trt, Z, weightfunc, weightptr,
    ##                             proxfunc, lambda, ridge, Q, NULL, NULL, opts)
    ## } 
    else if(type == "subgrp_multi") {
        out <- balancer_multi(X, V, trt, Z, weightfunc, weightptr,
                              proxfunc, balancefunc, lambda, nlambda,
                              lambda.min.ratio, ipw_weights, interact,
                              opts, prox_opts)
    } else {
        stop("type must be one of ('att', 'subgrp', 'subgrp_multi')")
    }

    return(out)
}


balancer_att <- function(X, trt, y=NULL, weightfunc, weightfunc_ptr,
                         proxfunc, balancefunc, lambda=NULL,
                         nlambda=20, lambda.min.ratio=1e-3,
                         ipw_weights=NULL, mu0=NULL, opts=list(),
                         prox_opts=list()) {
    #' Balancing weights for ATT (in subgroups)
    #' @param X n x d matrix of covariates
    #' @param trt Vector of treatment status indicators
    #' @param y Vector of outcomes to estimate effect(s). If NULL then only return weights    
    #' @param weightfunc Derivative of convex conjugate of dispersion function (possibly normalized)
    #' @param weightfunc_ptr Pointer to weightfunc
    #' @param proxfunc Prox operator of regularization function
    #' @param balancefunc Balance criterion measure
    #' @param lambda Regularization hyper parameter
    #' @param nlambda Number of hyperparameters to consider
    #' @param lambda.min.ratio Smallest value of hyperparam to consider, as proportion of smallest
    #'                         value that gives the reference weights
    #' @param ipw_weights Separately estimated IPW weights to measure dispersion against, default is NULL
    #' @param mu0 Optional estimates of the potential outcome under control, default is NULL
    #' @param opts Optimization options
    #'        \itemize{
    #'          \item{MAX_ITERS }{Maximum number of iterations to run}
    #'          \item{EPS }{Error rolerance}}
    #' @param prox_opts List of additional arguments for prox
    #'
    #' @return \itemize{
    #'          \item{theta }{Estimated dual propensity score parameters}
    #'          \item{weights }{Estimated primal weights}
    #'          \item{imbalance }{Imbalance in covariates}}

    n <- dim(X)[1]

    d <- dim(X)[2]

    x_t <- matrix(colMeans(X[trt==1,,drop=FALSE]), nrow=d)

    Xc <- X[trt==0,,drop=FALSE]

    ipw_weights <- ipw_weights[trt==0,,drop=F]
    
    loss_opts = list(Xc=Xc,
                     Xt=x_t,
                     weight_func=weightfunc_ptr,
                     ipw_weights=ipw_weights
                     )
    

    ## initialize at 0 if no initialization is passed
    init <- matrix(0, nrow=d, ncol=1)

    ## combine opts with defaults
    opts <- c(opts,
              list(max_it=5000,
                   eps=1e-8,
                   alpha=1.01, beta=.9,
                   accel=T,
                   x=init,
                   verbose=F))
    
    
    ## if hyperparam is NULL, start from reference weights and decrease
    if(is.null(lambda)) {
        lam0 <- balancefunc(balancing_grad_att(init, loss_opts))
        lam1 <- lam0 * lambda.min.ratio
        ## decrease on log scale
        lambda <- exp(seq(log(lam0), log(lam1), length.out=nlambda))
    }


    ## collect results
    out <- list()
    out$theta <- matrix(,nrow=d, ncol=length(lambda))
    out$imbalance <- matrix(,nrow=d, ncol=length(lambda))    
    out$weights <- matrix(0, nrow=n, ncol=length(lambda))
    out$weightfunc <- weightfunc


    ## with multiple hyperparameters do warm starts        
    prox_opts = c(prox_opts,
                  list(lam=1))


    apgout <- apg_warmstart(make_balancing_grad_att(),
                            proxfunc, loss_opts, prox_opts,
                            lambda,
                            opts$x, opts$max_it, opts$eps,
                            opts$alpha, opts$beta, opts$accel, opts$verbose)

    ## weights and theta
    out$theta <- do.call(cbind, apgout)
    out$weights[trt==0,] <- apply(out$theta, 2,
                                  function(th) weightfunc(X[trt==0,,drop=F], as.matrix(th), ipw_weights))
    
    out$imbalance <- apply(out$theta, 2,
                           function(th) balancing_grad_att(as.matrix(th), loss_opts))

    out$lambda <- lambda

    ## estimate treatment effect(s)

    ## outcome model
    if(is.null(mu0)) {
        mu0 <- rep(0, nrow(X))
    }

    ## divide by sum of weights for stability
    if(!is.null(y)) {
        out$att <- mean(y[trt==1] - mu0[trt==1]) -
            as.vector(t(y - mu0) %*% out$weights) / colSums(out$weights)
    } else {
        out$att <- NULL
    }
    return(out)

}


balancer_subgrp <- function(X, trt, Z=NULL, weightfunc, weightfunc_ptr,
                            proxfunc, hyperparam, ridge, Q=NULL, kernel, kern_param=1,
                            ipw_weights=NULL, opts=list()) {
    #' Balancing weights for ATT (in subgroups)
    #' @param X n x d matrix of covariates
    #' @param trt Vector of treatment status indicators
    #' @param Z Vector of subgroup indicators    
    #' @param weightfunc Derivative of convex conjugate of dispersion function (possibly normalized)
    #' @param weightfunc_ptr Pointer to weightfunc
    #' @param proxfunc Prox operator of regularization function, or "ridge"
    #' @param hyperparam Regularization hyper parameter
    #' @param ridge Whether to use L2 penalty in dual
    #' @param Q m x m matrix to tie together ridge penalty, default: NULL,
    #'          if TRUE, use covariance of treated groups
    #' @param kernel What kernel to use, default NULL
    #' @param kern_param Hyperparameter for kernel
    #' @param ipw_weights Separately estimated IPW weights to measure dispersion against, default is NULL
    #' @param opts Optimization options
    #'        \itemize{
    #'          \item{MAX_ITERS }{Maximum number of iterations to run}
    #'          \item{EPS }{Error rolerance}}
    #'
    #' @return \itemize{
    #'          \item{theta }{Estimated dual propensity score parameters}
    #'          \item{weights }{Estimated primal weights}
    #'          \item{imbalance }{Imbalance in covariates}}

    ## if no subgroups, put everything into one group
    if(is.null(Z)) {
        Z <- rep(1, length(trt))
    }
    ## get the distinct group labels
    grps <- sort(unique(Z))
    m <- length(grps)

    n <- dim(X)[1]

    ## if(normalized) {
    ##     ## add a bias term
    ##     X <- cbind(rep(1, n), X)
    ## }

    d <- dim(X)[2]

    ## ##if no kernel use linear features
    ## if(is.null(kernel)) {
    ## get the group treated moments
    x_t <- sapply(grps,
                  function(k) colMeans(X[(trt ==1) & (Z==k), , drop=FALSE]))
    x_t <- as.matrix(x_t)
    
    Xc <- X[trt==0,,drop=FALSE]

    loss_opts = list(Xc=Xc,
                     Xt=x_t,
                     weight_func=weightfunc_ptr,
                     weight_type="subgroup",
                     z=Z[trt==0],
                     ridge=ridge,
                     ipw_weights=ipw_weights[trt==0,,drop=F]
                     )

    ## if ridge, make the identity matrix
    if(ridge) {
        loss_opts$hyper <- hyperparam
        if(!is.null(Q)) { 
            loss_opts$hasQ <- TRUE
            if(Q) {
                loss_opts$Q <- t(x_t)
            } else {
                loss_opts$Q <- Q
            }
        } else {
            loss_opts$hasQ <- FALSE
        }
    }
    
    ## indices of subgroups
    ctrl_z = Z[trt==0]
    loss_opts$z_ind <- lapply(grps, function(k) which(ctrl_z==k)-1)

    if(m==1) {
        loss_opts$weight_type="base"
    }

    if(length(hyperparam) == 1) {
        prox_opts = list(lam=hyperparam)
    } else if(length(hyperparam) == 2) {
        prox_opts = list(lam1=list(lam=hyperparam[1]),
                         lam2=list(lam=hyperparam[2]))
    } else {
        stop("hyperparam must be length 1 or 2")
    }

    ## initialize at 0
    init = matrix(0, nrow=d, ncol=m)

    ## combine opts with defauls
    opts <- c(opts,
              list(max_it=5000,
                   eps=1e-8,
                   alpha=1.01, beta=.9,
                   accel=T,
                   x=init,
                   verbose=F))
    if(is.null(kernel)) {
        apgout <- apg(make_balancing_grad(), proxfunc, loss_opts, prox_opts,
                      opts$x, opts$max_it, opts$eps, opts$alpha, opts$beta, opts$accel, opts$verbose)
    } else {
        apgout <- apg(make_balancing_grad_kern(), proxfunc, loss_opts, prox_opts,
                      opts$x, opts$max_it, opts$eps, opts$alpha, opts$beta, opts$accel, opts$verbose)
    }
                  

    ## collect results
    out <- list()

    ## theta
    theta <- apgout
    out$theta <- theta
    ## weights
    weights <- numeric(n)
    if(m == 1) {
        weights[trt==0] <- weightfunc(X[trt==0,,drop=F], theta, ipw_weights)
    } else {
        for(i in 1:m) {
            k = grps[i]
            weights[(trt == 0) & (Z == k)] <-
                weightfunc(X[(trt == 0) & (Z == k), , drop=FALSE], theta[,i,drop=FALSE])
        }
    }
    out$weights <- weights

    ## The final imbalance
    loss_opts$ridge <- F
    out$imbalance <- balancing_grad(theta, loss_opts)
    out$weightfunc <- weightfunc
    return(out)
}





map_to_param <- function(X, link=c("logit", "linear", "pos-linear", "pos-enet", "posenet"),
                         regularizer=c(NULL, "l1", "grpl1", "l2", "ridge", "linf", "nuc",
                                       "l1_all", "l1_nuc"),
                         ipw_weights=NULL,
                         normalized=F, Q=NULL, alpha=1) {
    #' Map string choices to the proper parameters for the balancer sub-functions
    #' @param X n x d matrix of covariates
    #' @param type Find balancing weights for ATT, subgroup ATTs,
    #'             subgroup ATTs with multilevel p-score, multilevel observational studies,
    #'             ATT with missing outcomes, and heterogeneous effects
    #' @param link Link function for weights
    #' @param regularizer Dual of balance criterion
    #' @param normalized Whether to normalize the weights
    #' @param Q Matrix for generalized ridge, if null then use inverse covariance matrix
    #' @param alpha Elastic net parameter \eqn{\frac{1-\alpha}{2}\|\beta\|_2^2 + \alpha\|\beta\|_1}, defaults to 1
    #'
    #' @return Parameters for balancer
    
    
    if(link == "logit") {
        if(normalized) {
            weightfunc <- softmax_weights_ipw
        weightptr <- make_softmax_weights_ipw()
        } else {
            weightfunc <- exp_weights_ipw
            weightptr <- make_exp_weights_ipw()
        }
    } else if(link == "linear") {
        weightfunc <- lin_weights_ipw
        weightptr <- make_lin_weights_ipw()
    } else if(link == "pos-linear") {
        weightfunc <- pos_lin_weights_ipw
        weightptr <- make_pos_lin_weights_ipw()        
    } else if(link == "enet") {
        stop("Elastic Net not impleneted")
    } else if(link == "pos-enet") {
        stop("Elastic Net not impleneted")
    } else {
        stop("link must be one of ('logit', 'linear', 'pos-linear')")
    }


    prox_opts <- list(alpha=alpha)
    
    if(is.null(regularizer)) {
        proxfunc <- make_no_prox()
    } else if(regularizer == "l1") {
        proxfunc <- if(normalized) make_prox_l1_normalized() else make_prox_l1()
        balancefunc <- linf
    } else if(regularizer == "grpl1") {
        proxfunc <- if(normalized) make_prox_l1_grp_normalized() else make_prox_l1_grp()
        balancefunc <- linf_grp
    } else if(regularizer == "l1grpl1") {
        proxfunc <- if(normalized) make_prox_l1_grp_l1_normalized() else make_prox_l1_grp_l1()
        ## double the covariate matrix to include two sets of parameters
        X <- cbind(X,X)
        balancefunc <- linf_grp_linf
    } else if(regularizer == "l2") {
        proxfunc <- if(normalized) make_prox_l2_normalized() else make_prox_l2()
        balancefunc <- l2
    } else if(regularizer == "ridge") {
        proxfunc <- if(normalized) make_prox_l2_sq_normalized() else make_prox_l2_sq()
        ## balancefunc <- l2sq
        balancefunc <- function(x) (1 + l2(x))^2
    } else if (regularizer=="mahal") {
        proxfunc <- if(normalized) make_prox_l2_sq_Q_normalized() else make_prox_l2_Q_sq()
        if(is.null(Q)) {
            ## use inverse covariance matrix of Q is null
            ## just do svd once
            Xsvd <- svd(X)
            prox_opts$evec <- Xsvd$v
            prox_opts$eval <- 1 / (Xsvd$d^2 / nrow(X))
            Q <- prox_opts$evec %*% diag(prox_opts$eval) %*% t(prox_opts$evec)
        } else {
            ## eigendecomposition once
            Qsvd <- eigen(Q)
            prox_opts$evec <- Qsvd$vectors
            prox_opts$eval <- Qsvd$values
        }

        if(normalized) {
            Q <- rbind(0, cbind(0, Q))
        }
        balancefunc <- function(x) l2Q(x, Q)

    } else if(regularizer == "enet") {
        proxfunc <- if(normalized) make_prox_enet_normalized() else make_prox_enet()
        balancefunc <- function(x) (1 - alpha) * (1 + l2(x))^2 + alpha * linf(x)
    }else if(regularizer == "linf") {
        stop("L infinity regularization not implemented")
    } else if(regularizer == "nuc") {
        proxfunc <- if(normalized) make_prox_nuc_normalized()else make_prox_nuc()
        balancefunc <- op_norm
    } else if(regularizer == "nucl1") {
        proxfunc <- if(normalized) make_prox_nuc_l1_normalized() else make_prox_nuc_l1()
        ## double the covariate matrix to include two sets of parameters
        X <- cbind(X,X)
        balancefunc <- linf_op
    } else if(regularizer == "l1_all") {
        proxfunc <- make_prox_l1_all()
    } else if(regularizer == "l1_nuc") {
        proxfunc <- make_prox_l1_nuc()
    } else if(regularizer == "ridge_multi") {
        proxfunc <- if(normalized) make_prox_multilevel_ridge_normalized() else make_prox_multilevel_ridge()
        balancefunc <- function(x) {
            (1 - alpha) * (1 + balancer:::l2(x[,1]))^2 +
                alpha * (1 + balancer:::l2(x[,1]))^2
            }
    } else if(regularizer == "nuc_multi") {
        proxfunc <- if(normalized) make_prox_multilevel_ridge_nuc_normalized() else make_prox_multilevel_ridge_nuc()
        balancefunc <- function(x) balancer:::op_norm(x[,-1]) / alpha
    } else {
        stop("regularizer must be one of (NULL, 'l1', 'grpl1', 'l1grpl1', 'ridge', 'linf', 'nuc', 'nucl1')")
    }
    return(list(weightfunc, weightptr, proxfunc, balancefunc, prox_opts))
}


#' Preprocess covariates
#' 
#' @param X n x d matrix of covariates
#' @param trt Vector of treatment status indicators
#' @param ipw_weights Optional ipw weights to measure dispersion against
#' @param type Find balancing weights for ATT, subgroup ATTs,
#'             subgroup ATTs with multilevel p-score, multilevel observational studies,
#'             ATT with missing outcomes, and heterogeneous effects#'
#' @param link Link function for weights
#' @param normalized Whether to normalize the weights
#'
#' @return Processed covariate matrix
preprocess <- function(X, trt, ipw_weights, type, link, normalized) {

    ## ## center covariates by control means
    ## if(type == "att") {
    ##     X <- apply(X, 2, function(x) x - mean(x[trt==0]))
    ## }

    if(is.null(ipw_weights)) {
        ipw_weights = matrix(1/sum(trt==0), length(trt), 1)    
    } else {
        ipw_weights = matrix(ipw_weights, length(trt), 1)    
    }
    
    ## add intercept
    if(normalized) {
        ## X <- cbind(sum(trt)/sum(1-trt), X)
        X <- cbind(1, X)
    }
    return(list(X=X, ipw_weights=ipw_weights))
    
}
