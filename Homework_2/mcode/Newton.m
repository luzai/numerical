function res=Newton(func,IniGuess,TOL,MaxIter)
if nargin==3
    MaxIter=1000;
elseif nargin==2
    TOL=10^-2;
    MaxIter=1000;
elseif nargin<2 || nargin>4
    disp('Check You Input!');
end
%%
res=IniGuess;sol=res;
syms f gsym symx
f=func(symx);
gsym=symx-f/diff(f);
g=matlabFunction(gsym);
%%
k=1;
while(abs(g(res)-res)>TOL && k<MaxIter)
    res=g(res);
    sol(end+1)=res;
    k=k+1;
end
close all;
sol(end+1)=g(res);
disp('The Iteration Point of X is ' );
disp(sol');
figure('color',[1,1,1]); box on ; hold on;
stem(sol,'Marker','*','BaseValue',min(sol));
plot(sol);
xlabel('iteration');
ylabel('x');
title('Value of x at the k-th iteration');
%export_fig q1_1.png -m3


