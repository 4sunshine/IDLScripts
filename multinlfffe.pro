PRO MultiNLFFFE
undefine,box
files = DIALOG_PICKFILE(TITLE = 'NLFFE BOXES SELECT', FILTER = 'NORH_DONE_NLFFFE_EXPLORE*', /MULTIPLE_FILES)
sz = size(files)
bsqunp = DBLARR(sz[1])
bsqup = DBLARR(sz[1])

;bdift=FINDGEN(sz[1])
;bdifm=FINDGEN(sz[1])
;bdifl=FINDGEN(sz[1])
timear=STRARR(sz[1])
FOR i = 0, sz[1]-1 DO BEGIN
  restore,files[i]
  print,'task',i+1,' of',sz[1]
;  return_code = gx_box_make_nlfff_wwas_field("D:\ssw\packages\gx_simulator\gxbox\WWNLFFFReconstruction.dll", box)
;  cacheSTR = anytim(box.index.DATE_OBS,/hxrbs,/date)
;  nameSTR = STRMID(cacheSTR, 0, 2) + STRMID(cacheSTR, 3, 2) + STRMID(cacheSTR, 6, 2) + '_'
;
;  cacheSTR = anytim(box.index.DATE_OBS,/hxrbs,/time)
;  nameSTR = nameSTR + STRMID(cacheSTR, 0, 2) + STRMID(cacheSTR, 3, 2) + STRMID(cacheSTR, 6, 2)
;
;  save,box,FILENAME = 'NLFFFE_EXPLORE_' + nameSTR + '.sav'
  szl = size(box.bx)
  bxnp = box.bx
  bynp = box.by
  bznp = box.bz
  bsqunp[i] = TOTAL(bxnp^2 + bynp^2 + bznp^2)/szl[5]; b^2 = bx^2 + by^2 + bz^2
  undefine, box
  filep = FILE_SEARCH('D:\IDL84\def_path\out\*' + STRMID(FILE_BASENAME(files[i]), 25, 13) + '*')
  restore,filep
  bxp = box.bx
  byp = box.by
  bzp = box.bz
  bsqup[i] = TOTAL(bxp^2 + byp^2 + bzp^2)/szl[5]
  timear[i]=anytim(box.index.DATE_OBS,/yohkoh)
  undefine, box
;::::::::::::::::  option_B_make_difference ::::::::::::::::::::: 
;  bx=box.bx
;  by=box.by
;  bz=box.bz;
;  bxt=box.bx[76:135,119:181,0:29]
;  byt=box.by[76:135,119:181,0:29]
;  bzt=box.bz[76:135,119:181,0:29]
;  bpt=TOTAL(bxt^2+byt^2+bzt^2)
;  bxm=box.bx[53:109,96:116,0:29]
;  bym=box.by[53:109,96:116,0:29]
;  bzm=box.bz[53:109,96:116,0:29]
;  bpm=TOTAL(bxm^2+bym^2+bzm^2)
;  bxl=box.bx[75:139,27:97,0:29]
;  byl=box.by[75:139,27:97,0:29]
;  bzl=box.bz[75:139,27:97,0:29]
;  bpl=TOTAL(bxl^2+byl^2+bzl^2)
;  filenp = FILE_DIRNAME(files[i])+'\'+box.id.substring(11,25)+'_NLFFFE_DROT_0108.SAV'
;  undefine,box
;  restore, filenp
;  bxnpt=box.bx[76:135,119:181,0:29]
;  bynpt=box.by[76:135,119:181,0:29]
;  bznpt=box.bz[76:135,119:181,0:29]
;  bnpt=TOTAL(bxnpt^2+bynpt^2+bznpt^2)
;  bxnpm=box.bx[53:109,96:116,0:29]
;  bynpm=box.by[53:109,96:116,0:29]
;  bznpm=box.bz[53:109,96:116,0:29]
;  bnpm=TOTAL(bxnpm^2+bynpm^2+bznpm^2)
;  bxnpl=box.bx[75:139,27:97,0:29]
;  bynpl=box.by[75:139,27:97,0:29]
;  bznpl=box.bz[75:139,27:97,0:29]
;  bnpl=TOTAL(bxnpl^2+bynpl^2+bznpl^2)

;  bdift[i]=(bnpt-bpt)/bpt
;  bdifm[i]=(bnpm-bpm)/bpm
;  bdifl[i]=(bnpl-bpl)/bpl
;  undefine,box
ENDFOR
;print,bdif
  utplot,timear,bsqunp/bsqup
  save, timear, bsqunp, bsqup, FILENAME = 'DATA170903_TOTAL.sav'
;save, bdift,bdifm,bdifl,timear, FILENAME='0304_09_17_NONPOTENTIALITY.sav';+FILE_BASENAME(files[i])
END
