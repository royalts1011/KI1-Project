function [ V, L ] = dfs( A, startState, goalState )

% flatten the inputs and convert them to Ints:
startState = reshape(startState, 1, []);
startState = num2str(startState);
startState = strrep(startState, ' ', '');
startState = bin2dec(startState);

goalState = reshape(goalState, 1, []);
goalState = num2str(goalState);
goalState = strrep(goalState, ' ', '');
goalState = bin2dec(goalState);


%Implementieren Sie hier die einfache Tiefensuche.

V = [];                                     % Array speichert Knoten des Pfades
L = [];                                     % Array speichert ???
max = length(A);                            % Maximale Anzahl besuchter Knoten.
discovered = false(1,max);                  % Es gibt maximal maxRounds Knoten, die man sich anschauen kann.
queue = [startState];                       % In der queue ist aktuell nu der Startzustand

while ~isempty(queue)
    
    max = max - 1;
    if max == 0                                     % prüfen, ob maxRounds erreicht wurde
         fprintf('Suche benoetigt zu viel Zeit')    % wenn ja Schleife
         return                                     % beenden.
    end
    
    current = queue(end); 
    if discovered(current+1) == true
        return
    end
    
                                    % Vorne aus der Queue wir der erste Knoten genommen.
    discovered(current+1) = true;   % Wenn Ja Knoten als besucht markieren
    queue(end) = [];                % Knoten aus Warteschlange wird gelöscht                   
    V = [V, current];               % Knoten wird dem Pfad hinzugefügt


    if current == goalState       % Prüfen, ob current unser Ziel ist
        return                    % Wenn ja beenden, da gefunden.
    end
    
    for i = 1 : length(A)
        if  A(current+1,i) == 1    % Schauen, ob Knoten unbesucht und ob in A an position eine 1 steht
            queue = [queue, i-1];  % Knoten in Warteschlange aufnehmen
        end
    
                                          
    end

end
    
end