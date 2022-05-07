% Copyright (C) 2022 Frank E. Curtis, Daniel P. Robinson, Qi Wang
%
% All Rights Reserved.
%
% Note: CGT refers to the Trust Region book by Conn, Gould, and Toint

% SubproblemSolverMoreSorensen: solveSubproblem
function solveSubproblem(S,options,quantities,reporter,strategies)

% Initialize status
quantities.setSubproblemStatus(0);

% Compute dual variable bound values (see CGT pg. 192)
G_vec     =  abs(quantities.subproblemMatrix)*ones(length(quantities.subproblemVector),1) - abs(diag(quantities.subproblemMatrix));
G_bnds(1) =  max( diag(quantities.subproblemMatrix)+G_vec);
G_bnds(2) =  max(-diag(quantities.subproblemMatrix)+G_vec);
H_bnds    =  min(norm(quantities.subproblemMatrix,'fro'),norm(quantities.subproblemMatrix,inf));
l_max     =  min(G_bnds(1),H_bnds);
l_min     = -min(G_bnds(2),H_bnds);
l_init    =  quantities.subproblemVectorNorm2/quantities.trustRegionRadius;

% Compute minimum eigenpair
[eig_val,eig_vec] = S.minimumEigenpair(quantities,0);

% Replace minimum eigenvalue estimate
l_min = max(l_min,eig_val);

% Set dual variable bounds (see CGT pg. 192)
lambdaL = full(max([0,l_init - l_max,-min(diag(quantities.subproblemMatrix)),-eig_val]));
lambdaU = max([0,l_init - l_min]);

% Set estimate
quantities.setSubproblemMultiplier(lambdaL);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% STEPS INDICATED IN ALGORITHM 7.3.4 (pg. 193) FROM CGT BOOK %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Initialize factorization boolean
fact = 0;

% Initialize iteration counter
k = 1;

% Iteration loop
while 1
  
  %%%%%%%%%%
  % STEP 1 %
  %%%%%%%%%%
  
  % Check for factorization completed
  if fact == 0
    
    % Factorize shifted Hessian
    [L,errChol] = chol(quantities.subproblemMatrix+quantities.subproblemMultiplier*speye(length(quantities.subproblemVector)),'lower');
    
  end
  
  % Check for error
  if errChol == 0
    
    % Solve system
    ls_forw = -(L\quantities.subproblemVector);
    quantities.setSubproblemStep((ls_forw'/L)');
    
    % Evaluate step norm
    step_norm = norm(quantities.subproblemStep);
    
  end
  
  % Check for interior convergence
  if errChol == 0 && quantities.subproblemMultiplier == 0 && step_norm <= quantities.trustRegionRadius
    quantities.setSubproblemStatus(1);
    quantities.setSubproblemError(S.optimalityError(quantities));
    return;
  end
  
  %%%%%%%%%%
  % STEP 2 %
  %%%%%%%%%%

  % Update upper or lower bound
  if errChol == 0 && step_norm <= quantities.trustRegionRadius
    lambdaU = quantities.subproblemMultiplier;
  else
    lambdaL = quantities.subproblemMultiplier;
  end
  
  %%%%%%%%%%
  % STEP 3 %
  %%%%%%%%%%
  
  % Check for error
  if errChol == 0
    
    % Solve system for Newton step
    ls_temp = L\quantities.subproblemStep;
    
    % Set trial dual variable
    lambdaN = quantities.subproblemMultiplier + (step_norm/norm(ls_temp))^2*((step_norm-quantities.trustRegionRadius)/quantities.trustRegionRadius);
    
    % Check for short step
    if step_norm <= quantities.trustRegionRadius
      
      % Compute minimum eigenpair
      [~,eig_vec] = S.minimumEigenpair(quantities,quantities.subproblemMultiplier);
      
      % Compute inner product
      uHu = full(eig_vec'*(quantities.subproblemMatrix*eig_vec) + quantities.subproblemMultiplier*norm(eig_vec)^2);
      
      % Update lower bound
      lambdaL = max(lambdaL,quantities.subproblemMultiplier-uHu);
      
      % Compute roots
      alphas = roots([norm(eig_vec)^2,2*quantities.subproblemStep'*eig_vec,step_norm^2-quantities.trustRegionRadius^2]);
      
      % Choose best root
      if quantities.subproblemVector'*(quantities.subproblemStep+alphas(1)*eig_vec) + (1/2)*(quantities.subproblemStep+alphas(1)*eig_vec)'*quantities.subproblemMatrix*(quantities.subproblemStep+alphas(1)*eig_vec) < ...
          quantities.subproblemVector'*(quantities.subproblemStep+alphas(2)*eig_vec) + (1/2)*(quantities.subproblemStep+alphas(2)*eig_vec)'*quantities.subproblemMatrix*(quantities.subproblemStep+alphas(2)*eig_vec)
        alpha = alphas(1);
      else
        alpha = alphas(2);
      end
      
    end
    
  else
    
    % Compute minimum eigenpair
    [eig_val,eig_vec] = S.minimumEigenpair(quantities,quantities.subproblemMultiplier);
    
    % Update lower bound
    lambdaL = full(max(lambdaL,-eig_val));
    
  end
  
  %%%%%%%%%%
  % STEP 4 %
  %%%%%%%%%%
  
  % Check for termination
  if (errChol == 0 && abs(quantities.trustRegionRadius - step_norm) <= S.tolerance_*quantities.trustRegionRadius) || ...
      (errChol == 0 && step_norm <= quantities.trustRegionRadius && quantities.subproblemMultiplier == 0)
    quantities.setSubproblemStatus(1);
    quantities.setSubproblemError(S.optimalityError(quantities));
    return;
  end
  if (errChol == 0 && step_norm <= quantities.trustRegionRadius && alpha^2*uHu <= tolerance_*(quantities.subproblemStep'*(quantities.subproblemMatrix*quantities.subproblemStep) + quantities.subproblemMultiplier*step_norm^2 + quantities.subproblemMultiplier*quantities.trustRegionRadius^2))
    quantities.setSubproblemStep(quantities.subproblemStep + alpha*eig_vec);
    quantities.setSubproblemStatus(2);
    quantities.setSubproblemError(S.optimalityError(quantities));
    return;
  end
  if k >= S.iteration_limit_
    quantities.setSubproblemStatus(3);
    quantities.setSubproblemError(S.optimalityError(quantities));
    return;
  end
  
  %%%%%%%%%%
  % STEP 5 %
  %%%%%%%%%%
  
  % Check step norm
  if errChol == 0 && step_norm > quantities.trustRegionRadius && quantities.subproblemVectorNorm2 > 0
    quantities.setSubproblemMultiplier(lambdaN);
    fact = 0;
  elseif errChol == 0 && step_norm <= quantities.trustRegionRadius
    
    % Attempt to factorize new system
    [L,errChol] = chol(quantities.subproblemMatrix+lambdaN*speye(length(quantities.subproblemVector)),'lower');
    
    % Check error
    if errChol == 0
      fact = 1;
      quantities.setSubproblemMultiplier(lambdaN);
    else
      
      % Reset boolean
      fact = 0;
      
      % Update lower bound
      lambdaL = max(lambdaL,lambdaN);
      
      % Attempt to factorize system with lambdaL
      [L,errChol] = chol(quantities.subproblemMatrix+lambdaL*speye(length(quantities.subproblemVector)),'lower');
      
      % Check for error
      if errChol == 0
        
        % Solve system
        ls_forw = -(L\quantities.subproblemVector);
        quantities.setSubproblemStep((ls_forw'/L)');
        
        % Evaluate step norm
        step_norm = norm(quantities.subproblemStep);
        
      end
      
      % Check for interior convergence
      if errChol == 0 && step_norm <= quantities.trustRegionRadius
        
        % Update dual variable
        quantities.setSubproblemMultiplier(lambdaL);
        
        % Compute minimum eigenpair
        [~,eig_vec] = S.minimumEigenpair(quantities,quantities.subproblemMultiplier);
        
        % Compute roots
        alphas = roots([norm(eig_vec)^2,2*quantities.subproblemStep'*eig_vec,step_norm^2-quantities.trustRegionRadius^2]);
        
        % Choose best root
        if quantities.subproblemVector'*(quantities.subproblemStep+alphas(1)*eig_vec) + (1/2)*(quantities.subproblemStep+alphas(1)*eig_vec)'*quantities.subproblemMatrix*(quantities.subproblemStep+alphas(1)*eig_vec) < ...
            quantities.subproblemVector'*(quantities.subproblemStep+alphas(2)*eig_vec) + (1/2)*(quantities.subproblemStep+alphas(2)*eig_vec)'*quantities.subproblemMatrix*(quantities.subproblemStep+alphas(2)*eig_vec)
          alpha = alphas(1);
        else
          alpha = alphas(2);
        end
        
        % Set new solution
        quantities.setSubproblemStep(quantities.subproblemStep + alpha*eig_vec);
        
        % Set step norm
        step_norm = norm(quantities.subproblemStep);
        
      else
        
        % Update dual variable
        quantities.setSubproblemMultiplier(max(sqrt(lambdaL*lambdaU),lambdaL + 0.5*(lambdaU - lambdaL)));
        
      end
      
    end
    
  else
    
    % Reset dual variable estimate
    quantities.setSubproblemMultiplier(max(sqrt(lambdaL*lambdaU),lambdaL + 0.5*(lambdaU - lambdaL)));
    
  end
  
  % Increment iteration counter
  k = k + 1;
  
end

end % solveSubproblem