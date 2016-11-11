clear;close all;clc;

func1=@(x) exp(x)-x^2+3*x-2; 
func2=@(x) x*cos(x)-2*x^2+3*x-1;
res1=Bisection(func1,[0,1],10^-5,1000);
res2=Bisection(func2,[0.2,0.3],10^-5,1000);
res3=Bisection(func2,[1.2,1.3],10^-5,1000);

func3=@(x) 2*sin(pi*x)+x;
func4=@(x) 3*x^2-exp(x);

% figure('color',[1,1,1]);
% ezplot('x',[-2,2]);hold on;
% ezplot('2*sin(pi*x)',[-2,2]); 
% figure('color',[1,1,1]);
% ezplot(func4,[-2,4]);hold on;
% ezplot('0',[-2,4]);
% global time
% time=1;
res4=FixPoint(func3,1); %TOL=10^-2, MaxIter=1000 is default, by using nargin.
res5=FixPoint(func4,-1);
res6=FixPoint(func4,0);
res7=FixPoint(func4,1);
res8=FixPoint(func4,3);
res9=FixPoint(func4,4);

%% for more accurate numerical answer:
%syms sym_x
% % vpasolve(exp(sym_x)-sym_x^2+3*sym_x-2==0,sym_x,[0,1])
% % vpasolve(sym_x*cos(sym_x)-2*sym_x^2+3*sym_x-1==0,sym_x,[0.2,0.3])
% % vpasolve(sym_x*cos(sym_x)-2*sym_x^2+3*sym_x-1==0,sym_x,[1.2,1.3])

%for i=1:10
% vpasolve(2*sin(pi*sym_x)+sym_x,[1,2],'random',true) 
% %%1.2060351195709658517741718500895
%vpasolve(3*sym_x.^2-exp(sym_x),sym_x,[-1,4],'random',true) 
% %%-0.45896226753694851459857243243406 
% %%3.7330790286328142006199540298435
% %%0.9375...
%end
%% for understanding Newton method, check -1<diff(g(x))<1 
%  syms x f g
%  f=3*x^2-exp(x);
%  g=x-f/diff(f);
%  pretty(g)
%  %f=exp(x)/3*x;
%  g=diff(g);
%  pretty(g);
% double(subs(g,x,-0.3))
% double(subs(g,x,-0.45))
% double(subs(g,x,1.5))
% double(subs(g,x,2.0))
% double(subs(g,x,3.0))
% double(subs(g,x,3.73))
