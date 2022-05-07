% Copyright (C) 2022 Frank E. Curtis, Daniel P. Robinson, Qi Wang
%
% All Rights Reserved.

% Quantities: initialize
function initialize(Q,problem)

% Start clock
tic;

% Set current iterate
Q.currentIterate = Point(problem);

end % initialize