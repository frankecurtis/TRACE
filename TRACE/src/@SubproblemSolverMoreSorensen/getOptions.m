% Copyright (C) 2022 Frank E. Curtis, Daniel P. Robinson, Qi Wang
%
% All Rights Reserved.

% SubproblemSolverMoreSorensen: getOptions
function getOptions(S,options,reporter)

% Get options
S.iteration_limit_ = options.getOption(reporter,'iteration_limit');
S.tolerance_ = options.getOption(reporter,'tolerance');

end % getOptions