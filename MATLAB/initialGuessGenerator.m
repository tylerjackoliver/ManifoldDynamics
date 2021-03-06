% Function to generate the initial guess for the differential corrector
%
% Uses methodology outlined in (Richardson, 1980)
%
% Uses center x saddle eigenvalue to generate guess from frequency

function [x0Guess, tGuess] = initialGuessGenerator(mu, lNum, Ax)

	lPos = [lagrangianPointGenerator(mu, lNum) 0 0];										% Get position of equilibrium point
% 	[eValUnstable, eValStable, eValCenter] = eigenvalueGenerator(lPos, mu, 0);	% Get eigenvals of variational equations
	[eValUnstable, eValStable, eValCenter, UV, SV, CV] = eqPointEig3BP(lPos, mu);
    centerEigFreq = abs(imag(eValCenter(1)));									% Get lambda from frequency portion of complex eigenvalue
	gamma = gammaL(mu, lNum);
    l = abs(imag(eValCenter(1)));
	c2 = 1/gamma^3*(mu+((1-mu)*gamma^3)/((1-gamma)^3));										% Calculate c2
	k = (1/(2*centerEigFreq))*(centerEigFreq + 1 + 2*c2);								% Calculate k
	x0Guess = zeros(4, 1);												% Initialise initial guess state matrix
	x0Guess(1) = lPos(1) - Ax;												% Define initial x-coordinate
	x0Guess(4) = lPos(4) - Ax*k*l;												% Define y-accel
	tGuess = 2*pi/centerEigFreq;											% Initial guess for period

end
