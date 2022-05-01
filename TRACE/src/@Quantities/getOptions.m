% Copyright (C) 2022 Frank E. Curtis, Daniel P. Robinson, Qi Wang
%
% All Rights Reserved.

% Quantities: getOptions
function getOptions(Q,options,reporter)

% Get options
Q.check_derivatives_ = options.getOption(reporter,'check_derivatives');
Q.cpu_time_limit_ = options.getOption(reporter,'cpu_time_limit');
Q.iteration_limit_ = options.getOption(reporter,'iteration_limit');
Q.objective_function_evaluation_limit_ = options.getOption(reporter,'objective_function_evaluation_limit');
Q.objective_gradient_evaluation_limit_ = options.getOption(reporter,'objective_gradient_evaluation_limit');
Q.objective_hessian_evaluation_limit_ = options.getOption(reporter,'objective_hessian_evaluation_limit');
Q.scale_factor_gradient_limit_ = options.getOption(reporter,'scale_factor_gradient_limit');
Q.scale_problem_ = options.getOption(reporter,'scale_problem');
Q.size_limit_ = options.getOption(reporter,'size_limit');
Q.stationarity_tolerance_ = options.getOption(reporter,'stationarity_tolerance');

end % getOptions