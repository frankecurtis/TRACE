% Copyright (C) 2022 Frank E. Curtis, Daniel P. Robinson, Qi Wang
%
% All Rights Reserved.

% SubproblemSolverMoreSorensen: addOptions
function addOptions(options,reporter)

% Add double options
options.addDoubleOption(reporter,'tolerance',1e-08,0,inf);

% Add integer options
options.addIntegerOption(reporter,'iteration_limit',1e+02,0,inf);

end % addOptions