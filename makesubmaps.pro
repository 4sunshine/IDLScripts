PRO makesubmaps
;INPUTS:::::::::::::::::::::::::::::::::::::::::::::::::::::::
XRANGES = [[-11.065,55.479],[-35.837,25.849],[-11.551,59.364]];at 22:00
YRANGES = [[-270.64,-203.1],[-295.41,-273.5],[-370.21,-293.9]]
starttime = anytim('2017-09-03 22:00:00');initial_conditions_time
;::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
;files = DIALOG_PICKFILE(/MULTIPLE_FILES)
files=FILE_SEARCH('D:\IDL84\def_path\20170904\data_2017_09_04_iv\*')
sz=size(files)
szxy=size(XRANGES,/N_ELEMENTS)/2;count_of_regions
centres=findgen(szxy*2)
maxes=findgen(szxy)
lxy=findgen(szxy*2)
daylong = anytim('2017-09-03 00:00:00')-anytim('2017-09-02 00:00:00')
FOR i=0, szxy-1 DO BEGIN
  centres(2*i)=(XRANGES[2*i]+XRANGES[2*i+1])/2
  centres(2*i+1)=(YRANGES[2*i]+YRANGES[2*i+1])/2
  lxy(2*i)=(XRANGES[2*i+1]-XRANGES[2*i])/2;half_length_along x
  lxy(2*i+1)=(YRANGES[2*i+1]-YRANGES[2*i])/2;half_length_along y
ENDFOR
;OUTPUTS:::::::::::::::::::::::::::::::::::::::::::::::::::::
timear=STRARR(sz[1])
intens=FINDGEN(szxy*sz[1])
;::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
FOR i = 0, sz[1]-1 DO BEGIN
  print, 'made',FLOAT(i*1./(sz[1]-1))
  fits2map,files[i],map
  timear[i] = map.time
  itime=anytim(timear[i])
  for j = 0, szxy-1 DO BEGIN
    ll=arcmin2hel(centres(2*j)/60.,centres(2*j+1)/60.,date = anytim(itime,/yohkoh,/date))
    lat = ll(0)
    lon = ll(1)
    lonn = lon + diff_rot((itime-starttime)/daylong, lat)
    centre = ROUND(hel2arcmin(lat,lonn,date = anytim(itime,/yohkoh,/date))*60.)
    sub_map,map,smap,XRANGE = [centre(0)-lxy(2*j),centre(0)+lxy(2*j)], YRANGE = [centre(1)-lxy(2*j+1),centre(1)+lxy(2*j+1)]
    intens[i*szxy+j]=TOTAL(smap.data)
  endfor  
  undefine, map
ENDFOR
timear = anytim(timear,/yohkoh)
save,timear,intens,FILENAME='0304_09_17_REGIONS_I.sav'
;utplot,timear,intens[0:*:3]/MAX(intens[0:*:3])
;outplot,timear,intens[1:*:3]/MAX(intens[1:*:3])

END