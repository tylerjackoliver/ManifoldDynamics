% Computes a preliminary state transition matrix
%
% Revision Date         Revision Purpose          Author
% =============         ================        ==========
% 15.08.2017            Initial Creation        Jack Tyler
%

function STMdotOut = variationalEquations(t, PHI)

mu = 0.121;
m1 = 1-mu;
m2 = mu;
x(1:4) = PHI(17:20);                % Extract state from end of STM
STM = reshape(PHI(1:16), 4, 4);     % Now grab STM
STMdotOut = zeros(20, 1);

r13 = (x(1)+m2)^2+x(2)^2;
r23 = (x(1)-m1)^2+x(2)^2;

u_x = -x(1)+m1*(x(1)+m2)/r13^1.5 + m2*(x(1)-m1)/r23^1.5;
u_y = -x(2) + m1*x(2)/r13^1.5 +  m2*x(2)/r23^1.5;
u_xx = -1+(m1/r13^1.5)*(1-(3*(x(1)+m2)/r13+(m2/r23^1.5)*(1-(3*(x(1)-m1)^2/r23))));
u_yy = -1+(m1/r13^1.5)*(1-(3*x(2)^2/r13))+(m2/r23^1.5)*(1-(3*x(2)^2/r23));
u_xy = -(m1/r13^2.5)*3*x(2)*(x(1)+m2)-m2/r23^2.5*3*x(2)*(x(1)-m1);

jacobianMatrix = [0 0 1 0; 0 0 0 1; -u_xx -u_xy 0 2; -u_xy -u_yy -2 0];
STMdot = jacobianMatrix*STM;
STMdotOut(1:16) = reshape(STMdot, 16, 1);
STMdotOut(17) = x(3);
STMdotOut(18) = x(4);
STMdotOut(19) = 2*x(4) - u_x;
STMdotOut(20) = -2*x(3) - u_y;

end



