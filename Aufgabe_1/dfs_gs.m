function [ V, L ] = dfs_gs( A, startState, goalState )
    
% flatten the inputs and convert them to Ints:
startState = reshape(startState, 1, []);
startState = num2str(startState);
startState = strrep(startState, ' ', '');
startState = bin2dec(startState);

goalState = reshape(goalState, 1, []);
goalState = num2str(goalState);
goalState = strrep(goalState, ' ', '');
goalState = bin2dec(goalState);


%Implementieren Sie hier die Tiefensuche als Graphsuche.

V = [];                                     % Array speichert Knoten des Pfades
L = [];                                     % Array speichert ???
max = length(A);                            % Maximale Anzahl besuchter Knoten.
discovered = false(1,max);                  % Es gibt maximal maxRounds Knoten, die man sich anschauen kann.
queue = [startState];                       % In der queue ist aktuell nur der Startzustand
discovered(startState + 1) = true;          % Da Startzustand bereits betrachtet, setzen wir
                                            % in discovered auf bereits
                                            % besucht(true). 
                                            % +1, da discovered von 1...n
                                            % l�uft. W�hrend die Zust�nde
                                            % von 0 bis n-1 gehen.
                                           

while ~isempty(queue)
    
    max = max - 1;                                  % max um 1 decrementieren
    if max == 0                                     % pr�fen, ob max erreicht wurde
         fprintf('Zu Viele Durchlaeufe')            % wenn ja Schleife
         return                                     % beenden.
    end

    current = queue(end);         % Hinten aus der Queue wir der erste Knoten genommen. LIFO
    queue(end) = [];              % Knoten aus Warteschlange wird gel�scht                   
    V = [V, current];             % Knoten wird dem Pfad hinzugef�gt


    if current == goalState       % Pr�fen, ob current unser Ziel ist
        return                    % Wenn ja beenden, da gefunden.
    end
    
    for i = 1 : length(A)                                    % Hier wollen wir alle Verbindungen hinzuf�gen
        if discovered(i) == false && A(current+1,i) == 1;    % Schauen, ob Knoten unbesucht und ob in A an position eine 1 steht
            discovered(i) = true;                            % Wenn Ja Knoten als besucht markieren
            queue = [queue, i-1];                            % Knoten in Warteschlange aufnehmen -1 wieder da Knotenwerte um 1 verschoben
    end
    
                                          
end

end