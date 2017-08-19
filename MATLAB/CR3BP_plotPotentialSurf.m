% % Plot surface rendering of pseudo-potential for CR3BP.
% %
% % Assumptions: G, r = 1.
% %
% %
% % Requires CR3BP_computePotential.m to function.
% %
% % Included masses are for the Earth-Moon system!
% 
% 
% %% Initialise variables.
% 
% m1 = 1;							% Mass of body 1
% m2 = 1/6;							% Mass of body 2
% M = m1 + m2;							% Total mass of the EM system
% 
% 
% P = 2*pi*(1/M);							% System period (may need adjusting to be Kepler's 3rd - 2pi/M
% omega = 2*pi/P;							% Angular velocity (normalised to 1)
% 
% [X, Y] = meshgrid(-2:.05:2);					% Create grrid of x, y
% U = CR3BP_computePotential(X, Y, m1, m2);			% Compute potential for all values
% 
% %% Start plotting...
% 
% figure(1)
% 
% colormap default;						% Set the default colormap...
% 
% 
% %%%%%%%%%%  Left figure will show potential from directly above
% 
% subplot(1,2,1)
% 
% surf(X,Y,U,'FaceColor','interp','EdgeColor','none','FaceLighting','phong')
% 
% title(sprintf('m_1 = %.1f   m_2 = %.1f',m1, m2));
% axis square
% axis equal
% axis tight
% zlim([-3 -1]);
% view(90,90)     % viewing angle straight overhead
% camlight left
% 
% 
% 
% %%%%%%%%%%  Right figure will show potential tilted 30 degrees
% 
% subplot(1,2,2)
% 
% surf(X,Y,U,'FaceColor','interp','EdgeColor','none','FaceLighting','phong')
% 
% title(sprintf('m_1 = %.1f   m_2 = %.1f',m1, m2));
% axis tight
% axis square
% axis equal
% zlim([-3 -1]);
% view(90,30)     % viewing angle inclined by 30 degrees
% camlight left

% crtbpPotentialSurface.m
%
% Plots surface rendering of pseudo-potential for the circular, restricted 
% 3-body problem evaluated in the rotating reference frame tied to m1 & m2.
%
% Assumes G = 1 and r = 1, where r  is the distance between masses m1 & m2.
% The origin of the coordinate system is placed at the center-of-mass point
%
% Uses 'phong' lighting and raytracing to render the surface
%
% Program dependencies:
%    crtbpPotential.m - returns pseudo-potential
%
% Matlab-Monkey.com  10/10/2013



%%%%%%%%%%%%%%%%%%%%%  Parameters and Initialization  %%%%%%%%%%%%%%%%%%%%%

M1 = 1;       % mass 1
M2 = 1/6;     % mass 2
M = M1 + M2;  % total mass


P = 2*pi * 1;     % period from Kepler's 3rd law
omega0 = 2*pi/P;            % angular velocity of massive bodies

[X,Y] = meshgrid(-1.5:0.05:1.5);    % grid of (x,y) coordinates
U = CR3BP_computePotential(M1, M2, X, Y);   % calculate potential on grid points

figure

% define a custom, gray color map to render surface plot
map = ones(2 , 3)*.7;
colormap(map);



%%%%%%%%%%  Left figure will show potential from directly above

% figure(1)
% 
% surf(X,Y,U,'FaceColor','interp','EdgeColor','none','FaceLighting','phong');
% 
% % title('Pseudo-Potential Plot in the Earth-Moon System; \mu = 6');
% axis square
% axis equal
% axis tight
% % xlim([-2.5 2.5]);
% % ylim([-2.5 2.5]);
% zlim([-3 -1]);
% view(90,90)     % viewing angle straight overhead
% camlight left
% 


%%%%%%%%%  Right figure will show potential tilted 30 degrees

figure(2)

surf(X,Y,U,'FaceColor','interp','EdgeColor','none','FaceLighting','phong')
% contour(X, Y, U);
% title('Pseudo-potential in the Earth-Moon system; \mu = 6');
axis tight
axis square
axis equal
zlim([-5 -1]);
view(70,45)     % viewing angle inclined by 30 degrees
camlight left



%%%%%%%%%%  Print to file

% saveas(1, 'potential90', 'png');
% saveas(2, 'potential30', 'png');

