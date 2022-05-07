% Copyright (C) 2022 Frank E. Curtis, Daniel P. Robinson, Qi Wang
%
% All Rights Reserved.

% ProblemSimple class
classdef ProblemSimple < Problem

  % Properties (private set access)
  properties (SetAccess = private)
    
    initialPoint      = [4;2]
    name              = 'Simple'
    numberOfVariables = 2
    
  end % properties (private set access)

  % Methods (public access)
  methods (Access = public)
    
    %%%%%%%%%%%%%%%
    % CONSTRUCTOR %
    %%%%%%%%%%%%%%%
    
    % Constructor
    function P = ProblemSimple, end
    
    %%%%%%%%%%%%%%%%%%%%
    % EVALUATE METHODS %
    %%%%%%%%%%%%%%%%%%%%

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
    
  end % methods (public access)
  
end % ProblemSimple