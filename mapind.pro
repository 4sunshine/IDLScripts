file=DIALOG_PICKFILE(path='C:\solarsoft\packages\gx_simulator\workdata\',FILTER=['*.sav','*.map'])
restore,file
;'C:\idl_c_default\init_work_direct\conv2012.map'file=dialog_pickfile(path='C:\solarsoft\packages\gx_simulator\workdata\')
var=map.getmap(22);map17GHz
map2index,var,index,data
;save,FILENAME='11index.sav',index
;save,FILENAME='11data.sav',data
index2map,index,data,map
fnadd=map.id
fnadd=fnadd.replace(':','_')
fnadd=fnadd.replace(' ','_')
fnadd=fnadd.replace('.','_')
fnadd=fnadd.replace('[','_')
fnadd=fnadd.replace(']','_')
fnadd=fnadd.compress()
save,map,FILENAME=file_dirname(file)+'\'+file_basename(file,'.map')+fnadd+'test'+'.map'
END