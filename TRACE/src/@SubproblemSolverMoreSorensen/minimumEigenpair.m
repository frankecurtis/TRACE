% Copyright (C) 2022 Frank E. Curtis, Daniel P. Robinson, Qi Wang
%
% All Rights Reserved.

% SubproblemSolverMoreSorensen: minimumEigenpair
function [eig_val,eig_vec] = minimumEigenpair(S,quantities,lambda)

% Compute using eigs
[eig_vec,eig_val] = eigs(quantities.subproblemMatrix + lambda*speye(length(quantities.subproblemVector)),1,'SA');

% Recompute using eig if eigs failed
if isnan(eig_val)
  [EIGVEC,EIGVAL] = eig(full(quantities.subproblemMatrix + lambda*speye(length(quantities.subproblemVector))));
  eigvals = diag(EIGVAL);
  [eig_val,index] = min(eigvals);
  eig_vec = EIGVEC(:,index);
end

end