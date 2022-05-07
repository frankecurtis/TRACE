% Copyright (C) 2022 Frank E. Curtis, Daniel P. Robinson, Qi Wang
%
% All Rights Reserved.

% Point class
classdef Point < handle

  % Properties (private set access)
  properties (SetAccess = private)
    
    numberOfVariables
    point
    problem
    scaleFactor
    
  end % properties (private set access)
  
  % Properties (private get and set access)
  properties (GetAccess = private, SetAccess = private)
    
    %%%%%%%%%%%%%%
    % QUANTITIES %
    %%%%%%%%%%%%%%
    f % objective function
    f_unscaled % objective function, unscaled
    g % objective gradient
    g_norm2 % objective gradient, 2-norm
    H % objective Hessian
    
    %%%%%%%%%%%%%%
    % INDICATORS %
    %%%%%%%%%%%%%%
    f_evaluated = false
    g_evaluated = false
    g_norm2_evaluated = false
    H_evaluated = false
    scales_set = false
    
  end % properties (private get and set access)
  
  % Methods (public access)
  methods (Access = public)
    
    %%%%%%%%%%%%%%%
    % CONSTRUCTOR %
    %%%%%%%%%%%%%%%
    
    % Constructor
    function P = Point(varargin)
      
      % Check for correct number of input arguments
      if nargin < 1 || nargin > 2
        error('Point: Incorrect number of inputs to constructor.');
      end
      
      % Check for problem input (1 argument)
      if nargin == 1
        
        % Set problem
        P.problem = varargin{1};
        
        % Set initial point
        P.point = P.problem.initialPoint;
        
        % Set number of variables
        P.numberOfVariables = P.problem.numberOfVariables;
        
        % Initialize scale factors
        P.scaleFactor = 1.0;
        
      else % point + vector input (2 arguments)
        
        % Copy members from input point
        P.problem = varargin{1}.problem;
        P.numberOfVariables = varargin{1}.numberOfVariables;
        P.scaleFactor = varargin{1}.scaleFactor;
        
        % Set indicator
        P.scales_set = true;
        
        % Set point
        P.point = varargin{2};
        
      end
      
    end % Constructor
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % CHECK DERIVATIVE METHOD %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % Check derivatives
    function checkDerivatives(P,quantities)
      
      % Set parameters
      epsilon   = 1e-08;
      tolerance = 1e-04;
      
      % Evaluate objective quantities
      f = P.objectiveFunction(quantities);
      g = P.objectiveGradient(quantities);
      
      % Loop over coordinate directions
      for j = 1:P.numberOfVariables
        
        % Set perturbation
        perturbation = zeros(P.numberOfVariables,1); perturbation(j) = epsilon;
        
        % Set trial point
        temp = Point(quantities.currentIterate,quantities.currentIterate.point + perturbation);
        
        % Set trial objective value
        f_temp = temp.objectiveFunction(quantities);
        
        % Check derivative
        if abs((f_temp - f)/epsilon - g(j)) >= tolerance
          warning('g[%8d] = %+e != %e',j,g(j),(f_temp - f)/epsilon);
        end
        
      end
      
    end % checkDerivatives
    
    %%%%%%%%%%%%%%%%%%%%%%
    % EVALUATION METHODS %
    %%%%%%%%%%%%%%%%%%%%%%
    
    % Determine scale factors
    function determineScaleFactors(P,quantities)
      
      % Check whether to scale
      if quantities.scaleProblem
        
        % Evaluate objective gradient
        gradient = P.problem.evaluateObjectiveGradient(P.point);
        
        % Increment counter
        quantities.incrementObjectiveGradientEvaluationCounter;
        
        % Set objective scale factor
        P.scaleFactor = quantities.scaleFactorGradientLimit/max(quantities.scaleFactorGradientLimit,norm(gradient,inf));
        
        % Set gradient
        P.g = P.scaleFactor * gradient;
        
        % Set indicator
        P.g_evaluated = true;
        
      else
        
        % Set scales to 1
        P.scaleFactor = 1.0;
        
      end
      
      % Scales set
      P.scales_set = true;
      
    end % determineScaleFactors
    
    % Objective function
    function f = objectiveFunction(P,quantities)
      
      % Check if scales have been set
      if ~P.scales_set
        error('Point: Scale factors have not been set!');
      end
      
      % Check if already evaluated
      if ~P.f_evaluated
        
        % Evaluate
        [P.f_unscaled,err] = P.problem.evaluateObjectiveFunction(P.point);
        
        % Check for error
        if err == true
          error('Point: Error evaluating objective function!');
        end
        
        % Scale
        P.f = P.scaleFactor * P.f_unscaled;
        
        % Set indicator
        P.f_evaluated = true;
        
        % Increment counter
        quantities.incrementObjectiveFunctionEvaluationCounter;
        
      end
      
      % Set objective function value
      f = P.f;
      
    end % objectiveFunction
    
    % Objective function unscaled
    function f = objectiveFunctionUnscaled(P,quantities)
      
      % Check if already evaluated
      if ~P.f_evaluated
        
        % Evaluate
        P.objectiveFunction(quantities);
        
      end
      
      % Set objective function unscaled value
      f = P.f_unscaled;
      
    end % objectiveFunctionUnscaled
    
    % Objective gradient
    function g = objectiveGradient(P,quantities)
      
      % Check if scales have been set
      if ~P.scales_set
        error('Point: Scale factors have not been set!');
      end
      
      % Check if already evaluated
      if ~P.g_evaluated
        
        % Evaluate
        [g,err] = P.problem.evaluateObjectiveGradient(P.point);
        
        % Check for error
        if err == true
          error('Point: Error evaluating objective gradient!');
        end
        
        % Scale
        P.g = P.scaleFactor * g;
        
        % Set indicator
        P.g_evaluated = true;
        
        % Increment counter
        quantities.incrementObjectiveGradientEvaluationCounter;
        
      end
      
      % Set objective gradient value
      g = P.g;
      
    end % objectiveGradient
    
    % Objective gradient 2-norm
    function g_norm2 = objectiveGradientNorm2(P,quantities)
      
      % Check if gradient already evaluated
      if ~P.g_evaluated
        
        % Evaluate
        P.objectiveGradient(quantities);
        
      end
      
      % Set objective gradient 2-norm
      if ~P.g_norm2_evaluated
        
        % Evaluate
        P.g_norm2 = norm(P.objectiveGradient(quantities));
        
        % Set indicator
        P.g_norm2_evaluated = true;
        
      end
      
      % Set objective gradient norm value
      g_norm2 = P.g_norm2;
      
    end
    
    % Objective Hessian
    function H = objectiveHessian(P,quantities)
      
      % Check if scales have been set
      if ~P.scales_set
        error('Point: Scale factors have not been set!');
      end
      
      % Check if already evaluated
      if ~P.H_evaluated
        
        % Evaluate
        [H,err] = P.problem.evaluateObjectiveHessian(P.point);
        
        % Check for error
        if err == true
          error('Point: Error evaluating objective Hessian!');
        end
        
        % Scale
        P.H = P.scaleFactor * H;
        
        % Set indicator
        P.H_evaluated = true;
        
        % Increment counter
        quantities.incrementObjectiveHessianEvaluationCounter;
        
      end
      
      % Set objective Hessian value
      H = P.H;
      
    end % objectiveHessian
    
    % Stationarity error
    function v = stationarityError(P,quantities)
      
      % Evaluate measure
      v = norm(P.objectiveGradient(quantities),inf);
      
    end % stationarityError
    
  end % methods (public access)
  
end % Point