function res=NewtonNonlin(symfunc,symx,inix,maxIter)

if ~isa(symfunc,'sym') || ~isa(symx,'sym') 
    disp(['check Input!',class(symfunc),class(symx)]);
    error('ClassError.');
end
if size(symx,1)~=size(inix,1)
   error('Dimension miscount.') 
end
symJac=jacobian(symfunc,symx);
symJac=symJac+symx(3)*10^-100; %for problem_3_a, make the matrix nonsingular. Not the best way, but the easiest.
func=matlabFunction(symfunc);
Jac=matlabFunction(symJac);
res=zeros(3,1);
res(:,1)=inix;
for iter=1:maxIter
    XLnum=res(:,end);
    XL=num2cell(XLnum); %for matrix input, we can also use cell2mat(arrayfun(f, b(:, 1), b(:, 2), 'UniformOutput', 0)')'
    res(:,end+1)=XLnum-inv(Jac(XL{:}))*func(XL{:});
end

