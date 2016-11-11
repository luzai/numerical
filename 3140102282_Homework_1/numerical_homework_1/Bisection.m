function res=Bisection(func,lrMat,TOL,MaxIter,EasyForm)
if nargin==4
    EasyForm=false; %which means do not plot.
elseif size(lrMat,1)~=1 || size(lrMat,2)~=2 || nargin <4
    disp('Check you input!')
end
left=lrMat(1); right=lrMat(2);
%% Avoid fun(left) and func(right) is all positive or all negtive, for the stablility of solution, I choose not to use randi, although these behaviour may cause some soltion missing.
while func(left)*func(right)>0
    mid=(left+right)/2;
%    switch randi([0,1])
%        case 1
            right=mid;
%        case 0
%            left=mid;
%    end
end
%% State Bisection
mid=(left+right)/2;    
k=1;
sol=zeros(100,1); sol(1)=mid;
fun=zeros(100,1); fun(1)=func(mid);
while (k<=MaxIter) && (abs(func(mid))>TOL)
    if func(left)*func(mid)>0
        left=mid;
    else
        right=mid;
    end
    mid=(left+right)/2; 
    k=k+1;
    sol(k)=mid;
    fun(k)=func(mid);
end
res=sol(k);
disp(sol(1:k))
%% Plot And Disp(res)
if EasyForm==false 
    figure1=figure;
    subplot1 = subplot(2,1,1,'Parent',figure1);
    box(subplot1,'on');
    hold(subplot1,'on');
    stem(sol(1:k),'Parent',subplot1,'Marker','*','BaseValue',min(sol(1:k)));
    plot(sol(1:k));
    xlabel('iteration');
    ylabel('x');
    title('Value of x at the k-th iteration');
    
    subplot2 = subplot(2,1,2,'Parent',figure1);
    box(subplot2,'on');
    hold(subplot2,'on');
    stem(fun(1:k),'Parent',subplot2,'Marker','*','BaseValue',min(fun(1:k)));
    plot(fun(1:k))
    xlabel('iteration');
    ylabel('f(x)');
    title('Values of f(x) at the k-th iteration');
    needSave=sol(1:k);
    save xMat needSave
    
end
