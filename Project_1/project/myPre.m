function  [mupp,sigpp]=myPre(age,opt,rew)
% if nargin==2
%     wks=load('wks.mat',opt);
%     wks=wks.(opt);
%     mupp=wks(1);
%     sigpp=wks(2);
% elseif nargin==3 && strcmp(rew,'renew')
data=load('data.mat',opt);
data=data.(opt);
mupp=myInterp(data(:,1),data(:,5));
sigpp=myInterp(data(:,1),data(:,5)-data(:,4));
% end

%% Using cubic spline implement by myself.
function pp = myInterp(x,y)
%pp=csape(x',y');
pp = [];
n = length(x);
%% make sure comlumn
[nr, nc] = size(y);
if nr == 1
    y = reshape(y, nc, 1);
    nr = nc; 
end
[nr, nc] = size(x);
if nr == 1
    x = reshape(x, nc, 1);
    nr = nc; 
end
%%
if size(x) ~= size(y)
    error('x and y are of different size'); 
end
dx = [0; diff(x); 0];
dxx = dx(1:n) + dx(2:n+1);
% d_xx_j = h_j+h_{j+1}
%%
M = spdiags([[dx(2:n)./dxx(2:n); 0] 2*ones(n,1) [0; dx(2:n)./dxx(1:n-1)]], -1:1, n,n);
dy_l = 0;
dy_r = 0;

b = diff(y) ./ dx(2:n);
c = 6 * diff([dy_l; b; dy_r])./ dxx;

%% For natural spline interpolation
c(1)     = 0;
c(n)     = 0;
M(1,2)   = 0;
M(n,n-1) = 0;
c = M\c;
d = diff(c)./dx(2:n);
b = b  - dx(2:n).* (c(1:n-1)/3 + c(2:n)/6);

%% now compute the values yy
xx=x;
yy = zeros(size(xx));
for i=1:nr-1
    I = find(xx <= x(i+1) & xx >= x(i));
    yy(I) = y(i) + b(i)*(xx(I)-x(i))+c(i)/2*(xx(I)-x(i)).^2 + ...
        d(i)/6*(xx(I)-x(i)).^3;
end
pp=csape(xx,yy);
% c=c(1:end-1);
% y=y(1:end-1);
%% make piecewise poly
%pp=mkpp(x',[d,b,c,y]);
pp = csape(xx,yy);
% Here use csape is only make piecewise ploynomial!
% Becuase my [a,b,c,d] is different from pp-form in matlab. But I want to
% use its plot function. To use its fit-function is just for convenience! 

