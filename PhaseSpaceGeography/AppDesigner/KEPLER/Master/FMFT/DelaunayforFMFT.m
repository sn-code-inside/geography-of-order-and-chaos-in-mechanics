%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
norma_q = sqrt((sum((q_vec.^2)'))');
sm_ax = norma_q./(2-((sum((p_vec.^2)'))').*norma_q);
L = sqrt(sm_ax);
Delta = scalarp(q_vec,p_vec)./L;
delta = (sm_ax-norma_q)./sm_ax;
l = atan2(-delta.*sin(Delta)+Delta.*cos(Delta), delta.*cos(Delta)+Delta.*sin(Delta));
Lx = L.*cos(l);
Ly = L.*sin(l);
G_vec = vectorp(q_vec, p_vec);
G = norma(G_vec);
Ecc_vec = vectorp(p_vec, G_vec)-q_vec./[norma(q_vec)  norma(q_vec)  norma(q_vec)];
Ecc = norma(Ecc_vec);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
G_prj = sqrt(G_vec(:,1).^2+G_vec(:,2).^2);
sz = size(G_prj);
if all(G_prj)
    node = [-G_vec(:,2)./G_prj  G_vec(:,1)./G_prj  zeros(sz)];           
else
    if any(G_prj)
        node = zeros(sz(1),3);
        node(1,:) = [1  0  0];
        for jsz = 1 : sz(1)
            if G_prj(jsz) == 0
                if jsz == 1
                else
                    node(jsz,:) = node(jsz-1,:);
                end
            else
                node(jsz,:) = [-G_vec(jsz,2)/G_prj(jsz)  G_vec(jsz,1)/G_prj(jsz)  0 ];
            end
        end
    else
        node = [ones(sz)  zeros(sz)  zeros(sz)];
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Omega = 180/pi*atan2(node(:,2), node(:,1));
omega = 180/pi*atan2(scalarp(vectorp(node, Ecc_vec), G_vec)./G,...
        scalarp(node, Ecc_vec));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%              Write inputL.txt
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fid = fopen('FMFT/inputL.txt', 'wt');
fprintf(fid, '%14.10f %14.10f %14.10f\n',...
            [tau'; Lx'; Ly']);
fclose(fid);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%              Write inputG.txt
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fid = fopen('FMFT/inputG.txt', 'wt');
fprintf(fid, '%14.10f %14.10f %14.10f\n',...
            [tau'; (G.*cos(pi/180*omega))'; (G.*sin(pi/180*omega))']);
fclose(fid);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%              Write inputG3.txt
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fid = fopen('FMFT/inputG3.txt', 'wt');
fprintf(fid, '%14.10f %14.10f %14.10f\n',...
            [tau'; (G_vec(:,3).*cos(pi/180*Omega))'; (G_vec(:,3).*sin(pi/180*Omega))']);
fclose(fid);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%