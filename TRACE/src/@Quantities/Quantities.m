% Copyright (C) 2022 Frank E. Curtis, Daniel P. Robinson, Qi Wang
%
% All Rights Reserved.

% Quantities class
classdef Quantities < handle
  
  % Properties (private set access)
  properties (SetAccess = private)
    
    %%%%%%%%%%%%%%%%%%%%%%%%
    % ALGORITHM QUANTITIES %
    %%%%%%%%%%%%%%%%%%%%%%%%
    actualReduction
    cubicMultiplier
    currentIterate
    modelReduction
    step
    subproblemError
    subproblemMatrix
    subproblemMultiplier
    subproblemStatus
    subproblemStep
    subproblemVector
    subproblemVectorNorm2
    trialIterate
    trustRegionMultiplier
    trustRegionRadius
    
    %%%%%%%%%%%
    % OPTIONS %
    %%%%%%%%%%%
    checkDerivatives
    
    %%%%%%%%%%%%
    % COUNTERS %
    %%%%%%%%%%%%
    innerIterationCounter = 0
    innerIterationTotalCounter = 0
    iterationCounter = 0
    objectiveFunctionEvaluationCounter = 0
    objectiveGradientEvaluationCounter = 0
    objectiveHessianEvaluationCounter = 0
    
    %%%%%%%%%%%%%%
    % INDICATORS %
    %%%%%%%%%%%%%%
    scaleProblem
    
    %%%%%%%%%%%%%%
    % TOLERANCES %
    %%%%%%%%%%%%%%
    cpuTimeLimit
    innerIterationLimit
    iterationLimit
    objectiveFunctionEvaluationLimit
    objectiveGradientEvaluationLimit
    objectiveHessianEvaluationLimit
    scaleFactorGradientLimit
    sizeLimit
    stationarityTolerance
    
  end % properties (private set access)
  
  % Properties (private get and set access)
  properties (GetAccess = private, SetAccess = private)
    
    %%%%%%%%%%%%%%%%%%%%%%%%
    % ALGORITHM QUANTITIES %
    %%%%%%%%%%%%%%%%%%%%%%%%
    cubic_multiplier_initial_factor_
    cubic_multiplier_initial_maximum_
    cubic_multiplier_initial_minimum_
    initial_stationarity_error_
    trust_region_initial_factor_
    trust_region_initial_maximum_
    trust_region_initial_minimum_
    
  end
  
  % Methods (static)
  methods (Static)
    
    %%%%%%%%%%%%%%%%%%%
    % OPTIONS METHODS %
    %%%%%%%%%%%%%%%%%%%
    
    % Add options
    addOptions(options,reporter)
    
    %%%%%%%%%%%%%%%
    % GET METHODS %
    %%%%%%%%%%%%%%%
    
    % CPU time
    function cpu = cpuTime
      
      % Set return value
      cpu = toc;
      
    end % CPUTime
    
  end
  
  % Methods (public access)
  methods (Access = public)
    
    %%%%%%%%%%%%%%%
    % CONSTRUCTOR %
    %%%%%%%%%%%%%%%
    
    % Constructor
    function Q = Quantities(varargin), end
    
    %%%%%%%%%%%%%%%%%
    % PRINT METHODS %
    %%%%%%%%%%%%%%%%%
    
    % Print iteration header
    printIterationHeader(Q,reporter)
    
    % Print iteration values
    printIterationValues(Q,reporter)
    
    %%%%%%%%%%%%%%%%%%%
    % OPTIONS METHODS %
    %%%%%%%%%%%%%%%%%%%
    
    % Get options
    getOptions(Q,options,reporter)
    
    %%%%%%%%%%%%%%%%%%%%%%
    % INITIALIZE METHODS %
    %%%%%%%%%%%%%%%%%%%%%%
    
    % Initialize
    initialize(Q,problem)
    
    % Initialize parameters
    initializeParameters(Q)
        
    %%%%%%%%%%%%%%%%%
    % Check METHODS %
    %%%%%%%%%%%%%%%%%
    
    % Check exceeded limit, CPU
    function b = limitExceededCPU(Q)
      
      % Check limit
      b = (Q.cpuTime >= Q.cpuTimeLimit);
      
    end % limitExceededCPU
    
    % Check exceeded limit, evaluations
    function b = limitExceededEvaluations(Q)
      
      % Check limit
      b = (Q.objectiveFunctionEvaluationCounter > Q.objectiveFunctionEvaluationLimit || ...
        Q.objectiveGradientEvaluationCounter > Q.objectiveGradientEvaluationLimit || ...
        Q.objectiveHessianEvaluationCounter > Q.objectiveHessianEvaluationLimit);
      
    end % limitExceededEvaluations
    
    % Check exceeded limit, iterations
    function b = limitExceededIterations(Q)
      
      % Check limit
      b = (Q.innerIterationTotalCounter > Q.innerIterationLimit || ...
        Q.iterationCounter > Q.iterationLimit);
      
    end % limitExceededIterations
    
    % Check exceeded limit, size
    function b = limitExceededSize(Q)
      
      % Check limit
      b = (Q.currentIterate.numberOfVariables > Q.sizeLimit);
      
    end % limitExceededSize
    
    % Check stationarity satisfied
    function b = stationaritySatisfied(Q)
      
      % Check condition
      b = (Q.currentIterate.stationarityError(Q) <= max(1,Q.initial_stationarity_error_) * Q.stationarityTolerance);
      
    end % stationaritySatisfied
    
    %%%%%%%%%%%%%%%
    % SET METHODS %
    %%%%%%%%%%%%%%%
    
    % Set actual reduction
    function setActualReduction(Q,actualReduction)
      
      % Set actual reduction
      Q.actualReduction = actualReduction;
      
    end % setActualReduction
    
    % Set cubic multiplier
    function setCubicMultiplier(Q,cubicMultiplier)
      
      % Set cubic multiplier
      Q.cubicMultiplier = cubicMultiplier;
      
    end % setCubicMultiplier
    
    % Set model reduction
    function setModelReduction(Q,modelReduction)
      
      % Set model reduction
      Q.modelReduction = modelReduction;
      
    end % setModelReduction
    
    % Set step
    function setStep(Q,step)
      
      % Set step
      Q.step = step;
      
    end % setStep
    
    % Set subproblem error
    function setSubproblemError(Q,error)
      
      % Set subproblem error
      Q.subproblemError = error;
      
    end % setSubproblemError
    
    % Set subproblem matrix
    function setSubproblemMatrix(Q,matrix)
      
      % Set subproblem matrix
      Q.subproblemMatrix = matrix;
      
    end % setSubproblemMatrix
    
    % Set subproblem multiplier
    function setSubproblemMultiplier(Q,multiplier)
      
      % Set subproblem multiplier
      Q.subproblemMultiplier = multiplier;
      
    end % setsubproblemMultiplier
    
    % Set subproblem status
    function setSubproblemStatus(Q,status)
      
      % Set subproblem status
      Q.subproblemStatus = status;
      
    end % setSubproblemStatus
    
    % Set subproblem step
    function setSubproblemStep(Q,step)
      
      % Set subproblem step
      Q.subproblemStep = step;
      
    end % setSubproblemStep
    
    % Set subproblem vector
    function setSubproblemVector(Q,vector)
      
      % Set subproblem vector
      Q.subproblemVector = vector;
      
      % Set subproblem vector 2-norm
      Q.subproblemVectorNorm2 = norm(vector);
      
    end % setSubproblemVector
    
    % Set trial iterate
    function setTrialIterate(Q,iterate)
      
      % Set trial iterate
      Q.trialIterate = iterate;
      
    end % setTrialIterate
    
    % Set trust region multiplier
    function setTrustRegionMultiplier(Q,multiplier)
      
      % Set trust region multiplier
      Q.trustRegionMultiplier = multiplier;
      
    end % setTrustRegionMultiplier
    
    % Set trust region radius
    function setTrustRegionRadius(Q,radius)
      
      % Set trust region radius
      Q.trustRegionRadius = radius;
      
    end % setTrustRegionRadius
    
    % Update cubic multiplier
    function updateCubicMultiplier(Q,factor)
      
      % Multiply by factor
      Q.cubicMultiplier = Q.cubicMultiplier * factor;
      
    end % updateCubicMultiplier
    
    % Update iterate
    function updateIterate(Q)
      
      % Set current iterate to trial iterate
      Q.currentIterate = Q.trialIterate;
      
    end % updateIterate
    
    % Update trust region multiplier
    function updateTrustRegionMultiplier(Q,factor)
      
      % Multiply by factor
      Q.trustRegionMultiplier = Q.trustRegionMultiplier * factor;
      
    end % updateTrustRegionMultiplier
    
    % Update trust region radius
    function updateTrustRegionRadius(Q,factor)
      
      % Multiply by factor
      Q.trustRegionRadius = Q.trustRegionRadius * factor;
      
    end % updateTrustRegionRadius
    
    %%%%%%%%%%%%%%%%%%%%%
    % INCREMENT METHODS %
    %%%%%%%%%%%%%%%%%%%%%
    
    % Increment inner iteration counter
    function incrementInnerIterationCounter(Q)
      
      % Increment inner iteration counter
      Q.innerIterationCounter = Q.innerIterationCounter + 1;
      
    end % incrementInnerIterationCounter
    
    % Increment iteration counter
    function incrementIterationCounter(Q)
      
      % Increment iteration counter
      Q.iterationCounter = Q.iterationCounter + 1;
      
      % Increment total inner iteration counter
      Q.innerIterationTotalCounter = Q.innerIterationTotalCounter + Q.innerIterationCounter + 1;
      
      % Reset inner iteration counter
      Q.innerIterationCounter = 0;
      
    end % incrementIterationCounter
    
    % Increment objective function evaluation counter
    function incrementObjectiveFunctionEvaluationCounter(Q)
      
      % Increment objective function evaluation counter
      Q.objectiveFunctionEvaluationCounter = Q.objectiveFunctionEvaluationCounter + 1;
      
    end % incrementObjectiveFunctionEvaluationCounter
    
    % Increment objective gradient evaluation counter
    function incrementObjectiveGradientEvaluationCounter(Q)
      
      % Increment objective gradient evaluation counter
      Q.objectiveGradientEvaluationCounter = Q.objectiveGradientEvaluationCounter + 1;
      
    end % incrementObjectiveGradientEvaluationCounter
    
    % Increment objective Hessian evaluation counter
    function incrementObjectiveHessianEvaluationCounter(Q)
      
      % Increment objective Hessian evaluation counter
      Q.objectiveHessianEvaluationCounter = Q.objectiveHessianEvaluationCounter + 1;
      
    end % incrementObjectiveHessianEvaluationCounter
    
  end % methods (public access)
  
end % Quantities