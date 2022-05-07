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
  
  % Properties (private set access)
  properties (SetAccess = private)
    
    options
    quantities
    reporter
    status
    strategies
    
  end % properties (private set access)
  
  % Methods (public access)
  methods (Access = public)
    
    %%%%%%%%%%%%%%%
    % CONSTRUCTOR %
    %%%%%%%%%%%%%%%
    
    % Constructor
    function T = TRACE
      
      % Set options
      T.options = Options;
      
      % Set quantities
      T.quantities = Quantities;
      
      % Set reporter
      T.reporter = Reporter;
      
      % Set strategies
      T.strategies = Strategies;
      
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
      x = T.quantities.currentIterate.point;
      f = T.quantities.currentIterate.objectiveFunction(T.quantities);
      stationarity_error = T.quantities_.currentIterate.stationarityError(T.quantities);
      
    end % finalIterate
    
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