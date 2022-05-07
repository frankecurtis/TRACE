% Copyright (C) 2022 Frank E. Curtis, Daniel P. Robinson, Qi Wang
%
% All Rights Reserved.

% ProblemCUTEst class
classdef ProblemCUTEst < Problem
  
  % Properties (private set access)
  properties (SetAccess = private)
    
    initialPoint
    name
    numberOfVariables
    
  end % properties (private set access)
  
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
      P.initialPoint = prob.x;
      
      % Set number of variables
      P.numberOfVariables = prob.n;
      
      % Set name
      P.name = prob.name;
      
    end % Constructor
    
    %%%%%%%%%%
    % DELETE %
    %%%%%%%%%%
    
    % Descructor
    function delete(P)
      
      % Terminate CUTEst
      cutest_terminate;
      
    end % destructor
    
    %%%%%%%%%%%%%%%%%%%%
    % EVALUATE METHODS %
    %%%%%%%%%%%%%%%%%%%%
    
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
        
  end % methods (public access)
  
end % ProblemCUTEst