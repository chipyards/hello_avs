Nullsoft AVS Preset 0.2   �  �   Whacko AVS V - Reflectocube
---------------------------------------------------

After doing texture mapping DM's, I thought I'd do something more complicated. Environment mapping is not a good idea because it only looks cool on curvy surfaces... which is hard to do clearly with a DM.

However doing reflections is not too complicated and looks great on flat surfaces. So I took the cube from WaterCube, combined it with a sphere and some reflecting vector math. The result is this shiny, mirror cube. Looks cool :).

To make it easier to distinguish I added a soft color fill to the cube, but it looks cool without it too (turn off 'blend' on the last DM).

------------------------------------------------
UnConeD / Steven Wittens
[ steven@acko.net - www.acko.net ]

(If you wish to use this preset partially or whole in your own presets or packs, you may do so provided that a clear credit message is included in your preset, along with my contact information.) �����  �  $�   �                          (       �$   �   1   x=cos(i*tpi+hpi)*1.414;y=sin(i*tpi+hpi)*1.414;
 V   t=t+0.02;red=sin(hue+t)*.5+.2;green=sin(hue+2.09+t)*.5+.2;blue=sin(hue+4.18+t)*.5+.2;    hue=hue+rand(314)*.01    n=5;tpi=acos(-1)*2;hpi=tpi/8;       ���             $             (        �$   t   6   x=getosc(i*.5,0,0)*.5*r;
y=getosc(i*.5+.5,0,0)*.5*r;    t=t-0.02;r=r*.9+.1    r=2    n=200       ���     (       �       j      ���                   $   �   	   x=0;y=0; V   t=t+0.02;red=sin(hue+t)*.5+.6;green=sin(hue+2.09+t)*.5+.6;blue=sin(hue+4.18+t)*.5+.6;    hue=hue+rand(314)*.01;    n=1;t=2       ���        %   �     x=0;y=0                    +   !  �  y=y*af;
�rotate ray;
dx1=x*cz-y*sz;
dy1=x*sz+y*cz;
dy2=dy1*cx-1*sx;
dz2=dy1*sx+1*cx;
dx3=dx1*cy-dz2*sy;
dz2=dx1*sy+dz2*cy;
�intersect with cube;
k1=((oz-if(above(dz2,0),wd,-wd))/dz2)*2;
k2=((oy-if(above(dy2,0),wd,-wd))/dy2)*2;
k3=((ox-if(above(dx3,0),wd,-wd))/dx3)*2;
k=max(max(k1,k2),k3);
ix=-ox+dx3*k;iy=-oy+dy2*k;iz=-oz+dz2*k;
dx1=abs(if(equal(k,k3),iy-oy,ix-ox));
dy1=abs(if(equal(k,k1),iy-oy,iz-oz));
ol=max(dx1,dy1);
alpha=if(equal(k,-1000),0,below(ol,wd*2));
y=alpha+alpha*(cos(iy)+cos(ix))*.4;
�calculate normal;
k3=equal(k,k3);
k2=equal(k,k2);
k1=equal(k,k1);
�reflect ray if it intersects the cube;
dx3=if(band(alpha,k3),-dx3,dx3);
dy2=if(band(alpha,k2),-dy2,dy2);
dz2=if(band(alpha,k1),-dz2,dz2);
�move origin if we are reflecting;
ix=if(alpha,-ix,ox);
iy=if(alpha,-iy,oy);
iz=if(alpha,-iz,oz);
�intersect with sphere;
dx1=sqr(dx3)+sqr(dy2)+sqr(dz2);
dy1=(dz2*iz+dy2*iy+dx3*ix);
ol=sqr(iz)+sqr(iy)+sqr(ix)-30;
k=(dy1+sqrt(sqr(dy1)-dx1*ol))/dx1;
ix=ix-dx3*k;iy=iy-dy2*k;iz=iz-dz2*k;
�rotate sphere around cube;
ol=iy*cb-iz*sb;
iz=iy*sb+iz*cb;
k=ix*ca-iz*sa;
iz=ix*sa+iz*ca;
ix=k*cc-ol*sc;
iy=k*sc+ol*cc;
alpha=1-y*.3;
x=asin(sin(atan2(iz,ix)))*2.546;
y=-atan2(sqrt(sqr(iz)+sqr(ix)),iy)*3;
 �  t=t+0.16+ti*.5;pt=pt+0.3+ti*.5;
ox=sin(pt*.1231);oy=sin(pt*.1);oz=cos(pt*.0913);
ol=.3+2.5/sqrt(sqr(ox)+sqr(oy)+sqr(oz));
ox=ox*ol;oy=oy*ol;oz=oz*ol;
rxo=sin(t*.0373)*cos(t*0.0563)*sin(cos(t*.0631))*.5;
ryo=sin(t*.0511)*cos(t*0.071)*sin(cos(t*.0415))*.5;
ry=-atan2(ox,oz)+ryo;
rx=-atan2(oy,sqrt(sqr(ox)+sqr(oz)))+rxo;
rz=rz+.01+sin(t*.053)*cos(t*.117)*sin(cos(t*.0651))*.01;
cx=cos(rx);sx=sin(rx);cy=cos(ry);sy=sin(ry);cz=cos(rz);sz=sin(rz);
bt=bt*.9;af=h/w;
nv=(getspec(0,0.05,0)+nv)*.5;x=max(0,min(1,(nv-la)*2));la=nv;
wd=(wd+x*2)*.5+.5;
ol=cos(t*.0117)*sin(t*.00713)*32;
ca=cos(ol);sa=sin(ol);
ol=cos(t*.0061)*sin(t*.0047)*12;
cb=cos(ol);sb=sin(ol);
ti=ti*.7;
ol=cos(t*.0047)*sin(t*.00966)*12;
cc=cos(ol);sc=sin(ol);    ti=1;wd=1.5 "   t=0;rx=0;ry=0;pt=0;bt=0;la=0;wd=0                           