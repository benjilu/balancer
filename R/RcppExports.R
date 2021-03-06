# Generated by using Rcpp::compileAttributes() -> do not edit by hand
# Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#' Accelerated proximal gradient method
#'
#' @param grad_ptr Pointer to gradient function
#' @param prox_ptr Pointer to prox function
#' @param loss_opts List of options for loss (input data, tuning params, etc.)
#' @param prox_opts List of options for prox (regularization parameter)
#' @param x Initial value
#' @param max_it Maximum number of iterations
#' @param eps Convergence tolerance
#' @param beta Backtracking line search parameter
#' @param verbose How much information to print
#'
#' @return Optimal value
#' @export
apg <- function(grad_ptr, prox_ptr, loss_opts, prox_opts, x, max_it, eps, alpha, beta, accel, verbose) {
    .Call('_balancer_apg', PACKAGE = 'balancer', grad_ptr, prox_ptr, loss_opts, prox_opts, x, max_it, eps, alpha, beta, accel, verbose)
}

#' Accelerated proximal gradient method
#'
#' @param grad_ptr Pointer to gradient function
#' @param prox_ptr Pointer to prox function
#' @param loss_opts List of options for loss (input data, tuning params, etc.)
#' @param prox_opts List of options for prox (regularization parameter)
#' @param lams Vector of hyperparameters to use
#' @param x Initial value
#' @param max_it Maximum number of iterations
#' @param eps Convergence tolerance
#' @param beta Backtracking line search parameter
#' @param verbose How much information to print
#'
#' @return Optimal value
#' @export
apg_warmstart <- function(grad_ptr, prox_ptr, loss_opts, prox_opts, lams, x, max_it, eps, alpha, beta, accel, verbose) {
    .Call('_balancer_apg_warmstart', PACKAGE = 'balancer', grad_ptr, prox_ptr, loss_opts, prox_opts, lams, x, max_it, eps, alpha, beta, accel, verbose)
}

#' Generic balancing loss gradient
balancing_grad_att <- function(theta, opts) {
    .Call('_balancer_balancing_grad_att', PACKAGE = 'balancer', theta, opts)
}

make_balancing_grad_att <- function() {
    .Call('_balancer_make_balancing_grad_att', PACKAGE = 'balancer')
}

#' Generic balancing loss gradient
balancing_grad_multilevel <- function(theta, opts) {
    .Call('_balancer_balancing_grad_multilevel', PACKAGE = 'balancer', theta, opts)
}

make_balancing_grad_multilevel <- function() {
    .Call('_balancer_make_balancing_grad_multilevel', PACKAGE = 'balancer')
}

#' Gradient for standardization
balancing_grad_standardize <- function(theta, opts) {
    .Call('_balancer_balancing_grad_standardize', PACKAGE = 'balancer', theta, opts)
}

make_balancing_grad_standardize <- function() {
    .Call('_balancer_make_balancing_grad_standardize', PACKAGE = 'balancer')
}

#' Generic balancing loss gradient
balancing_grad <- function(theta, opts) {
    .Call('_balancer_balancing_grad', PACKAGE = 'balancer', theta, opts)
}

make_balancing_grad <- function() {
    .Call('_balancer_make_balancing_grad', PACKAGE = 'balancer')
}

#' Internal function to compute a gram matrix between X and Y
#' @param X, Y, matrices
#' @param kernel Kernel function
#' @param param Hyper parameter for the kernel
NULL

#' Polynomial kernel
#' @param x,y Input vectors
#' @param d Degree of polynomial
poly_kernel <- function(x, y, d) {
    .Call('_balancer_poly_kernel', PACKAGE = 'balancer', x, y, d)
}

#' Radial Basis Function kernel
#' @param x,y Input vectors
#' @param sig
rbf_kernel <- function(x, y, sig) {
    .Call('_balancer_rbf_kernel', PACKAGE = 'balancer', x, y, sig)
}

#' Compute a gram matrix between X and Y
#' for a given kernel
#' @param X, Y, matrices
#' @param kernel Name of kernel
#' @param param Hyper parameter for the kernel
compute_gram <- function(X, Y, kernel, param) {
    .Call('_balancer_compute_gram', PACKAGE = 'balancer', X, Y, kernel, param)
}

#' L1 Prox for multilevel model, separate for global/local params + intercepts
#'
#' @param x Input matrix (two sets of parameters x = U + V)
#' @param lam Prox scaling factor
#' @param opts List of options (opts["lam"] holds the other scaling
#'
#' @return soft thresholded parameters with different soft thresholds
#' [[Rcpp::export]]
NULL

make_no_prox <- function() {
    .Call('_balancer_make_no_prox', PACKAGE = 'balancer')
}

#' L1 Prox
#'
#' @param x Input matrix
#' @param lam Prox scaling factor
#' @param opts List of options (opts["lam"] holds the other scaling
#'
#' @return Soft thresholded X
prox_l1 <- function(x, lam, opts) {
    .Call('_balancer_prox_l1', PACKAGE = 'balancer', x, lam, opts)
}

make_prox_l1 <- function() {
    .Call('_balancer_make_prox_l1', PACKAGE = 'balancer')
}

#' L1 Prox ignoring intercept
#'
#' @param x Input matrix ([intercept, coefs])
#' @param lam Prox scaling factor
#' @param opts List of options (opts["lam"] holds the other scaling
#'
#' @return soft thresholded U + group-thresholded V
prox_l1_normalized <- function(x, lam, opts) {
    .Call('_balancer_prox_l1_normalized', PACKAGE = 'balancer', x, lam, opts)
}

make_prox_l1_normalized <- function() {
    .Call('_balancer_make_prox_l1_normalized', PACKAGE = 'balancer')
}

#' Group L1 Prox
#'
#' @param x Input matrix
#' @param lam Prox scaling factor
#' @param opts List of options (opts["lam"] holds the other scaling
#'
#' @return Group soft thresholded X
prox_l1_grp <- function(x, lam, opts) {
    .Call('_balancer_prox_l1_grp', PACKAGE = 'balancer', x, lam, opts)
}

make_prox_l1_grp <- function() {
    .Call('_balancer_make_prox_l1_grp', PACKAGE = 'balancer')
}

#' Group L1 Prox ignoring intercept
#'
#' @param x Input matrix
#' @param lam Prox scaling factor
#' @param opts List of options (opts["lam"] holds the other scaling
#'
#' @return Group soft thresholded X
prox_l1_grp_normalized <- function(x, lam, opts) {
    .Call('_balancer_prox_l1_grp_normalized', PACKAGE = 'balancer', x, lam, opts)
}

make_prox_l1_grp_normalized <- function() {
    .Call('_balancer_make_prox_l1_grp_normalized', PACKAGE = 'balancer')
}

#' L2 Prox
#'
#' @param x Input matrix
#' @param lam Prox scaling factor
#' @param opts List of options (opts["lam"] holds the other scaling
#'
#' @return Column soft thresholded X
prox_l2 <- function(x, lam, opts) {
    .Call('_balancer_prox_l2', PACKAGE = 'balancer', x, lam, opts)
}

make_prox_l2 <- function() {
    .Call('_balancer_make_prox_l2', PACKAGE = 'balancer')
}

#' L2 Prox ignoring intercept
#'
#' @param x Input matrix ([intercept, coefs])
#' @param lam Prox scaling factor
#' @param opts List of options (opts["lam"] holds the other scaling
#'
#' @return soft thresholded U + group-thresholded V
prox_l2_normalized <- function(x, lam, opts) {
    .Call('_balancer_prox_l2_normalized', PACKAGE = 'balancer', x, lam, opts)
}

make_prox_l2_normalized <- function() {
    .Call('_balancer_make_prox_l2_normalized', PACKAGE = 'balancer')
}

#' Squared L2 Prox
#'
#' @param x Input matrix
#' @param lam Prox scaling factor
#' @param opts List of options (opts["lam"] holds the other scaling
#'
#' @return Column soft thresholded X
prox_l2_sq <- function(x, lam, opts) {
    .Call('_balancer_prox_l2_sq', PACKAGE = 'balancer', x, lam, opts)
}

make_prox_l2_sq <- function() {
    .Call('_balancer_make_prox_l2_sq', PACKAGE = 'balancer')
}

#' Squared L2 Prox ignoring intercept
#'
#' @param x Input matrix ([intercept, coefs])
#' @param lam Prox scaling factor
#' @param opts List of options (opts["lam"] holds the other scaling
#'
#' @return soft thresholded U + group-thresholded V
prox_l2_sq_normalized <- function(x, lam, opts) {
    .Call('_balancer_prox_l2_sq_normalized', PACKAGE = 'balancer', x, lam, opts)
}

make_prox_l2_sq_normalized <- function() {
    .Call('_balancer_make_prox_l2_sq_normalized', PACKAGE = 'balancer')
}

#' Prox for 1/2 x'Qx
#'
#' @param x Input matrix
#' @param lam Prox scaling factor
#' @param opts List of options (opts["lam"] holds the other scaling
#'
#' @return Column soft thresholded X
prox_l2_sq_Q <- function(x, lam, opts) {
    .Call('_balancer_prox_l2_sq_Q', PACKAGE = 'balancer', x, lam, opts)
}

make_prox_l2_sq_Q <- function() {
    .Call('_balancer_make_prox_l2_sq_Q', PACKAGE = 'balancer')
}

#' Prox for 1/2 x'Qx ignoring intercept
#'
#' @param x Input matrix ([intercept, coefs])
#' @param lam Prox scaling factor
#' @param opts List of options (opts["lam"] holds the other scaling
#'
#' @return soft thresholded U + group-thresholded V
prox_l2_sq_Q_normalized <- function(x, lam, opts) {
    .Call('_balancer_prox_l2_sq_Q_normalized', PACKAGE = 'balancer', x, lam, opts)
}

make_prox_l2_sq_Q_normalized <- function() {
    .Call('_balancer_make_prox_l2_sq_Q_normalized', PACKAGE = 'balancer')
}

#' Prox for elastic net
#'
#' @param x Input matrix
#' @param lam Prox scaling factor
#' @param opts List of options (opts["lam"] holds the other scaling
#'
#' @return Column soft thresholded X
prox_enet <- function(x, lam, opts) {
    .Call('_balancer_prox_enet', PACKAGE = 'balancer', x, lam, opts)
}

make_prox_enet <- function() {
    .Call('_balancer_make_prox_enet', PACKAGE = 'balancer')
}

#' Prox for elastic net ignoring intercept
#'
#' @param x Input matrix ([intercept, coefs])
#' @param lam Prox scaling factor
#' @param opts List of options (opts["lam"] holds the other scaling
#'
#' @return soft thresholded U + group-thresholded V
prox_enet_normalized <- function(x, lam, opts) {
    .Call('_balancer_prox_enet_normalized', PACKAGE = 'balancer', x, lam, opts)
}

make_prox_enet_normalized <- function() {
    .Call('_balancer_make_prox_enet_normalized', PACKAGE = 'balancer')
}

#' Nuclear norm prox
#'
#' @param x Input matrix
#' @param lam Prox scaling factor
#' @param opts List of options (opts["lam"] holds the other scaling
#'
#' @return Singular value soft thresholded X
prox_nuc <- function(x, lam, opts) {
    .Call('_balancer_prox_nuc', PACKAGE = 'balancer', x, lam, opts)
}

make_prox_nuc <- function() {
    .Call('_balancer_make_prox_nuc', PACKAGE = 'balancer')
}

#' Nuclear norm prox ignoring intercept
#'
#' @param x Input matrix
#' @param lam Prox scaling factor
#' @param opts List of options (opts["lam"] holds the other scaling
#'
#' @return Singular value soft thresholded X
prox_nuc_normalized <- function(x, lam, opts) {
    .Call('_balancer_prox_nuc_normalized', PACKAGE = 'balancer', x, lam, opts)
}

make_prox_nuc_normalized <- function() {
    .Call('_balancer_make_prox_nuc_normalized', PACKAGE = 'balancer')
}

#' Group L1 + L1 Prox
#'
#' @param x Input matrix (two sets of parameters x = U + V)
#' @param lam Prox scaling factor
#' @param opts List of options (opts["lam"] holds the other scaling
#'
#' @return soft thresholded U + group-thresholded V
prox_l1_grp_l1 <- function(x, lam, opts) {
    .Call('_balancer_prox_l1_grp_l1', PACKAGE = 'balancer', x, lam, opts)
}

make_prox_l1_grp_l1 <- function() {
    .Call('_balancer_make_prox_l1_grp_l1', PACKAGE = 'balancer')
}

#' Group L1 + L1 Prox ignoring intercept
#'
#' @param x Input matrix (two sets of parameters x = U + V)
#' @param lam Prox scaling factor
#' @param opts List of options (opts["lam"] holds the other scaling
#'
#' @return soft thresholded U + group-thresholded V
prox_l1_grp_l1_normalized <- function(x, lam, opts) {
    .Call('_balancer_prox_l1_grp_l1_normalized', PACKAGE = 'balancer', x, lam, opts)
}

make_prox_l1_grp_l1_normalized <- function() {
    .Call('_balancer_make_prox_l1_grp_l1_normalized', PACKAGE = 'balancer')
}

#' Nuclear norm + L1 Prox
#'
#' @param x Input matrix (two sets of parameters x = U + V)
#' @param lam Prox scaling factor
#' @param opts List of options (opts["lam"] holds the other scaling
#'
#' @return svd soft thresholded U + soft-thresholded V
prox_nuc_l1 <- function(x, lam, opts) {
    .Call('_balancer_prox_nuc_l1', PACKAGE = 'balancer', x, lam, opts)
}

make_prox_nuc_l1 <- function() {
    .Call('_balancer_make_prox_nuc_l1', PACKAGE = 'balancer')
}

#' Nuclear norm + L1 Prox ignoring intercept
#'
#' @param x Input matrix (two sets of parameters x = U + V)
#' @param lam Prox scaling factor
#' @param opts List of options (opts["lam"] holds the other scaling
#'
#' @return svd soft thresholded U + soft-thresholded V
prox_nuc_l1_normalized <- function(x, lam, opts) {
    .Call('_balancer_prox_nuc_l1_normalized', PACKAGE = 'balancer', x, lam, opts)
}

make_prox_nuc_l1_normalized <- function() {
    .Call('_balancer_make_prox_nuc_l1_normalized', PACKAGE = 'balancer')
}

#' Squared L2 Prox for multilevel model, separate for global/local params + intercepts
#'
#' @param x Input matrix (contains global and local parameters
#' @param lam Prox scaling factor
#' @param opts List of options (opts["alpha"] holds the ratio between global and local balance
#'
#' @return L2 squared prox values
prox_multilevel_ridge <- function(x, lam, opts) {
    .Call('_balancer_prox_multilevel_ridge', PACKAGE = 'balancer', x, lam, opts)
}

make_prox_multilevel_ridge <- function() {
    .Call('_balancer_make_prox_multilevel_ridge', PACKAGE = 'balancer')
}

#' Squared L2 Prox for multilevel model, separate for global/local params + intercepts
#'
#' @param x Input matrix (contains global and local parameters
#' @param lam Prox scaling factor
#' @param opts List of options (opts["alpha"] holds the ratio between global and local balance
#'
#' @return L2 squared prox values
prox_multilevel_ridge_normalized <- function(x, lam, opts) {
    .Call('_balancer_prox_multilevel_ridge_normalized', PACKAGE = 'balancer', x, lam, opts)
}

make_prox_multilevel_ridge_normalized <- function() {
    .Call('_balancer_make_prox_multilevel_ridge_normalized', PACKAGE = 'balancer')
}

#' Squared L2 Prox for global parameters, nuclear norm prox for local parameters
#'
#' @param x Input matrix (contains global and local parameters
#' @param lam Prox scaling factor
#' @param opts List of options (opts["alpha"] holds the ratio between global and local balance
#'
#' @return L2 squared prox values
prox_multilevel_ridge_nuc <- function(x, lam, opts) {
    .Call('_balancer_prox_multilevel_ridge_nuc', PACKAGE = 'balancer', x, lam, opts)
}

make_prox_multilevel_ridge_nuc <- function() {
    .Call('_balancer_make_prox_multilevel_ridge_nuc', PACKAGE = 'balancer')
}

#' Squared L2 Prox for multilevel model, separate for global/local params + intercepts
#'
#' @param x Input matrix (contains global and local parameters
#' @param lam Prox scaling factor
#' @param opts List of options (opts["alpha"] holds the ratio between global and local balance
#'
#' @return L2 squared prox values
prox_multilevel_ridge_nuc_normalized <- function(x, lam, opts) {
    .Call('_balancer_prox_multilevel_ridge_nuc_normalized', PACKAGE = 'balancer', x, lam, opts)
}

make_prox_multilevel_ridge_nuc_normalized <- function() {
    .Call('_balancer_make_prox_multilevel_ridge_nuc_normalized', PACKAGE = 'balancer')
}

#' L1 Prox for multilevel model, separate for global/local params + intercepts
#'
#' @param x Input matrix (two sets of parameters x = U + V)
#' @param lam Prox scaling factor
#' @param opts List of options (opts["lam"] holds the other scaling
#'
#' @return soft thresholded parameters with different soft thresholds
prox_l1_all <- function(x, lam, opts) {
    .Call('_balancer_prox_l1_all', PACKAGE = 'balancer', x, lam, opts)
}

make_prox_l1_all <- function() {
    .Call('_balancer_make_prox_l1_all', PACKAGE = 'balancer')
}

make_prox_l1_nuc <- function() {
    .Call('_balancer_make_prox_l1_nuc', PACKAGE = 'balancer')
}

#' Nuclear norm projection ||x||_* <= lam
#'
#' @param x Input matrix
#' @param lam Constraint on nuclear norm
#' @param opts List of options (opts["lam"] holds the other scaling
#'
#' @return Singular value soft thresholded X
proj_nuc <- function(x, lam, opts) {
    .Call('_balancer_proj_nuc', PACKAGE = 'balancer', x, lam, opts)
}

make_proj_nuc <- function() {
    .Call('_balancer_make_proj_nuc', PACKAGE = 'balancer')
}

#' Squared L2 Prox for global parameters, nuclear norm projection for local parameters
#'
#' @param x Input matrix (contains global and local parameters
#' @param lam Prox scaling factor
#' @param opts List of options (opts["alpha"] holds the ratio between global and local balance
#'
#' @return L2 squared prox values
proj_multilevel_ridge_nuc <- function(x, lam, opts) {
    .Call('_balancer_proj_multilevel_ridge_nuc', PACKAGE = 'balancer', x, lam, opts)
}

make_proj_multilevel_ridge_nuc <- function() {
    .Call('_balancer_make_proj_multilevel_ridge_nuc', PACKAGE = 'balancer')
}

#' Linear weights
lin_weights <- function(Xc, theta) {
    .Call('_balancer_lin_weights', PACKAGE = 'balancer', Xc, theta)
}

#' Linear weights
lin_weights2 <- function(eta) {
    .Call('_balancer_lin_weights2', PACKAGE = 'balancer', eta)
}

#' Linear weights
lin_weights_ipw <- function(Xc, theta, q) {
    .Call('_balancer_lin_weights_ipw', PACKAGE = 'balancer', Xc, theta, q)
}

make_lin_weights <- function() {
    .Call('_balancer_make_lin_weights', PACKAGE = 'balancer')
}

make_lin_weights2 <- function() {
    .Call('_balancer_make_lin_weights2', PACKAGE = 'balancer')
}

make_lin_weights_ipw <- function() {
    .Call('_balancer_make_lin_weights_ipw', PACKAGE = 'balancer')
}

#' normalized logit weights, numerically stable
softmax_weights <- function(Xc, theta) {
    .Call('_balancer_softmax_weights', PACKAGE = 'balancer', Xc, theta)
}

#' normalized logit weights, numerically stable
softmax_weights2 <- function(eta) {
    .Call('_balancer_softmax_weights2', PACKAGE = 'balancer', eta)
}

#' normalized logit weights, numerically stable
softmax_weights_ipw <- function(Xc, theta, q) {
    .Call('_balancer_softmax_weights_ipw', PACKAGE = 'balancer', Xc, theta, q)
}

make_softmax_weights <- function() {
    .Call('_balancer_make_softmax_weights', PACKAGE = 'balancer')
}

make_softmax_weights2 <- function() {
    .Call('_balancer_make_softmax_weights2', PACKAGE = 'balancer')
}

make_softmax_weights_ipw <- function() {
    .Call('_balancer_make_softmax_weights_ipw', PACKAGE = 'balancer')
}

#' un-normalized logit weights
exp_weights <- function(Xc, theta) {
    .Call('_balancer_exp_weights', PACKAGE = 'balancer', Xc, theta)
}

#' un-normalized logit weights
exp_weights2 <- function(eta) {
    .Call('_balancer_exp_weights2', PACKAGE = 'balancer', eta)
}

make_exp_weights <- function() {
    .Call('_balancer_make_exp_weights', PACKAGE = 'balancer')
}

make_exp_weights2 <- function() {
    .Call('_balancer_make_exp_weights2', PACKAGE = 'balancer')
}

#' un-normalized logit weights
exp_weights_ipw <- function(Xc, theta, q) {
    .Call('_balancer_exp_weights_ipw', PACKAGE = 'balancer', Xc, theta, q)
}

make_exp_weights_ipw <- function() {
    .Call('_balancer_make_exp_weights_ipw', PACKAGE = 'balancer')
}

#' Linear weights
pos_lin_weights <- function(Xc, theta) {
    .Call('_balancer_pos_lin_weights', PACKAGE = 'balancer', Xc, theta)
}

#' Linear weights
pos_lin_weights2 <- function(eta) {
    .Call('_balancer_pos_lin_weights2', PACKAGE = 'balancer', eta)
}

make_pos_lin_weights <- function() {
    .Call('_balancer_make_pos_lin_weights', PACKAGE = 'balancer')
}

make_pos_lin_weights2 <- function() {
    .Call('_balancer_make_pos_lin_weights2', PACKAGE = 'balancer')
}

#' Linear weights
pos_lin_weights_ipw <- function(Xc, theta, q) {
    .Call('_balancer_pos_lin_weights_ipw', PACKAGE = 'balancer', Xc, theta, q)
}

make_pos_lin_weights_ipw <- function() {
    .Call('_balancer_make_pos_lin_weights_ipw', PACKAGE = 'balancer')
}

