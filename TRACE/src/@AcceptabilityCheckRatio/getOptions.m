% Copyright (C) 2022 Frank E. Curtis, Daniel P. Robinson, Qi Wang
%
% All Rights Reserved.

% AcceptabilityCheckRatio: getOptions
function getOptions(A,options,reporter)

% Get options
A.cubic_multiplier_decrease_factor_ = options.getOption(reporter,'cubic_multiplier_decrease_factor');
A.cubic_multiplier_increase_factor_ = options.getOption(reporter,'cubic_multiplier_increase_factor');
A.trust_region_multiplier_decrease_factor_ = options.getOption(reporter,'trust_region_multiplier_decrease_factor');
A.trust_region_multiplier_increase_factor_ = options.getOption(reporter,'trust_region_multiplier_increase_factor');
A.trust_region_radius_decrease_factor_ = options.getOption(reporter,'trust_region_radius_decrease_factor');
A.trust_region_radius_increase_factor_ = options.getOption(reporter,'trust_region_radius_increase_factor');
A.successful_tolerance_ = options.getOption(reporter,'successful_tolerance');
A.very_successful_tolerance_ = options.getOption(reporter,'very_successful_tolerance');

end % getOptions