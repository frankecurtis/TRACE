% Copyright (C) 2022 Frank E. Curtis, Daniel P. Robinson, Qi Wang
%
% All Rights Reserved.

% TRACE: addOptions
function addOptions(T)

% Add options from quantities
T.quantities_.addOptions(T.options_,T.reporter_);

% Add options from strategies
T.strategies_.addOptions(T.options_,T.reporter_);

end % addOptions