%Projekt 3, Aufgabe 2: Tiefe Einblicke ins Institut


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Namen und Matrikelnummern aller Gruppenmitglieder:
% Jesse Kruse: 675710
% Nils Loose: 675503
% Falco Lentzsch: 685454
% Jan-Ole Penderak: 681555
% Meiko Prilop: 681283
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Lade Bilddaten in imageDatstore-Objekt.
%myfolder='/meinPfad/zudenBildern/Bilder';
myfolder='/Users/nils.loose/Documents/Künstliche Intelligenz/KI1-Project/Aufgabe2/Bilder';
imds = imageDatastore(myfolder,'FileExtensions',{'.jpg'},'IncludeSubfolders',true,'LabelSource','foldernames');

%Teile in Trainings- und Testdaten ein
numTrainFiles=0.75; %Nutze 75% der Daten zum Training
[imdsTrain,imdsValidation] = splitEachLabel(imds,numTrainFiles,'randomize');

%TODO: Definiere die Netzarchitektur
net = resnet101; 
numClasses = numel(categories(imdsTrain.Labels))
lgraph = layerGraph(net)
newFCLayer = fullyConnectedLayer(numClasses,'Name','new_fc','WeightLearnRateFactor',10,'BiasLearnRateFactor',10); 
lgraph = replaceLayer(lgraph,'fc1000',newFCLayer); 
newClassLayer = classificationLayer('Name','new_classoutput'); 
lgraph = replaceLayer(lgraph,'ClassificationLayer_predictions',newClassLayer);
%Parameter des Lernverfahrens. 'MaxEpochs' gibt die Anzahl der zu
%trainierenden Epochen an und definiert dadurch, wie lange das Netz
%traininert wird.
options = trainingOptions('sgdm', ...
    'InitialLearnRate',0.001, ...
    'MaxEpochs',10, ...
    'Shuffle','every-epoch', ...
    'ValidationData',imdsValidation, ...
    'ValidationFrequency',1, ...
    'Verbose',false, ...
    'Plots','training-progress');%, ...
    % 'MiniBatchSize', 64);

%Definiere das Netz anhand der zuvor definierten Layer und starte Training.
myNet = trainNetwork(imdsTrain,lgraph,options);

%Evaluation. YPred beinhaltet die praedizierten Label, YTrue die
%tatsaechlichen.
YPred = classify(myNet,imdsValidation);
YTrue = imdsValidation.Labels;

%TODO: Evaluation und Output

YPred
YTrue
accuracy = sum(YPred == YTrue)/numel(YTrue)
















