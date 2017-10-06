%	Function to determine the distance gamma between a lagrangian point and P1
%
%	Author: Jack Tyler
%
%	References: Theory of Orbits, Szebhely; Halo orbit construction for the ISEE-3 mission, Richardson
%

function [gamma] = gammaL(massParameter, lNum)

	m1 = massParameter;
	m2 = 1-massParameter;

	% Use symbolic toolbox to set up Lagriangian point location equations
% 	syms mu gammaSym;
% 	l1Eqn = gammaSym^5 - (3-m1)*gammaSym^4 + (3-2*m1)*gammaSym^3 - m1*gammaSym^2 + 2*m1*gammaSym - m1 == 0;
% 	l2Eqn = gammaSym^5 + (3-m1)*gammaSym^4 + (3-2*m1)*gammaSym^3 - m1*gammaSym^2 - 2*m1*gammaSym - m1 == 0;
% 	l3Eqn = gammaSym^5 + (2+m1)*gammaSym^4 + (1+2*m1)*gammaSym^3 - m2*gammaSym^2 - 2*m2*gammaSym - m2 == 0;
% 
% 	rootsL1 = solve(l1Eqn, gammaSym);
% 	rootsL2 = solve(l2Eqn, gammaSym);
% 	rootsL3 = solve(l3Eqn, gammaSym);

%        x^5    x^4       x^3      x^2   x    const
poly1 = [1   -1*(3-m1)  (3-2*m1)  -m1   2*m1  -m1 ];
poly2 = [1      (3-m1)  (3-2*m1)  -m1  -2*m1  -m1 ];
poly3 = [1      (2+m1)  (1+2*m1)  -m2 -2*m2 -m2];

% solve for roots of quintic polynomial

rt1 = roots(poly1);
rt2 = roots(poly2);
rt3 = roots(poly3);

	for i = 1:5
		if isreal(rt1(i))
			gammaArray(1)=rt1(i);
		end
		if isreal(rt2(i))
			gammaArray(2)=rt2(i);
		end
		if isreal(rt3(i))
			gammaArray(3)=rt3(i);
		end
	
	gamma = gammaArray(lNum);

end
