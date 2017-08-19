% Function to generate the initial guess for the differential corrector
%
% Uses methodology outlined in (Richardson, 1980)
%
% Uses center x saddle eigenvalue to generate guess from frequency

function [x0Guess, tGuess] = initialGuessGenerator(mu, lNum, Ax)

	lPos = [lPointGenerator(mu, lNum) 0 0];										% Get position of equilibrium point
	[eValStable, eValUnstable, eValCenter, eVecStable, eVecUnstable, eVecCenter] = eigenvalueGenerator(lPos, mu);	% Get eigenvals of variational equations
	centerEigFreq = abs(imag(eValCenter(1)));									% Get lambda from frequency portion of complex eigenvalue
	gamma = gammaGenerator(mu, lNum);
	c2 = 1/g^3*(mu+((1-mu)*g^3)/((1-g)^3));										% Calculate c2
	k = (1/(2*centerEigFreq))*(centerEigFreq + 1 + 2*c2);								% Calculate k
	x0Guess = zeros(4, 1);												% Initialise initial guess state matrix
	x0Guess(1) = lPos - Ax;												% Define initial x-coordinate
	x0Guess(4) = Ax*k*l;												% Define y-accel
	tGuess = 2*pi/centerEigFreq;											% Initial guess for period

end
