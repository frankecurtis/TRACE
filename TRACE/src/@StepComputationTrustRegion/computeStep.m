% Copyright (C) 2022 Frank E. Curtis, Daniel P. Robinson, Qi Wang
%
% All Rights Reserved.

% StepComputationTrustRegion: computeStep
function err = computeStep(S,options,quantities,reporter,strategies)

% Initialize error
err = false;

% Set subproblem data
quantities.setSubproblemMatrix(quantities.currentIterate.objectiveHessian(quantities));
quantities.setSubproblemVector(quantities.currentIterate.objectiveGradient(quantities));

% Solve subproblem
strategies.subproblemSolver.solveSubproblem(options,quantities,reporter,strategies);

% Check for error
if quantities.subproblemStatus >= Enumerations.SS_ITERATION_LIMIT && S.fail_on_solver_failure_
  err = true;
end

% Set step
quantities.setStep(quantities.subproblemStep);

% Set trust region multiplier
quantities.setTrustRegionMultiplier(quantities.subproblemMultiplier);

% Set cubic multiplier
quantities.setCubicMultiplier(quantities.subproblemMultiplier/norm(quantities.subproblemStep));

% Set trial iterate
trial_iterate = Point(quantities.currentIterate,quantities.currentIterate.point + quantities.step);

% Set trial iterate
quantities.setTrialIterate(trial_iterate);
  
end % computeStep