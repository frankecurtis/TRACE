% Copyright (C) 2022 Frank E. Curtis, Daniel P. Robinson, Qi Wang
%
% All Rights Reserved.

% TRACE: getOptions
function getOptions(T)

% Get options for quantities
T.quantities_.getOptions(T.options_,T.reporter_);

% Get options for strategies
T.strategies_.getOptions(T.options_,T.reporter_);

end % getOptions