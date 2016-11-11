function[res,time]=GauSei(A,b)
D=diag(diag(A));
U = triu(A,1)*(-1);
L = tril(A,-1)*(-1);
assert(all(all(A==D-U-L)),'seperate A wrongly!');
T=inv(D-L)*U;
c=inv(D-L)*b;
x(:,1)=zeros(size(b));
TOL=10^-5;
tic
for iter=1:10000
    x(:,end+1)=T*x(:,end)+c;
    if(norm(A*x(:,end)-b,inf)<TOL)
        break;
    end
end
if(nargout==2)
    time=toc;
end
res=x(:,end);
