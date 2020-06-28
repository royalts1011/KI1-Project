%Projekt 3, Aufgabe 2: Tiefe Einblicke ins Institut


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Namen aller Gruppenmitglieder



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Lade Bilddaten in imageDatstore-Objekt.
%myfolder='/meinPfad/zudenBildern/Bilder';
myfolder='/Users/jannis/Downloads/p3_funktionsruempfe-2/Aufgabe2/Bilder';
imds = imageDatastore(myfolder,'FileExtensions',{'.jpg'},'IncludeSubfolders',true,'LabelSource','foldernames');

%Teile in Trainings- und Testdaten ein
numTrainFiles=0.75; %Nutze 75% der Daten zum Training
[imdsTrain,imdsValidation] = splitEachLabel(imds,numTrainFiles,'randomize');

%TODO: Definiere die Netzarchitektur
layers = [];

%Parameter des Lernverfahrens. 'MaxEpochs' gibt die Anzahl der zu
%trainierenden Epochen an und definiert dadurch, wie lange das Netz
%traininert wird.
options = trainingOptions('adam', ...
    'InitialLearnRate',0.01, ...
    'MaxEpochs',50, ...
    'Shuffle','every-epoch', ...
    'ValidationData',imdsValidation, ...
    'ValidationFrequency',10, ...
    'Verbose',false, ...
    'Plots','training-progress');

%Definiere das Netz anhand der zuvor definierten Layer und starte Training.
net = trainNetwork(imdsTrain,layers,options);

%Evaluation. YPred beinhaltet die praedizierten Label, YTrue die
%tatsaechlichen.
YPred = classify(net,imdsValidation);
YTrue = imdsValidation.Labels;

%TODO: Evaluation und Output

















