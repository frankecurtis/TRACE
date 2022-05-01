% Copyright (C) 2022 Frank E. Curtis, Daniel P. Robinson, Qi Wang
%
% All Rights Reserved.

% Problem class
classdef (Abstract) Problem < handle
  
  % Methods (abstract)
  methods (Abstract)
    
    % Objective function
    [f,err] = evaluateObjectiveFunction(P,x)
    
    % Objective gradient
    [g,err] = evaluateObjectiveGradient(P,x)
    
    % Objective Hessian
    [H,err] = evaluateObjectiveHessian(P,x)
    
    % Initial point
    x = initialPoint(P)
    
    % Name
    s = name(P)
    
    % Number of variables
    n = numberOfVariables(P)
    
  end % methods (abstract)
  
end % Problem