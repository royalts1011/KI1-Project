%Künstliche Intelligenz Projekt 3 Aufgabe 1: Am ROB rumfahren - Kalman
%machen, muss man nicht


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Namen und Matrikelnummern aller Gruppenmitglieder:
% Jesse Kruse: 675710
% Nils Loose: 675503
% Falco Lentzsch: 685454
% Jan-Ole Penderak: 681555
% Meiko Prilop: 681283
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc;
clear;
%Lade Daten
load('KalmanData.mat');


%TODO: Berechne gefilterte Position
p_filtered=zeros(size(p)); %Die Null-Initialisierung dient nur der fehlerfreien Visualisierung und sollte durch die Filterung ersetzt werden.

% init - Prädiktion:
x_t = [0.0;             % Im Initialen Zustand gehen wir davon aus, dass wir im Zentrum des Koordinatensystems
        0.0;            % starten und sich der Roboter nicht bewegt (Geschwindigkeit = 0)
        0.0;            % x_t_1: x-koordinate, x_t_2: y-koordinate, x_t_3: geschw in x-Richtung, x_t_4: geschw. in y-Richtung
        0.0];

F_t = [1, 0, 1, 0;      % Modellierung nach Formel p_(t+1) = p_t + geschw_t, also addition der jeweilgen komponenten aus x_t
        0, 1, 0, 1;     % Geschwindigkeiten werden zunächst unverändert übernommen
        0, 0, 1, 0; 
        0, 0, 0, 1];

u_t = [0.0;             % speichert die Beschleunigung als Aktion aus a
        0.0];

B_t = [0.5, 0.0;        % nach Formel wird die Hälfte der Beschleunigung als Strecke zurückgelgt(jeweils in
        0.0, 0.5;       % x- und y-Richtung. Auf die Geschwindiegkeit wird die Beschleunigung im neunen Zustand auffaddiert 
        1, 0.0;
        0.0, 1];

P_t = [0.0, 0, 0, 0;    % Initialisierung mit 0en bringt die besten Ergebnisse
        0, 0.0, 0, 0; 
        0, 0, 0.0, 0; 
        0, 0, 0, 0.0];
 
Q_t = [0.01, 0, 0, 0;   % Werte ebenfalls durch ausprobiern ermittelt.
        0, 0.01, 0, 0;  % nur werte aud der Diagonalen("runde Streuungen"). Keine Anhaltspunkte, für verformete Streunng
        0, 0, 0.01, 0; 
        0, 0, 0, 0.01];


% init - Update:

z_t = [0.0;             % enthlt später die Messung des Trackings
        0.0];

H_t =  [1, 0, 0, 0;     % abbildung von x_t auf auf 2x1 vektor um mit z_t verrechenbar zu sein
        0, 1, 0 ,0];    % nimmt die positionen aus x_t um die position in z_t vergleichen zu können
       

R_t = [0.5, 0;          % messrauchen ebenfalls durch ausprobieren ermittelt
        0, 0.5];  
    

for t = 1:72
   
    % Prädiktion:
    x_t = F_t * x_t + B_t * u_t;        % Prädiktion des neuen Zustandes
    P_t = F_t * P_t * F_t' + Q_t;       % Berechnung der Kovarianzmatrix
    
    u_t = a(:,t);                       % update u_t
    
    
    % Update:
    z_t = tracking(:,t);                             % Update Tracking
    
    K = (P_t * H_t') / (H_t * P_t * H_t' + R_t);     % Berechning Kalman-gain
    
    x_t = x_t + K * (z_t - H_t * x_t);               % update des Zustandes mit Gewichtung durch K
    P_t = P_t - (K * H_t * P_t);                     % update der Kovarianzmatrix mit Gewichtung durch K
    
    p_filtered(:,t) = x_t(1:2);                      % speicherung des gefilterten Zustandes.
   
end

% Euklidischer Abstand zwischen p_filtered und ground trouth
erg = (p_filtered - p).^2;
erg = sqrt(erg(1,:) + erg(2,:));
% ergibt den durchschnittlichen Abstand der Punkte
erg = sum(erg)/ 72;

disp(['Durchschnittliche Abweichung: ', num2str(erg)])

%Visualization
figure
hold on
plot(p(1,:),p(2,:)) %Ground Truth
plot(odometry(1,:),odometry(2,:)) %Odometry data
plot(tracking(1,:),tracking(2,:)) %Tracking data
plot(p_filtered(1,:),p_filtered(2,:))   %Filtered Data
legend('Ground Truth','Odometrie','Tracking','Filtered')
plot(p(1,1),p(2,1),'x')    %Start point
plot(odometry(1,end),odometry(2,end),'x') %Odometry End Point
plot(tracking(1,end),tracking(2,end),'x') %Tracking End Point
plot(p_filtered(1,end),p_filtered(2,end),'x') %Filtered End Point
hold off



























