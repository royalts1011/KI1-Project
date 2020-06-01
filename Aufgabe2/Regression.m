clear;
clc;

%KI Projekt 2 Aufgabe 2
%--------------------------------------------------------------------------
%Schätzen Sie den Qualitätswert eines Weins aufgrund seiner
%physikalisch-chemischen Eigenschaften.

%Lade Datensatz
load('Data.mat');

C=1;
gamma=10;

test_size = floor(length(Score)/5);

error = 0.0;

% 5-fach Kreuzvalidierung:
for run = 1:5
    
    % Ermittlung der aktuellen testmenge abhängig von Durchlauf 
    offset = (run - 1) * test_size;
    
    idx_test = 1 + offset : test_size + offset;
    idx_train = 1:length(Score);
    idx_train_bool = ~ismember(idx_train, idx_test);
    idx_train = idx_train(idx_train_bool);
    
    % Split in Test und Trainingsdaten
    X_test =  SensorData(idx_test, :);
    y_test = Score(idx_test);
    
    X_train = SensorData(idx_train,:);
    y_train = Score(idx_train);


    %Beipsielhaftes Training einer SVM. Hier wird ein radial basis function (rbf) Kernel
    %verwendet.

    %training
    SVMModel_nonlinear=fitrsvm(X_train,y_train,'BoxConstraint',C,'KernelFunction','rbf','KernelScale',gamma);

    %test
    y_pred=predict(SVMModel_nonlinear,X_test);
    
    % Berechnung der Abweichung für diesen Durchlauf
    Y_error = abs(y_pred - y_test);
    error = error + sum(Y_error) / length(Y_error);
    
end

%  Durchschnittliche Abweichung über alle Durchläufe
error = error / 5;

fprintf("Durchschnittliche Abweichung: " + error + "\n");













































