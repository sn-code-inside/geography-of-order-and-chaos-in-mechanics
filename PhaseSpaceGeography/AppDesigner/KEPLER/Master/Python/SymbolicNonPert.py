# -*- coding: utf-8 -*-
import sympy
sympy.init_printing
from sympy import *
###########################################################################
z1, z2, z3, z4, w1, w2, w3, w4, tau, x, x1, x2, x3, y1, y2, y3 = symbols("z1 z2 z3 z4 w1 w2 w3 w4 tau x x1 x2 x3 y1 y2 y3")

x1 =  2*z1*z3 + 2*z2*z4
x2 =  2*z2*z3 - 2*z1*z4
x3 = -z1**2 - z2**2 + z3**2 + z4**2
x  =  z1**2 + z2**2 + z3**2 + z4**2;
y1 =  (z1*w3 + z2*w4 + z3*w1 + z4*w2)/(z1**2 + z2**2 + z3**2 + z4**2)
y2 = -(z1*w4 - z2*w3 - z3*w2 + z4*w1)/(z1**2 + z2**2 + z3**2 + z4**2)
y3 = -(z1*w1 + z2*w2 - z3*w3 - z4*w4)/(z1**2 + z2**2 + z3**2 + z4**2)
x_vec = Matrix([x1, x2, x3])
y_vec = Matrix([y1, y2, y3])
###########################################################################
f = open("Python/parameters.txt","r")
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
    x = sqrt(x_vec[0]**2 + x_vec[1]**2 + x_vec[2]**2);
    return (1/2*(x_vec[0]**2 + x_vec[1]**2 ) - x_vec[2]**2 )/x**5
        
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

K = Kp(x_vec, y_vec, landa, epsilon1, epsilon2, epsilon3, epsilon4, epsilon5, deg1, deg2, deg3, deg4, deg5, Hp1, Hp2, Hp3, Hp4, Hp5)        
Kper = x*Kp(x_vec, y_vec, landa, epsilon1, epsilon2, epsilon3, epsilon4, epsilon5, deg1, deg2, deg3, deg4, deg5, Hp1, Hp2, Hp3, Hp4, Hp5)

F = pi*Matrix([w1 + diff(Kper,w1),  w2 + diff(Kper,w2),  w3 + diff(Kper,w3),  w4 + diff(Kper,w4),
     -z1 - diff(Kper,z1),  -z2 - diff(Kper,z2),  -z3 - diff(Kper,z3),  -z4 - diff(Kper,z4)])
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
F_str = F_str.replace('z1', 'W(1)')
F_str = F_str.replace('z2', 'W(2)')
F_str = F_str.replace('z3', 'W(3)')
F_str = F_str.replace('z4', 'W(4)')
F_str = F_str.replace('w1', 'W(5)')
F_str = F_str.replace('w2', 'W(6)')
F_str = F_str.replace('w3', 'W(7)')
F_str = F_str.replace('w4', 'W(8)')

with open('Python/F_str.txt','w') as f:
    f.writelines(F_str) 
####################################################################################