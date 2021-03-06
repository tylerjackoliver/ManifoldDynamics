% Differential correction subroutine for lyapunov iteration
%
%	Revision Date 		Purpose 				 Author
%	=============		=======					========
%	13/08/2017			Initial creation 		Jack Tyler
%

function [x0, te] = differentialCorrector(x0, massParameter)

	% Initialisation
    global mu
	global attemptNumber
	xdotMax = 1e-09;
	RelTol = 1e-012;
	AbsTol = 1e-012;
	maxAttempts = 20;
    mu = 0.121;
	attemptNumber = 0;
	xdot = 10;		% Arbitrarily high number to start off iteration
	disp('Beginning iteration sequence...');

	if abs(xdot) > xdotMax
		
		if attemptNumber > maxAttempts
			disp('Convergence error: number of iterations exceeded');
			return

		else
		
			% Integrate state matrix along trajectory
            MODEL = 'cr3bpModel';
			integratorOptionsTraj = odeset('RelTol', RelTol, 'AbsTol', AbsTol, 'Events', 'on'); % Add in events file
			[x, t, te, xe, ie] = ode45(MODEL, [0 5], x0, integratorOptionsTraj);
			xf = xe(1);
			yf = xe(2);
			xdotf = xe(3);
			ydotf = xe(4);
            te = te(2);
			% Integrate state transition matrix
			integratorOptionsSTM = odeset('RelTol', RelTol, 'AbsTol', AbsTol);
			[x, t, phi_t, PHI] = propagateSTM(x0, te, mu, integratorOptionsSTM);
			attemptNumber = attemptNumber + 1;
			displayString = sprintf('Differential correction: iteration number ', attemptNumber);
			disp(displayString);
            m1 = 1-mu;
            m2 = mu;
            r13 = ((xf+m2)^2 + yf^2)^1.5;
            r23 = ((xf-m1)^2 + yf^2)^1.5;
            u_x = -xf + m1*(xf+m2)/r13 + m2*(xf-m1)/r23;
            xAccel = 2*ydotf - u_x;
            yCorrection(attemptNumber) = (1/phi_t(3, 4) - phi_t(2, 4)*(xAccel/ydotf))*xdotf;
            show = 1 ; % set to 1 to plot successive approximations
        	if show==1,
                plot(x(:,1),x(:,2),'.-'); 
                hold on;
                m = length(x) ;
                plot(x(1,1),x(1,2),'b*');
                plot(x(m,1),x(1,2),'bo');
                %axis([min(x(:,1)) max(x(:,1)) min(x(:,2)) max(x(:,2))]);
                %axis equal
                pause(0.01) ;
            end
% 			corrector(massParameter, xf, yf, xdotf, ydotf, phi_t, attemptNumber);
            if mu > 1.e-3,
              DAMP = 1-0.5^attemptNumber ;
            else 
              DAMP = 1 ;
            end
			x0(4) = x0(4) - DAMP*yCorrection(attemptNumber);

        end
    end
end