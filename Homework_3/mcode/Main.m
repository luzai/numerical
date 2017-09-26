clc
%% %% problem 3
format long;
clear
A=[0.03 58.9 ;...
	5.31 -6.10];
b=[59.2;...
	47];
res3_1=GauEli([A,b])
A=[3.03 -12.1 14 -119;-3.03 12.1 -7 120; 6.11 -14.2 21 -139];
res3_2=GauEli(A)
tt=linsolve(A(:,1:end-1),A(:,end))

%% %% problem 4
clear;
A1 = [4,1,-1;-1,3,1;2,2,5];
b1 = [5;-4;1];
res4_1=JacSol(A1, b1)

%y=sym('y',[3,1]);
%[y1,y2,y3]=solve(A1*y==b1)
%vpa([y1;y2;y3])

A2 = [-2,1,0.5;1,-2,-0.5;0,1,2];
b2 = [4;-4;0];
res4_2=JacSol(A2, b2)

%% %% problem 5
clear;disp('for problem 5');
A1=[3,-1,1;3,6,2;3,3,7];
b1=[1;0;4];
[res1,time1]=JacSol(A1,b1);
[res2,time2]=GauSei(A1,b1);
disp(res1);disp('');disp(res2);

% y=sym('y',[3,1]);
% [y1,y2,y3]=solve(A1*y==b1) %symbolic compute. Get fractional solution
% vpa([y1;y2;y3])

fprintf('Using Jacobi method, it costs %f ms;\nUsing Gauss-Seidel method it costs %f ms \n\n',time1*1000,time2*1000)

A2=[10,-1,0;-1,10,-2;0,-2,10];
b2=[9;7;6];
[res1,time1]=JacSol(A2,b2);
[res2,time2]=GauSei(A2,b2);
disp(res1);disp('');disp(res2);
fprintf('Using Jacobi method, it costs %f ms;\nUsing Gauss-Seidel method it costs %f ms \n\n',time1*1000,time2*1000)
