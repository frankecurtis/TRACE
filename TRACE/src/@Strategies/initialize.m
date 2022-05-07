% Copyright (C) 2022 Frank E. Curtis, Daniel P. Robinson, Qi Wang
%
% All Rights Reserved.

% Strategies: initialize
function initialize(S,options,quantities,reporter)

% Initialize
S.acceptabilityCheck.initialize(options,quantities,reporter);
S.stepComputation.initialize(options,quantities,reporter);
S.subproblemSolver.initialize(options,quantities,reporter);

end % initialize