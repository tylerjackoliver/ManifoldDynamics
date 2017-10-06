% GENERATE SOME ORBITS, WOO
%
%   Revision Date           Revision Purpose              Author
%  ===============         ==================          ============
%    14.08.2017           Initial file creation         Jack Tyler
%

function [] = periodicOrbitGenerator(massParameter, lNum, numberOfFamilies)
    global mu
    mu = massParameter;
    
    gamma =gammaL(massParameter, lNum);
    
    amplitudeX1 = 1e-02*gamma;
    amplitudeX2 = 2*amplitudeX1;
    
    [x0, T] = generateAFamily(massParameter, lNum, amplitudeX1,...
        amplitudeX2, numberOfFamilies);
    integratorOptions = odeset('RelTol', 3e-14, 'AbsTol', 1e-014);
    
    for k = numberOfFamilies:-1:1
        
      tb = 0;
      tf = T(k)/2;
      [x0(k,0),t] = trajGet3BP(x0, tb, tf, massParameter, integratorOptions);
      plot(x(:,1),x(:,2),x(:,1),-x(:,2));
      title('PERIODIC ORBITS, YO');
      hold on
      axis equal
      
    end

    
    