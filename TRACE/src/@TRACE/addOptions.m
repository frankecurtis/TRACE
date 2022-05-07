% Copyright (C) 2022 Frank E. Curtis, Daniel P. Robinson, Qi Wang
%
% All Rights Reserved.

% TRACE: addOptions
function addOptions(T)

% Add options from quantities
T.quantities.addOptions(T.options,T.reporter);

% Add options from strategies
T.strategies.addOptions(T.options,T.reporter);

end % addOptions