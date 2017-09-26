function Main2_symbolic_compute()
syms x
k1=sym(1000000/log(2));
k=sym(4600000*10^(7/20));
%f=exp(-x)/(k*x + 1);
n=4;

%Laguerre polynomial
p=polelague(n);
%Roots
xi=real(solve(poly2sym(p)) );

%Coeficients
warning off;
P=LagInter(xi);
for i=1:n
    wi(i)=int(exp(-x)*P(i),x,0,inf);
end
%double(wi')

% double(xi)
double(k1*k*sum(wi'.*subs(1/(1+k*x),x,xi)))
end


function p=polelague(n)
% p=polegend(n)
% Almacena en las filas de la matriz p los coefs de los polinomios de Legendre
p(1,1)=1;
p(2,1:2)=[-1 1]; 
for k=2:n
   p(k+1,1:k+1)=((2*(k-2)*[0 p(k,1:k)]+3*[0 p(k,1:k)]-[p(k,1:k) 0]-(k-1).^2*[0 0 p(k-1,1:k-1)]));
end
p=p(n+1,:);
end

function [P]=LagInter(xn)
syms total L_up L_down x 
%sizen=size(xn,1);
total=prod(x-xn);
L_up=total./(x-xn); 
L_down=subs(L_up,x,xn);
L_down=L_down(L_down~=0);
P=L_up/L_down;
end



