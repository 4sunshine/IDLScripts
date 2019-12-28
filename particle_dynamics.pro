function bget,pcs   ;функция вычисления магнитного поля в точке с координатами pcs
x=pcs(0)
y=pcs(1)
z=pcs(2)
m=1d
h=0; z-homogen.field component/don't need
q=1d
r=(x^2+y^2+z^2)^0.5
bx=0;-3.d*x*z*m/r^5
by=2d*Exp(y)^10;-3.d*x*y*m/r^5
bz=0;(r^2-3.d*z)*m/r^5;-h
b0=(bx^2+by^2+bz^2)^0.5
w=q*b0
;print,w
b={b0:b0,bx:bx,by:by,bz:bz,w:w}
return,b
END

function dvdx,b,vp
a=100d ; a=a*
dvx=(vp(1)*b.bz-vp(2)*b.by)
dvy=(vp(2)*b.bx-vp(0)*b.bz)
dvz=(vp(0)*b.by-vp(1)*b.bx)
dv=[dvx,dvy,dvz];/a/b.b0
dv=dv/a/b.b0
return,dv
END

PRO particle_dynamics
n=20000 ; количество шагов по времени
a=100.d ; параметр a*
c=10.d  ; скорость света ; .d обозначает число с двойной точностью
pc=fltarr(n+1,3);пустой массив координат частицы в разные моменты времени длиной в количество шагов по времени
v=fltarr(n+1,3);пустой массив скоростей частицы в разные моменты времени
pc(0,*)=[2d,0.1d,-2d];начальные значения координат 
v(0,*)=[0.06d,0.01d,0.01d];начальные проекции скоростей (v- значит бета!)
v0=norm(v(0,*));модуль начального значения скорости (norm - вычисляет длину по теореме Пифагора)
r0=norm(pc(0,*));расстояние от начала координат
lb0=ATAN(pc(0,2)/r0);начальный угол лямбда
rl0=r0/(COS(lb0)^2);***высота силовой линии магнитного поля диполя
phi0=ASIN(pc(0,1)/r0/COS(lb0));начальный угол фи
For i=0,n-1 do begin ;вычисление динамики частицы
  pcs=pc(i,*) ;создание переменной pcs, в которой содержатся координаты частицы в данный момент времени
  b=bget(pcs) ;
  vp=v(i,*)
  dv=dvdx(b,vp)
  dv0=norm(v(i,*)+dv);norm of new speed  
  pc(i+1,*)=pc(i,*)+c*v(i,*)/a/b.b0
  v(i+1,*)=v0*(v(i,*)+dv)/dv0;energy conservation law
  ;v(i+1,*)=v(i,*)+dv ;example of radius disturbance
  ;bf=[b.bx,b.by,b.bz];vector of B
  ;mu=(b.bx*vp(0)+b.by*vp(1)+b.bz*vp(2))/norm(bf)/norm(vp);cosine of pitch-angle
  ;rad=norm(vp)*((1-mu^2)^0.5)/b.w
  ;print,rad
  print,FLOAT(i)/n
endfor
;print,v
xx=pc(*,0)
yy=pc(*,1)
zz=pc(*,2)
thtarr=((FINDGEN(300)-150)/150.)*!PI*0.5
fx=rl0*(COS(thtarr)^3)*COS(phi0)
fy=rl0*(COS(thtarr)^3)*SIN(phi0)
fz=rl0*(COS(thtarr)^2)*SIN(thtarr)

;ff=plot3d(fx,fy,fz)
pp=plot3d(xx,yy,zz,/overplot,xtitle='x',ytitle='y',ztitle='z');,$
  ;XRANGE=[-3, 3], YRANGE=[-3, 3], $
  ;ZRANGE=[-3, 3])
END

