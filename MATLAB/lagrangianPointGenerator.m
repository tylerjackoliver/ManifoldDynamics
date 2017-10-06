%	Function to determine the location of the Lagrangian points the the CR3BP defined in an inertial reference system
%
% 	Author: Jack Tyler
%
%	References: Henon, Exploration of the Restricted Problem IV; Halo orbit design for ISEE-3, Richardson.
%

function eqPos = lagrangianPointGenerator(massParameter, lNum)

	m1 = 1-massParameter;
	m2 = massParameter;

	% Determine gammaL for each eq. point
	distances = [m1 - gammaL(massParameter, 1), m1+gammaL(massParameter, 2), -m2-gammaL(massParameter, 3)];
	
	% Use this to construct matrix of positions

	lPos = [distances(1), 0; distances(2), 0; distances(3), 0; 0.5-m2, 0.5*sqrt(3); 0.5-m2, -0.5*sqrt(3)];

	% Return the position we're after

	eqPos = lPos(lNum, :);

end
