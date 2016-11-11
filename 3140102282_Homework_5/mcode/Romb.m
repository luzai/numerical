function res=Romb(f,xi,xe)
R(1,1)=Trape(f,xi,xe);
h=(xe-xi)/2;
R(2,1)=Trape(f,xi,(xi+xe)/2)+Trape(f,(xi+xe)/2,xe);
h=h/2; R(3,1)=0;
for xx=xi:h:(xe-h)
R(3,1)=R(3,1)+Trape(f,xx,xx+h);
end
R(2,2)=R(2,1)+1/3*(R(2,1)-R(1,1));
R(3,2)=R(3,1)+1/3*(R(3,1)-R(2,1));
R(3,3)=R(3,2)+1/15*(R(3,2)-R(2,2));
res=R(3,3);

