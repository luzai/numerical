function res = GauEli(A)
%The implement of Guass Elimination
%INPUT: augment matrix A
%OUTPUT: solution x or message about
n=size(A,1);
%ID=fopen('a.txt','w');
for i = 1:n-1
    cmpCol=max(A(:,1:end-1),[],2)./A(:,i);
    cmpCol=abs(cmpCol); %only use i:end of compare column!!
    [~,p]=max(cmpCol(i:end));
   % fprintf(ID,'%d ',p);
    if p == n+1
        disp('No unique solution'); return;
    else
        tmp = A(i,:);
        A(i,:) = A(p,:);
        A(p,:) = tmp;
    end
    for j = i+1:n
        magn = A(j,i)/A(i,i);
        for k = i+1:n+1
            A(j,k) = A(j,k) - magn*A(i,k);
        end
    end
end
if A(n,n) == 0
    disp('No unique solution'); return;
end
res=zeros(n,1);
res(n) = A(n,n+1)/A(n,n);
for i = n - 1:-1:1
    sumax = 0;
    for j = i+1:n
        sumax = sumax + A(i,j)*res(j);
    end
    res(i) = (A(i,n+1) - sumax)/A(i,i);
end

