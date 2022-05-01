% Copyright (C) 2022 Frank E. Curtis, Daniel P. Robinson, Qi Wang
%
% All Rights Reserved.

% ProblemCUTEst class
classdef ProblemCUTEst < Problem
  
  % Properties (private access)
  properties (SetAccess = private, GetAccess = private)
    
    %%%%%%%%%%%
    % MEMBERS %
    %%%%%%%%%%%
    x % initial point
    n % number of variables
    s % name
    
  end % properties (private access)
  
  % Methods (public access)
  methods (Access = public)
    
    %%%%%%%%%%%%%%%
    % CONSTRUCTOR %
    %%%%%%%%%%%%%%%
    
    % Constructor
    function P = ProblemCUTEst
      
      % Initialize CUTEst
      prob = cutest_setup();
      
      % Get initial point
      P.x = prob.x;
      
      % Set number of variables
      P.n = prob.n;
      
      % Set name
      P.s = prob.name;
      
    end % Constructor
    
    %%%%%%%%%%
    % DELETE %
    %%%%%%%%%%
    
    % Descructor
    function delete(P)
      
      % Terminate CUTEst
      cutest_terminate;
      
    end % destructor
    
    % Objective function
    function [f,err] = evaluateObjectiveFunction(P,x)
      
      % Initialize error
      err = false;
      
      % Evaluate objective function
      try
        f = cutest_obj(x);
      catch
        f = [];
        err = true;
      end
      
    end % evaluateObjectiveFunction
    
    % Objective gradient
    function [g,err] = evaluateObjectiveGradient(P,x)
      
      % Initialize error
      err = false;
      
      % Evaluate objective gradient
      try
        g = cutest_grad(x);
      catch
        g = [];
        err = true;
      end
      
    end % evaluateObjectiveGradient
    
    % Objective Hessian
    function [H,err] = evaluateObjectiveHessian(P,x)
      
      % Initialize error
      err = false;
      
      % Evaluate objective Hessian
      try
        H = cutest_sphess(x,[]);
      catch
        H = [];
        err = true;
      end
      
    end % evaluateObjectiveHessian
    
    % Initial point
    function x = initialPoint(P)
      
      % Set initial point
      x = P.x;
      
    end % initialPoint
    
    % Name
    function s = name(P)
      
      % Set name
      s = P.s;
      
    end % name
    
    % Number of variables
    function n = numberOfVariables(P)
      
      % Set number of variables
      n = P.n;
      
    end % numberOfVariables
    
  end % methods (public access)
  
end % ProblemCUTEst