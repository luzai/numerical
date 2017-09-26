format long;clear;close all
% syms G pho B No d p sigma2
%% prepare parameter
G=sym(-128.1);
pho=sym(3.76);
B=sym(1e6);
N0=sym(-114);
d=0.1;
p=23;

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
res=double(res);

%%  My algrithm starts
memo(1)=0;
for S=0.0001:0.0001:0.001
syms t 
k=double(k);k1=double(k1);
true=double(k*k1*S*int(exp(-S*t)/(1+S*k*t)+exp(-S/t)/(t*(k*S+t)),0,1));
f1=exp(-S*t)/(1+S*k*t);%double(int(f1,0,1));
f2=exp(-S/t)/(t*(k*S+t));%double(int(f2,0,1));

% f=exp(-x)/(1+k*x);
% xx=0:0.000001:0.0001;
% plot(xx,double(subs(f,x,xx)));

f1=matlabFunction(f1);
f2=matlabFunction(f2);

% xx=0:0.0001:0.01;
% plot(xx,double(subs(f1,t,xx)));
% figure
% xx=1e-30:0.0001:0.01;
% plot(xx,double(subs(f2,t,xx)));

r1 = adapt_simp ( f1, 0, 1,  10^-16);
r2 = adapt_simp ( f2, 10^-18, 1, 10^-16);
res=k*k1*S*(r1+r2)

error=abs(res-true)/true
memo(end+1)=res;
end
plot(0.0001:0.0001:0.001,memo(2:end))














