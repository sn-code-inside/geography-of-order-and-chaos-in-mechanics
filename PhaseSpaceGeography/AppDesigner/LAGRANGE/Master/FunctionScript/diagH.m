% Diagonalization of the linearized Hamiltonian

H = [        1/4             3/4*sqrt(3)*(1-2*mu)  0    0 -1  0;
     3/4*sqrt(3)*(1-2*mu)             -5/4         0    1  0  0;
              0                         0          1    0  0  0;
              
              0                         1          0    1  0  0;
             -1                         0          0    0  1  0;
              0                         0          0    0  0  1];

Omega = [0  0  0   1  0  0;
         0  0  0   0  1  0;
         0  0  0   0  0  1;
     
        -1  0  0   0  0  0;
         0 -1  0   0  0  0;
         0  0 -1   0  0  0];

SH = Omega*H;               
[T,E] = eig(SH);