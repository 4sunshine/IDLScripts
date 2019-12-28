PRO data2array
files=dialog_pickfile(/MULTIPLE_FILES,$
 TITLE='Select GX boxes')
aa=size(files)
s = STRARR(aa(1))
xc = DBLARR(aa(1))
yc = DBLARR(aa(1))
for i=0,aa(1)-1 do begin
  file = files(i)
  restore, file
  s[i] = anytim(box.index.DATE_OBS,/yohkoh)
  xc[i] = (*box.refmaps).get_map_prop(0,/xc)
  yc[i] = (*box.refmaps).get_map_prop(0,/yc)
  undefine, box
endfor
save, s, xc, yc, FILENAME = 'boxesDateTime.sav'

END

