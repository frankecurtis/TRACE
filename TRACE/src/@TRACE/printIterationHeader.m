% Copyright (C) 2022 Frank E. Curtis, Daniel P. Robinson, Qi Wang
%
% All Rights Reserved.

% TRACE: printIterationHeader
function printIterationHeader(T)

% Print iteration header
if mod(T.quantities_.iterationCounter,20) == 0
  T.quantities_.printIterationHeader(T.reporter_);
  T.strategies_.printIterationHeader(T.reporter_);
  T.reporter_.printf(Enumerations.R_SOLVER,Enumerations.R_PER_ITERATION,'\n');
end

end % printIterationHeader