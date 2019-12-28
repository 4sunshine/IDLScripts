PRO EM_FORME
;EMISSION MEASURE FOR ME

channels=['94','131','171','193','211','335']

xr=[840,910]
yr=[-240,-170]

 wave1='94'
 wave2='131'
 wave3='171'
 wave4='193'
 wave5='211'
 wave6='335'
 f1='D:\IDL84\def_path\2013-10-28\'   &  files1=file_search( f1+'*'+wave1+'_.fts')
 f2 =f1  & files2=file_search( f2+'*'+wave2+'_.fts')
 f3=f1 & files3=file_search( f3+'*'+wave3+'_.fts')
 f4=f1 & files4=file_search( f4+'*'+wave4+'_.fts')
 f5=f1 & files5=file_search( f5+'*'+wave5+'_.fts')
 f6=f1 & files6=file_search( f6+'*'+wave6+'_.fts')
 help,files2
  ;files = [[files1],[files2],[files3],[files4],[files5],[files6]];MUST BE EQUAL Number of Files
  files=[ [files1[1:n_elements(files1)-1]  ], [files2[0:n_elements(files2)-2] ],  [files3[0:n_elements(files3)-2] ], [files4[0:n_elements(files4)-2]   ], [files5[1:n_elements(files5)-1] ], [files6[1:n_elements(files6)-1] ]]
  for j=0, (size(files))[1]-1  do begin
    read_sdo, reform( files[j,*] ),tind,tdata
    help,files2
    help,tind
;    help,tind(1);
    stop
        tdata=tdata>0
        aia_prep,  tind, tdata ,oind, odata,normalize=1
        index2map,oind,odata  ,map_t
    

        durs=tind.exptime

        map_in=smap_t
        data=map_in.data

        sub_map,map_t,smap_t,xrange=xr,yrange=yr
        
;            ;;get average of every two (or n) images
;            for cc=0,5 do begin
;              read_sdo, reform( files[j:j+1,cc] ),tind,tdata
;              tdata=tdata>0
;              aia_prep,  tind, tdata ,oind, odata,normalize=1
;              index2map,oind,odata  ,map_t
;              sub_map,map_t,smap_t,xrange=xr,yrange=yr
;              data[*,*,cc]=average( smap_t.data ,3)
;            endfor

  
      map_in=REP_TAG_VALUE(map_in, data > 0.001  ,'data')
  
      n_mc=0
      filename='131028EM.sav'
      save, map_in, durs,xr, yr, filename='131028EMMAP.sav'
      get_em_from_aia, map_in=map_in,durs=durs,n_img=2, n_mc=0,filename=filename, xr=xr,yr=yr
;      stop
      print,j,'     -----------------    ', (size(files))[1]

    endfor
END