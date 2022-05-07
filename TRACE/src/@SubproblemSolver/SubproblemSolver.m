% Copyright (C) 2022 Frank E. Curtis, Daniel P. Robinson, Qi Wang
%
% All Rights Reserved.

% SubproblemSolver class
classdef (Abstract) SubproblemSolver < Strategy

  % Properties (abstract, constant)
  properties (Abstract, Constant)
    
    name
    
  end % properties (abstract, constant)
  
  % Methods (abstract, static)
  methods (Abstract, Static)
    
    % Add options
    addOptions(options,reporter)
    
  end % methods (abstract, static)
  
  % Methods (abstract)
  methods (Abstract)
    
    % Print iteration header
    printIterationHeader(S,reporter)
    
    % Print iteration values
    printIterationValues(S,quantities,reporter)
    
    % Get options
    getOptions(S,options,reporter)
    
    % Initialize
    initialize(S,options,quantities,reporter)
    
    % Solve subproblem
    solveSubproblem(S,options,quantities,reporter,strategies)
    
  end % methods (abstract)
  
end % SubproblemSolver