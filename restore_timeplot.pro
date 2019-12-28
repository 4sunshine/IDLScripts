restore,'0304_09_17_REGIONS_I.sav'
timenorh=tim2jd(timear)
undefine,timear
restore,'0304_09_17_NONPOTENTIALITY.sav'
timehmi=tim2jd(timear)
undefine,timear
;utplot,timehmi,bdift,Background='00FF00'x,COLOR='FF0000'x,LINESTYLE=4,THICK=2

;p2 = plot(timenorh,intens[0:*:3]/MAX(intens[0:*:3]),xtickunits='time',XTITLE='Time, h',$
;   YTITLE = 'Value',COLOR='BLUE',XRANGE=[timehmi[0],timehmi[-1]],$
;   YRANGE = [0.4,1],LINESTYLE=0,THICK=4,$
;   TITLE='2017/09/04 Top Region')
;
; p = plot(timehmi,bdift+0.6,xtickunits='time',XTITLE='Time, h',SYMBOL=1,$
;   YTITLE = 'Value',COLOR='Red',XRANGE=[timehmi[0],timehmi[-1]],LINESTYLE=6,THICK=4,/OVERPLOT)
   
   
 p2 = plot(timenorh,intens[2:*:3]/MAX(intens[2:*:3]),xtickunits='time',XTITLE='Time, h',$
   YTITLE = 'Value',COLOR='BLUE',XRANGE=[timehmi[0],timehmi[-1]],$
   YRANGE = [0,1],LINESTYLE=0,THICK=4,$
   TITLE='2017/09/04 Bottom Region')

 p = plot(timehmi,bdifl,xtickunits='time',XTITLE='Time, h',SYMBOL=1,$
   YTITLE = 'Value',COLOR='Red',XRANGE=[timehmi[0],timehmi[-1]],LINESTYLE=6,THICK=4,/OVERPLOT)
   
l = legend(TARGET=[bdifm,intens])
l[1].label="(E-E0)/E0"
l[0].label="I/Imax, NoRH"

END