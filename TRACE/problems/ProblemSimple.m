% Copyright (C) 2022 Frank E. Curtis, Daniel P. Robinson, Qi Wang
%
% All Rights Reserved.

% ProblemSimple class
classdef ProblemSimple < Problem
  
  % Methods (public access)
  methods (Access = public)
    
    %%%%%%%%%%%%%%%
    % CONSTRUCTOR %
    %%%%%%%%%%%%%%%
    
    % Constructor
    function P = ProblemSimple
      
      % DO NOTHING
      
    end % Constructor
    
    % Objective function
    function [f,err] = evaluateObjectiveFunction(P,x)
      
      % Evaluate objective function
      f = (1/2)*x(1)^2 + (1/2)*x(2)^2;
      
      % No error
      err = false;
      
    end % evaluateObjectiveFunction
    
    % Objective gradient
    function [g,err] = evaluateObjectiveGradient(P,x)
      
      % Evaluate objective gradient
      g = [x(1); x(2)];
      
      % No error
      err = false;
      
    end % evaluateObjectiveGradient
    
    % Objective Hessian
    function [H,err] = evaluateObjectiveHessian(P,x)
      
      % Evaluate objective Hessian
      H = eye(2);
      
      % No error
      err = false;
      
    end % evaluateObjectiveHessian
    
    % Initial point
    function x = initialPoint(P)
      
      % Set initial point
      x = [4; 2];
      
    end % initialPoint
    
    % Name
    function s = name(P)
      
      % Set name
      s = 'Simple';
      
    end % name
    
    % Number of variables
    function n = numberOfVariables(P)
      
      % Set number of variables
      n = 2;
      
    end % numberOfVariables
    
  end % methods (public access)
  
end % ProblemSimple