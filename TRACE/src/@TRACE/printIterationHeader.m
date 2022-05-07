% Copyright (C) 2022 Frank E. Curtis, Daniel P. Robinson, Qi Wang
%
% All Rights Reserved.

% TRACE: printIterationHeader
function printIterationHeader(T)

% Print iteration header
if mod(T.quantities.iterationCounter,20) == 0
  T.quantities.printIterationHeader(T.reporter);
  T.strategies.printIterationHeader(T.reporter);
  T.reporter.printf(Enumerations.R_SOLVER,Enumerations.R_PER_ITERATION,'\n');
end

end % printIterationHeader