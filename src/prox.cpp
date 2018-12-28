
#include <RcppArmadillo.h>
//#include <Rcpp.h>
#include <numeric>
#include "balancer_types.h"

using namespace arma;
using namespace Rcpp;
using namespace std;

// PROX FUNCTIONS


mat no_prox(mat theta, double t, List opts) {

  return theta;
     
}

// [[Rcpp::export]]
pptr make_no_prox() {
  return pptr(new proxPtr(no_prox));
}

//' L1 Prox
//'
//' @param x Input matrix
//' @param lam Prox scaling factor
//' @param opts List of options (opts["lam"] holds the other scaling
//'
//' @return Soft thresholded X
// [[Rcpp::export]]
mat prox_l1(mat x, double lam, List opts) {
  lam = lam * as<double>(opts["lam"]);
  return (x - lam) % (x > lam) + (x + lam) % (x < -lam);
}


// [[Rcpp::export]]
pptr make_prox_l1() {
  return pptr(new proxPtr(prox_l1));
}



//' L1 Prox ignoring intercept
//'
//' @param x Input matrix ([intercept, coefs])
//' @param lam Prox scaling factor
//' @param opts List of options (opts["lam"] holds the other scaling
//'
//' @return soft thresholded U + group-thresholded V
// [[Rcpp::export]]
mat prox_l1_normalized(mat x, double lam, List opts) {

  // separate out the intercept
  int d = x.n_rows;

  mat alpha = x.row(0);
  mat beta = x.rows(1,d-1);

  // prox on beta
  beta = prox_l1(beta, lam, opts);

  return join_vert(alpha, beta);
  
}

// [[Rcpp::export]]
pptr make_prox_l1_normalized() {
  return pptr(new proxPtr(prox_l1_normalized));
}



//' Group L1 Prox
//'
//' @param x Input matrix
//' @param lam Prox scaling factor
//' @param opts List of options (opts["lam"] holds the other scaling
//'
//' @return Group soft thresholded X
// [[Rcpp::export]]
mat prox_l1_grp(mat x, double lam, List opts) {
  lam = lam * as<double>(opts["lam"]);
  double rownorm;
  for(int i=0; i < x.n_rows; i++) {
    rownorm = norm(x.row(i), 2);
    x.row(i) = (x.row(i) - x.row(i) / rownorm * lam) * (rownorm > lam);
  }
  return x;
}

// [[Rcpp::export]]
pptr make_prox_l1_grp() {
  return pptr(new proxPtr(prox_l1_grp));
}


//' L2 Prox
//'
//' @param x Input matrix
//' @param lam Prox scaling factor
//' @param opts List of options (opts["lam"] holds the other scaling
//'
//' @return Column soft thresholded X
// [[Rcpp::export]]
mat prox_l2(mat x, double lam, List opts) {
  lam = lam * as<double>(opts["lam"]);
  double colnorm;
  for(int j=0; j < x.n_cols; j++) {
    colnorm = norm(x.col(j), 2);
    x.col(j) = (x.col(j) - x.col(j) / colnorm * lam) * (colnorm > lam);
  }
  return x;
}

// [[Rcpp::export]]
pptr make_prox_l2() {
  return pptr(new proxPtr(prox_l2));
}



//' L2 Prox ignoring intercept
//'
//' @param x Input matrix ([intercept, coefs])
//' @param lam Prox scaling factor
//' @param opts List of options (opts["lam"] holds the other scaling
//'
//' @return soft thresholded U + group-thresholded V
// [[Rcpp::export]]
mat prox_l2_normalized(mat x, double lam, List opts) {

  // separate out the intercept
  int d = x.n_rows;

  mat alpha = x.row(0);
  mat beta = x.rows(1,d-1);

  // prox on beta
  beta = prox_l2(beta, lam, opts);

  return join_vert(alpha, beta);
  
}

// [[Rcpp::export]]
pptr make_prox_l2_normalized() {
  return pptr(new proxPtr(prox_l2_normalized));
}


//' Squared L2 Prox
//'
//' @param x Input matrix
//' @param lam Prox scaling factor
//' @param opts List of options (opts["lam"] holds the other scaling
//'
//' @return Column soft thresholded X
// [[Rcpp::export]]
mat prox_l2_sq(mat x, double lam, List opts) {
  lam = lam * as<double>(opts["lam"]);
  
  return x / (1 + lam);
}

// [[Rcpp::export]]
pptr make_prox_l2_sq() {
  return pptr(new proxPtr(prox_l2_sq));
}





//' Squared L2 Prox ignoring intercept
//'
//' @param x Input matrix ([intercept, coefs])
//' @param lam Prox scaling factor
//' @param opts List of options (opts["lam"] holds the other scaling
//'
//' @return soft thresholded U + group-thresholded V
// [[Rcpp::export]]
mat prox_l2_sq_normalized(mat x, double lam, List opts) {

  // separate out the intercept
  int d = x.n_rows;

  mat alpha = x.row(0);
  mat beta = x.rows(1,d-1);

  // prox on beta
  beta = prox_l2_sq(beta, lam, opts);

  return join_vert(alpha, beta);
  
}

// [[Rcpp::export]]
pptr make_prox_l2_sq_normalized() {
  return pptr(new proxPtr(prox_l2_sq_normalized));
}







//' Prox for 1/2 x'Qx
//'
//' @param x Input matrix
//' @param lam Prox scaling factor
//' @param opts List of options (opts["lam"] holds the other scaling
//'
//' @return Column soft thresholded X
// [[Rcpp::export]]
mat prox_l2_sq_Q(mat x, double lam, List opts) {
  lam = lam * as<double>(opts["lam"]);
  // use eigendecomposition to speed up inversion
  mat evec = as<mat>(opts["evec"]);
  vec eval = as<vec>(opts["eval"]);
  
  return evec * diagmat(1 / (1 + lam * eval)) * evec.t() * x;
}

// [[Rcpp::export]]
pptr make_prox_l2_sq_Q() {
  return pptr(new proxPtr(prox_l2_sq_Q));
}





//' Prox for 1/2 x'Qx ignoring intercept
//'
//' @param x Input matrix ([intercept, coefs])
//' @param lam Prox scaling factor
//' @param opts List of options (opts["lam"] holds the other scaling
//'
//' @return soft thresholded U + group-thresholded V
// [[Rcpp::export]]
mat prox_l2_sq_Q_normalized(mat x, double lam, List opts) {

  // separate out the intercept
  int d = x.n_rows;

  mat alpha = x.row(0);
  mat beta = x.rows(1,d-1);

  // prox on beta
  beta = prox_l2_sq_Q(beta, lam, opts);

  return join_vert(alpha, beta);
  
}

// [[Rcpp::export]]
pptr make_prox_l2_sq_Q_normalized() {
  return pptr(new proxPtr(prox_l2_sq_Q_normalized));
}










//' Prox for elastic net
//'
//' @param x Input matrix
//' @param lam Prox scaling factor
//' @param opts List of options (opts["lam"] holds the other scaling
//'
//' @return Column soft thresholded X
// [[Rcpp::export]]
mat prox_enet(mat x, double lam, List opts) {
  double alpha = as<double>(opts["alpha"]);
    
  return prox_l2_sq(prox_l1(x, lam * alpha, opts), lam * (1-alpha), opts);
}

// [[Rcpp::export]]
pptr make_prox_enet() {
  return pptr(new proxPtr(prox_enet));
}





//' Prox for elastic net ignoring intercept
//'
//' @param x Input matrix ([intercept, coefs])
//' @param lam Prox scaling factor
//' @param opts List of options (opts["lam"] holds the other scaling
//'
//' @return soft thresholded U + group-thresholded V
// [[Rcpp::export]]
mat prox_enet_normalized(mat x, double lam, List opts) {

  // separate out the intercept
  int d = x.n_rows;

  mat alpha = x.row(0);
  mat beta = x.rows(1,d-1);

  // prox on beta
  beta = prox_enet(beta, lam, opts);

  return join_vert(alpha, beta);
  
}

// [[Rcpp::export]]
pptr make_prox_enet_normalized() {
  return pptr(new proxPtr(prox_enet_normalized));
}





//' Nuclear norm prox
//'
//' @param x Input matrix
//' @param lam Prox scaling factor
//' @param opts List of options (opts["lam"] holds the other scaling
//'
//' @return Singular value soft thresholded X
// [[Rcpp::export]]
mat prox_nuc(mat x, double lam, List opts) {
  mat U; vec s; mat V;
  // SVD then threshold singular values
  svd_econ(U, s, V, x);
  // Rcout << U.n_rows << ", " << U.n_cols << "\n";
  // Rcout << V.n_rows << ", " << V.n_cols << "\n";
  // Rcout << s.size() << "\n";
  int d = x.n_rows;
  int m = x.n_cols;

  // threshold singular values
  lam = lam * as<double>(opts["lam"]);
  s = (s - lam) % (s > lam) + (s + lam) % (s < -lam);
  // mat smat;
  // if(d >= m) {
  //   //smat = join_vert(diagmat(s), zeros<mat>(d - m, m));
  //   x = U.cols(0, m-1) * (diagmat(s) * V.t());
  // } else {
  //   // smat = join_horiz(diagmat(s), zeros<mat>(d, m - d));
    
  //   x = (U * diagmat(s)) * V.cols(0, d-1).t();
  // }
  // return x;

  return U * diagmat(s) * V.t();
}

// [[Rcpp::export]]
pptr make_prox_nuc() {
  return pptr(new proxPtr(prox_nuc));
}



//' Group L1 + L1 Prox
//'
//' @param x Input matrix (two sets of parameters x = U + V)
//' @param lam Prox scaling factor
//' @param opts List of options (opts["lam"] holds the other scaling
//'
//' @return soft thresholded U + group-thresholded V
// [[Rcpp::export]]
mat prox_l1_grp_l1(mat x, double lam, List opts) {

  // split matrix in half
  int d = x.n_rows / 2;

  mat x1 = x.rows(0, d-1);
  mat x2 = x.rows(d, 2 * d - 1);

  x1 = prox_l1(x1, lam, as<List>(opts["lam1"]));
  x2 = prox_l1_grp(x2, lam, as<List>(opts["lam2"]));

  return join_vert(x1, x2);
  
}

// [[Rcpp::export]]
pptr make_prox_l1_grp_l1() {
  return pptr(new proxPtr(prox_l1_grp_l1));
}


//' Nuclear norm + L1 Prox
//'
//' @param x Input matrix (two sets of parameters x = U + V)
//' @param lam Prox scaling factor
//' @param opts List of options (opts["lam"] holds the other scaling
//'
//' @return svd soft thresholded U + soft-thresholded V
// [[Rcpp::export]]
mat prox_nuc_l1(mat x, double lam, List opts) {

  // split matrix in half
  int d = x.n_rows / 2;

  mat x1 = x.rows(0, d-1);
  mat x2 = x.rows(d, 2 * d - 1);

  x1 = prox_l1(x1, lam, as<List>(opts["lam1"]));
  x2 = prox_nuc(x2, lam, as<List>(opts["lam2"]));

  return join_vert(x1, x2);
  
}

// [[Rcpp::export]]
pptr make_prox_nuc_l1() {
  return pptr(new proxPtr(prox_nuc_l1));
}



//' L1 Prox for multilevel model, separate for global/local params + intercepts
//'
//' @param x Input matrix (two sets of parameters x = U + V)
//' @param lam Prox scaling factor
//' @param opts List of options (opts["lam"] holds the other scaling
//'
//' @return soft thresholded parameters with different soft thresholds
// [[Rcpp::export]]
mat prox_l1_all(mat x, double lam, List opts) {

  int n_groups = as<int>(opts["n_groups"]);

  // global intercept
  mat global_int = x.submat(0,0,0,0);

  // group intercepts
  mat group_int = x.submat(0, 1, 0, x.n_cols - 1);

  // global parameters
  mat global_param = x.submat(1, 0, x.n_rows-1, 0);
  
  // group parameters
  mat group_param = x.submat(1, 1, x.n_rows-1, x.n_cols-1);

  global_int = prox_l1(global_int, lam, as<List>(opts["lam1"]));

  group_int = prox_l1(group_int, lam, as<List>(opts["lam2"]));

  global_param = prox_l1(global_param, lam, as<List>(opts["lam3"]));


  group_param = prox_l1(group_param, lam, as<List>(opts["lam4"]));  


  return join_cols(join_rows(global_int, group_int), join_rows(global_param, group_param));
  
}

// [[Rcpp::export]]
pptr make_prox_l1_all() {
  return pptr(new proxPtr(prox_l1_all));
}


//' L1 Prox for multilevel model, separate for global/local params + intercepts
//'
//' @param x Input matrix (two sets of parameters x = U + V)
//' @param lam Prox scaling factor
//' @param opts List of options (opts["lam"] holds the other scaling
//'
//' @return soft thresholded parameters with different soft thresholds
// [[Rcpp::export]]
mat prox_l1_nuc(mat x, double lam, List opts) {

  int n_groups = as<int>(opts["n_groups"]);

  // global intercept
  mat global_int = x.submat(0,0,0,0);

  // group intercepts
  mat group_int = x.submat(0, 1, 0, x.n_cols - 1);

  // global parameters
  mat global_param = x.submat(1, 0, x.n_rows-1, 0);
  
  // group parameters
  mat group_param = x.submat(1, 1, x.n_rows-1, x.n_cols-1);

  global_int = prox_l1(global_int, lam, as<List>(opts["lam1"]));

  group_int = prox_l1(group_int, lam, as<List>(opts["lam2"]));

  global_param = prox_l1(global_param, lam, as<List>(opts["lam3"]));


  group_param = prox_nuc(group_param, lam, as<List>(opts["lam4"]));  


  return join_cols(join_rows(global_int, group_int), join_rows(global_param, group_param));
  
}

// [[Rcpp::export]]
pptr make_prox_l1_nuc() {
  return pptr(new proxPtr(prox_l1_nuc));
}
