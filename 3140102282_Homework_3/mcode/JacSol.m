function [res,time]=JacSol(A,b)
%seperate A into A=D-L-U;
D = diag(diag(A));
U = triu(A,1)*(-1);
L = tril(A,-1)*(-1);
assert(all(all(A==D-U-L)),'seperate A wrongly!') 
T = inv(D)*(L+U);
c = inv(D)*b;
x(:,1)=zeros(size(b));
TOL=10^-5;
tic
for iter=1:10000 
    x(:,end+1) = T*x(:,end)+c;
    normInf = norm(A*x(:,end)-b,inf);
    if normInf  < TOL
        break;
    end
end
if(nargout==2)
	time=toc;
end
res=x(:,end);

