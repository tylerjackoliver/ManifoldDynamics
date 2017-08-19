% Propagates the state transition matrix for orbti propagation in the 3BP
%
%	Revision Date		Purpose			Author
%	=============		=======			======
%	13/08/2017		Initial creation	Jack Tyler
%

function [x, t, phi, PHI] = propagateSTM(x0, t, massParameter, options, fixed_step)

	%% Initialisation
	
	global mu
	mu = massParameter;
	dimension = length(x0)	% Grab the number of dimensions for the propagation from the inital conditions
	governingEquations = 'variationalEquations.m';	% Set the model for the governing equations
	phi_0(1:dimension^2) = reshape(eye(dimension), dimension^2, 1);	% Initialise STM matrix
	phi_0(1+dimension^2:dimension+dimension^2) = x0; 	% Append state matrix to end of state transition matrix	
	
	%% Execution

	[t, PHI] = ode45(governingEquations, [0 t], phi_0, options); % Integration -- use ode45 for non-stiff DE, try ode113 if doesn't work
	x = PHI(:, 1+dimension^2:dimension+dimension^2);	% Extract the trajectory from PHI
	phi = reshape(PHI(length(t), 1:dimension^2), dimension, dimension); % Actual STM

	%% Termination

end
