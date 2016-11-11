    close all;format long;clc
% % Problem 1
% x1=[7.0,9.4,12.3]';
% y1=[2,4,6]';
% res1=LeastSquare(x1,y1)
% 
% x2=[x1',8.3,11.3,14.4,15.9]';
% y2=[y1',3,5,8,10]';
% res2=LeastSquare(x2,y2)
% problem 6
% syms x
% f=cos(x)*cos(x);
% Trape(f,-0.25,0.25)
% Simps(f,-0.25,0.25)
% % vpa(int(f,-0.25,0.25))
% 
% f=x*log(x+1);
% Trape(f,-0.5,0)
% Simps(f,-0.5,0)
% % vpa(int(f,-0.5,0))
% 
% f=sin(x)*sin(x)-2*x*sin(x)+1; 
% Trape(f,0.75,1.3)
% Simps(f,0.75,1.3)
% % vpa(int(f,0.75,1.3))
% 
% f=1/(x*log(x));
% Trape(f,exp(1),exp(1)+1)
% Simps(f,exp(1),exp(1)+1)
% % vpa(int(f,exp(1),exp(1)+1))

%problem 7
% f=cos(x)*cos(x);
% Romb(f,-1,1)
% %vpa(int(f,-1,1))
% 
% f=x*log(x+1);
% Romb(f,-.75,.75)
% 
% f=sin(x)*sin(x)-2*x*sin(x)+1;
% Romb(f,1,4)
% 
% f=1/(x*log(x));
% Romb(f,exp(1),2*exp(1))

%problem 8
% %  [T,Y]=ode45(@(t,y)y/t-(y/t)^2,1:0.1:2,1);
% %  plot(T,Y,'-o')
% %  [T,Y]=ode45(@(t,y)y/t-(y/t)^2,[1,2],1);
% %  pp=spline(T,Y);
% %  Yout=ppval(pp,[1:0.1:2]');disp(Yout);
% %  syms y t;
% %  ppture=matlabFunction(dsolve('Dy=y/t-(y/t)^2','y(1)=1','t'));
% %  ppture(1:0.1:2)'

[T,Y]=myode(@(t,y)y/t-(y/t)^2,1:0.1:2,1);
figure;plot(T,Y,'-o')
[T,Y]=myode(@(t,y)1+y/t+(y/t)^2,1:0.2:3,0);
figure;plot(T,Y,'-o')
