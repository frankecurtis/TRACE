% Copyright (C) 2022 Frank E. Curtis, Daniel P. Robinson, Qi Wang
%
% All Rights Reserved.

% AcceptabilityCheckRatio: printIterationHeader
function printIterationHeader(A,reporter)

% Print iteration header
reporter.printf(Enumerations.R_SOLVER,Enumerations.R_PER_ITERATION,...
  '    Act. Red.     Mod. Red.');
  
end % printIterationHeader