% Copyright (C) 2022 Frank E. Curtis, Daniel P. Robinson, Qi Wang
%
% All Rights Reserved.

% Quantities: initializeParameters
function initializeParameters(Q)

% Set initial stationarity error
Q.initial_stationarity_error_ = Q.currentIterate.stationarityError(Q);

% Set cubic multiplier
Q.cubicMultiplier = max(Q.cubic_multiplier_initial_minimum_,...
                        min(Q.cubic_multiplier_initial_factor_/Q.currentIterate.objectiveGradientNorm2(Q),...
                            Q.cubic_multiplier_initial_maximum_));

% Set trust region radius
Q.trustRegionRadius = max(Q.trust_region_initial_minimum_,...
                          min(Q.trust_region_initial_factor_*Q.currentIterate.objectiveGradientNorm2(Q),...
                              Q.trust_region_initial_maximum_));

end % initialize