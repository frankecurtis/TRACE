% Copyright (C) 2022 Frank E. Curtis, Daniel P. Robinson, Qi Wang
%
% All Rights Reserved.

% AcceptabilityCheckRatio: addOptions
function addOptions(options,reporter)

% Add double options
options.addDoubleOption(reporter,'cubic_multiplier_decrease_factor',5e-01,0,1);
options.addDoubleOption(reporter,'cubic_multiplier_increase_factor',2e+00,1,inf);
options.addDoubleOption(reporter,'trust_region_multiplier_decrease_factor',5e-01,0,1);
options.addDoubleOption(reporter,'trust_region_multiplier_increase_factor',2e+00,1,inf);
options.addDoubleOption(reporter,'trust_region_radius_decrease_factor',5e-01,0,1);
options.addDoubleOption(reporter,'trust_region_radius_increase_factor',2e+00,1,inf);
options.addDoubleOption(reporter,'successful_tolerance',1e-08,0,1);
options.addDoubleOption(reporter,'very_successful_tolerance',1e-01,0,1);

end % addOptions