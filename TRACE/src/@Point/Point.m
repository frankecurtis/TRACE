% Copyright (C) 2022 Frank E. Curtis, Daniel P. Robinson, Qi Wang
%
% All Rights Reserved.

% Point class
classdef Point < handle
  
  % Properties (private access)
  properties (SetAccess = private, GetAccess = private)
    
    %%%%%%%%%%%
    % Problem %
    %%%%%%%%%%%
    p
    
    %%%%%%%%%%%%%%
    % QUANTITIES %
    %%%%%%%%%%%%%%
    n % number of variables
    x % point
    f % objective function
    f_unscaled % objective function, unscaled
    g % objective gradient
    H % objective Hessian
    
    %%%%%%%%%%%%%%%%%
    % SCALE FACTORS %
    %%%%%%%%%%%%%%%%%
    f_scale
    
    %%%%%%%%%%%%%%
    % INDICATORS %
    %%%%%%%%%%%%%%
    f_evaluated = false
    g_evaluated = false
    H_evaluated = false
    scales_set = false
    
  end % properties (private access)
  
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
        P.p = varargin{1};
        
        % Set initial point
        P.x = P.p.initialPoint;
        
        % Set number of variables
        P.n = P.p.numberOfVariables;
        
        % Initialize scale factors
        P.f_scale = 1.0;
        
      else % point + vector input (2 arguments)
        
        % Copy members from input point
        P.p = varargin{1}.problem;
        P.n = varargin{1}.numberOfVariables;
        P.f_scale = varargin{1}.scaleFactor;
        
        % Set indicator
        P.scales_set = true;
        
        % Set point
        P.x = varargin{2};
        
      end
      
    end % Constructor
    
    %%%%%%%%%%%%%%%%%%%%
    % MAKE NEW METHODS %
    %%%%%%%%%%%%%%%%%%%%
    
    % Make linear combination
    function P = makeLinearCombination(P_curr,alpha,d)
      
      % Create new point
      P = Point(P_curr,P_curr.point + alpha*d);
      
    end % makeLinearCombination
    
    %%%%%%%%%%%%%%%
    % GET METHODS %
    %%%%%%%%%%%%%%%
    
    % Number of variables
    function n = numberOfVariables(P)
      
      % Set number of variables
      n = P.n;
      
    end % numberOfVariables
    
    % Point
    function x = point(P)
      
      % Set point
      x = P.x;
      
    end % point
    
    % Problem
    function p = problem(P)
      
      % Set problem
      p = P.p;
      
    end % problem
    
    % Scale factor
    function f_scale = scaleFactor(P)
      
      % Set scale factors
      f_scale = P.f_scale;
      
    end % scaleFactors
    
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
      for j = 1:P.n
        
        % Set perturbation
        perturbation = zeros(P.n,1); perturbation(j) = epsilon;
        
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
        gradient = P.p.evaluateObjectiveGradient(P.x);
        
        % Increment counter
        quantities.incrementObjectiveGradientEvaluationCounter;
        
        % Set objective scale factor
        P.f_scale = quantities.scaleFactorGradientLimit/max(quantities.scaleFactorGradientLimit,norm(gradient,inf));
        
        % Set gradient
        P.g = P.f_scale * gradient;
        
        % Set indicator
        P.g_evaluated = true;
        
      else
        
        % Set scales to 1
        P.f_scale = 1.0;
        
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
        [P.f_unscaled,err] = P.p.evaluateObjectiveFunction(P.x);
        
        % Check for error
        if err == true
          error('Point: Error evaluating objective function!');
        end
        
        % Scale
        P.f = P.f_scale * P.f_unscaled;
        
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
        [g,err] = P.p.evaluateObjectiveGradient(P.x);
        
        % Check for error
        if err == true
          error('Point: Error evaluating objective gradient!');
        end
        
        % Scale
        P.g = P.f_scale * g;
        
        % Set indicator
        P.g_evaluated = true;
        
        % Increment counter
        quantities.incrementObjectiveGradientEvaluationCounter;
        
      end
      
      % Set objective gradient value
      g = P.g;
      
    end % objectiveGradient
    
    % Objective Hessian
    function H = objectiveHessian(P,quantities)
      
      % Check if scales have been set
      if ~P.scales_set
        error('Point: Scale factors have not been set!');
      end
      
      % Check if already evaluated
      if ~P.H_evaluated
        
        % Evaluate
        [H,err] = P.p.evaluateObjectiveHessian(P.x);
        
        % Check for error
        if err == true
          error('Point: Error evaluating objective Hessian!');
        end
        
        % Scale
        P.H = P.f_scale * H;
        
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