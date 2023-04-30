function [h,hg,T,P,rho,a]=isa_prop(num_of_points_in_one_layer)
% This function calculates the International Standard Atmosphere (ISA) parameters at different altitudes based on improved methods. 
% The ISA provides the standard values for atmospheric properties such as temperature, pressure, density, and speed of sound in the atmosphere at various altitudes. 
% The atmosphere is divided into seven layers, and each layer has a different temperature-pressure relationship. The layers are defined based on the height from the sea level and the temperature and pressure values at each layer are defined based on the ISA.
%
% Inputs:
% - num_of_points_in_one_layer: number of points to generate within each layer. This parameter determines the granularity of the output. A larger number results in a more precise output but requires more computational time.
%
% Outputs:
% - h  : height in kilometers from the sea level
% - hg : geopotential height in kilometers
% - T  : temperature in Celsius
% - P  : pressure in bar
% - rho: density in kg/m^3
% - a  : speed of sound in km/h
%
% Note: This function uses the improved ISA method based on the 1976 U.S.
% Standard Atmosphere.
%
% The algorithm of this function is as follows:
% 1. Define the height ranges of the seven layers.
% 2. Divide each layer into "num_of_points_in_one_layer" points.
% 3. Calculate the geopotential height based on the height of each point.
% 4. Calculate the temperature, pressure, the density and speed of sound for each point in each layer.
% 5. Return the calculated values for all the points.



% Validate input argument
if num_of_points_in_one_layer <= 1
    error('Input argument must be a positive integer greater than 1.');
end

% Initialize arrays
hg0=[0,11e3,25e3,47e3,53e3,79e3,90e3,105e3];
T0=[288.16,216.66,216.66,282.66,282.66,165.66,165.66];
P0=[101330,22632,2488.6,120.44,58.321,1.0094,.10444];
a0=[-0.0065,0,0.003,0,-0.0045,0,0.004];

% constant
g0=9.80665;
R=287.04;
r=6.356766e6;
gamma=1.4;

N=num_of_points_in_one_layer;

hg_1=linspace(hg0(1),hg0(2),N);
hg_2=linspace(hg0(2),hg0(3),N);
hg_3=linspace(hg0(3),hg0(4),N);
hg_4=linspace(hg0(4),hg0(5),N);
hg_5=linspace(hg0(5),hg0(6),N);
hg_6=linspace(hg0(6),hg0(7),N);
hg_7=linspace(hg0(7),hg0(8),N);

hg=transpose([hg_1;hg_2;hg_3;hg_4;hg_5;hg_6;hg_7]);

h=(r*hg)./(r+hg);

T=zeros(size(hg));
P=zeros(size(hg));
rho=zeros(size(hg));
a=zeros(size(hg));

% Calculate properties
for layer=1:7
    if mod(layer,2)==0          %isothermal
        T(1:N,layer)=T0(layer);
        P(1:N,layer)=P0(layer)*exp(-g0*(hg(1:N,layer)-hg0(layer))/(R*T0(layer)));
    else                        %gradient
        T(1:N,layer)=T0(layer)+a0(layer).*(hg(1:N,layer)-hg0(layer));
        P(1:N,layer)=P0(layer)*(T(1:N,layer)/T0(layer)).^(-g0/(a0(layer)*R));
    end
    rho(1:N,layer)=P(1:N,layer)/R./T(1:N,layer);
    a(1:N,layer)=sqrt(gamma*R*T(1:N,layer));
end

% Convert units
h=h/1000;
hg=hg/1000;
T=T-273;
P=P/10^5;
a=a/1000*3600;