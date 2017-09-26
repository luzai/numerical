xn=[0;0.5;1;2];

fhdl=fopen('p2.txt','a');
syms total L_up L_down x 
sizen=size(xn,1);
total=prod(x-xn);
L_up=total./(x-xn); 
L_down=subs(L_up,x,xn);L_down=L_down(L_down~=0);
L=L_up./L_down;
fprintf(fhdl,'\\[ %s \\] \n \\[ %s\\] \n',latex(L),latex(collect(L)));
fclose(fhdl);


