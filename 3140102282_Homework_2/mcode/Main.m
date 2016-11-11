%%%% problem 1
format long;
clear
f1=@(x) -x^3-cos(x);
Newton(f1,-1,10^-5,2);

%%%% problem 3
clear
format long;
syms f1 f2;
x=sym('x',[3,1]);
f1=[3*x(1)-cos(x(2)*x(3))-1/2;...
    4*x(1)^2-625*x(2)^2+2*x(2)-1;...
    exp(-x(1)*x(2))+20*x(3)+(10*pi-3)/3];
%MetrixPlot(f1(1));
f2=[x(1)^2+x(2)-37;...
    x(1)-x(2)^2-5;...
    x(1)+x(2)+x(3)-3];
NewtonNonlin(f1,x,[0,0,0].',2)
NewtonNonlin(f2,x,[0,0,0].',2)
% problem 4
clear
format long
syms x1 x2 x3 f1 f2 f3 g1 g2;
f1=15*x1+x2^2-4*x3-13;
f2=x1^2+10*x2-x3-11;
f3=x2^3-25*x3+22;
g1=f1^2+f2^2+f3^2;
x=[x1;x2;x3];
tol=10^-5;
MaxIter=10000;

ini=[1;1;1];
res=SDescent(g1,x,ini,tol,MaxIter);
disp(res(:,end));

ini=[-8,-8,-19];
res=SDescent(g1,x,ini,tol,MaxIter);
disp(res(:,end));

f1=10*x1-2*x2^2+x2-2*x3-5;
f2=8*x2^2+4*x3^2-9;
f3=8*x2*x3+4;
g2=f1^2+f2^2+f3^2;

ini=[1;0;1];
res=SDescent(g2,x,ini,tol,MaxIter);
disp(res(:,end));

ini=[0,1,-1];
res=SDescent(g2,x,ini,tol,MaxIter);
disp(res(:,end));

ini=[1,-1,0];
res=SDescent(g2,x,ini,tol,MaxIter);
disp(res(:,end));

ini=[0,0,-1];
res=SDescent(g2,x,ini,tol,MaxIter);
disp(res(:,end));


%%%% for predict: 
[x1,x2,x3]=solve([f1==0,f2==0,f3==0]);
for ii=1:size(x1,1)
    res=[];
    for jj=1:3
        tmp=eval(['x',num2str(jj)]);
        tmp2=tmp(ii);
        res=[res;tmp2];
    end
    disp(double(res));
end