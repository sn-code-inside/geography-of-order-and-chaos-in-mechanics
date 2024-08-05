# -*- coding: utf-8 -*-
import sympy
sympy.init_printing
from sympy import *
####################################################################################
U1, U2, U3, U4, V1, V2, V3, V4, G1, G2, G3, A1, A2, A3, Ko, tau, x, x1, x2, x3, y1, y2, y3 = symbols("U1 U2 U3 U4 V1 V2 V3 V4 G1 G2 G3 A1 A2 A3 Ko tau x x1 x2 x3 y1 y2 y3")
UV = Matrix([[U1, V1], [U2, V2], [U3, V3], [U4, V4]])
x_vec = Matrix([x1, x2, x3])
y_vec = Matrix([y1, y2, y3])
####################################################################################
f = open("./Python/parameters.txt","r")
parameter_list = eval(f.read())
f.close()

landa = parameter_list[0]

epsilon1 = parameter_list[1]
epsilon2 = parameter_list[2]
epsilon3 = parameter_list[3]
epsilon4 = parameter_list[4]
epsilon5 = parameter_list[5]

deg1 = parameter_list[6]
deg2 = parameter_list[7]
deg3 = parameter_list[8]
deg4 = parameter_list[9]
deg5 = parameter_list[10]

Hp1 = parameter_list[11]
Hp2 = parameter_list[12]
Hp3 = parameter_list[13]
Hp4 = parameter_list[14]
Hp5 = parameter_list[15]

def  Kp(x_vec, y_vec, landa, epsilon1, epsilon2, epsilon3, epsilon4, epsilon5,
        deg1, deg2, deg3, deg4, deg5, Hp1, Hp2, Hp3, Hp4, Hp5):
    return epsilon1*landa**(2*deg1+2)*eval(Hp1 + '(x_vec, y_vec)') \
         + epsilon2*landa**(2*deg2+2)*eval(Hp2 + '(x_vec, y_vec)') \
         + epsilon3*landa**(2*deg3+2)*eval(Hp3 + '(x_vec, y_vec)') \
         + epsilon4*landa**(2*deg4+2)*eval(Hp4 + '(x_vec, y_vec)') \
         + epsilon5*landa**(2*deg5+2)*eval(Hp5 + '(x_vec, y_vec)')
         
def Anisotropic(x_vec, y_vec):
    return y_vec[2]**2

def Hill(x_vec, y_vec):
    mu = 0.1; # Moon mass, with Moon mass + Earth mass = 1
    return  mu/2*(-2*x_vec[0]**2 + x_vec[1]**2 + x_vec[2]**2)

def Euler1(x_vec, y_vec):
    return -1/sqrt((x_vec[0] - 2/landa**2)**2 + x_vec[1]**2 + x_vec[2]**2)

def Euler2(x_vec, y_vec):
    return -1/sqrt(x_vec[0]**2 + (x_vec[1] - 2/landa**2)**2 + x_vec[2]**2)

def Euler3(x_vec, y_vec):
    return -1/sqrt(x_vec[0]**2 + x_vec[1]**2 + (x_vec[2] - 2/landa**2)**2)

def Oscillator(x_vec, y_vec):
    k1 = 1.
    k2 = 1.
    k3 = 1.
    return 1/2*(k1*x_vec[0]**2 + k2*x_vec[1]**2 + k3*x_vec[2]**2)

def overR2(x_vec, y_vec):
    return 1/(x_vec[0]**2 + x_vec[1]**2 + x_vec[2]**2)

def overR3(x_vec, y_vec):
    return 1/(x_vec[0]**2 + x_vec[1]**2 + x_vec[2]**2)**(3/2)

def p_2(x_vec, y_vec):
    return y_vec[1]

def QZ1(x_vec, y_vec):
    return x_vec[1]**2 + x_vec[2]**2

def QZ2(x_vec, y_vec):
    return x_vec[0]**2 + x_vec[2]**2

def QZ3(x_vec, y_vec):
    return x_vec[1]**2 + x_vec[0]**2

def Satellite(x_vec, y_vec):
    x = sqrt(x_vec[0]**2 + x_vec[1]**2 + x_vec[2]**2)
    return -(1/2*(x_vec[0]**2 + x_vec[1]**2 ) - x_vec[2]**2 )/x**5
        
def Stark1(x_vec,y_vec):
    return x_vec[0]

def Stark2(x_vec,y_vec):
    return x_vec[1]

def Stark3(x_vec,y_vec):
    return x_vec[2]

def Zeeman1(x_vec, y_vec):
    return x_vec[1]*y_vec[2]-x_vec[2]*y_vec[1]

def Zeeman2(x_vec, y_vec):
    return x_vec[2]*y_vec[0]-x_vec[0]*y_vec[2]

def Zeeman3(x_vec, y_vec):
    return x_vec[0]*y_vec[1]-x_vec[1]*y_vec[0]

def Zero(x_vec, y_vec):
    return 0
####################################################################################
K = Kp(x_vec, y_vec, landa, epsilon1, epsilon2, epsilon3, epsilon4, epsilon5,
        deg1, deg2, deg3, deg4, deg5, Hp1, Hp2, Hp3, Hp4, Hp5)
Kper = 2*pi*x*K
dKper_U1 = 2*pi*(cos(2*pi*tau)*x*diff(K,x1)-sin(2*pi*tau)*diff(K,y1))
dKper_U2 = 2*pi*(cos(2*pi*tau)*x*diff(K,x2)-sin(2*pi*tau)*diff(K,y2))
dKper_U3 = 2*pi*(cos(2*pi*tau)*x*diff(K,x3)-sin(2*pi*tau)*diff(K,y3))
dKper_U4 = (2*pi*sin(2*pi*tau)*(y1*diff(K,y1)+y2*diff(K,y2)+y3*diff(K,y3))-2*pi*sin(2*pi*tau)*K)

dKper_V1 = 2*pi*(sin(2*pi*tau)*x*diff(K,x1)+cos(2*pi*tau)*diff(K,y1))     	
dKper_V2 = 2*pi*(sin(2*pi*tau)*x*diff(K,x2)+cos(2*pi*tau)*diff(K,y2))     	
dKper_V3 = 2*pi*(sin(2*pi*tau)*x*diff(K,x3)+cos(2*pi*tau)*diff(K,y3))     	
dKper_V4 = (-2*pi*cos(2*pi*tau)*(y1*diff(K,y1)+y2*diff(K,y2)+y3*diff(K,y3))+2*pi*cos(2*pi*tau)*K)

dKper_G1 = 0     	
dKper_G2 = 0    	
dKper_G3 = 0     	
#    	
dKper_A1 = -diff(Kper,x1)     	
dKper_A2 = -diff(Kper,x2)     	
dKper_A3 = -diff(Kper,x3)     	
   	
dKper_Ko = -2*pi*(y1*diff(K,y1)+y2*diff(K,y2)+y3*diff(K,y3)) + 2*pi*K
####################################################################################
grad_Kp = Matrix([dKper_U1, dKper_U2, dKper_U3, dKper_U4, dKper_V1, dKper_V2, dKper_V3, dKper_V4, dKper_G1, dKper_G2, dKper_G3, dKper_A1, dKper_A2, dKper_A3, dKper_Ko])

L1 = [ 0, -G3, G2, A1,   Ko, 0, 0, 0,      0, U3, -U2,   U4, 0, 0,   V1]
L2 = [ G3, 0, -G1, A2,   0, Ko, 0, 0,     -U3, 0,  U1,   0, U4, 0,   V2] 
L3 = [-G2, G1, 0,  A3,   0, 0, Ko, 0,      U2,-U1, 0,    0,  0, U4,  V3]
L4 = [-A1,-A2,-A3,  0,   0, 0, 0, Ko,      0,  0,  0,   -U1,-U2,-U3,  V4]
L5 = [-Ko, 0, 0, 0,      0, -G3, G2, A1,   0, V3, -V2,   V4, 0, 0,  -U1]
L6 = [0, -Ko, 0, 0,      G3, 0, -G1, A2,  -V3, 0,  V1,   0, V4, 0,  -U2]
L7 = [0, 0, -Ko, 0,     -G2, G1, 0,  A3,   V2,-V1,  0,   0,  0, V4, -U3]
L8 = [0, 0, 0, -Ko,     -A1,-A2,-A3,  0,   0,  0,   0,  -V1,-V2,-V3, -U4]

POISSON = Matrix([L1, L2, L3, L4, L5, L6, L7, L8])
F = POISSON*grad_Kp
###################################################################################
F1_str = str(F[0])
F2_str = str(F[1])
F3_str = str(F[2])
F4_str = str(F[3])
F5_str = str(F[4])
F6_str = str(F[5])
F7_str = str(F[6])
F8_str = str(F[7])

F_str = '[' + F1_str + '; ' + F2_str + '; ' + F3_str + '; ' + F4_str + '; ' + F5_str + '; ' + F6_str + '; ' + F7_str + '; ' + F8_str  + ']'
F_str = F_str.replace('**', '^')
F_str = F_str.replace('U1', 'W(1)')
F_str = F_str.replace('U2', 'W(2)')
F_str = F_str.replace('U3', 'W(3)')
F_str = F_str.replace('U4', 'W(4)')
F_str = F_str.replace('V1', 'W(5)')
F_str = F_str.replace('V2', 'W(6)')
F_str = F_str.replace('V3', 'W(7)')
F_str = F_str.replace('V4', 'W(8)')
F_str = F_str.replace('G1', '((W(2)*W(7)-W(3)*W(6))/Ko)')
F_str = F_str.replace('G2', '((W(3)*W(5)-W(1)*W(7))/Ko)')
F_str = F_str.replace('G3', '((W(1)*W(6)-W(2)*W(5))/Ko)')
F_str = F_str.replace('x1', '((W(1)*cos(2*pi*tau)+W(5)*sin(2*pi*tau)-A1))')
F_str = F_str.replace('x2', '((W(2)*cos(2*pi*tau)+W(6)*sin(2*pi*tau)-A2))')
F_str = F_str.replace('x3', '((W(3)*cos(2*pi*tau)+W(7)*sin(2*pi*tau)-A3))')
F_str = F_str.replace('A1', '((W(4)*W(5)-W(1)*W(8))/Ko)')
F_str = F_str.replace('A2', '((W(4)*W(6)-W(2)*W(8))/Ko)')
F_str = F_str.replace('A3', '((W(4)*W(7)-W(3)*W(8))/Ko)')
F_str = F_str.replace('y1', '((-W(1)*sin(2*pi*tau)+W(5)*cos(2*pi*tau))/x)')
F_str = F_str.replace('y2', '((-W(2)*sin(2*pi*tau)+W(6)*cos(2*pi*tau))/x)')
F_str = F_str.replace('y3', '((-W(3)*sin(2*pi*tau)+W(7)*cos(2*pi*tau))/x)')
F_str = F_str.replace('x',  '((Ko-W(4)*sin(2*pi*tau)+W(8)*cos(2*pi*tau)))')
F_str = F_str.replace('Ko', '(1/2*(sqrt(W(1)^2+W(2)^2+W(3)^2+W(4)^2)+sqrt(W(5)^2+W(6)^2+W(7)^2+W(8)^2)))')
F_str = F_str.replace('tau', '(tau-floor(tau))')

with open('./Python/F_str.txt','w') as f:
    f.writelines(F_str) 
####################################################################################
