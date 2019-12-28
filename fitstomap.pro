PRO fitstomap
file=dialog_pickfile(path='C:\solarsoft\packages\gx_simulator\workdata\',filter=['*.map'],TITLE='Select MAP file to make SUBMAP')
filer=dialog_pickfile(path='C:\solarsoft\packages\gx_simulator\workdata\',filter=['*.fits'],TITLE='Select fits reference file')
mreadfits_header, filer, indexr
mreadfits,filer,indexr,datar
index2map,indexr,datar,mapr
restore,file
help,indexr
sub_map,rmap,smap,xrange=[indexr.crval1-$
  indexr.crpix1*indexr.cdelt1,indexr.crval1+$
  indexr.crpix1*indexr.cdelt1],yrange=[indexr.crval2-$
  indexr.crpix2*indexr.cdelt2,indexr.crval2+$
  indexr.crpix2*indexr.cdelt2]
  smap=rebin_map(smap,64,64)
plot_map,smap
help,smap
save,smap,FILENAME=file_dirname(file)+'\'+file_basename(file,'.map')+'_reb'+'.map'
END

