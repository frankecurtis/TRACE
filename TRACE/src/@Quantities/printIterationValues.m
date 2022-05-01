% Copyright (C) 2022 Frank E. Curtis, Daniel P. Robinson, Qi Wang
%
% All Rights Reserved.

% Quantities: printIterationValues
function printIterationValues(Q,reporter)

% Print iteration values
reporter.printf(Enumerations.R_SOLVER,Enumerations.R_PER_ITERATION,...
  '%6d %+e',...
  Q.iterationCounter,...
  Q.currentIterate.objectiveFunction(Q));

end % printIterationValues