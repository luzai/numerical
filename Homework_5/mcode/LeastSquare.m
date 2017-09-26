function res=LeastSquare(X,Y)
F=fittype(@(k,x) k*(x-5.3));
res = fit( X, Y, F, 'StartPoint',1 );
figure('Color',[1 1 1]);
plot( res, X, Y );
%legend off
