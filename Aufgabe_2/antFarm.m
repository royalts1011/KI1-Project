%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Namen und Matrikelnummern aller Gruppenmitglieder:
% Jesse Kruse: 675710 
% Nils Loose: 675503
% Falco Lentzsch: 685454 
% Jan-Ole Penderak: 681555 
% Meiko Prilop: 681283
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
n = 10;                 % Anzahl an Ameisen
nSurv = 2;              % Anzahl ueberlebene Ameisen 
nDeaths = n - nSurv;    % Anzahl sterbender Ameisen pro Iteration
nMutations = 9;         % Anzahl Mutationen pro Iterationen
maxIter = 8000;         % Anzahl an Iterationen  festlegen
randdist = 0.1;         % In Prozent - Wie Wahrscheinlich ein Pixel 
                        % unabhängig von seiner Nachbarschaft mutiert
progress = true;        % Wenn gesetzt wird der Fortschritt während des 
                        % Trainierens angezeigt
    
 
% Initialisierung.
P = zeros(n, x, y);         % Initiale Ameisen
Child = zeros(n, x, y);     % Kinder Ameisen initialisieren
fitness = zeros(n, 1);      % fitness Array der Laenge der Anzahl Ameisen
 
% Generiere Startpopulation.
for i = 1:n
   P(i, :, :) = round(rand(x, y));          % Runde Ameise als Startzustand
   %P(i, :, :) = antdummy;                  % Rauschende Ameise als
                                            % Startzustand
end
 
% Hier wird die initiale Fitness berechnet.
for i = 1:n
    fitness(i) = fitnessFunction(P(i, :, :));
                                            % Funktion wird aufgerufen, die
                                            % fuer jede Ameise die Fitness
                                            % berechnet und in einem Array
                                            % speichert.
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
    if mod(k,1000) == 0 && progress == true % logging
        k
        fitness
        
    end
     if mod(k,250) == 0                     % Die WS das ein Pixel 
        randdist = randdist / 1.5;          % unabhaengig von seiner 
                                            % Nachbarschaft mutiert nimmt
                                            % alle 250 Iterationen um 50%
                                            % ab. Somit sinkt die Anzahl
                                            % diese Mutationen während der
                                            % Laufzeit
     end
    
    % Selektion.
    for i=1:nDeaths
        weekAnt = min(fitness);             % schwaechste Ameise anhand der 
                                            % Fitness bestimmen
        idx = find(weekAnt == fitness);     % Index der schwaechsten Ameise
                                            % bestimmen schwaechste Ameise
        P(idx(1),:,:)=[];                   % loeschen fitness der
        fitness(idx(1))=[];                 % schwaechsten Ameise loeschen
                                            
        
    end
 
    
    % Rekombination. Berechne relative Fitness zur Fortpflanzung
    reprod = zeros(1);                      % Vektor - Enthält für jede  
                                            % Ameise die WS das sie sich
                                            % Fortpflanzt; desto besser die
                                            % Fitness deste höher die
                                            % Fortpflanzungs-WS
    idx = zeros(1,nSurv);
    totalFitness = sum(fitness);            % Wird benötigt damit 
                                            % sum(reprod) == 1 gilt und
                                            % reprod eine WS-Verteilung ist
    for j = 1 : nSurv
        reprod(j) = fitness(j)/totalFitness;
        idx(j) = j;
    end
    
    
    for j = 1 : n                           % Die n Kinder werden 'erzeugt'
        par1 = P(randsrc(1,1,[idx;reprod]),:,:);
        par2 = P(randsrc(1,1,[idx;reprod]),:,:);
                                            % Die beiden Eltern werden
                                            % anhand ihres reprod-Wertes
                                            % ausgewählt (können auch die
                                            % gleichen sein)
        
        
        Child(j,:,:) = [par1(1,1:99,:),par2(1,100:198,:)];
                                            % Die n Kinder setzten sich
                                            % 50:50 aus beiden Elternteilen
                                            % zusammen.
    end
    
    P = Child;                              % Zwischenspeicher, damit kein 
    Child = zeros(n, x, y);                 % Elternteil überschrieben wird.
    
    
    
    
    % Mutation.
    mutations = randsrc(1,nMutations,[1 2 3 4 5 6 7 8 9 10]);
                                            % Zu mutierende individuen
    for i = 1 : nMutations                  % nMutations viele Ameisen
                                            % werden mutiert
        for j = 1 : 150                     % Bei jeder Ameise werden 
                                            % 150 px mutiert
                                            
            val1 = randi([1 198], 1);       % Hier werden jeweil die 
            val2 = randi([1 160], 1);       % Koordinaten Pixels bestimmt
            
                                            % Zufällige mutation zu 0 / 1
                                            % und die vier Pixelwerte der
                                            % Nachbarn oder sich selber (am
                                            % Rand)
            newval = [0,1,...               
                P(mutations(i),max(1,val1-1),val2), ... 
                P(mutations(i),min(val1+1,198),val2), ...
                P(mutations(i),val1,max(1,val2-1)), ...
                P(mutations(i),val1,min(val2+1,160))];
                            
                                            % Der neue Pixelwert ist mit WS
                                            % randdist zufällig 0 oder 1
                                            % und 1-2*randist
                                            % gleichverteilt einer der
                                            % vier benachbarten Pixelwerte.
            P(mutations(i),val1,val2) = ...
                newval(randsrc(1,1,[[1 2 3 4 5 6]; ...
                    [randdist randdist ...
                    0.25-randdist/2 0.25-randdist/2 ...
                    0.25-randdist/2 0.25-randdist/2]]));
        end
    end
                                            % Die Fitness der neuen
                                            % Generation wird hier berechnet
    for i = 1:n
        fitness(i) = fitnessFunction(P(i, :, :));
    end
    
                                            % Abbruchkriterium, falls 
                                            % Population sehr gut ist.
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
