Nullsoft AVS Preset 0.2      �   Whacko AVS V - Mercury
-------------------------------------------

We'll start with the easy ones :). This preset is not as advanced as the others, but I loved the liquid chrone effect so I kept it in.

The basic 'engine' behind the effect is the trusty Colorfade + Water combination. By using Unique Tone you reduce it to a bunch of swirly gray shapes. Then there's some finishing subtractive passes and a water filter for the pseudo-3D effect.

------------------------------------------------
UnConeD / Steven Wittens
[ steven@acko.net - www.acko.net ]

(If you wish to use this preset partially or whole in your own presets or packs, you may do so provided that a clear credit message is included in your preset, along with my contact information.) �����  �   $�   �                          (       �                     ��������      ����$   �    red=1;
sd1=(sd1*41+sd4*5.11+7191)%10000;
sd2=(sd2*23+2377)%10000;
sd3=(sd3*17+sd2*.5117+1371)%10000;
sd4=(sd4*511+2314)%10000;
px=(sd1%1000)*.002-1;
py=(sd2%1000)*.002-1;
pz=(sd3%1000)*.002-1;
x1=1/sqrt(sqr(px)+sqr(py)+sqr(pz));
red=if(below(x1,1),0,1);
px=px*x1;py=py*x1;pz=pz*x1;
x1=px*cz+py*sz;y1=py*cz-px*sz;
y2=y1*cx+pz*sx;z2=pz*cx-y1*sx;
x3=x1*cy+z2*sy;z3=z2*cy-x1*sy+1.8;
iz=if(above(z3,0.1),1/z3,0);
x=if(above(z3,0.1),x3*iz,x);y=if(above(z3,0.1),y2*iz*af,y);
red=red*(iz*3-.5);green=abs(getosc(i,0,0));blue=red*1.5;
 �   rx=rx+rxo;ry=ry+ryo;rz=rz+rzo;cx=cos(rx);sx=sin(rx);cy=cos(ry);sy=sin(ry);cz=cos(rz);sz=sin(rz);sd1=1213;sd2=4147;sd3=321;sd4=1211;af=w/h �   rxo=getosc(0,0,0)*.2;ryo=getosc(0.1,0,0)*.2;rzo=getosc(0.2,0,0)*.2;rxo=min(0.03,abs(rxo))*sign(rxo);ryo=min(0.03,abs(ryo))*sign(ryo);rzo=min(0.02,abs(rzo))*sign(rzo);    n=100;ryo=.001;rzo=.0017       �}}              +   �  �   d=sin(sin(sin(d)));
x=sin(r)*d;y=cos(r)*d;
d=sqrt(sqr(x)+sqr(y));r=atan2(y,x);
d=d*df;
r=r+ro;
x=cos(r)*d+xc;y=(sin(r)*d+yc)*w/h
 �   t=t-0.05-dti*.38;
df=sin(dt+cos(t))*cos(dt*0.317+ro)*.12+.4;
dt=dt+0.015+dti*.2;
ro=ro+sin(t*0.71)*cos(t*0.453)*sin(cos(t*.391))*.09+.001;
xc=cos(ro)*.5*(1-df);yc=sin(ro)*.5*(1-df);
dti=dti*.7;    dti=getspec(0,.3,0)*4; &   dt=rand(100)/10;mvo=rand(100)/50;t=0;                            ,          ����1   � $�   �                          ,          ,                   &         ���            