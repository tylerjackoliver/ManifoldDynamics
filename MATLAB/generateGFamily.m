% Generates a family of a-type periodic orbits around a specific lagrangian
% point
%
%    Revision Date                Purpose              Author
%   ===============           ================        ==========
%     14.08.2017              Initial creation        Jack Tyler
%
function [x0, t12] = generateAFamily(massParameter, lNum, amplitudeX1,...
    amplitudeX2, numberOfFamilies)  
    %% Variable initialisation
  
    mu = massParameter;
    dimension = 4;
    x0 = zeros(numberOfFamilies, dimension);
    t12 = zeros(numberOfFamilies, 1);
    dx = 0;
    dy = 0;
    dt = 0;
    x0_next = zeros(1, 4);
    t12_next = zeros(1, 4);
    famNum = 0;
    
    %% Execution
    
    % We need to initialise the first two orbits ourself to generate the
    % differentials for the following families
    
    [x0Guess1, t12Guess1] = initialGuessGenerator(massParameter, lNum,...
        amplitudeX1);   % Generate an initial guess from the first amplitude
    [x0Guess2, t12Guess2] = initialGuessGenerator(massParameter, lNum,...
        amplitudeX2);   % Generate an initial guess from the second amplitude
    
    famNum = 1;     % Initialise family number to 1
    disp(sprintf('Computing orbit number ', famNum));
    [xInit1, t12Init1] = differentialCorrector(x0Guess1, massParameter); % Perform differential correction on 1st guess
    
    famNum = 2;
    disp(sprintf('Computing orbit number ', famNum));
    [xInit2, t12Init2] = differentialCorrector(x0Guess2, massParameter); % Perform differential correction on 2nd guess
    
    x0(1:2, 1:dimension) = [transpose(xInit1(:)); transpose(xInit2(:))]; % Add DC output to initial conditions array
    t12(1:2) = [t12Init1; t12Init2];                                     % Add period initial guess to time array
    
    % Now work on the rest of the families, using above as differentials
    
    for famNum = 3:numberOfFamilies
        
        disp(sprintf('Computing orbit number ', famNum));
        dx = x0(famNum-1, 1)- x0(famNum-2, 1);  % Compute dX from previous two orbits (-1, -2)
        dy = x0(famNum-1, 4);                   % Compute dY from previous two orbits (-1, -2)
        dt = t12(famNum-1) - t12(famNum-2);     % Compute dt from previous two orbits (-1, -2)
        
        x0_newGuess = [(x0(famNum-1, 1)+dx) 0 0 (x0(famNum-1, 4)+dy)];  % Construct a new state guess from deltas
        t12_newGuess = (T(famNum-1)+dt)/2 + delta;                      % Construct a new period guess from deltas
        
        [tempx0, tempt12] = differentialCorrector(x0_newGuess,...       % Perform DC on this and save to dummy variables
            massParameter);
        x0(famNum, 1:dimension) = x0_newGuess;                          % Add DC output to x0 array
        t12(dimension) = t12_newGuess;                                  % Save period to t12 array
        
    end
    
    %% Termination
    
    saveData = [x0 t12];
    save x0.csv -double saveData;                                       % Save data as .csv for later access
    
end