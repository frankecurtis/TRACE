% Copyright (C) 2022 Frank E. Curtis, Daniel P. Robinson, Qi Wang
%
% All Rights Reserved.

% SubproblemSolverMoreSorensen: printIterationHeader
function printIterationHeader(S,reporter)

% Print iteration header
reporter.printf(Enumerations.R_SOLVER,Enumerations.R_PER_ITERATION,...
  '     TR Rad.     TR Mult.    Cub. Mult.  ?  |Sub. Step|  Sub. Error');
  
end % printIterationHeader