% Copyright (C) 2022 Frank E. Curtis, Daniel P. Robinson, Qi Wang
%
% All Rights Reserved.

% StepComputationTrustRegion: getOptions
function getOptions(S,options,reporter)

% Get options
S.fail_on_solver_failure_ = options.getOption(reporter,'fail_on_solver_failure');

end % getOptions