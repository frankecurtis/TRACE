% Copyright (C) 2022 Frank E. Curtis, Daniel P. Robinson, Qi Wang
%
% All Rights Reserved.

% AcceptabilityCheckRatio class
classdef AcceptabilityCheckRatio < AcceptabilityCheck

  % Properties (constant)
  properties (Constant)
    
    name = 'Ratio'
    
  end % properties (constant)
  
  % Properties (private get and set access)
  properties (GetAccess = private, SetAccess = private)
    
    %%%%%%%%%%%
    % OPTIONS %
    %%%%%%%%%%%
    cubic_multiplier_decrease_factor_
    cubic_multiplier_increase_factor_
    trust_region_multiplier_decrease_factor_
    trust_region_multiplier_increase_factor_
    trust_region_radius_decrease_factor_
    trust_region_radius_increase_factor_
    successful_tolerance_
    very_successful_tolerance_
    
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
    function A = AcceptabilityCheckRatio, end
    
    %%%%%%%%%%%%%%%%%
    % PRINT METHODS %
    %%%%%%%%%%%%%%%%%
    
    % Print iteration header
    printIterationHeader(A,reporter)
    
    % Print iteration values
    printIterationValues(A,quantities,reporter)
    
    %%%%%%%%%%%%%%%%%%%
    % OPTIONS METHODS %
    %%%%%%%%%%%%%%%%%%%
    
    % Get options
    getOptions(A,options,reporter)
    
    %%%%%%%%%%%%%%%%%%%%%%
    % INITIALIZE METHODS %
    %%%%%%%%%%%%%%%%%%%%%%
    
    % Initialize
    initialize(A,options,quantities,reporter)
    
    %%%%%%%%%%%%%%%%%
    % CHECK METHODS %
    %%%%%%%%%%%%%%%%%
    
    % Check acceptability
    err = checkAcceptability(A,options,quantities,reporter,strategies)
    
  end % methods (public access)
  
end % AcceptabilityCheckRatio