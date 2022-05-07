% Copyright (C) 2022 Frank E. Curtis, Daniel P. Robinson, Qi Wang
%
% All Rights Reserved.

% Strategies: printIterationHeader
function printIterationHeader(S,reporter)

% Print iteration header
S.subproblemSolver.printIterationHeader(reporter);
S.stepComputation.printIterationHeader(reporter);
S.acceptabilityCheck.printIterationHeader(reporter);

end % printIterationHeader