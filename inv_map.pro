FUNCTION qtri,losfile,gxmap;invdat=outstructure
  restore,losfile
  restore,gxmap
  fmap=map.getmap(14);8
  pp=strsplit(fmap.id)
  ofreq=float(strmid(fmap.id,pp(1),pp(2)-pp(1)-1))
  hg=header.ny
  wdt=header.nx
  inv=bytarr(hg,wdt)
  inv(*,*)=0
  cs=boolarr(hg,wdt)
  cs(*,*)=0
  ft=fltarr(hg,wdt)
  ;  nt=fltarr(hg,wdt)
  frq=fltarr(hg,wdt,10)
  bf=fltarr(hg,wdt,10)
  bt=fltarr(hg,wdt)
  record=multi_restore(lun,file=losfile,/new)
  for i=0,hg-1 do begin
    record=multi_restore(lun)
    pt=size(record.parms)
    path=pt(2)
    for j=0,wdt-1 do begin
      ;      arrn=record.parms(j,*,11);array of n0
      ;      nm=max(arrn,nmi);max n0
      arrnb=record.parms(j,*,12);array of nb
      nbm=max(arrnb,nmi);max nb
      k=nmi
      if nbm ne 0 then begin
        repeat k++ until record.parms(j,k,12) eq 0
        nmi=k;end of nonthermal
        floor=nmi
        for k=floor,path-3 do begin
          if ((record.parms(j,k,14) lt 90.0)&&(record.parms(j,k+1,14) ge 90.0)$
            &&(record.parms(j,k+2,14) ge 90.))||$
            ((record.parms(j,k,14) gt 90.)&&(record.parms(j,k+1,14) le 90.)$
            &&(record.parms(j,k+2,14) le 90.)&&((record.parms(j,k+2,14) ne 0.)))$
            then begin
            frq(j,i,inv(j,i))=(((0.171887*record.parms(j,k+1,11)*(record.parms(j,k+1,13)^3)$
              *(record.parms(j,k,1)+record.parms(j,k+1,1)+record.parms(j,k-1,1))$
              /Abs(record.parms(j,k+2,14)-record.parms(j,k-1,14))))^0.25)*1E-4 ;need qt frequency GHz
            bf(j,i,inv(j,i))=record.parms(j,k+1,13)
            ;          nt(j,i,inv(j,i))=record.parms(j,k+1,11)
            inv(j,i)=inv(j,i)+1
          endif
        endfor
        k=0
        while k lt inv(j,i) do begin
          if ofreq lt frq(j,i,k) then cs(j,i)=~cs(j,i)
          k++
        endwhile
        if cs(j,i) eq 1 then begin
          ft(j,i)=MAX(frq(j,i,*))
          bt(j,i)=MAX(bf(j,i,*))
        endif
      endif
    endfor
  endfor
  ;cs(*,*)=float(cs(*,*))
  map2index,fmap,index,data
  index2map,index,cs,mapcs
  mapcs.id='qt_inversion_nlfffe'
  ft(*,*)=ft(*,*)*cs(*,*)
  map2index,fmap,index,data
  index2map,index,ft,mapft
  mapft.id='ft_map_nlfffe [GHz]'
  map2index,fmap,index,data
  index2map,index,bt,mapbt
  mapbt.id='bt_nlfffe [G]'
  map=fmap
  invdat={map:fmap,ninv:inv,ft:mapft,cs:mapcs,obsfr:ofreq,bt:mapbt};count of qt reg-ft-inverted or not
  RETURN,invdat
END

PRO inv_map
losfile=DIALOG_PICKFILE(path='D:\IDL84\def_path\PAPER_EPS\FINAL_DATA',FILTER=['*.sav','*.los'],$
TITLE='Select los-data file')
gxmap=DIALOG_PICKFILE(path='D:\IDL84\def_path\PAPER_EPS\FINAL_DATA',FILTER=['*.sav','*.map'],$
  TITLE='Select gx map file')
out=qtri(losfile,gxmap)
;map=make_map(out.cs)
map=out.cs
save,map,FILENAME=file_dirname(gxmap)+'\'+file_basename(gxmap,'.map')+out.cs.id+'.map'
;plot_map,out.ft
map=out.ft
save,map,FILENAME=file_dirname(gxmap)+'\'+file_basename(gxmap,'.map')+out.ft.id+'.map'
map=out.Map
save,map,FILENAME=file_dirname(gxmap)+'\'+file_basename(gxmap,'.map')+'r-l deg'+'.map';out.map.id+'.map'
map=out.bt
save,map,FILENAME=file_dirname(gxmap)+'\'+file_basename(gxmap,'.map')+out.bt.id+'.map'
END