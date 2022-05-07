% Copyright (C) 2022 Frank E. Curtis, Daniel P. Robinson, Qi Wang
%
% All Rights Reserved.

% SubproblemSolverMoreSorensen class
classdef SubproblemSolverMoreSorensen < SubproblemSolver
  
  % Properties (constant)
  properties (Constant)
    
    name = 'MoreSorensen'
        
  end % properties (constant)
  
  % Properties (private get and set access)
  properties (GetAccess = private, SetAccess = private)
    
    %%%%%%%%%%%
    % OPTIONS %
    %%%%%%%%%%%
    iteration_limit_
    tolerance_
    
  end % properties (private get and set access)
  
  % Methods (static)
  methods (Static)
    
    %%%%%%%%%%%%%%%%%%%
    % OPTIONS METHODS %
    %%%%%%%%%%%%%%%%%%%
    
    % Add options
    addOptions(options,reporter)
    
  end % methods (static)
  
  % Methods (public access)
  methods (Access = public)
    
    %%%%%%%%%%%%%%%
    % CONSTRUCTOR %
    %%%%%%%%%%%%%%%
    
    % Constructor
    function S = SubproblemSolverMoreSorensen, end
    
    %%%%%%%%%%%%%%%%%
    % PRINT METHODS %
    %%%%%%%%%%%%%%%%%
    
    % Print iteration header
    printIterationHeader(S,reporter)
    
    % Print iteration values
    printIterationValues(S,quantities,reporter)
    
    %%%%%%%%%%%%%%%%%%%
    % OPTIONS METHODS %
    %%%%%%%%%%%%%%%%%%%
    
    % Get options
    getOptions(S,options,reporter)
    
    %%%%%%%%%%%%%%%%%%%%%%
    % INITIALIZE METHODS %
    %%%%%%%%%%%%%%%%%%%%%%
    
    % Initialize
    initialize(S,options,quantities,reporter)
    
    %%%%%%%%%%%%%%%%%%%
    % COMPUTE METHODS %
    %%%%%%%%%%%%%%%%%%%
    
    % Minimum eigenpair
    [eig_val,eig_vec] = minimumEigenpair(S,quantities,lambda)

    % Minimum eigenpair
    err = optimalityError(S,quantities)
    
    % Solve subproblem
    solveSubproblem(S,options,quantities,reporter,strategies)
    
  end % methods (public access)
  
end % SubproblemSolverMoreSorensen