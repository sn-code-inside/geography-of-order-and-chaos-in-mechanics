%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%              Symbolic (perturbative)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear maplemex
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
syms U1 U2 U3 U4 V1 V2 V3 V4 G1 G2 G3 A1 A2 A3 Ko real
syms tau x x1 x2 x3 y1 y2 y3 real
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
UV = [U1 V1; U2 V2; U3 V3; U4 V4];
x_vec = [x1 x2 x3];
y_vec = [y1 y2 y3];
K = Kp([x1 x2 x3],[y1 y2 y3], lambda, epsilon1, epsilon2, epsilon3, epsilon4, epsilon5,...
                   deg1, deg2, deg3, deg4, deg5, Hp1, Hp2, Hp3, Hp4, Hp5);
Kper = 2*pi*x*K;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dKper_U1 = 2*pi*(cos(2*pi*tau)*x*diff(K,x1)-sin(2*pi*tau)*diff(K,y1));     	 
dKper_U2 = 2*pi*(cos(2*pi*tau)*x*diff(K,x2)-sin(2*pi*tau)*diff(K,y2));     	
dKper_U3 = 2*pi*(cos(2*pi*tau)*x*diff(K,x3)-sin(2*pi*tau)*diff(K,y3));     	
dKper_U4 = (2*pi*sin(2*pi*tau)*(y1*diff(K,y1)+y2*diff(K,y2)+y3*diff(K,y3))-2*pi*sin(2*pi*tau)*K);     	
%     	
dKper_V1 = 2*pi*(sin(2*pi*tau)*x*diff(K,x1)+cos(2*pi*tau)*diff(K,y1));     	
dKper_V2 = 2*pi*(sin(2*pi*tau)*x*diff(K,x2)+cos(2*pi*tau)*diff(K,y2));     	
dKper_V3 = 2*pi*(sin(2*pi*tau)*x*diff(K,x3)+cos(2*pi*tau)*diff(K,y3));     	
dKper_V4 = (-2*pi*cos(2*pi*tau)*(y1*diff(K,y1)+y2*diff(K,y2)+y3*diff(K,y3))+2*pi*cos(2*pi*tau)*K);     	
%     	
dKper_G1 = 0;     	
dKper_G2 = 0;     	
dKper_G3 = 0;     	
%     	
dKper_A1 = -diff(Kper,x1);     	
dKper_A2 = -diff(Kper,x2);     	
dKper_A3 = -diff(Kper,x3);     	
%     	
dKper_Ko = -2*pi*(y1*diff(K,y1)+y2*diff(K,y2)+y3*diff(K,y3)) + 2*pi*K;     	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     	
grad_Kp = [dKper_U1; dKper_U2; dKper_U3; dKper_U4;...]     	
           dKper_V1; dKper_V2; dKper_V3; dKper_V4;...     	
           dKper_G1; dKper_G2; dKper_G3;...     	
           dKper_A1; dKper_A2; dKper_A3;...     	
           dKper_Ko];     	
P_GA = [0 -G3 G2 A1; G3 0 -G1 A2; -G2 G1 0 A3; -A1 -A2 -A3 0];     	
P_GU = [0 U3 -U2; -U3 0 U1; U2 -U1 0; 0 0 0];     	
P_GV = [0 V3 -V2; -V3 0 V1; V2 -V1 0; 0 0 0];     	
P_AU = [U4 0 0; 0 U4 0; 0 0 U4; -U1 -U2 -U3];     	
P_AV = [V4 0 0; 0 V4 0; 0 0 V4; -V1 -V2 -V3];     	
POISSON = [P_GA  Ko*eye(4) P_GU P_AU  UV(:,2);...     	
        -Ko*eye(4)  P_GA   P_GV P_AV -UV(:,1)];     	
F = POISSON*grad_Kp;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%