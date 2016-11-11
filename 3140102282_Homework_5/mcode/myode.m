function [T,Y]=myode(f,T,yi)
h=T(2)-T(1);
Y=zeros(size(T));
Y(1)=yi;
for iter=2:size(T,2)
Y(iter)=Y(iter-1)+h*f(T(iter-1),Y(iter-1));
end