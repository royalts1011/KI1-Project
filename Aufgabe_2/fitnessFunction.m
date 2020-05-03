function [fitness] = fitnessFunction(actualAnt)
    load('ant.mat');
        
    antV = ant(:);                    % Wandel perfekte Ameise in Vektor um.
    actualAntV = actualAnt(:);        % Wandel aktuelle Ameie in Vektor um.
    counter = 0;                      % Zähler für == Elemente
    
    for i = 1 : length(antV)
        if antV(i) == actualAntV(i)
           counter = counter + 1;        % Zähler für gleiche Pixel
        end
    end
    
    fitness = counter/length(antV);   % Prozentualer Anteil gleicher Pixel
    
end