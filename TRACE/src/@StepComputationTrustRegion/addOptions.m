% Copyright (C) 2022 Frank E. Curtis, Daniel P. Robinson, Qi Wang
%
% All Rights Reserved.

% StepComputationTrustRegion: addOptions
function addOptions(options,reporter)

% Add bool options
options.addBoolOption(reporter,'fail_on_solver_failure',false);

end % addOptions