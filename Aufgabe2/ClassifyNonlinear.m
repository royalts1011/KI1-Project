%KI Projekt 2 Aufgabe 2
%--------------------------------------------------------------------------
%Unterscheiden Sie gute von nicht so guten Weinen. 
%Ein Wein zählt als gut wenn er einen Score von 7 oder mehr erreicht.

clear;
clc;

% Variablen
C=1;
gamma=10;

%Lade Datensatz
load('Data.mat');

% Die Scores in binäre Labels (gut = 1, schlecht = 0) transformieren
labels_Score = Score >= 7;
idx_good = find(labels_Score);
idx_bad =  find(~labels_Score);

% Dataset mit 50:50 (gut:schlecht) erstellen
dataset1 = SensorData(idx_good,:);
dataset2 = SensorData(idx_bad(1:length(idx_good)),:);
dataset = [dataset1; dataset2];

labels1 = labels_Score(idx_good);
labels2 = labels_Score(idx_bad(1:length(idx_good)));
labels = [labels1; labels2];

% Dataset so sortieren, dass immer abwechselnd ein guter und ein schlechter
% nacheinander stehen. Damit hat man für die einzelmengen sichgestellt,
% dass immer 50:50 Verhältnis herscht. 
% Um Labels entsprechend mit zu tauschen werden die beiden konkateniert
data_and_labels_sort = [dataset, labels];
idx1 = 1:length(data_and_labels_sort)/2;
idx2 = length(data_and_labels_sort)/2+1:length(data_and_labels_sort);
idx = vertcat(idx1,idx2);
idx = idx(:)';

data_and_labels = data_and_labels_sort(idx,:);

% Daten und Label wieder auseinander pflücken:
data = data_and_labels(:,1:11);
labels = data_and_labels(:,12);



size_test = floor(length(labels)/5);

error = 0.0;

% 5-fach Kreuzvalidierung -> Zerlegen der Menge in 5 Teilmengen, von denen
% jeweils eine pro Durchlauf zum testen verwendet wird.
for run = 1:5
    
    % Über Offset verschieben wir die Menge die gerade als Test genutzt
    % wird.
    offset = (run-1) * size_test;
    
    % Bestimmung des Testsets
    idx_test = 1 + offset: size_test + offset; 
    
    X_test = data(idx_test,:);
    Y_test = labels(idx_test);
    
    % Verwednen dann die übrigen Indizes zum trainieren
    idx_train = 1:length(labels);
    idx_train_bool = ~ismember(idx_train, idx_test);
    idx_train = idx_train(idx_train_bool);
    
    
    X_train = data(idx_train,:);
    Y_train = labels(idx_train);
    
   %Beipsielhaftes Training einer SVR. Hier wird ein radial basis function (rbf) Kernel
   %verwendet.


    %training
    SVMModel_nonlinear=fitcsvm(X_train,Y_train,'BoxConstraint',C,'KernelFunction','rbf','KernelScale',gamma);

    %test
    y_pred=predict(SVMModel_nonlinear,X_test);

    Y_error = abs(y_pred - Y_test);
    error = error + sum(Y_error)/size_test;

end

error = error / 5














































