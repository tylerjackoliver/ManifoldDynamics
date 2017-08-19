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
	syms mu, gammaSym;
	l1Eqn = gammaSym^5 - (3-m1)*gammaSym^4 + (3-2*m1)*gammaSym^3 - m1*gammaSym^2 + 2*m1*gammaSym - m1 == 0;
	l2Eqn = gammaSym^5 + (3-m1)*gammaSym^4 + (3-2*m1)*gammaSym^3 - m1*gammaSym^2 - 2*m1*gammaSym - m1 == 0;
	l3Eqn = gammaSym^5 + (2+m1)*gammaSym^4 + (1+2*mu)*gammaSym^3 - m2*gammaSym^2 - 2*m2*gammaSym - m2 == 0;

	rootsL1 = solve(l1Eqn, gammaSym);
	rootsL2 = solve(l2Eqn, gammaSym);
	rootsL3 = solve(l3Eqn, gammaSym);

	for i = 1:5
		if isreal(rootsL1(i))
			gammaArray(1)=rootsL1(i);
		end
		if isreal(rootsL2(i))
			gammaArray(2)=rootsL2(i);
		end
		if isreal(rootsL3(i))
			gammaArray(3)=rootsL3(i);
		end
	
	gamma = gammaArray(lNum);

end
