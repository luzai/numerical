function [P,boAbsErr]=LagInter(f,xn)
fhdl=fopen('p1.txt','a');
syms total L_up L_down x 
sizen=size(xn,1);
total=prod(x-xn);
L_up=total./(x-xn); 
L_down=subs(L_up,x,xn);L_down=L_down(L_down~=0);
L=L_up./L_down;
fprintf(fhdl,'\\[ %s \\] \n \\[ %s\\] \n',latex(L),latex(collect(L)));
yn=subs(f,x,xn);
P=L.'*yn;
fprintf(fhdl,'\\[ %s \\] \n \\[ %s \\] \n ',latex(collect(P)),latex(collect(vpa(P))));
%fprintf('\\[ %s \\] \n  \n',latex(collect(P)));
P=collect(P);%P=coeffs(P);
fprintf(fhdl,'\\[ %s \\] \n',latex(abs(diff(f,sizen)/factorial(sizen)*total)));
resid1=matlabFunction(abs(diff(f,sizen)/factorial(sizen)));
resid2=matlabFunction(abs(total));
testnum=min(xn):1e-5:max(xn);
boAbsErr=max(resid1(testnum))*max(resid2(testnum));
fclose(fhdl);


