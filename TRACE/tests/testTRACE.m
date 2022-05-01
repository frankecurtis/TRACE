% Copyright (C) 2022 Frank E. Curtis, Daniel P. Robinson, Qi Wang
%
% All Rights Reserved.

function testTRACE

% Add source code to path
addpath('../problems/');
addpath('../src/');
addpath('/usr/local/opt/cutest/libexec/src/matlab');

% Declare algorithm
T = TRACE;

% Declare problem
P = ProblemSimple;

% Optimize
T.optimize(P);