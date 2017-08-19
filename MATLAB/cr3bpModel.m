% Defines the model of the CR3BP for use in numerical integration subroutines
% Assumes notations and normalisations as found in report
% Last revised: 5/8/17.

function [xdot, terminaloutput, directionoutput] = pcr3bp(t,x, endFlag)			% Define inputs as time, state matrix, and argument to shift model behaviour at end of integration.
	global massParam								% Define global mass parameter
	mu = massParam;

	if isempty(flag)								% If integration flag is 0
		m1 = 1-mu;								% Set mass m1 from mu
		m2 = mu;								% Set mass m2 from mu

		r13 = ((x(1)+m2)^2 + x(2)^2)^1.5;					% Distance from particle to m1 (> m2)
		r23 = ((x(1)-m1)^2 + x(2)^2)^1.5;					% Distance from particle to m2 (<m1)

		ux = -x(1) + m1*(x(1)+m2)/r13 + m2*(x(1) - m1)/r23;			% Partial derivative of u wrt x
		uy = -x(2) + m1*x(2)/r13 + m2*x(2)/r23;					% Partial derivative of u wrt y

		xdot = zeros(4, 1)							% Set up state derivative matrix
		xdot(1) = x(3);								% == x_dot
		xdot(2) = x(4);								% == y_dot
		xdot(3) = 2*x(4) - ux;							% == x-acceleration, from gov. equation
		xdot(4) = -2*x(3) - uy;							% == y-accel, from gov. equation

%	else
%		if abs(t) > 10e-3							% If integration has begun
%			terminalOutput = 1;						% The integration should terminate
%		else
%			terminalOutput = 0;						% The integration should not terminate
%
%		end

%		direction = -1;

%		xdot = x(2);								% Check for x-axis crossing

%	end

end
