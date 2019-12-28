FUNCTION losd,losfile;invdat=outstructure
  restore,losfile
  hg=header.ny
  wdt=header.nx
  invpx=0
  invpn=0
  record=multi_restore(lun,file=losfile,/new)
  for i=0,hg-1 do begin
    record=multi_restore(lun)
    pt=size(record.parms)
    path=pt(2)
    for j=0,wdt-1 do begin
      if (i eq 38)&&(j eq 15) then begin;LFP22-38_15;LFP1907-33_12
      arrnb=record.parms(j,*,12);array of nb
      nbm=max(arrnb,nmi);max nb
      k=nmi
      if nbm ne 0 then begin
;        repeat k++ until record.parms(j,k,12) eq 0
;        nmi=k;end of nonthermal
        floor=nmi
        np=record.parms(j,floor:path-3,11);thermal electrons concentration
        bp=record.parms(j,floor:path-3,13);b-field
        tp=record.parms(j,floor:path-3,14);theta
        pp=record.parms(j,floor:path-3,1)/1.E8;dz
        s=0.d
        sp=fltarr(N_ELEMENTS(pp));path
        for k=0,path-4-floor do begin
          sp[k+1]=pp[k]+s
          s=sp[k+1]
        endfor
        for k=floor,path-3 do begin
          if ((record.parms(j,k,14) lt 90.0)&&(record.parms(j,k+1,14) ge 90.0)$
            &&(record.parms(j,k+2,14) ge 90.))$
            then begin
            invpx=sp[k-floor+1]
            endif
            if ((record.parms(j,k,14) gt 90.)&&(record.parms(j,k+1,14) le 90.)$
              &&(record.parms(j,k+2,14) le 90.))$
              then begin
              invpn=sp[k-floor]
            endif
         endfor   
      endif
      endif
    endfor
  endfor
  los={n:np,b:bp,theta:tp,s:sp,qtp:invpx,qtn:invpn};count of qt reg-ft-inverted or not
  RETURN,los
END

PRO los_data
losfile=DIALOG_PICKFILE(path='C:\solarsoft\packages\gx_simulator\workdata\',FILTER=['*.sav','*.los'],$
TITLE='Select los-data file')
los=losd(losfile)
plot1=plot(los.s,los.theta,$
  FONT_NAME='Helvetica',$
  XTITLE='distance along LOS, $10^8$ cm',$;10!E8!N
  YTITLE='$\theta$, degrees',POSITION=[.15,.55,.45,.95],XRANGE=[0,100],YRANGE=[0,180])
plot11=plot([los.qtn,los.qtn],[0.,200.],$
POSITION=[.15,.55,.45,.95],XRANGE=[0,100],/OVERPLOT,linestyle='dashed')
;plot12=plot([los.qtp,los.qtp],[0.,200.],$
;  POSITION=[.15,.55,.45,.95],XRANGE=[0,100],/OVERPLOT,linestyle='dashed')
plot2=plot(los.s,los.n,$
    FONT_NAME='Helvetica',$
    XTITLE='distance along LOS, $10^8$ cm',$;10!E8!N
    YTITLE='$n_0$, $cm^{-3}$',POSITION=[.30,.1,.7,.40],/YLOG,/CURRENT,XRANGE=[0,100],YRANGE=[1.E7,7E8])
    plot21=plot([los.qtn,los.qtn],[1.E7,7E8],$
    POSITION=[.30,.1,.7,.40],XRANGE=[0,100],/OVERPLOT,linestyle='dashed')
;  plot22=plot([los.qtp,los.qtp],[1.E7,5E8],$
;    POSITION=[.30,.1,.7,.40],XRANGE=[0,100],/OVERPLOT,linestyle='dashed')
plot3=plot(los.s,los.b,$
    FONT_NAME='Helvetica',$
    XTITLE='distance along LOS, $10^8$ cm',$;10!E8!N
    YTITLE='B, Gauss',POSITION=[.60,.55,0.90,.95],/CURRENT,XRANGE=[0,100],YRANGE=[0,450])  
  plot31=plot([los.qtn,los.qtn],[0,450],$
    POSITION=[.60,.55,0.90,.95],XRANGE=[0,100],/OVERPLOT,linestyle='dashed')
;  plot32=plot([los.qtp,los.qtp],[0,200],$
;    POSITION=[.60,.55,0.90,.95],XRANGE=[0,100],/OVERPLOT,linestyle='dashed')
END