clear all;
close all;
clc;

figure(1);
set(gcf, 'Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.9]);
set(gcf, 'PaperOrientation', 'landscape');
set(gcf, 'PaperUnits', 'centimeters', 'PaperPosition', [0 0 29.7 21]);
set(gcf, 'PaperSize', [29.7 21.0]);

% Lade Daten.
load('ant.mat');
[x, y] = size(ant);

% Setze Parameter.
n = 10;
% TODO: Setzt die Parameter eures Genetischen Algorithmus.
nSurv = 
nMutations = 
maxIter = 

% Initialisierung.
P = zeros(n, x, y);
fitness = zeros(n, 1);

% Generiere Startpopulation.
% TODO: Kommentiert/Unkommentiert eine der Zeilen, um eine der Startpopulationen zu erhalten.
for i = 1:n
%     P(i, :, :) = round(rand(x, y));
%     P(i, :, :) = antdummy;
end

% Initiale Fitness.
% TODO: Berechnet Fitness der Startpopulation.
for i = 1:n
    fitness(i) = 
end

% Visualisierung der Startpopulation.
for i = 1:n
    subplot(3, n, i);
    imagesc(squeeze(P(i, :, :)));
    axis image;
    set(gca, 'xtick', [], 'ytick', []);
    title(fitness(i), 'FontWeight', 'bold');
end

for k = 1:maxIter
    
    % Selektion.
    % TODO: Selektiert die besten Individuen.
 
    
    % Rekombination.
    % TODO: Generiert neue Individuen aus Überlebenden durch Rekombination.

    
    % Mutation.
    % TODO: Mutiere zufällig die neuen Individuen.

    
    % Fitness-Update.
    % TODO: Berechne Fitness der neuen Generation.
    for i = 1:n
        fitness(i) = 
    end
    
    % Abbruchkriterium, falls Population sehr gut ist.
    if (min(fitness) >= 0.99)
        break;
    end
end

% Visualisiere gefundene Population.
for i = 1:n
    subplot(3, n, 10+i);
    imagesc(squeeze(P(i, :, :)));
    axis image;
    set(gca, 'xtick', [], 'ytick', []);
    title(fitness(i), 'FontWeight', 'bold');
end

% Zeige benoetigte Generationen.
subplot(3, n, 11);
text(0, -75, ['nach ' num2str(k) ' Iterationen'], 'FontWeight', 'bold');

% Zum Vergleich: Visualisiere perfekte Population.
for i = 1:n
    subplot(3, n, 20+i);
    imagesc(ant);
    axis image;
    set(gca, 'xtick', [], 'ytick', []);
end

print('-dpng', 'antFarm.png', '-r300');