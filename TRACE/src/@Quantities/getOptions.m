% Copyright (C) 2022 Frank E. Curtis, Daniel P. Robinson, Qi Wang
%
% All Rights Reserved.

% Quantities: getOptions
function getOptions(Q,options,reporter)

% Get options
Q.checkDerivatives = options.getOption(reporter,'check_derivatives');
Q.cpuTimeLimit = options.getOption(reporter,'cpu_time_limit');
Q.cubic_multiplier_initial_factor_ = options.getOption(reporter,'cubic_multiplier_initial_factor');
Q.cubic_multiplier_initial_maximum_ = options.getOption(reporter,'cubic_multiplier_initial_maximum');
Q.cubic_multiplier_initial_minimum_ = options.getOption(reporter,'cubic_multiplier_initial_minimum');
Q.innerIterationLimit = options.getOption(reporter,'inner_iteration_limit');
Q.iterationLimit = options.getOption(reporter,'iteration_limit');
Q.objectiveFunctionEvaluationLimit = options.getOption(reporter,'objective_function_evaluation_limit');
Q.objectiveGradientEvaluationLimit = options.getOption(reporter,'objective_gradient_evaluation_limit');
Q.objectiveHessianEvaluationLimit = options.getOption(reporter,'objective_hessian_evaluation_limit');
Q.scaleFactorGradientLimit = options.getOption(reporter,'scale_factor_gradient_limit');
Q.scaleProblem = options.getOption(reporter,'scale_problem');
Q.sizeLimit = options.getOption(reporter,'size_limit');
Q.stationarityTolerance = options.getOption(reporter,'stationarity_tolerance');
Q.trust_region_initial_factor_ = options.getOption(reporter,'trust_region_initial_factor');
Q.trust_region_initial_maximum_ = options.getOption(reporter,'trust_region_initial_maximum');
Q.trust_region_initial_minimum_ = options.getOption(reporter,'trust_region_initial_minimum');

end % getOptions