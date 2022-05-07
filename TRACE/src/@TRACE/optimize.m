% Copyright (C) 2022 Frank E. Curtis, Daniel P. Robinson, Qi Wang
%
% All Rights Reserved.

% TRACE: optimize
function optimize(T,problem)

% Initialize status
T.status = Enumerations.S_UNSET;

% Get options
T.getOptions;

% Initialize quantities
T.quantities.initialize(problem);

% Scale problem
T.quantities.currentIterate.determineScaleFactors(T.quantities);

% Store initial stationarity
T.quantities.initializeParameters;

% Initialize strategies
T.strategies.initialize(T.options,T.quantities,T.reporter);

% Print header
T.printHeader(problem);

% Main loop
while true
  
  % Print iteration header
  T.printIterationHeader;
  
  % Print iteration quantities
  T.quantities.printIterationValues(T.reporter);
  
  % Check for termination of best iterate
  if T.quantities.stationaritySatisfied, T.status = Enumerations.S_SUCCESS; break; end

  % Check for CPU time termination
  if T.quantities.limitExceededCPU, T.status = Enumerations.S_CPU_TIME_LIMIT; break; end
  
  % Check for termination on problem size limit
  if T.quantities.limitExceededSize, T.status = Enumerations.S_SIZE_LIMIT; break; end
  
  % Check for termination on iteration limit
  if T.quantities.limitExceededIterations, T.status = Enumerations.S_ITERATION_LIMIT; break; end
  
  % Check for termination on evaluation limit
  if T.quantities.limitExceededEvaluations, T.status = Enumerations.S_EVALUATION_LIMIT; break; end
  
  % Check whether to check derivatives
  if T.quantities.checkDerivatives, T.quantities.currentIterate.checkDerivatives(T.quantities); end
  
  % Compute step
  err = T.strategies.stepComputation.computeStep(T.options,T.quantities,T.reporter,T.strategies);
  
  % Check for error
  if err == true, T.status = Enumerations.S_STEP_COMPUTATION_FAILURE; break; end
  
  % Print subproblem solve and step computation values
  T.strategies.subproblemSolver.printIterationValues(T.quantities,T.reporter);
  T.strategies.stepComputation.printIterationValues(T.quantities,T.reporter);
  
  % Check acceptability
  err = T.strategies.acceptabilityCheck.checkAcceptability(T.options,T.quantities,T.reporter,T.strategies);
  
  % Check for error
  if err == true, T.status = Enumerations.S_ACCEPTABILITY_CHECK_FAILURE; break; end
  
  % Print acceptability check values
  T.strategies.acceptabilityCheck.printIterationValues(T.quantities,T.reporter);
  
  % Print new line
  T.reporter.printf(Enumerations.R_SOLVER,Enumerations.R_PER_ITERATION,'\n');
  
end % main loop

% Print new line
T.reporter.printf(Enumerations.R_SOLVER,Enumerations.R_PER_ITERATION,'\n');

% Print footer
T.printFooter;

end % optimize