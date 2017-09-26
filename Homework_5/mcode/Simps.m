function res=Simps(f,xi,xe)
xm=xi+xe;xm=xm/2;
F=matlabFunction(f);
res=(xe-xm)/3*(F(xi)+4*F(xm)+F(xe));
