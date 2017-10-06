function [values, isterminal, direction] = eventsFunction(x, t)
    if abs(t) < 1e-012
        isterminal = 0;
    else
        isterminal = 1;
    end
    direction = -1;
    values = x(2);