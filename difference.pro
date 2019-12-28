PRO difference
;;two b-maps
file=DIALOG_PICKFILE(path='C:\solarsoft\packages\gx_simulator\workdata\',FILTER=['*.map'],TITLE='Reference map')
restore,file
mapr=map;reference map
mapr.data[where(mapr.data lt 0.)]=0.
plot_map,mapr,cbar=1,/new,xrange=[700.,840.],yrange=[-350.,-220.]
file=file_dirname(file)+'\'+file_basename(file,'.map')+'_err.map'
restore,file
maprer=map;reference error map
maprer.data[where(maprer.data lt 0.)]=1000.
;print,maprer.data
plot_map,maprer,cbar=1,/new,xrange=[700.,840.],yrange=[-350.,-220.]
file=DIALOG_PICKFILE(path='C:\solarsoft\packages\gx_simulator\workdata\',FILTER=['*.map'],TITLE='Differential map')
restore,file
mapo=map;overlayed map
mapo.data[where(mapo.data lt 0.)]=0.
mapo=drot_map(mapo,ref_map=mapr)
plot_map,mapo,cbar=1,/new,xrange=[700.,840.],yrange=[-350.,-220.]
file=file_dirname(file)+'\'+file_basename(file,'.map')+'_err.map'
restore,file
mapoer=map;overlayed map error
mapoer.data[where(mapoer.data lt 0.)]=1000.
;mapoer=drot_map(mapoer,ref_map=maprer)
plot_map,maprer,cbar=1,/new,xrange=[700.,840.],yrange=[-350.,-220.]
;map1=drot_map(mapo,ref_map=mapr)
;mapom=merge_map(mapr,map1)
;dfmap=diff_map(mapr,mapom)
;map2=drot_map(mapoer,ref_map=maprer)
;mermap=merge_map(maprer,map2,/add)
;mapd=merge_map(mapr,mapo,/drotate)
dfmap=diff_map(mapr,mapo,/rotate)
mermap=merge_map(maprer,mapoer,/drotate,/add)
help,dfmap
help,mermap
;;two b-maps END
;;error of b sum two maps
sub_map,dfmap,smap,xrange=[700.,840.],yrange=[-350.,-220.]
sub_map,mermap,sermap,xrange=[700.,840.],yrange=[-350.,-220.]
print,smap.data
plot_map,smap,cbar=1,/new
plot_map,sermap,cbar=1,/new
help,smap
help,sermap
n=N_ELEMENTS(sermap.data)
edata=sermap.data
edata=FLOAT(edata)
sdata=smap.data
sdata=-FLOAT(sdata)
for i=0,n-1 do begin
  if ((sdata[i]+edata[i]) ge 0.)&&$
    ((sdata[i]-edata[i]) le 0.) then begin sdata[i]=0.
    endif else sdata[i]=1.;abs(sdata[i])
endfor
smap.data=sdata
print,max(sdata)
plot_map,smap,cbar=1,/new
map=smap
;dmap=diff_map(mapr,mapd,/rotate)
;plot_map,dmap
;file=DIALOG_PICKFILE(path='C:\solarsoft\packages\gx_simulator\workdata\',FILTER=['*.fits','*.fts','*.fit'],TITLE='AIA/NORH IMG FITS')
;fits2map,file,map
;dimap=drot_map(map,REF_MAP=mapr)
;plot_map,dimap
save,map,FILENAME=file_dirname(file)+'\'+'error_map'+'.map'
END