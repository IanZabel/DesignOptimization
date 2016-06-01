clear all
clc
% Design Optimization: Rocket Dry Mass
% Ian B Zabel

%% Initially Defined Parameters:
%  Note on mass fraction: goal 0.04 < fi < 0.3 (?)
%  This range typical for in-atmo craft        (?)

g    = 9.81;  % Gravity                    (m/s^2)
dv   = 2000;  % Required delta-v           (m/s)
mt   = 2.2;   % Mass of Fuel Tanks, Known  (kg)
me   = 0.5;   % Mass of Engine, Known      (kg)
Isp  = 250;   % Target Specific Impulse    (s)
Ve   = Isp*g; % Exhaust Velocity           (m/s)
C    = dv/Ve; % Delta-v / Exhaust Velocity (dimless)
of   = 1.3;   % Oxidizer to Fuel Ratio     (dimless)
fi   = 0.15;  % Target Inert Mass Fraction (dimless)
fp   = 1-fi;  % Propellant Mass Fraction   (dimless)
rhof = 786;   % Fuel Density, Isopropyl    (kg/m^3)
rhoo = 1146;  % Oxidizer Density, Lox      (kg/m^3)
mfee = 1.4;   % Feed System Mass           (kg)
mpay = 1;     % Avi. and Recovery Mass     (kg)

%% Fuel Considerations:

mprop = mwet*(exp(C)-1)*(1-fi)/(1-fi*exp(C)); % Propellant Mass (kg)
mox   = mprop*of/(of+1);                      % Oxidizer Mass   (kg)
mf    = mprop-mox;                            % Fuel Mass       (kg)
Vf    = mf/rhof;                              % Fuel Volume     (m^3)
Vox   = mox/rhoo;                             % Ox. Volume      (m^3)

fprintf('Propellant Mass: %3.2f (kg) \n',   mprop)
fprintf('Fuel Mass:       %3.2f (kg) \n',   mf)
fprintf('Oxidizer Mass:   %3.2f (kg) \n\n', mox)

%% Wet and Dry Mass Calculation:

c    = mprop+mpay+mfee+mt+me;           % (Wet Mass)-(Airframe Mass) (kg)
mair = (exp(C)*(c-mprop)-c)/(1-exp(C)); % Airframe Mass              (kg)
mw   = c+mair;                          % Wet Mass                   (kg)
md   = c+mair-mprop;                    % Dry Mass                   (kg)

fprintf('Airframe Mass: %3.2f (kg)\n',   mair)
fprintf('Wet Mass:      %3.2f (kg)\n',   mw)
fprintf('Dry Mass:      %3.2f (kg)\n\n', md)
