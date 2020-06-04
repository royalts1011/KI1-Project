%KI Projekt 2 Aufgabe 2
%--------------------------------------------------------------------------
%Unterscheiden Sie gute von nicht so guten Weinen. 
%Ein Wein zählt als gut wenn er einen Score von 7 oder mehr erreicht.

clear;
clc;

% Variablen
C=1.0;
gamma=10;

%Lade Datensatz
load('Data.mat');

% Die Scores in binäre Labels (gut = 1, schlecht = 0) transformieren
labels_Score = Score >= 7;
idx_good = find(labels_Score);
idx_bad =  find(~labels_Score);

% nach guten und schlechten auftrennen, um die guten entsprechend zu
% vervielfältigen.
data_good = SensorData(idx_good, :);
data_good = normc(data_good);
data_bad = SensorData(idx_bad,:);
data_bad = normc(data_bad);

labeles_good = labels_Score(idx_good);
labeles_bad = labels_Score(idx_bad);

% Zusammen fassen von Labels und Daten um sie einfacher weiter verarbeiten
% zu können und die Labels beim tauschen an der richtigen Stelle bleiben.
dat_lab_good = [data_good, labeles_good];
dat_lab_bad = [data_bad, labeles_bad];


% Dataset mit 50:50 (gut:schlecht) erstellen:

% benötigte Werte berechnen
num_batch_bad = floor(length(idx_bad)/5);
num_batch_good = floor(length(idx_good)/5);
faktor = ceil(num_batch_bad / num_batch_good);

data_lab_good_rep = zeros(size(dat_lab_bad));

% in 5_fach_Kreuzvalidierung benötigen wir 5 Einzelmengen, die jeweils
% einmal Testmenge sind. Um sicher zustellen, dass in der Trainingsmenge
% keine Daten vorhanden sind die auch im Test sind werden die guten Weine
% auch in Fünftel zerlegt. Das erste Fünftel wird dann sieben mal
% konkatniert und von diesem dann 276 genommen um die richitge Anzahl zu
% haben. So ist sichergestllt, dass pro fünftel unterschiedliche gute Weite
% vorhanden sind.
for i = 1:5
    
    offset = (i - 1) * num_batch_good;
    offset2 = (i - 1) * num_batch_bad;
    
    % ein fünftel herauskopieren
    batch_good_norep = dat_lab_good(1+offset : num_batch_good+offset, :);
    % um "faktor" (=7) vervielfältigen
    batch_good = repmat(batch_good_norep, faktor,1);
    % durch mal 7 ein paar zuviel, daher hier wieder reduktion auf passende
    % 276
    batch_good = batch_good(1:num_batch_bad,:);
    % einsortieren in Gesamtmatrix
    data_lab_good_rep(1+offset2 :num_batch_bad+offset2, :) = batch_good(:,:);
    
end
% das floor() oben fehlen die letzten beiden Einträge, werden hier noch so
% hinzugefügt
data_lab_good_rep(end-1,: ) = batch_good(end-1, :);
data_lab_good_rep(end,:) = batch_good(end, :);

data_and_labels_sort = [data_lab_good_rep; dat_lab_bad];


% Dataset so sortieren, dass immer abwechselnd ein guter und ein schlechter
% nacheinander stehen. Damit hat man für die Einzelmengen in der Kreuzvalidierung
% sichgestellt, dass immer 50:50 Verhältnis herscht. 
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
    
     % suffle data randomly:
    rand_vec_test = randperm(length(idx_test));
    X_test = X_test(rand_vec_test,:);
    Y_test = Y_test(rand_vec_test);
    
    % Verwednen dann die übrigen Indizes zum trainieren
    idx_train = 1:length(labels);
    idx_train_bool = ~ismember(idx_train, idx_test);
    idx_train = idx_train(idx_train_bool);
    
    
    X_train = data(idx_train,:);
    Y_train = labels(idx_train);
    
    % suffle data randomly:
    rand_vec_train = randperm(length(idx_train));
    X_train = X_train(rand_vec_train,:);
    Y_train = Y_train(rand_vec_train);
    
    %Beipsielhaftes Training einer SVM. Hier wird ein linearer Kernel
    %verwendet.

     %training
    SVMModel_nonlinear=fitcsvm(X_train,Y_train,'BoxConstraint',C,'KernelFunction','rbf','KernelScale',gamma);

    %test
    y_pred=predict(SVMModel_nonlinear,X_test);

    Y_error = abs(y_pred - Y_test);
    error = error + sum(Y_error)/length(Y_error);
    
end

error = error / 5;

fprintf("Anteil falscher Vorhersagen: " + error + "\n");



%test run:

X = SensorData;
Y = labels_Score;

SVMModel = fitcsvm(X,Y,'BoxConstraint',C,'KernelFunction','rbf','KernelScale',gamma)
CVSVMModel = crossval(SVMModel,'KFold', 5)
TrainedModel = CVSVMModel.Trained{1}
kfoldLoss(CVSVMModel)












































