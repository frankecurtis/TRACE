% Copyright (C) 2022 Frank E. Curtis, Daniel P. Robinson, Qi Wang
%
% All Rights Reserved.

% Strategies: getOptions
function getOptions(S,options,reporter)

% Get strategies options
acceptability_check_name = options.getOption(reporter,'acceptability_check');
step_computation_name = options.getOption(reporter,'step_computation');
subproblem_solver_name = options.getOption(reporter,'subproblem_solver');

% Switch on acceptability check names
switch acceptability_check_name
  case 'Ratio'
    S.acceptabilityCheck = AcceptabilityCheckRatio;
  %case ...
  otherwise
    S.acceptabilityCheck = AcceptabilityCheckRatio;
end

% Switch on step computation names
switch step_computation_name
  case 'TrustRegion'
    S.stepComputation = StepComputationTrustRegion;
  %case ...
  otherwise
    S.stepComputation = StepComputationTrustRegion;
end

% Switch on subproblem solver names
switch subproblem_solver_name
  case 'MoreSorensen'
    S.subproblemSolver = SubproblemSolverMoreSorensen;
  %case ...
  otherwise
    S.subproblemSolver = SubproblemSolverMoreSorensen;
end

% Get options
S.acceptabilityCheck.getOptions(options,reporter);
S.stepComputation.getOptions(options,reporter);
S.subproblemSolver.getOptions(options,reporter);

end % getOptions