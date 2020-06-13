function [Y_predict] = predict_kNN(X_train,Y_train,X_test, k)
%In dieser Funktion wird ein k-Nearest-Neighbor Klassifikator genutzt,um
%auf Basis der Beobachtungen X_train und Y_train eine Klassifikation für
%X_test zu treffen. k beschreibt die Anzahl der betrachteten Nachbarn.
    
    %Variablen für jede Iteration über die Testdaten
    dist_list = zeros(size(X_train,1),2);   %Distanzen zu allen Knoten
    pred_list = zeros(k);                   %Label der Nachbarn
    
    %Variable in der die prediction für jedes Testobject steht
    Y_predict = zeros(size(X_test,1),1);
    
    %Iteration über alle Elemente aus X_test
    for subject=1:size(X_test,1)
        %Betrachtung jedes Nachbarn 
        for neighbour=1:size(X_train,1)
            %Berechnung der Distanzen zu allen anderen Knoten
            dist_list(neighbour,1) = neighbour;
            dist_list(neighbour,2) = euclidean_dist(X_test(subject,:),X_train(neighbour,:));
        end
        
        %Sortieren der Liste
        dist_list = sortrows(dist_list,2);
        
        %Betrachtung der k nächsten Nachbarn
        for neighbour=1:k
            pred_list(neighbour) = Y_train(dist_list(neighbour,1));
        end
        %Finale pred basierend auf Mehrheitsentscheid
        pred = 0;
        for label=1:k
            pred = pred + pred_list(label);
        end
        
        %Speichern der prediction
        Y_predict(subject) = round(pred/k);
    end



end

%Berechung der Distanz im n-dimensionalen durch die Euklidische Distanz
function dist = euclidean_dist(current_node, target_node)
    dist = 0;
    for dim=1:size(current_node,2)
        dist = dist + (current_node(dim)-target_node(dim))^2;
    end
    dist = sqrt(dist);
end