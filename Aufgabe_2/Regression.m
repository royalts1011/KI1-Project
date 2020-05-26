%KI Projekt 2 Aufgabe 2
%--------------------------------------------------------------------------
%Schätzen Sie den Qualitätswert eines Weins aufgrund seiner
%physikalisch-chemischen Eigenschaften.

%Lade Datensatz
load('Data.mat');


%Beipsielhaftes Training einer SVM. Hier wird ein radial basis function (rbf) Kernel
%verwendet.
C=1;
gamma=10;

%training
SVMModel_nonlinear=fitrsvm(X_train,y_train,'BoxConstraint',C,'KernelFunction','rbf','KernelScale',gamma);

%test
y_pred=predict(SVMModel_nonlinear,X_test);















































