PRO FlowAndEnergy
undefine,box
files = DIALOG_PICKFILE(TITLE = 'NLFFE BOXES SELECT', FILTER = 'NORH_DONE_NLFFFE_EXPLORE*', /MULTIPLE_FILES)
sz = size(files)


;REGIONS_BOUNDARIES_TO_EXTRACT
;region = [xmin,xmax,ymin,ymax,zmin,zmax]
; TT,TB,CL,CR,BL,BR
tt = [47,101,110,135,0,60]
tb = [47,100,90,109,0,60]
cl = [43,69,53,89,0,60]
cr = [70,93,54,89,0,60]
bl = [45,81,12,52,0,60]
br = [82,116,13,52,0,60]
regs = [[tt],[tb],[cl],[cr],[bl],[br]] ; regions
topf = [47,101,110,110,0,60];JY
cenf = [70,70,54,89,0,60];JX
botf = [82,82,13,52,0,60];JX
cflow = [[topf],[cenf],[botf]]

regcount = size(regs)
flowcount = size(cflow)

;bdift=FINDGEN(sz[1])
;bdifm=FINDGEN(sz[1])
;bdifl=FINDGEN(sz[1])
timear=STRARR(sz[1])
efull = DBLARR(sz[1],regcount[2])
epot = DBLARR(sz[1],regcount[2])
depart = DBLARR(sz[1],regcount[2]) ; (ef-ep)/ep
radio = DBLARR(sz[1],regcount[2])
curflow = DBLARR(sz[1],flowcount[2])
abscurflow = DBLARR(sz[1],flowcount[2])
transcur = DBLARR(sz[1],flowcount[2])

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
  fbx = box.bx ; f means full field
  fby = box.by
  fbz = box.bz
  undefine,box
  filep = FILE_SEARCH('D:\IDL84\def_path\out\*' + STRMID(FILE_BASENAME(files[i]), 25, 13) + '*')
  restore,filep
  pbx = box.bx
  pby = box.by
  pbz = box.bz
  timear[i]=anytim(box.index.DATE_OBS,/yohkoh)
  undefine,box
  filerad = FILE_SEARCH('D:\IDL84\def_path\BASEMAPS\SAV\17GHZ\*' + STRMID(FILE_BASENAME(files[i]), 25, 13) + '*')
  restore,filerad
  rdata = mapw.data
  undefine,mapw
  FOR j = 0, regcount[2] - 1 DO BEGIN
;    bxf = fbx[regs[0,j]:regs[1,j],regs[2,j]:regs[3,j],regs[4,j]:regs[5,j]]
;    byf = fby[regs[0,j]:regs[1,j],regs[2,j]:regs[3,j],regs[4,j]:regs[5,j]]
;    bzf = fbz[regs[0,j]:regs[1,j],regs[2,j]:regs[3,j],regs[4,j]:regs[5,j]]
;    efull[i,j] = TOTAL(bxf^2 + byf^2 + bzf^2)
;    bxp = pbx[regs[0,j]:regs[1,j],regs[2,j]:regs[3,j],regs[4,j]:regs[5,j]]
;    byp = pby[regs[0,j]:regs[1,j],regs[2,j]:regs[3,j],regs[4,j]:regs[5,j]]
;    bzp = pbz[regs[0,j]:regs[1,j],regs[2,j]:regs[3,j],regs[4,j]:regs[5,j]]
;    epot[i,j] = TOTAL(bxp^2 + byp^2 + bzp^2)
    efull[i,j] = TOTAL(fbx[regs[0,j]:regs[1,j],regs[2,j]:regs[3,j],regs[4,j]:regs[5,j]]^2+$
      fby[regs[0,j]:regs[1,j],regs[2,j]:regs[3,j],regs[4,j]:regs[5,j]]^2+$
      fbz[regs[0,j]:regs[1,j],regs[2,j]:regs[3,j],regs[4,j]:regs[5,j]]^2)
    epot[i,j] = TOTAL(pbx[regs[0,j]:regs[1,j],regs[2,j]:regs[3,j],regs[4,j]:regs[5,j]]^2+$
      pby[regs[0,j]:regs[1,j],regs[2,j]:regs[3,j],regs[4,j]:regs[5,j]]^2+$
      pbz[regs[0,j]:regs[1,j],regs[2,j]:regs[3,j],regs[4,j]:regs[5,j]]^2)
    depart[i,j] = (efull[i,j] - epot[i,j])/epot[i,j]
    radio[i,j] = TOTAL(rdata[regs[0,j]:regs[1,j],regs[2,j]:regs[3,j]])
    undefine,bxf,byf,bzf,bxp,byp,bzp
  ENDFOR
  undefine,fbx,fby,fbz,pbx,pby,pbz
  filecur = FILE_SEARCH('D:\IDL84\def_path\CURL_UTIL\*' + STRMID(FILE_BASENAME(files[i]), 25, 13) + '*')
  restore,filecur
  cx = box.bx
  cy = box.by
  cz = box.bz

  undefine,box
  curflow[i,0] = TOTAL(cy[cflow[0,0]:cflow[1,0],cflow[2,0]:cflow[3,0],cflow[4,0]:cflow[5,0]])
  abscurflow[i,0] = TOTAL(cy[cflow[0,0]:cflow[1,0],cflow[2,0]:cflow[3,0],cflow[4,0]:cflow[5,0]]^2+ $
    cx[cflow[0,0]:cflow[1,0],cflow[2,0]:cflow[3,0],cflow[4,0]:cflow[5,0]]^2+ $
    cz[cflow[0,0]:cflow[1,0],cflow[2,0]:cflow[3,0],cflow[4,0]:cflow[5,0]]^2)
  curflow[i,1] = TOTAL(cx[cflow[0,1]:cflow[1,1],cflow[2,1]:cflow[3,1],cflow[4,1]:cflow[5,1]])
  abscurflow[i,1] = TOTAL(cx[cflow[0,1]:cflow[1,1],cflow[2,1]:cflow[3,1],cflow[4,1]:cflow[5,1]]^2+ $
    cy[cflow[0,1]:cflow[1,1],cflow[2,1]:cflow[3,1],cflow[4,1]:cflow[5,1]]^2+ $
    cz[cflow[0,1]:cflow[1,1],cflow[2,1]:cflow[3,1],cflow[4,1]:cflow[5,1]]^2)

  curflow[i,2] = TOTAL(cx[cflow[0,2]:cflow[1,2],cflow[2,2]:cflow[3,2],cflow[4,2]:cflow[5,2]])
  abscurflow[i,2] = TOTAL(cx[cflow[0,2]:cflow[1,2],cflow[2,2]:cflow[3,2],cflow[4,2]:cflow[5,2]]^2+ $
    cy[cflow[0,2]:cflow[1,2],cflow[2,2]:cflow[3,2],cflow[4,2]:cflow[5,2]]^2+ $
    cz[cflow[0,2]:cflow[1,2],cflow[2,2]:cflow[3,2],cflow[4,2]:cflow[5,2]]^2)
  transcur[i,0] = (AVERAGE(cx[cflow[0,0]:cflow[1,0],cflow[2,0]:cflow[3,0],cflow[4,0]:cflow[5,0]])^2+ $
    AVERAGE(cz[cflow[0,0]:cflow[1,0],cflow[2,0]:cflow[3,0],cflow[4,0]:cflow[5,0]])^2)^0.5
  transcur[i,1] = (AVERAGE(cy[cflow[0,1]:cflow[1,1],cflow[2,1]:cflow[3,1],cflow[4,1]:cflow[5,1]])^2+ $
    AVERAGE(cz[cflow[0,1]:cflow[1,1],cflow[2,1]:cflow[3,1],cflow[4,1]:cflow[5,1]])^2)^0.5
  transcur[i,2] = (AVERAGE(cy[cflow[0,2]:cflow[1,2],cflow[2,2]:cflow[3,2],cflow[4,2]:cflow[5,2]])^2+ $
    AVERAGE(cz[cflow[0,2]:cflow[1,2],cflow[2,2]:cflow[3,2],cflow[4,2]:cflow[5,2]])^2)^0.5
  

;  bxf = box.bx[]
;  bynp = box.by
;  bznp = box.bz
;  bsqunp[i] = TOTAL(bxnp^2 + bynp^2 + bznp^2)/szl[5]; b^2 = bx^2 + by^2 + bz^2
;  undefine, box
;  filep = FILE_SEARCH('D:\IDL84\def_path\out\*' + STRMID(FILE_BASENAME(files[i]), 25, 13) + '*')
;  restore,filep
;  bxp = box.bx
;  byp = box.by
;  bzp = box.bz
;  bsqup[i] = TOTAL(bxp^2 + byp^2 + bzp^2)/szl[5]
;  undefine, box
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
  ;utplot,timear,bsqunp/bsqup
  data = {timear:timear,curflow:curflow,abscurflow:abscurflow,efull:efull,epot:epot,depart:depart,radio:radio,transcur:transcur,$
    regs:regs,cflow:cflow}
  save, data, FILENAME = 'DATA_FINAL_CRIMEA19_60_LASTSEARCH_TOTAL.sav'
;save, bdift,bdifm,bdifl,timear, FILENAME='0304_09_17_NONPOTENTIALITY.sav';+FILE_BASENAME(files[i])
END
