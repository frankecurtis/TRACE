% Copyright (C) 2022 Frank E. Curtis, Daniel P. Robinson, Qi Wang
%
% All Rights Reserved.

% Quantities class
classdef Quantities < handle
  
  % Properties (private access)
  properties (SetAccess = private, GetAccess = private)
    
    %%%%%%%%%%%%%%%%%%%%%%%%
    % ALGORITHM QUANTITIES %
    %%%%%%%%%%%%%%%%%%%%%%%%
    current_iterate_
    direction_
    trial_iterate_
    
    %%%%%%%%%%%
    % OPTIONS %
    %%%%%%%%%%%
    check_derivatives_
    
    %%%%%%%%%%%%
    % COUNTERS %
    %%%%%%%%%%%%
    iteration_counter_ = 0
    objective_function_evaluation_counter_ = 0
    objective_gradient_evaluation_counter_ = 0
    objective_hessian_evaluation_counter_ = 0
    
    %%%%%%%%%%%%%%
    % INDICATORS %
    %%%%%%%%%%%%%%
    scale_problem_
    
    %%%%%%%%%%%%%%
    % TOLERANCES %
    %%%%%%%%%%%%%%
    cpu_time_limit_
    iteration_limit_
    objective_function_evaluation_limit_
    objective_gradient_evaluation_limit_
    objective_hessian_evaluation_limit_
    scale_factor_gradient_limit_
    size_limit_
    stationarity_tolerance_
    
  end
  
  % Methods (static)
  methods (Static)
    
    %%%%%%%%%%%%%%%%%%%
    % OPTIONS METHODS %
    %%%%%%%%%%%%%%%%%%%
    
    % Add options
    addOptions(options,reporter)
    
    %%%%%%%%%%%%%%%
    % GET METHODS %
    %%%%%%%%%%%%%%%
    
    % CPU time
    function cpu = CPUTime
      
      % Set return value
      cpu = toc;
      
    end % CPUTime
    
  end
  
  % Methods (public access)
  methods (Access = public)
    
    %%%%%%%%%%%%%%%
    % CONSTRUCTOR %
    %%%%%%%%%%%%%%%
    
    % Constructor
    function Q = Quantities(varargin)
      
      % DO NOTHING
      
    end % Constructor
    
    %%%%%%%%%%%%%%%%%
    % PRINT METHODS %
    %%%%%%%%%%%%%%%%%
    
    % Print iteration header
    printIterationHeader(Q,reporter)
    
    % Print iteration values
    printIterationValues(Q,reporter)
    
    %%%%%%%%%%%%%%%%%%%
    % OPTIONS METHODS %
    %%%%%%%%%%%%%%%%%%%
    
    % Get options
    getOptions(Q,options,reporter)
    
    %%%%%%%%%%%%%%%%%%%%%%
    % INITIALIZE METHODS %
    %%%%%%%%%%%%%%%%%%%%%%
    
    % Initialize
    initialize(Q,problem)
    
    %%%%%%%%%%%%%%%
    % GET METHODS %
    %%%%%%%%%%%%%%%
    
    % Check derivatives
    function b = checkDerivatives(Q)
      
      % Set return value
      b = Q.check_derivatives_;
      
    end % checkDerivatives
    
    % CPU time limit
    function cpu_max = CPUTimeLimit(Q)
      
      % Set return value
      cpu_max = Q.cpu_time_limit_;
      
    end % CPUTimeLimit
    
    % Current iterate
    function iterate = currentIterate(Q)
      
      % Set return value
      iterate = Q.current_iterate_;
      
    end % currentIterate
    
    % Direction
    function d = direction(Q)
      
      % Set return value
      d = Q.direction_;
      
    end % direction
    
    % Iteration counter
    function k = iterationCounter(Q)
      
      % Set return value
      k = Q.iteration_counter_;
      
    end % iterationCounter
    
    % Iteration limit
    function k_max = iterationLimit(Q)
      
      % Set return value
      k_max = Q.iteration_limit_;
      
    end % iterationLimit
    
    % Exceeded limit, CPU
    function b = limitExceededCPU(Q)
      
      % Check limit
      b = (Q.CPUTime >= Q.cpu_time_limit_);
      
    end % limitExceededCPU
    
    % Exceeded limit, evaluations
    function b = limitExceededEvaluations(Q)
      
      % Check limit
      b = (Q.objective_function_evaluation_counter_ > Q.objective_function_evaluation_limit_ || ...
        Q.objective_gradient_evaluation_counter_ > Q.objective_gradient_evaluation_limit_ || ...
        Q.objective_hessian_evaluation_counter_ > Q.objective_hessian_evaluation_limit_);
      
    end % limitExceededEvaluations
    
    % Exceeded limit, iterations
    function b = limitExceededIterations(Q)
      
      % Check limit
      b = (Q.iteration_counter_ > Q.iteration_limit_);
      
    end % limitExceededIterations
    
    % Exceeded limit, size
    function b = limitExceededSize(Q)
      
      % Check limit
      b = (Q.current_iterate_.numberOfVariables > Q.size_limit_);
      
    end % limitExceededSize
    
    % Objective function evaluation counter
    function f = objectiveFunctionEvaluationCounter(Q)
      
      % Set return value
      f = Q.objective_function_evaluation_counter_;
      
    end % objectiveFunctionEvaluationCounter
    
    % Objective function evaluation limit
    function f_max = objectiveFunctionEvaluationLimit(Q)
      
      % Set return value
      f_max = Q.objective_function_evaluation_limit_;
      
    end % objectiveFunctionEvaluationLimit
    
    % Objective gradient evaluation counter
    function g = objectiveGradientEvaluationCounter(Q)
      
      % Set return value
      g = Q.objective_gradient_evaluation_counter_;
      
    end % objectiveGradientEvaluationCounter
    
    % Objective gradient evaluation limit
    function g_max = objectiveGradientEvaluationLimit(Q)
      
      % Set return value
      g_max = Q.objective_gradient_evaluation_limit_;
      
    end % objectiveGradientEvaluationLimit
    
    % Objective Hessian evaluation counter
    function H = objectiveHessianEvaluationCounter(Q)
      
      % Set return value
      H = Q.objective_hessian_evaluation_counter_;
      
    end % objectiveHessianEvaluationCounter
    
    % Objective Hessian evaluation limit
    function H_max = objectiveHessianEvaluationLimit(Q)
      
      % Set return value
      H_max = Q.objective_hessian_evaluation_limit_;
      
    end % objectiveHessianEvaluationLimit
    
    % Scale factor gradient limit
    function s_max = scaleFactorGradientLimit(Q)
      
      % Set return value
      s_max = Q.scale_factor_gradient_limit_;
      
    end % scaleFactorGradientLimit
    
    % Scale problem
    function b = scaleProblem(Q)
      
      % Set return value
      b = Q.scale_problem_;
      
    end % scaleProblem
    
    % Size limit
    function s_max = sizeLimit(Q)
      
      % Set return value
      s_max = Q.size_limit_;
      
    end % sizeLimit
    
    % Stationarity satisfied
    function b = stationaritySatisfied(Q)
      
      % Check condition
      b = (Q.current_iterate_.stationarityError(Q) <= Q.stationarity_tolerance_);
      
    end % stationaritySatisfied
    
    % Stationarity tolerance
    function t = stationarityTolerance(Q)
      
      % Set return value
      t = Q.stationarity_tolerance_;
      
    end % stationarityTolerance
    
    % Trial iterate
    function iterate = trialIterate(Q)
      
      % Set return value
      iterate = Q.trial_iterate_;
      
    end % trialIterate
    
    %%%%%%%%%%%%%%%
    % SET METHODS %
    %%%%%%%%%%%%%%%
    
    % Set direction
    function setDirection(Q,direction)
      
      % Set direction
      Q.direction_ = direction;
      
    end % setDirection
    
    % Set trial iterate
    function setTrialIterate(Q,iterate)
      
      % Set trial iterate
      Q.trial_iterate_ = iterate;
      
    end % setTrialIterate
    
    % Update iterate
    function updateIterate(Q)
      
      % Set current iterate to trial iterate
      Q.current_iterate_ = Q.trial_iterate_;
      
    end % updateIterate
    
    %%%%%%%%%%%%%%%%%%%%%
    % INCREMENT METHODS %
    %%%%%%%%%%%%%%%%%%%%%
    
    % Increment iteration counter
    function incrementIterationCounter(Q)
      
      % Increment iteration counter
      Q.iteration_counter_ = Q.iteration_counter_ + 1;
      
    end % incrementIterationCounter
    
    % Increment objective function evaluation counter
    function incrementObjectiveFunctionEvaluationCounter(Q)
      
      % Increment objective function evaluation counter
      Q.objective_function_evaluation_counter_ = Q.objective_function_evaluation_counter_ + 1;
      
    end % incrementObjectiveFunctionEvaluationCounter
    
    % Increment objective gradient evaluation counter
    function incrementObjectiveGradientEvaluationCounter(Q)
      
      % Increment objective gradient evaluation counter
      Q.objective_gradient_evaluation_counter_ = Q.objective_gradient_evaluation_counter_ + 1;
      
    end % incrementObjectiveGradientEvaluationCounter
    
    % Increment objective Hessian evaluation counter
    function incrementObjectiveHessianEvaluationCounter(Q)
      
      % Increment objective Hessian evaluation counter
      Q.objective_hessian_evaluation_counter_ = Q.objective_hessian_evaluation_counter_ + 1;
      
    end % incrementObjectiveHessianEvaluationCounter
    
  end % methods (public access)
  
end % Quantities