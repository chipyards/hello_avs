Nullsoft AVS Preset 0.2    _  [  Whacko AVS II - Zero-G Maze
-------------------------------------------------

What happens when you mess around (a lot) with the depth-conditions in the cube DM from the first Whacko pack? Exactly, you get this :) Because the code contains some backdoors, the camera has to stay inside the intersection of the tunnels. Too bad, but it would make the code intensely slower to allow this. This is because it doesn't support the back-side of the planes (looks very messed up).

The tunnel texture moves around and rotates in order to make it look a bit disorienting. It's also tiled in a mirrored way (like Alien Checkboard), so you don't get non-matching edges between each tile.

The fun part here is that the preset shows that the fog is not fake: the amount of fogging on a point depends on the position of the camera: this is especially noticable on the edges of the intersection.

The fog itself is gradiented between the four corners using superscopes and a big zoom-in... looks a lot cooler than single-coloured fog...


UnConeD / Steven Wittens
[ steven@acko.net - www.acko.net ]

(If you wish to use this preset partially or whole in your own presets or packs, you should first mail me. I will practically never deny your request, but I like to know who uses my presets. This copyright message should also be included completely in your preset.)
 ����%  �   $�   �                          $   �   6   d=v*2+0.1; r=t+i*3.14159*2; x=cos(r)*d; y=sin(r)*d;
 K   t=t-0.05;red=sin(t+ro)*.5+1.3;green=sin(t+go)*.5+1.3;blue=sin(t+bo)*.5+1.3 B   ro=rand(100)/100*6.28;go=rand(100)/100*6.28;bo=rand(100)/100*6.28    n=800;ro=0;go=2.0;bo=4.0       ���     +   �   8   xx=x+dx/10;
yy=y+dy/10;
x=xx*ca+yy*sa;
y=yy*ca-xx*sa     Y   rv=rand(628)/100;
dx=cos(rv);
dy=sin(rv);
ra=rand(100)/500;
ca=cos(ra);
sa=sin(ra); 1   rv=rand(628)/100;dx=cos(rv);dy=sin(rv);ca=1;sa=0                                              (        (�$   �   ]   x=0;y=i*.2-.1;
red=sin(t+ro+i*2)/2+.5;
green=sin(t+go+i*2)/2+.5;
blue=sin(t+bo+i*2)/2+.5;    t=t-0.05;aa=aa*0.7; I   aa=0.0;ro=rand(100)/100*6.28;go=rand(100)/100*6.28;bo=rand(100)/100*6.28    n=50;ro=0;go=2.0;bo=4.0              (       �$   �   `   y=0;x=i*.5-.1;
red=sin(t+ro+i*2)*.5+.5;
green=sin(t+go+i*2)*.5+.5;
blue=sin(t+bo+i*2)*.5+.5;    t=t-0.05;aa=aa*0.7; I   aa=0.0;ro=rand(100)/100*6.28;go=rand(100)/100*6.28;bo=rand(100)/100*6.28    n=50;ro=0;go=2.0;bo=4.0                 +   �     x=x/14;y=y/14                   +   �  �  x=sin(r)*d;y=-cos(r)*d;
dx=x;dy=y;dz=0.6;
dx1=dx*cz-dy*sz;
dy1=dx*sz+dy*cz;
dy2=dy1*cx-dz*sx;
dz2=dy1*sx+dz*cx;
dx3=dx1*cy-dz2*sy;
dz3=dx1*sy+dz2*cy;
k1=abs((-1-oy)/dy2);
k1=if(below(k1*dy2,0),abs((1-oy)/dy2),k1);
k2=abs((-1-ox)/dx3);
k2=if(below(k2*dx3,0),abs((1-ox)/dx3),k2);
k3=abs((-1-oz)/dz3);
k3=if(below(k3*dz3,0),abs((1-oz)/dz3),k3);
k=min(min(max(k1,k2),max(k2,k3)),max(k1,k3));
ix=dx3*k-ox;iy=dy2*k-oy;iz=dz3*k-oz;
x=if(equal(k,k1),-ix,if(equal(k,k2),-iy,-ix));
y=if(equal(k,k1),iz,if(equal(k,k2),iz,iy));
ix=ix+ox;iy=iy+oy;iz=iz+oz;
d=sqrt(ix*ix+iy*iy+iz*iz);
alpha=2/d-0.4;
x=asin(sin(x*2.7))*.5;
y=asin(sin(y*2.7))*.5;
alpha=if(above(alpha,1),1,if(below(alpha,0),0,alpha));
 7  t=t+0.2;
rx=rx+rxo-0.03*cos(t/9)*cos(t/20)*sin(sin(t/9));
ry=ry+ryo+0.03*sin(t/10)*cos(t/22)*sin(cos(t/31));
rz=rz+rzo+0.03;
cx=cos(rx);sx=sin(rx);cy=cos(ry);sy=sin(ry);cz=cos(rz);sz=sin(rz);
rxo=(rxo+rxt)*.5;
ryo=(ryo+ryt)*.5;
rzo=(rzo+rzt)*.5;
ox=sin(t*.5)*.5;
oy=sin(t*.53)*.5;
oz=sin(t*.57)*.5;
 Z   rxt=(rand(80)/320)*sign(-rxt);
ryt=(rand(80)/320)*sign(-ryt);
rzt=(rand(80)/320)-0.125; H   t=0;rx=1.57;ry=1.57;rx=0;ry=0;rz=0;rxo=0;ryo=0;rzo=0;rxt=0;ryt=0;rzt=0;       $   $                