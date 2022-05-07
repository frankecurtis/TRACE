% Copyright (C) 2022 Frank E. Curtis, Daniel P. Robinson, Qi Wang
%
% All Rights Reserved.

% AcceptabilityCheckRatio: checkAcceptability
function err = checkAcceptability(A,options,quantities,reporter,strategies)

% Initialize error
err = false;

% Evaluate actual reduction
quantities.setActualReduction(quantities.currentIterate.objectiveFunction(quantities) ...
  - quantities.trialIterate.objectiveFunction(quantities));

% Evaluate model reduction
quantities.setModelReduction(-quantities.currentIterate.objectiveGradient(quantities)'*quantities.step ...
  - 0.5*quantities.step'*quantities.currentIterate.objectiveHessian(quantities)*quantities.step);

% Check ratio
if quantities.actualReduction >= A.successful_tolerance_ * quantities.modelReduction
  
  % Update iterate
  quantities.updateIterate;
  
  % Check ratio
  if quantities.actualReduction >= A.very_successful_tolerance_ * quantities.modelReduction
  
    % Increase radius
    quantities.updateTrustRegionRadius(A.trust_region_radius_increase_factor_);
    
  end

  % Increase iteration counter
  quantities.incrementIterationCounter;

else
  
  % Decrease radius
  quantities.updateTrustRegionRadius(A.trust_region_radius_decrease_factor_);
  
  % Increase inner iteration counter
  quantities.incrementInnerIterationCounter;
  
end
  
end % checkAcceptability