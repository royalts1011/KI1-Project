load fisheriris
X = meas(:,1:2);
y = categorical(species);
labels = categories(y);

gscatter(X(:,1),X(:,2),species,'rgb','osd');
xlabel('Sepal length');
ylabel('Sepal width');