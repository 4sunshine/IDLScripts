;INVERSION OF POLARIZ RESTORE
fle=DIALOG_PICKFILE(path='C:\solarsoft\packages\gx_simulator\workdata\',FILTER=['*.sav','*.los'])
restore,fle
hg=header.ny
wdt=header.nx
inv=fltarr(hg,wdt)
inv(*,*)=0
frq=fltarr(hg,wdt,10)
record=multi_restore(lun,file=fle,/new)
for i=0,hg-1 do begin
  record=multi_restore(lun)
  pt=size(record.parms)
  path=pt(2)
  for j=0,wdt-1 do begin
    arrn=record.parms(j,*,11);array of n0
    nm=max(arrn,nmi);max n0
    floor=nmi;min los
;    print,floor,path
    for k=floor,path-3 do begin
      if ((record.parms(j,k,14) lt 90.0)&&(record.parms(j,k+1,14) ge 90.0)$
        &&(record.parms(j,k+2,14) ge 90.))||$
        ((record.parms(j,k,14) gt 90.)&&(record.parms(j,k+1,14) le 90.)$
        &&(record.parms(j,k+2,14) le 90.))$
         then begin
            frq(j,i,inv(j,i))=(((0.171887*record.parms(j,k+1,11)*(record.parms(j,k+1,13)^3)$
            *(record.parms(j,k,1)+record.parms(j,k+1,1)+record.parms(j,k-1,1))$
            /Abs(record.parms(j,k+2,14)-record.parms(j,k-1,14))))^0.25)*1E-4 ;need qt frequency GHz
          inv(j,i)=inv(j,i)+1
          endif ;else begin
            ;if (record.parms(j,k,14) gt 90.)&&(record.parms(j,k+1,14) le 90.)$
            ;  &&(record.parms(j,k+2,14) le 90.) then begin
            ;frq(j,i,inv(j,i))=(((0d171887*record.parms(j,k+1,11)*(record.parms(j,k+1,13)^3)$
            ;*(record.parms(j,k,1)+record.parms(j,k+1,1)+record.parms(j,k-1,1))$
            ;/Abs(record.parms(j,k+2,14)-record.parms(j,k-1,14))))^0.25)*1E-4 ;need qt frequency GHz
            ;  inv(j,i)=inv(j,i)+1
            ;  endif
          ;endelse
    endfor    
  endfor
endfor
print,max(inv)
print,max(frq)
END
