% Copyright (C) 2022 Frank E. Curtis, Daniel P. Robinson, Qi Wang
%
% All Rights Reserved.

% Enumerations class
classdef Enumerations < uint8
  
  enumeration
    
    %%%%%%%%%%%%%%%%%%
    % REPORTER TYPES %
    %%%%%%%%%%%%%%%%%%
    R_SOLVER (0)
    R_SUBSOLVER (1)
    
    %%%%%%%%%%%%%%%%%%%
    % REPORTER LEVELS %
    %%%%%%%%%%%%%%%%%%%
    R_BASIC (0)
    R_PER_ITERATION (1)
    R_PER_INNER_ITERATION (2)
    R_DETAILED (3)
    
    %%%%%%%%%%%%%%%%%%%
    % SOLVER STATUSES %
    %%%%%%%%%%%%%%%%%%%
    S_UNSET (0)
    S_SUCCESS (1)
    S_CPU_TIME_LIMIT (2)
    S_SIZE_LIMIT (3)
    S_ITERATION_LIMIT (4)
    S_EVALUATION_LIMIT (5)
    S_STEP_COMPUTATION_FAILURE (6)
    S_ACCEPTABILITY_CHECK_FAILURE (7)

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % SUBPROBLEM SOLVER STATUSES %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    SS_UNSET (0)
    SS_SUCCESS (1)
    SS_SUCCESS_HARD (2)
    SS_ITERATION_LIMIT (3)

  end % enumeration
  
end % Enumerations