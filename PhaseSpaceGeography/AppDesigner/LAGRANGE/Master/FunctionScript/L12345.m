mu = 0.04;
opts = optimset('Display','off','TolX',eps);
hold on

    f = @(x)x + (1-mu)/(x-mu)^2 - mu/(x-mu+1)^2;  
    xeq = fzero(f, mu-1/2, opts);
    Eql = [xeq  0  0  0  xeq  0];
    plot3(Eql(1), Eql(2), 0, '-*r', 'MarkerSize',6);

    f = @(x)x + (1-mu)/(x-mu)^2 + mu/(x-mu+1)^2;
    xeq = fzero(f, 1.1*(mu-1), opts);
    Eql = [xeq  0  0  0  xeq  0];
    plot3(Eql(1), Eql(2), 0, '-*r', 'MarkerSize',6);

    f = @(x)x - (1-mu)/(x-mu)^2 - mu/(x-mu+1)^2;
    xeq = fzero(f, 1.1*mu, opts);
    Eql = [xeq  0  0  0  xeq  0];
    plot3(Eql(1), Eql(2), 0, '-*r', 'MarkerSize',6);
 
    Eql = [mu-1/2   sqrt(3)/2  0  -sqrt(3)/2  mu-1/2  0];
    plot3(Eql(1), Eql(2), 0, '-*r', 'MarkerSize',6);

    Eql = [mu-1/2  -sqrt(3)/2  0   sqrt(3)/2  mu-1/2  0];
    plot3(Eql(1), Eql(2), 0, '-*r', 'MarkerSize',6);
    
    plot3(mu-1,0,0,'-mo','MarkerFaceColor',[0.6  0.6  0.6],'MarkerSize',20*(mu)^(1/3))
    plot3(mu,0,0,'-mo','MarkerFaceColor','b','MarkerSize',20*(1-mu)^(1/3))
    plot3(0,0,0,'-mo','MarkerFaceColor','k','MarkerSize',4)
    
grid off
xlabel('\itx', 'FontSize',14)
ylabel('\ity', 'FontSize',14)