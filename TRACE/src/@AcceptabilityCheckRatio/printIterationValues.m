% Copyright (C) 2022 Frank E. Curtis, Daniel P. Robinson, Qi Wang
%
% All Rights Reserved.

% AcceptabilityCheckRatio: printIterationValues
function printIterationValues(A,quantities,reporter)

% Print iteration values
reporter.printf(Enumerations.R_SOLVER,Enumerations.R_PER_ITERATION,...
  ' %+e %+e',...
  quantities.actualReduction,...
  quantities.modelReduction);

end % printIterationValues