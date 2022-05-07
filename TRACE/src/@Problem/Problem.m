% Copyright (C) 2022 Frank E. Curtis, Daniel P. Robinson, Qi Wang
%
% All Rights Reserved.

% Problem class
classdef (Abstract) Problem < handle

  % Properties (abstract, private set access)
  properties (Abstract, SetAccess = private)
    
    initialPoint
    name
    numberOfVariables
    
  end % properties (abstract, private set access)
  
  % Methods (abstract)
  methods (Abstract)
    
    % Objective function
    [f,err] = evaluateObjectiveFunction(P,x)
    
    % Objective gradient
    [g,err] = evaluateObjectiveGradient(P,x)
    
    % Objective Hessian
    [H,err] = evaluateObjectiveHessian(P,x)
    
  end % methods (abstract)
  
end % Problem