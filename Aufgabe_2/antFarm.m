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
nSurv = 3;
nMutations = 4;
maxIter = 8000;

% Initialisierung.
P = zeros(n, x, y);
fitness = zeros(n, 1);

% Generiere Startpopulation.
% TODO: Kommentiert/Unkommentiert eine der Zeilen, um eine der Startpopulationen zu erhalten.
for i = 1:n
      P(i, :, :) = round(rand(x, y));
%     P(i, :, :) = antdummy;
end

% Initiale Fitness.
% TODO: Berechnet Fitness der Startpopulation.

ant = double(ant);
for i = 1:n
    summe = 0;
    for j = 1:x
        for l = 1:y
            if (ant(j,l) == P(i,j,l))
                summe = summe +1;
            end
        end
    end
    fitness(i) = summe/(x*y);
    
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
    best_indivs = zeros(1,nSurv);
    for i = 1:nSurv
        [max_val, tmp_idx] = max(fitness);
        best_indivs(i) = tmp_idx;
        % null setzen, damit idx nicht doppelt als bester vorkommt (vtl
        % lieber (-1)
        fitness(tmp_idx) = 0;
    end
 
    
    % Rekombination.
    % TODO: Generiert neue Individuen aus Überlebenden durch Rekombination.
    
    % 6 rekombinationene vom besten mit allen
    P_old = P;
    
    for i = 1:nSurv
        
        for diff = 2:nSurv
            for j = 1:x
                if(mod(j,2) == 0)
                    P(i,j,:) =  P_old(best_indivs(1),j,:);
                else                  
                    P(i,j,:) =  P_old(best_indivs(diff),j,:);
                end
            end
        end
        
    end
    
    % übrige rekombinationen zweitbester bis voll
   
    for i = (nSurv + 1):size(P,1)
        
        for diff = 3:nSurv
            for j = 1:x
                if (mod(j,2) == 0)
                    P(i,j,:) = P_old(best_indivs(2),j,:);
                else
                    P(i,j,:) = P_old(best_indivs(diff),j,:);  
                end
            end
        end
        
    end
    
    
    % Mutation.
    % TODO: Mutiere zufällig die neuen Individuen.
    
    for i = 1:size(P,1)
        num_muts = nMutations;
        for j = 0:num_muts
            idx_x = round(rand() * 197 + 1);
            idx_y = round(rand() * 159 + 1);
            
            P(i, idx_x, idx_y) = ~P(i, idx_x, idx_y);
            
        end
    end
    
    
    % Fitness-Update.
    % TODO: Berechne Fitness der neuen Generation.
    for i = 1:n
        summe = 0;
        for j = 1:x
            for l = 1:y
                if (ant(j,l) == P(i,j,l))
                    summe = summe + 1;
                end
            end
        end
    fitness(i) = summe/(x*y);
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