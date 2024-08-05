%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
L = sqrt(sm_ax);
lprime = atan2(-uR(:,4), -vR(:,4));
Gprime_vec = Sprime_vec + Dprime_vec;
Rprime_vec = Sprime_vec - Dprime_vec;
Gprime = norma(Gprime_vec);
G3prime = Gprime_vec(:,3);
Eccprime_vec = Rprime_vec./[L L L];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
G_prj = sqrt(Gprime_vec(:,1).^2+Gprime_vec(:,2).^2);
sz = size(G_prj);
if all(G_prj)
    node = [-Gprime_vec(:,2)./G_prj  Gprime_vec(:,1)./G_prj  zeros(sz)];           
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
                node(jsz,:) = [-Gprime_vec(jsz,2)/G_prj(jsz)  Gprime_vec(jsz,1)/G_prj(jsz)  0 ];
            end
        end
    else
        node = [ones(sz)  zeros(sz)  zeros(sz)];
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Omegaprime = atan2(node(:,2), node(:,1));
omegaprime = atan2(scalarp(vectorp(node, Eccprime_vec), Gprime_vec)./Gprime,...
        scalarp(node, Eccprime_vec));
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%              Write inputL.txt
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Lx = L.*cos(lprime);
Ly = L.*sin(lprime);
fid = fopen('FMFT/inputL.txt', 'wt');
fprintf(fid, '%14.10f %14.10f %14.10f\n',...
            [tau'; Lx'; Ly']);
fclose(fid);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%              Write inputG.txt
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Gx = Gprime.*cos(omegaprime);
Gy = Gprime.*sin(omegaprime);
fid = fopen('FMFT/inputG.txt', 'wt');
fprintf(fid, '%14.10f %14.10f %14.10f\n',...
            [tau'; Gx'; Gy']);
fclose(fid);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%              Write inputG3.txt
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
G3x = G3prime.*cos(Omegaprime);
G3y = G3prime.*sin(Omegaprime);
fid = fopen('FMFT/inputG3.txt', 'wt');
fprintf(fid, '%14.10f %14.10f %14.10f\n',...
            [tau'; G3x'; G3y']);
fclose(fid);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%