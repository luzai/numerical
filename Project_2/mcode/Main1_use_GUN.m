close all;format long;clear
% syms G pho B No d p sigma2
%% prepare parameter
G=sym(-128.1);
pho=sym(3.76);
B=sym(1e6);
N0=sym(-114);
d=0.1;
p=23;

% G=-128.1;
% pho=3.76;
% B=1e6;
% N0=-114;

G = dB2W(G);
sigma2=G*d^(-pho);
N0 = dB2W(N0-30);
%% using matlab symbolic tool
syms h f(h) dR(h)

f=exp(-h);
dR=B*log2(1+2*p*h*sigma2/N0)*f;
res=int(dR,h,0,inf);
double(res);

k1=sym(1000000/log(2));
k=sym(4600000*10^(7/20));
syms x f(x)
f=k1*k/(1+k*x)*exp(-x);
res=int(f,x,0,inf);
double(res);

f=1/(1+k*x)*exp(-x);
res=k1*k*int(f,x,0,inf);
double(res);

%% for illustration
% xx=sym(0:0.01:2)
% plot(xx,subs(f,h,xx));
% hold on;
% plot(xx,subs(log2(1+2*p*h*sigma2/N0),h,xx));
% plot(xx,subs(dR,h,xx));
% hold off;

%%  My algrithm starts
[wi,xi,~]=gen_laguerre_rule(50,0,0,1);
double(k1*k*sum(wi.*subs(1/(1+k*x),x,xi)))


% [wi,xi,~]=gen_laguerre_rule(50,0,0,1/k);
% double(k1*sum(wi.*subs(1/(1+x),x,xi)))
% 
% double(int(exp(-x)/x,x,1/k,inf)*exp(1/k)/k*k*k1)
% [wi,xi,~]=gen_laguerre_rule(50,0,1/k,1);
% double(exp(1/k)/k*k*k1*sum(wi.*subs(1/x,x,xi)))

inti=1;
endi=1000;
resd(1)=0;
for n=inti:endi
[wi,xi,~]=gen_laguerre_rule(n,0,0,1);
%  * the ORDER (number of points) in the rule;
%  * ALPHA, the exponent of |X|;
%  * A, the left endpoint of integration;
%  * B, the scale factor in the exponential;
%  * FILENAME, the root name of the output files.
% The generalized Gauss-Laguerre quadrature rule is used as follows:
% 
%         Integral ( a <= x < +oo ) |x-a|^alpha * exp(-b*(x-a)) f(x) dx
%  
% is to be approximated by
%         Sum ( 1 <= i <= order ) w(i) * f(x(i))
      
resd(n)=sum(wi.*subs(1/(1+k*x),x,xi));
end
plot(inti:endi,double(resd));
double(resd(end)*k1*k)

 
%% for test
% syms x;
% f=exp(-x)/(1+x);
% 
% res=double(int(f,x,0,inf))
% 
% for n=1:100
% [wi,xi,~]=gen_laguerre_rule(n,0,0,1);
% res(n)=sum(wi.*subs(1/(x+1),x,xi));
% end
% plot(1:100,double(res))
























