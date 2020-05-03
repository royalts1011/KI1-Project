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
nSurv = 2;
nDeaths = n - nSurv;
nMutations = 9;
maxIter = 8000;
randdist = 0.1;
 
 
% Initialisierung.
P = zeros(n, x, y);
Child = zeros(n, x, y);
fitness = zeros(n, 1);
 
% Generiere Startpopulation.
% TODO: Kommentiert/Unkommentiert eine der Zeilen, um eine der Startpopulationen zu erhalten.
for i = 1:n
   P(i, :, :) = round(rand(x, y));
   %P(i, :, :) = antdummy;
end
 
% Initiale Fitness.
% TODO: Berechnet Fitness der Startpopulation.
for i = 1:n
    fitness(i) = fitnessFunction(P(i, :, :));
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
    if mod(k,1000) == 0
        k
        %randdist = randdist / 10;
        fitness
        
    end
     if mod(k,250) == 0
        
        randdist = randdist / 1.5;

    end
    % Selektion.
    % TODO: Selektiert die besten Individuen.
    
    for i=1:nDeaths
        weekAnt = min(fitness); %schwaechstes Ameise bestimmen
        idx = find(weekAnt == fitness); %Index der Ameise
        %Ameise entfernen
        P(idx(1),:,:)=[];
        fitness(idx(1))=[]; 
        
    end
 
    
    % Rekombination.
    % TODO: Generiert neue Individuen aus ï¿½berlebenden durch Rekombination.
    
    %Berechne relative Fitness zur Fortpflanzung
    reprod = zeros(1);
    foo = zeros(1,nSurv);
    totalFitness = sum(fitness);
    for j = 1 : nSurv
        reprod(j) = fitness(j)/totalFitness;
        foo(j) = j;
    end
    
    
    for j = 1 : n
        par1 = P(randsrc(1,1,[foo;reprod]),:,:);
        par2 = P(randsrc(1,1,[foo;reprod]),:,:);
%         for col  = 1 : 198/2
%             for row = 1 : 160/2
%                 Child(j,2*col,2*row) = par1(1,2*col,2*row);
%                 Child(j,2*col-1,2*row-1) = par2(1,2*col-1,2*row-1);
%             end
%             
%         end
      Child(j,:,:) = [par1(1,1:99,:),par2(1,100:198,:)];
       
    
    end
    
    P = Child;
    Child = zeros(n, x, y);
    
    % Mutation.
    % TODO: Mutiere zufï¿½llig die neuen Individuen.
    mutations = randsrc(1,nMutations,[1 2 3 4 5 6 7 8 9 10]);%Zu mutierende individuen
    for i = 1 : nMutations
        %current best value: 100
        for j = 1 : 150%mutationNumber%ceil(maxIter/500- var*var)  %ceil(100 / (var*var))
            val1 = randi([1 198], 1);
            val2 = randi([1 160], 1);
            %newval = floor((P(mutations(i),max(1,val1-1),val2) + P(mutations(i),min(val1+1,198),val2) + P(mutations(i),val1,max(1,val2-1))+ P(mutations(i),val1,min(val2+1,160)))/3);
            newval = [0,1,P(mutations(i),max(1,val1-1),val2), P(mutations(i),min(val1+1,198),val2), P(mutations(i),val1,max(1,val2-1)), P(mutations(i),val1,min(val2+1,160))];
            
            P(mutations(i),val1,val2) = newval(randsrc(1,1,[[1 2 3 4 5 6];[randdist randdist 0.25-randdist/2 0.25-randdist/2 0.25-randdist/2 0.25-randdist/2]]));%~P(mutations(i),val1,val2);
        end
    end
    % Fitness-Update.
    % TODO: Berechne Fitness der neuen Generation.
    for i = 1:n
        fitness(i) = fitnessFunction(P(i, :, :));
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
