PRO fitstoimg
files=dialog_pickfile(/MULTIPLE_FILES,$
  filter=['*.fits','*.fts','*.fit'],TITLE='Select FITS files to make PNG')
aa=size(files)
for i=0,aa(1)-1 do begin
  fits2map,files(i),map
;  sub_map,map,smap;,xrange=[830,1000],yrange=[-50,150]
;  help,smap
  bb=size(map.data)*4;*2;20
  fnadd=map.time
  fnadd=fnadd.replace(':','_')
  fnadd=fnadd.replace(' ','_')
  fnadd=fnadd.replace('.','_')
  fnadd=fnadd.replace('[','_')
  fnadd=fnadd.replace(']','_')
  fnadd=fnadd.compress()
  map2jpeg,map,map.id+'_'+fnadd+'.jpeg',size=[bb(1),bb(2)]
endfor
END

