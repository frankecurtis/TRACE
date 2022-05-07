% Copyright (C) 2022 Frank E. Curtis, Daniel P. Robinson, Qi Wang
%
% All Rights Reserved.

% Quantities: addOptions
function addOptions(options,reporter)

% Add bool options
options.addBoolOption(reporter,'check_derivatives',false);
options.addBoolOption(reporter,'scale_problem',true);

% Add integer options
options.addIntegerOption(reporter,'inner_iteration_limit',1e+04,0,inf);
options.addIntegerOption(reporter,'iteration_limit',1e+04,0,inf);
options.addIntegerOption(reporter,'objective_function_evaluation_limit',1e+04,0,inf);
options.addIntegerOption(reporter,'objective_gradient_evaluation_limit',1e+04,0,inf);
options.addIntegerOption(reporter,'objective_hessian_evaluation_limit',1e+04,0,inf);
options.addIntegerOption(reporter,'size_limit',1e+06,0,inf);

% Add double options
options.addDoubleOption(reporter,'cubic_multiplier_initial_factor',1e+00,0,inf);
options.addDoubleOption(reporter,'cubic_multiplier_initial_maximum',1e+20,0,inf);
options.addDoubleOption(reporter,'cubic_multiplier_initial_minimum',1e-20,0,inf);
options.addDoubleOption(reporter,'cpu_time_limit',1800,0,inf);
options.addDoubleOption(reporter,'scale_factor_gradient_limit',1e+02,0,inf);
options.addDoubleOption(reporter,'stationarity_tolerance',1e-05,0,inf);
options.addDoubleOption(reporter,'trust_region_initial_factor',1e+00,0,inf);
options.addDoubleOption(reporter,'trust_region_initial_maximum',1e+20,0,inf);
options.addDoubleOption(reporter,'trust_region_initial_minimum',1e-20,0,inf);

end % addOptions