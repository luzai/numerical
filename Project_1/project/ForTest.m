function ForTest()
opt='boyHeight';
data=load('data.mat',opt);
data=data.(opt);
xx=data(:,1);
yy=data(:,5)-data(:,4);
%SmoothingSpline(xx,yy);
ca=myPre(1,'boyHeight');
fnplt(ca);

fitdata=data(1,2:end);
mu = 0;
sigma = 1;
x = [-3,-2,-1,0,1,2,3];
standard = normpdf(x,mu,sigma);

myDraw('boyHeight');

%% For drawing overview plot.
function myDraw(opt)

optlist={'boyHeight';'boyWeight';'girlHeight';'girlWeight'};
for i=1:4
    opt=optlist(i);opt=opt{:};
    data=load('data.mat',opt);
    data=data.(opt);
    
    mupp=myInterp(data(:,1),data(:,5));
    sigpp=myInterp(data(:,1),data(:,5)-data(:,4));
    
end
h=figure('color','white');hold on;
xlabel('X');ylabel('Y');zlabel('P_{XY}')

x=linspace(0,81,500);
y=linspace(min(min(data(:,2:end))),max(max(data(:,2:end))),500);
[xx,yy]=meshgrid(x,y);
zz=zeros(size(xx));
for iter=1:size(x,2)
    zz(:,iter)=normpdf(yy(:,iter),ppval(mupp,x(iter)),ppval(sigpp,x(iter)));
end
mesh(xx,yy,zz)
hold  off;
view(3)

%% Using cubic spline implement by myself.
function pp = myInterp(x,y,xx)
pp = [];
n = length(x);
%% check for the slopes at the endpoints being given or not
[nr, nc] = size(y);
if nr == 1,  y = reshape(y, nc, 1); nr = nc; end
[nr, nc] = size(x);
if nr == 1,  x = reshape(x, nc, 1); nr = nc; end
%%
if size(x) ~= size(y), error('x and y are of different size'); end
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
% use its plot function. To use its fit-function is just for convenience. 


function fitresult=SmoothingSpline(X,Y)
%% Using smoothing spline.
ft = fittype( 'smoothingspline' );
opts = fitoptions( 'Method', 'SmoothingSpline' );
opts.SmoothingParam = 0.115222516467702;
[fitresult, ~] = fit( X', Y', ft, opts );
figure;
plot( fitresult, X', Y' );
