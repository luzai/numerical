function res=Trape(f,Xi,Xe)
F=matlabFunction(f);
res=(Xe-Xi)/2*(F(Xi)+F(Xe));