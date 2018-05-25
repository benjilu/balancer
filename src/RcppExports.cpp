// Generated by using Rcpp::compileAttributes() -> do not edit by hand
// Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#include "balancer_types.h"
#include <RcppArmadillo.h>
#include <Rcpp.h>

using namespace Rcpp;

// apg
mat apg(gptr grad_ptr, pptr prox_ptr, List loss_opts, List prox_opts, mat x, int max_it, double eps, double alpha, double beta, bool accel);
RcppExport SEXP _balancer_apg(SEXP grad_ptrSEXP, SEXP prox_ptrSEXP, SEXP loss_optsSEXP, SEXP prox_optsSEXP, SEXP xSEXP, SEXP max_itSEXP, SEXP epsSEXP, SEXP alphaSEXP, SEXP betaSEXP, SEXP accelSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< gptr >::type grad_ptr(grad_ptrSEXP);
    Rcpp::traits::input_parameter< pptr >::type prox_ptr(prox_ptrSEXP);
    Rcpp::traits::input_parameter< List >::type loss_opts(loss_optsSEXP);
    Rcpp::traits::input_parameter< List >::type prox_opts(prox_optsSEXP);
    Rcpp::traits::input_parameter< mat >::type x(xSEXP);
    Rcpp::traits::input_parameter< int >::type max_it(max_itSEXP);
    Rcpp::traits::input_parameter< double >::type eps(epsSEXP);
    Rcpp::traits::input_parameter< double >::type alpha(alphaSEXP);
    Rcpp::traits::input_parameter< double >::type beta(betaSEXP);
    Rcpp::traits::input_parameter< bool >::type accel(accelSEXP);
    rcpp_result_gen = Rcpp::wrap(apg(grad_ptr, prox_ptr, loss_opts, prox_opts, x, max_it, eps, alpha, beta, accel));
    return rcpp_result_gen;
END_RCPP
}
// balancing_grad
mat balancing_grad(mat theta, List opts);
RcppExport SEXP _balancer_balancing_grad(SEXP thetaSEXP, SEXP optsSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< mat >::type theta(thetaSEXP);
    Rcpp::traits::input_parameter< List >::type opts(optsSEXP);
    rcpp_result_gen = Rcpp::wrap(balancing_grad(theta, opts));
    return rcpp_result_gen;
END_RCPP
}
// make_balancing_grad
gptr make_balancing_grad();
RcppExport SEXP _balancer_make_balancing_grad() {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    rcpp_result_gen = Rcpp::wrap(make_balancing_grad());
    return rcpp_result_gen;
END_RCPP
}
// balancing_grad_kern
mat balancing_grad_kern(mat theta, List opts);
RcppExport SEXP _balancer_balancing_grad_kern(SEXP thetaSEXP, SEXP optsSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< mat >::type theta(thetaSEXP);
    Rcpp::traits::input_parameter< List >::type opts(optsSEXP);
    rcpp_result_gen = Rcpp::wrap(balancing_grad_kern(theta, opts));
    return rcpp_result_gen;
END_RCPP
}
// make_balancing_grad_kern
gptr make_balancing_grad_kern();
RcppExport SEXP _balancer_make_balancing_grad_kern() {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    rcpp_result_gen = Rcpp::wrap(make_balancing_grad_kern());
    return rcpp_result_gen;
END_RCPP
}
// poly_kernel
double poly_kernel(mat x, mat y, double d);
RcppExport SEXP _balancer_poly_kernel(SEXP xSEXP, SEXP ySEXP, SEXP dSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< mat >::type x(xSEXP);
    Rcpp::traits::input_parameter< mat >::type y(ySEXP);
    Rcpp::traits::input_parameter< double >::type d(dSEXP);
    rcpp_result_gen = Rcpp::wrap(poly_kernel(x, y, d));
    return rcpp_result_gen;
END_RCPP
}
// rbf_kernel
double rbf_kernel(mat x, mat y, double sig);
RcppExport SEXP _balancer_rbf_kernel(SEXP xSEXP, SEXP ySEXP, SEXP sigSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< mat >::type x(xSEXP);
    Rcpp::traits::input_parameter< mat >::type y(ySEXP);
    Rcpp::traits::input_parameter< double >::type sig(sigSEXP);
    rcpp_result_gen = Rcpp::wrap(rbf_kernel(x, y, sig));
    return rcpp_result_gen;
END_RCPP
}
// compute_gram
mat compute_gram(mat X, mat Y, std::string kernel, double param);
RcppExport SEXP _balancer_compute_gram(SEXP XSEXP, SEXP YSEXP, SEXP kernelSEXP, SEXP paramSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< mat >::type X(XSEXP);
    Rcpp::traits::input_parameter< mat >::type Y(YSEXP);
    Rcpp::traits::input_parameter< std::string >::type kernel(kernelSEXP);
    Rcpp::traits::input_parameter< double >::type param(paramSEXP);
    rcpp_result_gen = Rcpp::wrap(compute_gram(X, Y, kernel, param));
    return rcpp_result_gen;
END_RCPP
}
// make_no_prox
pptr make_no_prox();
RcppExport SEXP _balancer_make_no_prox() {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    rcpp_result_gen = Rcpp::wrap(make_no_prox());
    return rcpp_result_gen;
END_RCPP
}
// prox_l1
mat prox_l1(mat x, double lam, List opts);
RcppExport SEXP _balancer_prox_l1(SEXP xSEXP, SEXP lamSEXP, SEXP optsSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< mat >::type x(xSEXP);
    Rcpp::traits::input_parameter< double >::type lam(lamSEXP);
    Rcpp::traits::input_parameter< List >::type opts(optsSEXP);
    rcpp_result_gen = Rcpp::wrap(prox_l1(x, lam, opts));
    return rcpp_result_gen;
END_RCPP
}
// make_prox_l1
pptr make_prox_l1();
RcppExport SEXP _balancer_make_prox_l1() {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    rcpp_result_gen = Rcpp::wrap(make_prox_l1());
    return rcpp_result_gen;
END_RCPP
}
// prox_l1_grp
mat prox_l1_grp(mat x, double lam, List opts);
RcppExport SEXP _balancer_prox_l1_grp(SEXP xSEXP, SEXP lamSEXP, SEXP optsSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< mat >::type x(xSEXP);
    Rcpp::traits::input_parameter< double >::type lam(lamSEXP);
    Rcpp::traits::input_parameter< List >::type opts(optsSEXP);
    rcpp_result_gen = Rcpp::wrap(prox_l1_grp(x, lam, opts));
    return rcpp_result_gen;
END_RCPP
}
// make_prox_l1_grp
pptr make_prox_l1_grp();
RcppExport SEXP _balancer_make_prox_l1_grp() {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    rcpp_result_gen = Rcpp::wrap(make_prox_l1_grp());
    return rcpp_result_gen;
END_RCPP
}
// prox_l2
mat prox_l2(mat x, double lam, List opts);
RcppExport SEXP _balancer_prox_l2(SEXP xSEXP, SEXP lamSEXP, SEXP optsSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< mat >::type x(xSEXP);
    Rcpp::traits::input_parameter< double >::type lam(lamSEXP);
    Rcpp::traits::input_parameter< List >::type opts(optsSEXP);
    rcpp_result_gen = Rcpp::wrap(prox_l2(x, lam, opts));
    return rcpp_result_gen;
END_RCPP
}
// make_prox_l2
pptr make_prox_l2();
RcppExport SEXP _balancer_make_prox_l2() {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    rcpp_result_gen = Rcpp::wrap(make_prox_l2());
    return rcpp_result_gen;
END_RCPP
}
// prox_nuc
mat prox_nuc(mat x, double lam, List opts);
RcppExport SEXP _balancer_prox_nuc(SEXP xSEXP, SEXP lamSEXP, SEXP optsSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< mat >::type x(xSEXP);
    Rcpp::traits::input_parameter< double >::type lam(lamSEXP);
    Rcpp::traits::input_parameter< List >::type opts(optsSEXP);
    rcpp_result_gen = Rcpp::wrap(prox_nuc(x, lam, opts));
    return rcpp_result_gen;
END_RCPP
}
// make_prox_nuc
pptr make_prox_nuc();
RcppExport SEXP _balancer_make_prox_nuc() {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    rcpp_result_gen = Rcpp::wrap(make_prox_nuc());
    return rcpp_result_gen;
END_RCPP
}
// prox_l1_grp_l1
mat prox_l1_grp_l1(mat x, double lam, List opts);
RcppExport SEXP _balancer_prox_l1_grp_l1(SEXP xSEXP, SEXP lamSEXP, SEXP optsSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< mat >::type x(xSEXP);
    Rcpp::traits::input_parameter< double >::type lam(lamSEXP);
    Rcpp::traits::input_parameter< List >::type opts(optsSEXP);
    rcpp_result_gen = Rcpp::wrap(prox_l1_grp_l1(x, lam, opts));
    return rcpp_result_gen;
END_RCPP
}
// make_prox_l1_grp_l1
pptr make_prox_l1_grp_l1();
RcppExport SEXP _balancer_make_prox_l1_grp_l1() {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    rcpp_result_gen = Rcpp::wrap(make_prox_l1_grp_l1());
    return rcpp_result_gen;
END_RCPP
}
// prox_nuc_l1
mat prox_nuc_l1(mat x, double lam, List opts);
RcppExport SEXP _balancer_prox_nuc_l1(SEXP xSEXP, SEXP lamSEXP, SEXP optsSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< mat >::type x(xSEXP);
    Rcpp::traits::input_parameter< double >::type lam(lamSEXP);
    Rcpp::traits::input_parameter< List >::type opts(optsSEXP);
    rcpp_result_gen = Rcpp::wrap(prox_nuc_l1(x, lam, opts));
    return rcpp_result_gen;
END_RCPP
}
// make_prox_nuc_l1
pptr make_prox_nuc_l1();
RcppExport SEXP _balancer_make_prox_nuc_l1() {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    rcpp_result_gen = Rcpp::wrap(make_prox_nuc_l1());
    return rcpp_result_gen;
END_RCPP
}
// lin_weights
mat lin_weights(mat Xc, mat theta);
RcppExport SEXP _balancer_lin_weights(SEXP XcSEXP, SEXP thetaSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< mat >::type Xc(XcSEXP);
    Rcpp::traits::input_parameter< mat >::type theta(thetaSEXP);
    rcpp_result_gen = Rcpp::wrap(lin_weights(Xc, theta));
    return rcpp_result_gen;
END_RCPP
}
// lin_weights2
mat lin_weights2(mat eta);
RcppExport SEXP _balancer_lin_weights2(SEXP etaSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< mat >::type eta(etaSEXP);
    rcpp_result_gen = Rcpp::wrap(lin_weights2(eta));
    return rcpp_result_gen;
END_RCPP
}
// make_lin_weights
wptr make_lin_weights();
RcppExport SEXP _balancer_make_lin_weights() {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    rcpp_result_gen = Rcpp::wrap(make_lin_weights());
    return rcpp_result_gen;
END_RCPP
}
// make_lin_weights2
wptr2 make_lin_weights2();
RcppExport SEXP _balancer_make_lin_weights2() {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    rcpp_result_gen = Rcpp::wrap(make_lin_weights2());
    return rcpp_result_gen;
END_RCPP
}
// softmax_weights
mat softmax_weights(mat Xc, mat theta);
RcppExport SEXP _balancer_softmax_weights(SEXP XcSEXP, SEXP thetaSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< mat >::type Xc(XcSEXP);
    Rcpp::traits::input_parameter< mat >::type theta(thetaSEXP);
    rcpp_result_gen = Rcpp::wrap(softmax_weights(Xc, theta));
    return rcpp_result_gen;
END_RCPP
}
// softmax_weights2
mat softmax_weights2(mat eta);
RcppExport SEXP _balancer_softmax_weights2(SEXP etaSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< mat >::type eta(etaSEXP);
    rcpp_result_gen = Rcpp::wrap(softmax_weights2(eta));
    return rcpp_result_gen;
END_RCPP
}
// make_softmax_weights
wptr make_softmax_weights();
RcppExport SEXP _balancer_make_softmax_weights() {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    rcpp_result_gen = Rcpp::wrap(make_softmax_weights());
    return rcpp_result_gen;
END_RCPP
}
// make_softmax_weights2
wptr2 make_softmax_weights2();
RcppExport SEXP _balancer_make_softmax_weights2() {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    rcpp_result_gen = Rcpp::wrap(make_softmax_weights2());
    return rcpp_result_gen;
END_RCPP
}
// exp_weights
mat exp_weights(mat Xc, mat theta);
RcppExport SEXP _balancer_exp_weights(SEXP XcSEXP, SEXP thetaSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< mat >::type Xc(XcSEXP);
    Rcpp::traits::input_parameter< mat >::type theta(thetaSEXP);
    rcpp_result_gen = Rcpp::wrap(exp_weights(Xc, theta));
    return rcpp_result_gen;
END_RCPP
}
// exp_weights2
mat exp_weights2(mat eta);
RcppExport SEXP _balancer_exp_weights2(SEXP etaSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< mat >::type eta(etaSEXP);
    rcpp_result_gen = Rcpp::wrap(exp_weights2(eta));
    return rcpp_result_gen;
END_RCPP
}
// make_exp_weights
wptr make_exp_weights();
RcppExport SEXP _balancer_make_exp_weights() {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    rcpp_result_gen = Rcpp::wrap(make_exp_weights());
    return rcpp_result_gen;
END_RCPP
}
// make_exp_weights2
wptr2 make_exp_weights2();
RcppExport SEXP _balancer_make_exp_weights2() {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    rcpp_result_gen = Rcpp::wrap(make_exp_weights2());
    return rcpp_result_gen;
END_RCPP
}
// pos_lin_weights
mat pos_lin_weights(mat Xc, mat theta);
RcppExport SEXP _balancer_pos_lin_weights(SEXP XcSEXP, SEXP thetaSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< mat >::type Xc(XcSEXP);
    Rcpp::traits::input_parameter< mat >::type theta(thetaSEXP);
    rcpp_result_gen = Rcpp::wrap(pos_lin_weights(Xc, theta));
    return rcpp_result_gen;
END_RCPP
}
// pos_lin_weights2
mat pos_lin_weights2(mat eta);
RcppExport SEXP _balancer_pos_lin_weights2(SEXP etaSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< mat >::type eta(etaSEXP);
    rcpp_result_gen = Rcpp::wrap(pos_lin_weights2(eta));
    return rcpp_result_gen;
END_RCPP
}
// make_pos_lin_weights
wptr make_pos_lin_weights();
RcppExport SEXP _balancer_make_pos_lin_weights() {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    rcpp_result_gen = Rcpp::wrap(make_pos_lin_weights());
    return rcpp_result_gen;
END_RCPP
}
// make_pos_lin_weights2
wptr2 make_pos_lin_weights2();
RcppExport SEXP _balancer_make_pos_lin_weights2() {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    rcpp_result_gen = Rcpp::wrap(make_pos_lin_weights2());
    return rcpp_result_gen;
END_RCPP
}

static const R_CallMethodDef CallEntries[] = {
    {"_balancer_apg", (DL_FUNC) &_balancer_apg, 10},
    {"_balancer_balancing_grad", (DL_FUNC) &_balancer_balancing_grad, 2},
    {"_balancer_make_balancing_grad", (DL_FUNC) &_balancer_make_balancing_grad, 0},
    {"_balancer_balancing_grad_kern", (DL_FUNC) &_balancer_balancing_grad_kern, 2},
    {"_balancer_make_balancing_grad_kern", (DL_FUNC) &_balancer_make_balancing_grad_kern, 0},
    {"_balancer_poly_kernel", (DL_FUNC) &_balancer_poly_kernel, 3},
    {"_balancer_rbf_kernel", (DL_FUNC) &_balancer_rbf_kernel, 3},
    {"_balancer_compute_gram", (DL_FUNC) &_balancer_compute_gram, 4},
    {"_balancer_make_no_prox", (DL_FUNC) &_balancer_make_no_prox, 0},
    {"_balancer_prox_l1", (DL_FUNC) &_balancer_prox_l1, 3},
    {"_balancer_make_prox_l1", (DL_FUNC) &_balancer_make_prox_l1, 0},
    {"_balancer_prox_l1_grp", (DL_FUNC) &_balancer_prox_l1_grp, 3},
    {"_balancer_make_prox_l1_grp", (DL_FUNC) &_balancer_make_prox_l1_grp, 0},
    {"_balancer_prox_l2", (DL_FUNC) &_balancer_prox_l2, 3},
    {"_balancer_make_prox_l2", (DL_FUNC) &_balancer_make_prox_l2, 0},
    {"_balancer_prox_nuc", (DL_FUNC) &_balancer_prox_nuc, 3},
    {"_balancer_make_prox_nuc", (DL_FUNC) &_balancer_make_prox_nuc, 0},
    {"_balancer_prox_l1_grp_l1", (DL_FUNC) &_balancer_prox_l1_grp_l1, 3},
    {"_balancer_make_prox_l1_grp_l1", (DL_FUNC) &_balancer_make_prox_l1_grp_l1, 0},
    {"_balancer_prox_nuc_l1", (DL_FUNC) &_balancer_prox_nuc_l1, 3},
    {"_balancer_make_prox_nuc_l1", (DL_FUNC) &_balancer_make_prox_nuc_l1, 0},
    {"_balancer_lin_weights", (DL_FUNC) &_balancer_lin_weights, 2},
    {"_balancer_lin_weights2", (DL_FUNC) &_balancer_lin_weights2, 1},
    {"_balancer_make_lin_weights", (DL_FUNC) &_balancer_make_lin_weights, 0},
    {"_balancer_make_lin_weights2", (DL_FUNC) &_balancer_make_lin_weights2, 0},
    {"_balancer_softmax_weights", (DL_FUNC) &_balancer_softmax_weights, 2},
    {"_balancer_softmax_weights2", (DL_FUNC) &_balancer_softmax_weights2, 1},
    {"_balancer_make_softmax_weights", (DL_FUNC) &_balancer_make_softmax_weights, 0},
    {"_balancer_make_softmax_weights2", (DL_FUNC) &_balancer_make_softmax_weights2, 0},
    {"_balancer_exp_weights", (DL_FUNC) &_balancer_exp_weights, 2},
    {"_balancer_exp_weights2", (DL_FUNC) &_balancer_exp_weights2, 1},
    {"_balancer_make_exp_weights", (DL_FUNC) &_balancer_make_exp_weights, 0},
    {"_balancer_make_exp_weights2", (DL_FUNC) &_balancer_make_exp_weights2, 0},
    {"_balancer_pos_lin_weights", (DL_FUNC) &_balancer_pos_lin_weights, 2},
    {"_balancer_pos_lin_weights2", (DL_FUNC) &_balancer_pos_lin_weights2, 1},
    {"_balancer_make_pos_lin_weights", (DL_FUNC) &_balancer_make_pos_lin_weights, 0},
    {"_balancer_make_pos_lin_weights2", (DL_FUNC) &_balancer_make_pos_lin_weights2, 0},
    {NULL, NULL, 0}
};

RcppExport void R_init_balancer(DllInfo *dll) {
    R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
}