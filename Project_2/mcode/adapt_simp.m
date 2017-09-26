function y = adapt_simp ( f, a, b, TOL )

fa = feval ( f, a );
fc = feval ( f, (a+b)/2 );
fb = feval ( f, b );
sab = (b-a)*(fa + 4*fc + fb)/6;
[approx eest nfunc] = as ( sab, fa, fc, fb, f, a, b, TOL );
y = approx; 
return

function [app, est, nf] = as ( sab, fa, fc, fb, f, a, b, TOL )

c = (a+b)/2;
fd = feval ( f, (a+c)/2 );
fe = feval ( f, (c+b)/2 );
sac = (c-a)*(fa + 4*fd + fc)/6;
scb = (b-c)*(fc + 4*fe + fb)/6;

errest = abs ( sab - sac - scb );
if ( errest < (10.0*TOL) )
   app = sac+scb;
   est = errest / 10.0;
   nf = 2;
   return;
else
   [a1 e1 n1] = as ( sac, fa, fd, fc, f, a, c, TOL/2.0 );
   [a2 e2 n2] = as ( scb, fc, fe, fb, f, c, b, TOL/2.0 );
   app = a1 + a2;
   est = e1 + e2;
   nf = n1 + n2 + 2;
   return;
end;