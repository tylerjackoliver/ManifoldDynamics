% Differential correction subroutine for lyapunov iteration
%
%	Revision Date 		Purpose 				 Author
%	=============		=======					========
%	13/08/2017			Initial creation 		Jack Tyler
%

function [x0, t] = differentialCorrection(x0, massParameter)

	% Initialisation

	global attemptNumber
	mu = massParameter;
	xdotMax = 1e-09;
	RelTol = 1e-012;
	AbsTol = 1e-012;
	maxAttempts = 20;
	attemptNumber = 0;
	xdot = 10;		% Arbitrarily high number to start off iteration
	disp('Beginning iteration sequence...');

	if abs(xdot) > xdotMax
		
		if attemptNumber > attemptNumberMax
			disp('Convergence error: number of iterations exceeded');
			break

		else
		
			% Integrate state matrix along trajectory
			integratorOptionsTraj = odeset('RelTol', RelTol, 'AbsTol', AbsTol, 'Events', 'on'); % Add in events file
			[t, x, te, xe, ie] = ode45(MODEL, [0 5], x0, integratorOptionsTraj);
			xf = xe(1);
			yf = xe(2);
			xdotf = xe(3);
			ydotf = xe(4);
			% Integrate state transition matrix
			integratorOptionsSTM = odeset('RelTol', RelTol, 'AbsTol', AbsTol);
			[x, t, phi_t, PHI] = propagateSTM(x0, te, mu, integratorOptionsSTM);
			attemptNumber = attemptNumber + 1;
			displayString = sprintf('Differential correction: iteration number ', attemptNumber);
			disp(displayString);
			corrector(massParameter, xf, yf, xdotf, ydotf, phi_t);
			x0(4) = x0(4) - yCorrection(attemptNumber);

		end
	end
end

function [yCorrection] = corrector(massParameter, xf, yf, xdotf, ydotf, phi_t)

	mu = massParameter;
	m1 = 1-mu;
	m2 = mu;
	r13 = ((xf+m2)^2 + yf^2)^1.5;
	r23 = ((x1-m1)^2 + yf^2)^1.5;
	u_x = -xf + m1*(xf+m2)/r13 + m2*(x1-m1)/r23;
	xAccel = 2*ydotf - u_x;
	yAccel(attemptNumber) = (1/phi_t(3, 4) - phi_t(2, 4)*(xAccel/ydotf))*xdotf;

end
