%Projekt 3, Aufgabe 2: Tiefe Einblicke ins Institut


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Namen aller Gruppenmitglieder



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Lade Bilddaten in imageDatstore-Objekt.
%myfolder='/meinPfad/zudenBildern/Bilder';
myfolder='/Users/nils.loose/Documents/Künstliche Intelligenz/KI1-Project/Aufgabe2/Bilder';
imds = imageDatastore({myfolder,myfolder,myfolder,myfolder,myfolder,myfolder,myfolder,myfolder,myfolder,myfolder},'FileExtensions',{'.jpg'},'IncludeSubfolders',true,'LabelSource','foldernames');


%Teile in Trainings- und Testdaten ein
numTrainFiles=0.75; %Nutze 75% der Daten zum Training
[imdsTrain,imdsValidation] = splitEachLabel(imds,numTrainFiles,'randomize');


%Image Augmentation
augmenter = imageDataAugmenter( ...
    'RandRotation',[-20,20], ...
    'RandXTranslation',[-3 3], ...
    'RandYTranslation',[-3 3], ...
    'RandScale',[0.5 1], ...
    'RandXReflection',[1], ...
    'RandYReflection',[1]);

augImds = augmentedImageDatastore([224 224 3],imdsTrain,'DataAugmentation',augmenter);

batchedData = preview(augImds);
imshow(imtile(batchedData.input))
augImds


layers = [
    imageInputLayer([224 224 3])
    convolution2dLayer(3,10,'Stride',1,'Padding',1)
    batchNormalizationLayer
    reluLayer
    maxPooling2dLayer(3,'Stride',2);
    
    convolution2dLayer(3,10,'Stride',1,'Padding',1)
    batchNormalizationLayer
    reluLayer
    maxPooling2dLayer(3,'Stride',2);
    
    convolution2dLayer(3,10,'Stride',1,'Padding',1)
    batchNormalizationLayer
    reluLayer
    maxPooling2dLayer(3,'Stride',2);
    
    convolution2dLayer(3,10,'Stride',1,'Padding',1)
    batchNormalizationLayer
    reluLayer
    maxPooling2dLayer(3,'Stride',2);
    
    dropoutLayer(0.5) 
    fullyConnectedLayer(4)
    softmaxLayer
    classificationLayer];


%Parameter des Lernverfahrens. 'MaxEpochs' gibt die Anzahl der zu
%trainierenden Epochen an und definiert dadurch, wie lange das Netz
%traininert wird.
options = trainingOptions('adam', ...
    'InitialLearnRate',0.01, ...
    'MaxEpochs',50, ...
    'Shuffle','every-epoch', ...
    'ValidationData',imdsValidation, ...
    'ValidationFrequency',3, ...
    'Verbose',false, ...
    'Plots','training-progress');

%Definiere das Netz anhand der zuvor definierten Layer und starte Training.
net = trainNetwork(augImds,layers,options);


%Evaluation. YPred beinhaltet die praedizierten Label, YTrue die
%tatsaechlichen.
YPred = classify(net,imdsValidation);
YTrue = imdsValidation.Labels;

%TODO: Evaluation und Output
accuracy = sum(YPred == YTrue)/numel(YTrue)