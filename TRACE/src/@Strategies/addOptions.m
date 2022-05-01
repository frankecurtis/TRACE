% Copyright (C) 2022 Frank E. Curtis, Daniel P. Robinson, Qi Wang
%
% All Rights Reserved.

% Strategies: addOptions
function addOptions(options,reporter)

% Add options
options.addStringOption(reporter,'direction_computation','TrustRegion');

% Add direction computation options
d = DirectionComputationTrustRegion;
d.addOptions(options,reporter);

end % addOptions