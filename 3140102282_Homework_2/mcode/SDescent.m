function res=SDescent(symfunc,symx,ini,TOL,MaxIter,alpha)
if nargin==5 
    alpha=10^-5;
elseif argin >6 || size(symx,2)~=1
        error('Check Input');
end

grad=jacobian(symfunc,symx);
grad=grad.';%!!! associate !!!

func=matlabFunction(symfunc);
grad=matlabFunction(grad);
res(:,1)=ini;

for iter=1:MaxIter
    XLnum=res(:,end);
    XL=num2cell(XLnum);
    res(:,end+1)=XLnum-alpha*grad(XL{:});
    if abs(func(XL{:}))<TOL 
        break;
    end
% % A different measure way;
%     if norm(res(:,end)-res(:,end-1))<tol
%         break;
%     end
end
%disp(iter);




