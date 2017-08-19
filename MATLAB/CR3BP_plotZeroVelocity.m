

G = 1;       % Gravitational Constant
M1 = 1;      % mass 1
M2 = 1/6;    % mass 2
M = M1 + M2; % total mass

R = 1;       % distance between M1 and M2 set to 1


%%%%%%%%%%%%%%%%  Orbital properties of two massive bodies  %%%%%%%%%%%%%%%
mu = G*M;
mu1 = G*M1;
mu2 = G*M2;

R10 = [-M2/M; 0];           % initial position of M1
R20 = [M1/M; 0];            % initial position of M2

P = 2*pi;                   % period from Kepler's 3rd law
omega0 = 1;                 % angular velocity of massive bodies


[X,Y] = meshgrid(-2:0.01:2);
U = CR3BP_computePotential(mu1, mu2, X, Y);


U0 = CR3BP_computePotential(mu1, mu2, 0, 1);


m = 2;
map = ones(m , 3)*.8;

colormap(map);



level = [-2.5 -2.1 -1.96 -1.8 -1.68 -1.6];

for j = 1:6
    
    subplot(2,3,j)
    
    %  contourf(X,Y,U,[-5:.5:-1]);
    contourf(X,Y,U,level(j)+[0 -0.0001]);
    hold on
    plot(-M2/(M1+M2),0,'ko','MarkerSize',7,'MarkerFaceColor','b')
    plot(M1/(M1+M2),0,'ko','MarkerSize',5,'MarkerFaceColor','k')

    % xlim([min(X) max(X)])
    % ylim([min(Y) max(Y)])
    title(sprintf('C = %.2f',-2*level(j)));
    axis equal
    axis square
     
end



set(gcf, 'PaperPosition', [0 -1 8 4]);
print ('-dpng','zeroVelocity.png','-r100');