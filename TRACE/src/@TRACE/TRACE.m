% Copyright (C) 2022 Frank E. Curtis, Daniel P. Robinson, Qi Wang
%
% All Rights Reserved.
%
% TRACE
%
% Constructors:
%
%   T = TRACE
%
% Public methods:
%
%   T.optimize(problem)
%       Runs optimization algorithm.
%
%   [x,f,stationarity_error] = finalIterate(T)
%       Returns final iterate.
%
%   o = options(T)
%       Returns options object.
%
%   r = reporter(T)
%       Returns reporter object.

% TRACE class
classdef TRACE < handle
  
  % Properties (private access)
  properties (SetAccess = private, GetAccess = private)
    
    %%%%%%%%%%%
    % Members %
    %%%%%%%%%%%
    options_
    quantities_
    reporter_
    status_
    strategies_
    
  end
  
  % Methods (public access)
  methods (Access = public)
    
    %%%%%%%%%%%%%%%
    % CONSTRUCTOR %
    %%%%%%%%%%%%%%%
    
    % Constructor
    function T = TRACE
      
      % Set options
      T.options_ = Options;
      
      % Set quantities
      T.quantities_ = Quantities;
      
      % Set reporter
      T.reporter_ = Reporter;
      
      % Set strategies
      T.strategies_ = Strategies;
      
      % Add options
      T.addOptions;
      
    end % Constructor
    
    %%%%%%%%%%%%
    % OPTIMIZE %
    %%%%%%%%%%%%
    
    % Optimize
    optimize(T,problem)
    
    %%%%%%%%%%%%%%%
    % GET METHODS %
    %%%%%%%%%%%%%%%
    
    % Final iterate
    function [x,f,stationarity_error] = finalIterate(T)
      
      % Set return values
      x = T.quantities_.currentIterate.point;
      f = T.quantities_.currentIterate.objectiveFunction(T.quantities_);
      stationarity_error = T.quantities_.currentIterate.stationarityError(T.quantities_);
      
    end % finalIterate
    
    % Options
    function o = options(T)
      
      % Set return value
      o = T.options_;
      
    end % options
    
    % Reporter
    function r = reporter(T)
      
      % Set return value
      r = T.reporter_;
      
    end % reporter
    
  end % methods (public access)
  
  % Methods (private access)
  methods (Access = private)
    
    %%%%%%%%%%%%%%%%%
    % PRINT METHODS %
    %%%%%%%%%%%%%%%%%
    
    % Print footer
    printFooter(T)
    
    % Print header
    printHeader(T,P)
    
    % Print iteration header
    printIterationHeader(T)
    
    %%%%%%%%%%%%%%%%%%%
    % OPTIONS METHODS %
    %%%%%%%%%%%%%%%%%%%
    
    % Add options
    addOptions(T)
    
    % Get options
    getOptions(T)
    
  end % methods (private access)
  
end % TRACE