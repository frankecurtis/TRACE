% Copyright (C) 2022 Frank E. Curtis, Daniel P. Robinson, Qi Wang
%
% All Rights Reserved.

% Strategies: addOptions
function addOptions(options,reporter)

% Add options
options.addStringOption(reporter,'acceptability_check','Ratio');
options.addStringOption(reporter,'step_computation','TrustRegion');
options.addStringOption(reporter,'subproblem_solver','MoreSorensen');

% Add acceptability check options
a = AcceptabilityCheckRatio;
a.addOptions(options,reporter);

% Add step computation options
d = StepComputationTrustRegion;
d.addOptions(options,reporter);

% Add subproblem solver options
s = SubproblemSolverMoreSorensen;
s.addOptions(options,reporter);

end % addOptions