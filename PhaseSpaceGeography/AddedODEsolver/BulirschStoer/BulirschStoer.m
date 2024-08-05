function [tau_c,W] = BulirschStoer(dynFun,t,z0,tol)
% [z, info] = BulirschStoer(dynFun,t,z0,tol)
%
% Solves an initial value problem using the Bulirsch-Stoer method. This
% method is ideal for high-accuracy solutions to smooth initial value
% problems.
%
% Computes z(t) such that dz/dt = dynFun(t,z), starting from the initial
% state z0. The solution at the grid-points will be accurate to within tol.
%
% If the provided grid is insufficient, this function will automatically
% introduce intermediate grid points to achieve the required accuracy.
%
% INPUTS:
%   dynFun = function handle for the system dynamics
%       dz = dynFun(t,z)
%           t = scalar time
%           z = [nz,1] = state as column vector
%           dz = [nz,1] = derivative of state as column vector
%   t = [1,nt] = time grid-point vector
%   z0 = [nz,1] = initial state vector
%   tol = [nz,1] = error tolerance along each dimension. If tol is a
%       scalar, then all dimensions will satisfy that error tolerance.
%
% OUTPUTS:     (nt = n+1)
%   z = [nz,nt] = solution to the initial value problem
%   info
%       .error = [nx,nt] = error estimate at each grid point
%       .nFunEval = [1,nt] = number of function evaluations for each point
%
% NOTES:
%   Implementation details:
%   http://web.mit.edu/ehliu/Public/Spring2006/18.304/implementation_bulirsch_stoer.pdf
%
% TUTORIAL:
%   The big idea here is based on Richardson extrapolation. Suppose that
%   you solve an initial value problem using the modified mid-point method
%   (below), where you can pick the number of sub-steps (n). The solution
%   will become increasingly accurate as the number of sub-steps becomes
%   large.
%
%   Now, imagine that you solve the same problem several times, each time
%   using more sub-steps. You should be able to observe a trend: the
%   solutions asymtotically approach some value. Richardson exprapolation
%   is the math (algorithm) that looks a this sequence of improving
%   approximations to the solution, and then extrapolates, to the limit as
%   the step size goes to zero.
%
%   The modified mid-point method is not chosen at random. It has a special
%   property: the expression for the error goes up by powers of two, rather
%   than one. This makes the convergence particularily good.
%
%   This function (BulirschStoer) is just a wrapper for the sub-function
%   BulirschStoerStep, which is where the real work is done.
%
% Modified:   2023/03/25   B. Cordani

% If a step fails, how many sub-steps should be created in its place?
nStepRefine = 3;  

% Simple logistics and memory allocation:
nt = length(t);
nz = size(z0,1);
z = zeros(nz,nt);
z(:,1) = z0;
info.error = zeros(size(z));
info.nFunEval = zeros(1,nt);

% March forward in time, from grid-point to grid-point
for i=2:nt
    
    tSpan = [t(i-1), t(i)];
    [zF, stepInfo] = BulirschStoerStep(dynFun, tSpan, z(:,i-1), tol);
    
    if strcmp(stepInfo.exit,'converged')  %Successful step!
        z(:,i) = zF;
        info.error(:,i) = stepInfo.error;
        info.nFunEval(i) = stepInfo.nFunEval;
        
    else  %Failed to converge -- try again on a better mesh
        time = linspace(tSpan(1),tSpan(2),nStepRefine+1);
        [zTmp, infoTmp] = BulirschStoer(dynFun,time,z(:,i-1),tol);
        z(:,i) = zTmp(:,end);
        info.error(:,i) = infoTmp.error(:,end);
        info.nFunEval(i) = sum(infoTmp.nFunEval);
        
    end
end
W = z';
tau_c = t';
end

%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%


function [zF, info] = BulirschStoerStep(dynFun, tSpan, z0, tol)
% [zF, info] = BulirschStoerStep(dynFun, tSpan, z0, tol)
%
% Computes a single step using the Bulirsch-Stoer method
%
% INPUTS:
%   dynFun = function handle for the system dynamics
%       dz = dynFun(t,z)
%           t = scalar time
%           z = [nz,1] = state as column vector
%           dz = [nz,1] = derivative of state as column vector
%   tSpan = [1,2] = [t0, tF] = time span for the step
%   z0 = [nz,1] = initial state vector
%   tol = [nz,1] = error tolerance along each dimension. If tol is a
%       scalar, then all dimensions will satisfy that error tolerance.
%
% OUTPUTS:     (nt = n+1)
%   zF = [nz,1] = final state
%   info = struct with solver information:
%       .exit = exit condition
%           'converge' = successful convergence
%           'maxRefine' = reached max refinement; did not converge
%       .error = [nz,1] = error estimate along each dimension
%       .nFunEval = scalar int = count calls to dynFun
%       .nRefine = how many refinement steps were required?
%
% NOTES:
%   Implementation details:
%   http://web.mit.edu/ehliu/Public/Spring2006/18.304/implementation_bulirsch_stoer.pdf
%

% Set an upper limit on the number of mesh refinements in the sequence
nRefineMax = 8; 

% Simple logistics and memory allocation
n = 2*(1:nRefineMax);
nz = size(z0,1);
if length(tol)==1
    tol = tol*ones(size(z0));
end
T = zeros(nz,nRefineMax,nRefineMax);   %Extrapolation table
E = zeros(nz,nRefineMax);   %Error estimate table

info.exit = 'maxRefine';  %Assume that we fail to meet tolerance
for j=1:nRefineMax  %Loop over the sequence of improving meshes
    
    % Compute the estimate of the solution on the current mesh
    [~,z] = modifiedMidpointRule(dynFun, tSpan, z0, n(j));
    T(:,j,1) = z(:,end);
    
    if j>1
        
        % Compute the extrapolation table entries:
        for k=2:j
            num = T(:,j,k-1) - T(:,j-1,k-1);
            den = (n(j)/(n(j-k+1)))^2 - 1;
            T(:,j,k) = T(:,j,k-1) + num/den;
        end
        
        % Compute the error estimates:
        E(:,j) = abs(T(:,j,j-1) - T(:,j,j));
        
        % Check convergence:
        if all(E(:,j)<tol)
            info.exit = 'converged';
            break;
        end
    end
    
end

% Other useful things:
info.error = E(:,j);     %Error estimate
info.nFunEval = sum(n(1:j));    %number of function evaluations
info.nRefine = j;

% Return the estimate of the solution:
zF = T(:,j,j);

end



%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%



function [t,z] = modifiedMidpointRule(dynFun, tSpan, z0, n)
% [t,z] = modifiedMidpointRule(dynFun, tSpan, z0, n)
%
% Approximates the solution to the initial value problem by numerical
% integration with the modified mid-point rule.
%
% INPUTS:
%   dynFun = function handle for the system dynamics
%       dz = dynFun(t,z)
%           t = scalar time
%           z = [nz,1] = state as column vector
%           dz = [nz,1] = derivative of state as column vector
%   tSpan = [1,2] = [t0,tF] = time span for simulation
%   z0 = [nz,1] = initial state vector
%   n = scalar integer number of steps.   (require:  n > 2)
%
% OUTPUTS:     (nt = n+1)
%   t = [1,nt] = time stamps for intermediate points
%   z = [nz,nt] = state estimate at final time
%
% NOTES:
%   Implementation details:
%   http://web.mit.edu/ehliu/Public/Spring2006/18.304/implementation_bulirsch_stoer.pdf
%

nt = n+1;
nz = size(z0,1);

t0 = tSpan(1);
tF = tSpan(2);
h = (tF-t0)/n;
t = linspace(tSpan(1), tSpan(2), nt);
z = zeros(nz,n);

% Initialize and then run the modified mid-point method.
z(:,1) = z0;
z(:,2) = z0 + h*dynFun(t0,z0);
for i=3:nt
    z(:,i) = z(:,i-2) + 2*h*dynFun(t(i-1),z(:,i-1));
end

% Refine the final point using the dynamics function at final point.
z(:,nt) = 0.5*(z(:,nt) + z(:,nt-1) + h*dynFun(t(nt),z(:,nt)));

end