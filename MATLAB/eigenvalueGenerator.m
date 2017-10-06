% Function to generate eigenvalues of the Jacobian matrix
%
%
%   Revision Date           Revision Purpose            Author
%   =============         =====================       ==========
%   15.08.2017            Initial file creation        J Tyler
%
%

function [unstableEvals, stableEvals, centerEvals] = eigenvalueGenerator(inMatrix, mu, timeType)

    %% Initialise variables

    stableEvals = [];
    unstableEvals = [];
    centerEvals = [];
    stableNum = 1;
    unstableNum = 1;
    centerNum = 1;
    
    %% Code execution
    matrix = jacobianMatrix(inMatrix, mu);
    [eVals, eVecs] = eig(matrix);

    % Determine type of Eigenvalue and add it to the respective matrix

    for i = 1:length(matrix)

        if timeType == 1 % Discrete time intervals

            if abs(matrix(i, i)) - 1 < tolerance
                stableEvals(stableNum) = matrix(i, i);
                stableNum = stableNum + 1;
            elseif abs(matrix(i, i)) - 1 > tolerance
                unstableEvals(unstableNum) = mMatrix(i, i);
                unstableNum = unstableNum + 1;
            else
                centerEvals(centerNum) = matrix(i, i);
                centerNum = centerNum + 1;

            end
        elseif timeType == 0
            
            if real(matrix(i, i)) < 0
                stableEvals(stableNum) = matrix(i, i);
                stableNum = stableNum + 1;
            elseif real(matrix(i, i)) > 0
                unstableEvals(unstableNum) = matrix(i, i);
                unstableNum = unstableNum + 1;
            else
                centerEvals(centerNum) = matrix(i, i);
                centerNum = centerNum + 1;
            end
        end
    end
end
% Auxiliary function to clean up matrix of super small values

function [cleanedMatrix] = cleaner(inputMatrix)

    if nargin < 2
        tolerance = 1e-012;
    end
    
    for i = 1:length(inputMatrix)

        if abs(real(inputMatrix(i))) < tolerance

            inputMatrix(i) = inputMatrix(i) - real(inputMatrix(i));

        end

        if abs(imag(inputMatrix(i))) < tolerance

            inputMatrix(i) = inputMatrix(i) - imag(inputMatrix(i))*i;

        end
    end
    
    cleanedMatrix = inputMatrix;
    
end
