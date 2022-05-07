% Copyright (C) 2022 Frank E. Curtis, Daniel P. Robinson, Qi Wang
%
% All Rights Reserved.

% TRACE: getOptions
function getOptions(T)

% Get options for quantities
T.quantities.getOptions(T.options,T.reporter);

% Get options for strategies
T.strategies.getOptions(T.options,T.reporter);

end % getOptions