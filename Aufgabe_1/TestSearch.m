%Künstliche Intelligenz - Projekt 1

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Namen und Matrikelnummern aller Gruppenmitglieder:
% Jesse Kruse: 675710
% Nils Loose: 675503
% Falco Lentzsch: 685454
% Jan-Ole Penderak: 681555
% Meiko Prilop: 681283
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Lade die leere Leinwand und ein Bild des Holstentores.
load('Holstentor.mat');
load('Leinwand.mat');

%Lade zuvor berechnete Adjazenzmatrix (siehe Aufgabenteil b).
load('Adjacency.mat');

%Geben Sie das gewünschte Start und das Gewünschte Ziel an.
startState= [0,0,0;
             0,0,0;
             0,0,0;
             0,0,0];
goalState= [0,0,0;
            1,0,1;
            1,1,1;
            1,0,1];

%% Breitensuche als Graphsuche
%starte Timer
tstart=tic;

%Führe Breitensuche als Graphsuche durch
[ V_b, L_b ] = bfs_gs( A, startState, goalState );

%Ausgabe:
fprintf('\n Breitensuche als Graphsuche:\n')
fprintf(['Anzahl besuchter Knoten: ' num2str(length(V_b)) '\n'])
fprintf(['Besuchte Knoten: ' num2str(V_b) '\n'])
fprintf(['Benoetigte Zeit: ' num2str(toc(tstart)) '\n'])

%% Tiefensuche als Graphsuche
%starte Timer
tstart=tic;

%Führe Tiefensuche als Graphsuche durch
[ V_dgs, L_dgs ] = dfs_gs( A, startState, goalState );

%Ausgabe:
fprintf('\n Tiefensuche als Graphsuche:\n')
fprintf(['Anzahl besuchter Knoten: ' num2str(length(V_dgs)) '\n'])
fprintf(['Besuchte Knoten: ' num2str(V_dgs) '\n'])
fprintf(['Benoetigte Zeit: ' num2str(toc(tstart)) '\n'])

%% Einfache Tiefensuche
%starte Timer
tstart=tic;

%Führe einfache Tiefensuche durch
[ V_d, L_d ] = dfs( A, startState, goalState );

%Ausgabe:
fprintf('\n Einfache Tiefensuche:\n')
fprintf(['Anzahl besuchter Knoten: ' num2str(length(V_d)) '\n'])
fprintf(['Besuchte Knoten: ' num2str(V_d) '\n'])
fprintf(['Benoetigte Zeit: ' num2str(toc(tstart)) '\n'])




















