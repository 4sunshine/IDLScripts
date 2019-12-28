file=DIALOG_PICKFILE(path='C:\solarsoft\packages\gx_simulator\workdata\',FILTER=['*.sav','*.gxm'],$
  TITLE='Select gxm file')
restore,file
;b=model->GetB(bx=bx,by=by,bz=bz)
;model->getproperty,xcoord_conv=dx,ycoord_conv=dy,zcoord_conv=dz,refmaps=refmaps,ew=ew,ns=ns
;dr=[dx[1],dy[1],dz[1]]
;box={bx:bx,by:by,bz:bz,dr:dr,lat:-20.273,lon:-76.267007}
;save,box,FILENAME=file_dirname(file)+'\'+'box_of_'+file_basename(file,'.gxm')+'.sav'
END