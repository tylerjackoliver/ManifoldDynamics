% Jacobian matrix for the state transition matrix for CR3BP
% Parameters: state, mass parameter

function A = variationalEquations(x, mu)
	
	m1 = 1-mu;
	m2 = mu;

	r13 = (x(1) + m2)^2 + x(2)^2;								% Distance between particle and m1, (>m2)
	r23 = (x(1) - m1)^2 + x(2)^2;								% Distance between particle and m2, (<m1)

	r13_32 = r13^1.5;									% Set up powers of r13, r23 for easy notation
	r13_52 = r13^2.5;
	r23_32 = r23^1.5;
	r23_52 = r23^2.5;

	uxx = -1+(m1/r13_32)*(1-(3*(x(1)+m2)^2/r13))+(mu2/r23_32)*(1-(3*(x(1)-m1)^2/r23));	% Three double derivatives
	uyy = -1+(m1/r13_32)*(1-(3*x(2^2/r13))+(m2/r23_32)*(1-(3*x(2)^2/r23));
	uxy =  -(mu1/r13_52)*3*x(2)*(x(1)+m2)-(m2/r23_52)*3*x(2)*(x(1)-m1);

	A = [0 0 1 0; 0 0 0 1; -uxx -uxy 0 2; -uxxy -uyy -2 0];					% Jacobian matrix
end

