% Copyright (C) 2022 Frank E. Curtis, Daniel P. Robinson, Qi Wang
%
% All Rights Reserved.

% SubproblemSolverMoreSorensen: optimalityError
function err = optimalityError(S,quantities)

% Compute optimality error
err = norm([quantities.subproblemVector + (quantities.subproblemMatrix + quantities.subproblemMultiplier * speye(length(quantities.subproblemStep))) * quantities.subproblemStep;
            min(0,quantities.subproblemStep'*(quantities.subproblemMatrix + quantities.subproblemMultiplier * speye(length(quantities.subproblemStep))) * quantities.subproblemStep);
            min(0,quantities.subproblemMultiplier);
            min(0,quantities.trustRegionRadius - norm(quantities.subproblemStep));
            quantities.subproblemMultiplier*(quantities.trustRegionRadius - norm(quantities.subproblemStep))],inf);

end