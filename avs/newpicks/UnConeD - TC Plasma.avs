Nullsoft AVS Preset 0.2   �  �  Whacko AVS III - True-Color Plasma
----------------------------------------------------------

Who doesn't remember this classic effect? In the demo-days, fake true-colour had to be simulated in 256 colormode: thanks to AVS, we can now have real, true-color plasma :)

A bunch of sines and cosines on a variety of transformations on the coordinates create this hypnotising swirly mass. Some brightness filters and subtractions complete the effect by clipping the colours (resulting in the same effect as a 'chrome' filter). The movements are slightly beat-responsive, the colours a lot.

It keeps going on for hours...


UnConeD / Steven Wittens
[ steven@acko.net - www.acko.net ]

(If you wish to use this preset partially or whole in your own presets or packs, you should first mail me. I will practically never deny your request, but I like to know who uses my presets. This copyright message should also be included completely in your preset.)
 ����u  �   $�   �                          (        (�$   �   ]   x=0;y=i*.2-.1;
red=sin(t+ro+i*2)/2+.5;
green=sin(t+go+i*2)/2+.5;
blue=sin(t+bo+i*2)/2+.5;    t=t-0.05;aa=aa*0.7; I   aa=0.0;ro=rand(100)/100*6.28;go=rand(100)/100*6.28;bo=rand(100)/100*6.28    n=50;ro=0;go=2.0;bo=4.0              (       #�$   �   `   y=0;x=i*.5-.1;
red=sin(t+ro+i*2)*.5+.5;
green=sin(t+go+i*2)*.5+.5;
blue=sin(t+bo+i*2)*.5+.5;    t=t-0.05;aa=aa*0.7; I   aa=0.0;ro=rand(100)/100*6.28;go=rand(100)/100*6.28;bo=rand(100)/100*6.28    n=50;ro=0;go=2.0;bo=4.0                          +   �     x=x/14;y=y/14                   !                    �         +   �  �  x1=x-cx;y1=y-cy;
d1=sqrt(sqr(x1)+sqr(y1));r1=atan2(y1,-x1)+t*0.141;
x2=x-bx;y2=y-by;
d2=sqrt(sqr(x2)+sqr(y2));r2=atan2(y2,-x2)-t*0.0791;
aa=sin(x1*2.5+sin(y*x*sin(r2*.5+t))+t)*.5+.5;
bb=sin(d1*3+cos((y+x+t*0.7419)*3)*.5+sin(r2*.1+t*0.3791))*.5+.5;
cc=cos(d2*3+cos(r1*.1+y*3+dy))*.5+.5;
dd=(cos(x+dx+t+d1)*.25+sin(t+d*2+y2)*.25+.5);
pa=alpha;alpha=aa*bb*cc*dd;
alpha=pow((pa+alpha*15)*.0625,0.2)-0.2
   ti=ti*0.8;
t=t-0.05-ti;
cx=cos(t*0.97)*sin(t*0.371)*cos(sin(t*0.129))*3+2;
cy=sin(t*0.771)*cos(t*0.771)*cos(sin(t*0.179+1))*3-2;
bx=sin(t*0.197)*sin(t*0.873)*cos(sin(t*0.129))*3+3;
by=cos(t*0.476)*cos(t*0.431)*cos(sin(t*0.291+2))*3+2;
dx=cos(t*0.4771)+2;dy=sin(t*0.4910)+3;    ti=0.2    t=rand(100);          (                 ����1   � $�   �                          ,          ,          ����1   � $�   �                          ,          ,          