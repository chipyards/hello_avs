Nullsoft AVS Preset 0.2   �  �   Whacko AVS VI - Retrosquares
----------------------------------------------------

What's this? Well, this preset started out just as the pattern you see. It's generated using a DM with alpha-blending that blends in each points depending on the pattern. Then, using a multiplier and convolution, it's converted into the neat retro-pattern you see before you. What's neat is that it's completely tile-able and continuous: no edges where it repeats.

To make it slightly more interesting, I added a height-mapped DM with alpha-blending.

Steven Wittens / UnConeD
steven@acko.net - www.acko.net

(If you wish to use any part of this preset in your own packs you are free to do so, on the condition that you include my contact information) +   ~  j  pp=pp+1;
pc=if(band(above(y,.95),below(x,-.95)),1,0);
lx1=if(pc,94,lx1);lx2=if(pc,94,lx2);
ly1=if(pc,61,ly1);ly2=if(pc,61,ly2);
lx1=(lx1*351+gx)%1000;ly1=(ly1*411+gy)%1000;
lx2=(lx2*351+gxt)%1000;ly2=(ly2*411+gyt)%1000;
alpha=sign(sin(lx1+ly1)-.7)*(1-ip)+sign(sin(lx2+ly2)-.7)*ip;
lv=if(below(x,-.95),alpha,lv);
alpha=if(above(x,.95),lv,alpha);
py=y;
 ^   t=t-0.05;
py=-1;
lx1=94;ly1=61;
lx2=94;ly2=61;
ip=if(below(ip,1),ip+.04,1);
lv=0;
pp=0; �   x=below(ip,1);
gx=if(x,gx,gxt);
gy=if(x,gy,gyt);
ip=if(x,ip,0);
gxt=if(x,gxt,rand(100)+40+321);
gyt=if(x,gyt,rand(100)+50+711);                                d`Multiplier                                       d�            p�Channel Shift                      �                               ���             +   �    x=x*(1.3+zo2*.3);y=y*(1.3+zo2*.3)*af;
d=x*cr+y*sr;y=x*sr-y*cr;x=d;
d0=sqrt(sqr(x-xo0)+sqr(y-yo0));
d1=sqrt(sqr(x-xo1)+sqr(y-yo1));
lhv=hv;
hv=1/(1+((sin(d1*3-t*2)+sin(d0*4+t*.14)+sin(x*cg+y*sg-t*5.97))*.25+.5));
alpha=1.5-hv*1.5;
x=x*hv-xo2;
y=(y*hv-yo2)*iaf; &  t=t-0.035-ti*.15;ti=ti*.8;
xo0=sin(sin(t*0.906)*cos(t*0.322)*5-cos(t*.415));
yo0=sin(sin(t*0.172+mf1)*cos(t*0.579)*5-cos(t*.365));
xo1=sin(sin(t*0.117)*cos(t*0.41-mf1)*5-cos(t*.44));
yo1=sin(sin(t*0.249)*cos(t*0.342)*5-cos(t*.175));
xo2=sin(sin(t*0.0402)*cos(t*0.0636+mf2)*5-cos(t*.011))*4;
yo2=sin(sin(t*0.0213)*cos(t*0.0507)*5-cos(t*.099))*4;
zo2=sin(sin(t*0.0326)*cos(t*0.0951)*5-cos(t*.0747))+2;
ro=ro+sin(sin(t*0.1326)*cos(t*0.1951)*5-cos(t*.1747+mf2))*.03;
cr=cos(ro);sr=sin(ro);
iaf=w/h;af=h/w;
cg=cos(yo2+zo2)*5;sg=sin(yo2+zo2)*5;    ti=1; )   t=rand(100);mf1=rand(200);mf2=rand(200);                          !                    �         ����)  � $�   �                          l�sHolden03: Convolution Filter    �                                                      ������������            ��������������������        ��������   ��������        ��������������������            ������������                                    ����   ����U   � $�   �                                  QQQ                               