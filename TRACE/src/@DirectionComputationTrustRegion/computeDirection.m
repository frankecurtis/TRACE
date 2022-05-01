% Copyright (C) 2022 Frank E. Curtis, Daniel P. Robinson, Qi Wang
%
% All Rights Reserved.

% DirectionComputationTrustRegion: computeDirection
function err = computeDirection(D,options,quantities,reporter,strategies)

% Initialize error
err = false;

% TEMPORARY
quantities.setTrialIterate(quantities.currentIterate);
  
end % computeDirection