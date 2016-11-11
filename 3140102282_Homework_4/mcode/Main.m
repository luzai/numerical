clc ,close all ;clear
format long
%% problem 1
hdl=fopen('p1.txt','w');
fclose(hdl);
disp('problem 1')
syms f x
f=exp(2*x)*cos(3*x);
xn=[0,0.3,0.6].';
[r,err]=LagInter(f,xn);
%disp(double(coeffs(r)))
disp(vpa(r,5))
%disp('Visually oriented, it is ') ;pretty(vpa(r))
fprintf('The bound of abosolute error is   ');disp(vpa(err,5))
%clipboard=latex(r);
ezplot(f,[0,0.6]);hold on
ezplot(r,[0,0.6])

f=sin(log(x));
xn=[2.0,2.4,2.6].';
[r,err]=LagInter(f,xn);
%disp(double(coeffs(r)))
disp(vpa(r,5))
%disp('Visually oriented, it is '); pretty(vpa(r))
fprintf('The bound of abosolute error is   ');disp(vpa(err,5))
figure
ezplot(f,[2.0,2.6]);hold on
ezplot(r,[2.0,2.6])
%% probelm 5
x=[0,1,2];xx=0:0.01:2;
y=[0,1,2];
ppfunc=csape(x,[0,y,0],'second');
fnplt(ppfunc,[0,2]);
aa=fnbrk(ppfunc,1);
res1=poly2sym(aa.coefs);fprintf('For problem 5 : \npiecewise function on [0,1] is %s\n and on [1,2] is ',latex(res1));
aaa=fnbrk(ppfunc,2);
syms X 
res2=poly2sym(aaa.coefs,X-1);disp(res2)
ppfunc.coefs;
hold on
ppfunc=csape(x,[1,y,1],'clamp');
fnplt(ppfunc,[0,2],'r');



