Nullsoft AVS Preset 0.2   �   �   . brainstorm

made exclusively for AVSociety volume 6

mail:  duo_BC@yahoo.com
web:  http://duo.deviantART.com
aim:  visual duo

. duo | brad candullo


 ����Q  �   $�   �                          (       �$   �   o   c=i*pi*2; dm=.5;
x=pby-.4;
y=v*(.3+pby)-pbx;
red=1+pby+getosc(0,0,0);
green=pby-v;
blue=getosc(0,0,0)*80;    pbx=cos(pbx); pby=-sin(pby); "   pbx=rand(10)/10; pby=rand(10)/10;    n=10; pi=3.14159       ���    $   �   o   c=i*pi*2; dm=.5;
x=pby+.4;
y=v*(.3+pby)+pbx;
red=1+pby+getosc(0,0,0);
green=pby-v;
blue=getosc(0,0,0)*80;    pbx=cos(pbx); pby=-sin(pby); "   pbx=rand(10)/10; pby=rand(10)/10;    n=10; pi=3.14159       ���    +   �  c  dxA=cos(x*(rdn)+pfx)*.2;
dyA=cos(y*(rdn)+pfy)*.2;
dxB=d*(.55*sin(cos(pfr)));
dyB=d*(.55*sin(cos(pfr)));
dxC=cos(d*3+pfx)*.2;
dyC=sin(d*3+pfy)*.2;
dx=if(above(rdn,10),if(above(rdn,20),dxC,dxA),dxB);
dy=if(above(rdn,10),if(above(rdn,20),dyC,dyA),dyB);
d=dx*dy+d;
rA=r+sin(d*5)*(.1-abs(cos(pfr)*.2));
r=if(above(rdn,20),rA,r-pfr*sin(d*ds*.5)*.02); m   pfd=pfd+pbd; ds=sin(pfd); dc=cos(pfd);
pfx=pfx+pbx-(pfx*.1);
pfy=pfy+pby-(pfy*.1);
pfr=pfr+pbr-(pfr*.01); �   bc=if(equal(bc,lmt),bcn,bc+1);
pbd=rand(50)/400-.01;
pbr=rand(50)/500;
pbx=rand(50)/100-.02;
pby=rand(50)/100-.02;
rdn=2+rand(30); 2   pbd=0; pbr=0; pbx=0; pby=0; bc=0; lmt=15; bcn=-1;                                             ����      ����!                    �         ����1   �$�   �                     
                     %         &         ��                (              2	  2	  2	                 �����  � $   �                     d   +   �  �   x1=y*sin(x+pfx*.5)*.2+x*cos(cos(dc*.4));
y1=x*sin(y+pfy*.5)*.2+y*cos(cos(dc*.4));
z1=sqrt(x1*x1*y1*y1);
x=x1/(1+z1)+sin(cos(pfx)*.2*pbx);
y=y1/(1+z1)+sin(cos(pfy)*.2*pbx); W   pfd=pfd+pbd; ds=sin(pfd); dc=cos(pfd);
pfx=pfx+pbx-(pfx*.01);
pfy=pfy+pby-(pfy*.01); D   pbd=rand(50)/400-.01;
pbx=rand(50)/100-.02;
pby=rand(50)/100-.02;    pbd=0; pbx=0; pby=0;                             &           �            