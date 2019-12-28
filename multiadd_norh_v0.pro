undefine, box
file = DIALOG_PICKFILE(TITLE = 'NLFFE BOX SELECT', FILTER = 'DONE_NLFFFE_EXPLORE*', /MULTIPLE_FILES)
sz = size(file)
FOR i = 0, sz[1]-1 DO BEGIN
  restore, file[i]

;  cacheSTR = anytim(box.index.DATE_OBS,/hxrbs,/date)
;  nameSTR = STRMID(cacheSTR, 0, 2) + STRMID(cacheSTR, 3, 2) + STRMID(cacheSTR, 6, 2) + '_'
;
;  cacheSTR = anytim(box.index.DATE_OBS,/hxrbs,/time)
;  nameSTR = nameSTR + STRMID(cacheSTR, 0, 2) + STRMID(cacheSTR, 3, 2) + STRMID(cacheSTR, 6, 2)
  fileA = 'D:\IDL84\def_path\ipas\ipa' + STRMID(FILE_BASENAME(file[i]), 20, 13)
  fileS = 'D:\IDL84\def_path\ipas\ips' + STRMID(FILE_BASENAME(file[i]), 20, 13)
  ;fileA = DIALOG_PICKFILE(TITLE = nameSTR + '_NORH 17 GHz', FILTER = 'ipa*', PATH = 'D:\IDL84\def_path\ipas\')
  ;fileS = FILE_BASENAME(fileA)
  ;fileS_dir = FILE_DIRNAME(fileA)
  ;STRPUT, fileS, 's', 2
  ;fileS = fileS_dir + '\' + fileS
  ;print, fileS
  gx_box_add_refmap_norh, box, fileA, id = '17 GHz (R+L), K'
  gx_box_add_refmap_norh, box, fileS, id = '17 GHz (R-L), K'

  save, box, FILENAME = 'NORH_' + FILE_BASENAME(file[i])
  FILE_MOVE, FILE_BASENAME(file[i]), 'XDONE_' + FILE_BASENAME(file[i])
  undefine, box
ENDFOR
;undefine,box
;datef = '20160418'
;norht = '160418_003525'
;file = DIALOG_PICKFILE(TITLE=datef)
;restore,file
;;return_code = gx_box_make_nlfff_wwas_field("D:\ssw\packages\gx_simulator\gxbox\WWNLFFFReconstruction.dll", box)
;gx_box_add_refmap_norh,box,'D:\IDL84\def_path\'+datef+'\ipa'+norht,id='17 GHz (R+L), K'
;gx_box_add_refmap_norh,box,'D:\IDL84\def_path\'+datef+'\ips'+norht,id='17 GHz (R-L), K'
;gx_box_add_refmap_norh,box,'D:\IDL84\def_path\'+datef+'\ipz'+norht,id='34 GHz (R+L), K'
;;gx_box_add_refmap_norh,box,'D:\IDL84\def_path\'+datef+'\rips'+norht+'s.fits',id='34 GHz (R+L), K'
;save,box,FILENAME = datef+'_'+norht+'_nlfff.sav';add_v2
END