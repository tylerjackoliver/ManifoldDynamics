%% Calculate and plot the trajectory of GRAIL

% Add in MICE/SPICE toolkit...
addpath('mice/src/mice');
addpath('mice/lib/');

% define the number of divisions of the time interval
STEP = 1000;

cspice_furnsh({'standard.tm', 'grail_110910_120102_nav_v01.bsp'});

et = cspice_str2et({'Dec 14, 2011 01:00', 'Jan 2, 2012'});
times = (0:STEP-1)*(et(2) - et(1))/STEP + et(1);

[pos, ltime] = cspice_spkpos('GRAIL-A', times, 'J2000', 'NONE', 'Earth');
% [posearth, ltimeearth] = cspice_spkpos('Moon', times, 'J2000', 'NONE', 'Earth');

% Plot this shit, yo.

x = pos(1,:);
y = pos(2,:);
z = pos(3,:);

% hold on
figure(1)
plot3(x, y, z);
hold on
% Clear residual kernels...
cspice_kclear;
% Plot the Moon...

cspice_furnsh({'standard.tm', 'de414.bsp'});
[pose, ltimee] = cspice_spkpos('Moon', times, 'J2000', 'NONE', 'Earth');

xe = pose(1,:);
ye = pose(2,:);
ze = pose(3,:);


plot3(xe, ye, ze);
grid off
%legend('GRAIL-A Orbit', 'Lunar Orbit');
xlabel('X [Mm]');
ylabel('Y [Mm]');
zlabel('Z [Mm]');
saveas(1, 'grail_orbit4.png', 'png');
hold off
cspice_kclear;