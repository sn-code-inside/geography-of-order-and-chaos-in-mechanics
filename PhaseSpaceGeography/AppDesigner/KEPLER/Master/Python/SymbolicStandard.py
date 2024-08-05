# -*- coding: utf-8 -*-
import sympy
sympy.init_printing
from sympy import *
####################################################################################
tau, q, q1, q2, q3, p1, p2, p3, null = symbols("tau q q1 q2 q3 p1 p2 p3 null")
q_vec = Matrix([q1, q2, q3])
p_vec = Matrix([p1, p2, p3])
####################################################################################
f = open("Python/parameters.txt","r")
parameter_list = eval(f.read())
f.close()

null = parameter_list[0]

epsilon1 = parameter_list[1]
epsilon2 = parameter_list[2]
epsilon3 = parameter_list[3]
epsilon4 = parameter_list[4]
epsilon5 = parameter_list[5]

Hp1 = parameter_list[11]
Hp2 = parameter_list[12]
Hp3 = parameter_list[13]
Hp4 = parameter_list[14]
Hp5 = parameter_list[15]
         
def Anisotropic(q_vec, p_vec):
    return p_vec[2]**2

def Hill(q_vec, p_vec):
    mu = 0.1; # Moon mass, with Moon mass + Earth mass = 1
    return  mu/2*(-2*q_vec[0]**2 + q_vec[1]**2 + q_vec[2]**2)

def Euler1(q_vec, p_vec):
    return -1/sqrt((q_vec[0] - 2)**2 + q_vec[1]**2 + q_vec[2]**2)

def Euler2(q_vec, p_vec):
    return -1/sqrt(q_vec[0]**2 + (q_vec[1] - 2)**2 + q_vec[2]**2)

def Euler3(q_vec, p_vec):
    return -1/sqrt(q_vec[0]**2 + q_vec[1]**2 + (q_vec[2] - 2)**2)

def Oscillator(q_vec, p_vec):
    k1 = 1.
    k2 = 1.
    k3 = 1.
    return 1/2*(k1*q_vec[0]**2 + k2*q_vec[1]**2 + k3*q_vec[2]**2)

def overR2(q_vec, p_vec):
    return 1/(q_vec[0]**2 + q_vec[1]**2 + q_vec[2]**2)

def overR3(q_vec, p_vec):
    return 1/(q_vec[0]**2 + q_vec[1]**2 + q_vec[2]**2)**(3/2)

def p_2(q_vec, p_vec):
    return p_vec[1]

def QZ1(q_vec, p_vec):
    return q_vec[1]**2 + q_vec[2]**2

def QZ2(q_vec, p_vec):
    return q_vec[0]**2 + q_vec[2]**2

def QZ3(q_vec, p_vec):
    return q_vec[1]**2 + q_vec[0]**2

def Satellite(q_vec, p_vec):
    x = sqrt(q_vec[0]**2 + q_vec[1]**2 + q_vec[2]**2);
    return (1/2*(q_vec[0]**2 + q_vec[1]**2 ) - q_vec[2]**2 )/x**5
        
def Stark1(q_vec,p_vec):
    return q_vec[0]

def Stark2(q_vec,p_vec):
    return q_vec[1]

def Stark3(q_vec,p_vec):
    return q_vec[2]

def Zeeman1(q_vec, p_vec):
    return q_vec[1]*p_vec[2]-q_vec[2]*p_vec[1]

def Zeeman2(q_vec, p_vec):
    return q_vec[2]*p_vec[0]-q_vec[0]*p_vec[2]

def Zeeman3(q_vec, p_vec):
    return q_vec[0]*p_vec[1]-q_vec[1]*p_vec[0]

def Zero(q_vec, p_vec):
    return 0
####################################################################################
def Hp(q_vec, p_vec, epsilon1, epsilon2, epsilon3, epsilon4, epsilon5, Hp1, Hp2, Hp3, Hp4, Hp5):
    return epsilon1*eval(Hp1 + '(q_vec, p_vec)') + epsilon2*eval(Hp2 + '(q_vec, p_vec)') \
    + epsilon3*eval(Hp3 + '(q_vec, p_vec)') + epsilon4*eval(Hp4 + '(q_vec, p_vec)') \
    + epsilon5*eval(Hp5 + '(q_vec, p_vec)')
    
Hper = Hp(q_vec, p_vec, epsilon1, epsilon2, epsilon3, epsilon4, epsilon5, Hp1, Hp2, Hp3, Hp4, Hp5)
dHp_q1 = diff(Hper,q1)
dHp_q2 = diff(Hper,q2)
dHp_q3 = diff(Hper,q3)
dHp_p1 = diff(Hper,p1)
dHp_p2 = diff(Hper,p2)
dHp_p3 = diff(Hper,p3)

F = Matrix([p1+dHp_p1, p2+dHp_p2, p3+dHp_p3, -q1/sqrt(q1**2 + q2**2 + q3**2)**3-dHp_q1, \
            -q2/sqrt(q1**2 + q2**2 + q3**2)**3-dHp_q2, -q3/sqrt(q1**2 + q2**2 + q3**2)**3-dHp_q3])
###################################################################################
F1_str = str(F[0])
F2_str = str(F[1])
F3_str = str(F[2])
F4_str = str(F[3])
F5_str = str(F[4])
F6_str = str(F[5])

F_str = '[' + F1_str + '; ' + F2_str + '; ' + F3_str + '; ' + F4_str + '; ' + F5_str + '; ' + F6_str  + ']'

F_str = F_str.replace('**', '^')
F_str = F_str.replace('q1', 'W(1)')
F_str = F_str.replace('q2', 'W(2)')
F_str = F_str.replace('q3', 'W(3)')
F_str = F_str.replace('p1', 'W(4)')
F_str = F_str.replace('p2', 'W(5)')
F_str = F_str.replace('p3', 'W(6)')

with open('Python/F_str.txt','w') as f:
    f.writelines(F_str)
####################################################################################
