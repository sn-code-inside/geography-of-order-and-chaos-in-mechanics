%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
if (S_vec_o(1)^2+S_vec_o(2)^2) == 0
    Rot4_S = eye(4);
else
    n_S1 = -S_vec_o(2)/sqrt(S_vec_o(1)^2+S_vec_o(2)^2);
    n_S2 =  S_vec_o(1)/sqrt(S_vec_o(1)^2+S_vec_o(2)^2);
    n_S3 =  0;
    phi_S = -1/2*acos(S_vec_o(3)/sqrt(S_vec_o(1)^2+S_vec_o(2)^2+S_vec_o(3)^2));
    
    Rot4_S = [cos(phi_S)   -n_S3*sin(phi_S)   n_S2*sin(phi_S)   n_S1*sin(phi_S);...
         n_S3*sin(phi_S)    cos(phi_S)     -n_S1*sin(phi_S)   n_S2*sin(phi_S);...
        -n_S2*sin(phi_S)  n_S1*sin(phi_S)      cos(phi_S)     n_S3*sin(phi_S);...
        -n_S1*sin(phi_S) -n_S2*sin(phi_S)  -n_S3*sin(phi_S)      cos(phi_S)];
end

if (D_vec_o(1)^2+D_vec_o(2)^2) == 0
    Rot4_D = eye(4);
else
    n_D1 = -D_vec_o(2)/sqrt(D_vec_o(1)^2+D_vec_o(2)^2);
    n_D2 =  D_vec_o(1)/sqrt(D_vec_o(1)^2+D_vec_o(2)^2);
    n_D3 =  0;
    phi_D = -1/2*acos(D_vec_o(3)/sqrt(D_vec_o(1)^2+D_vec_o(2)^2+D_vec_o(3)^2));
    
    Rot4_D =  [cos(phi_D)   -n_D3*sin(phi_D)   n_D2*sin(phi_D)   -n_D1*sin(phi_D);...
         n_D3*sin(phi_D)    cos(phi_D)     -n_D1*sin(phi_D)    -n_D2*sin(phi_D);...
        -n_D2*sin(phi_D)  n_D1*sin(phi_D)      cos(phi_D)      -n_D3*sin(phi_D);...
         n_D1*sin(phi_D)  n_D2*sin(phi_D)   n_D3*sin(phi_D)       cos(phi_D)];
end

uR = u*Rot4_S'*Rot4_D';
vR = v*Rot4_S'*Rot4_D';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%