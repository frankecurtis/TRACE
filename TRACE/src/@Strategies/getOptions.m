% Copyright (C) 2022 Frank E. Curtis, Daniel P. Robinson, Qi Wang
%
% All Rights Reserved.

% Strategies: getOptions
function getOptions(S,options,reporter)

% Get strategies options
direction_computation_name = options.getOption(reporter,'direction_computation');

% Switch on direction computation names
switch direction_computation_name
  case 'TrustRegion'
    S.direction_computation_ = DirectionComputationTrustRegion;
  %case ???
  otherwise
    S.direction_computation_ = DirectionComputationTrustRegion;
end

% Get options
S.direction_computation_.getOptions(options,reporter);

end % getOptions