% Copyright (C) 2022 Frank E. Curtis, Daniel P. Robinson, Qi Wang
%
% All Rights Reserved.

% TRACE: optimize
function optimize(T,problem)

% Get options
T.getOptions;

% Initialize quantities
T.quantities_.initialize(problem);

% Scale problem
T.quantities_.currentIterate.determineScaleFactors(T.quantities_);

% Initialize strategies
T.strategies_.initialize(T.options_,T.quantities_,T.reporter_);

% Print header
T.printHeader(problem);

% Main loop
while true
  
  % Print iteration header
  T.printIterationHeader;
  
  % Print iteration quantities
  T.quantities_.printIterationValues(T.reporter_);
  
  % Check for termination of best iterate
  if T.quantities_.stationaritySatisfied, T.status_ = Enumerations.S_SUCCESS; break; end

  % Check for CPU time termination
  if T.quantities_.limitExceededCPU, T.status_ = Enumerations.S_CPU_TIME_LIMIT; break; end
  
  % Check for termination on problem size limit
  if T.quantities_.limitExceededSize, T.status_ = Enumerations.S_SIZE_LIMIT; break; end
  
  % Check for termination on iteration limit
  if T.quantities_.limitExceededIterations, T.status_ = Enumerations.S_ITERATION_LIMIT; break; end
  
  % Check for termination on evaluation limit
  if T.quantities_.limitExceededEvaluations, T.status_ = Enumerations.S_EVALUATION_LIMIT; break; end
  
  % Check whether to check derivatives
  if T.quantities_.checkDerivatives, T.quantities_.currentIterate.checkDerivatives(T.quantities_); end
  
  % Compute search direction (sets direction)
  err = T.strategies_.directionComputation.computeDirection(T.options_,T.quantities_,T.reporter_,T.strategies_);
  
  % Check for error
  if err == true, T.status_ = Enumerations.S_DIRECTION_COMPUTATION_FAILURE; break; end
  
  % Print direction computation values
  T.strategies_.directionComputation.printIterationValues(T.quantities_,T.reporter_);
  
  % Update current iterate to trial iterate
  T.quantities_.updateIterate;
  
  % Increment iteration counter
  T.quantities_.incrementIterationCounter;
  
  % Print new line
  T.reporter_.printf(Enumerations.R_SOLVER,Enumerations.R_PER_ITERATION,'\n');
  
end % main loop

% Print new line
T.reporter_.printf(Enumerations.R_SOLVER,Enumerations.R_PER_ITERATION,'\n');

% Print footer
T.printFooter;

end % optimize