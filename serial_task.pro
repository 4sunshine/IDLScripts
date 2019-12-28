PRO serial_task
;initial_conditions
;start_time
tstart = '2017-09-03 22:00:00';'2017-09-03 22:00:00'
;end_time
tend = '2017-09-04 09:11:00'
;step_time
tstep = '00:12:00'
;initial_conditions
centre = [15.,-270.]; at 22:00
out_dir = 'D:/IDL84/def_path/out'
tmp_dir = 'D:/IDL84/def_path/temp'
dx_km=1000.
size_pix=[160,160,100]
;computing_count_of_tasks
daylong = anytim('2017-09-03 00:00:00')-anytim('2017-09-02 00:00:00')
cot = ROUND((anytim(tend)-anytim(tstart))/anytim(tstep))
print,'count_of_tasks =',cot
anytstep = anytim(tstep)
;serial_work
FOR i = 0, cot DO BEGIN
  print,'task',i+1,' of ',cot+1
  print, centre
  itime = anytim(tstart)+i*anytstep
  print,anytim(itime,/yohkoh)
  gx_box_prepare_box, itime, centre, size_pix, dx_km, out_dir = out_dir,/cea, tmp_dir = tmp_dir, /aia_euv
  ll=arcmin2hel(centre(0)/60.,centre(1)/60.,date = anytim(itime,/yohkoh,/date))
  lat = ll(0)
  lon = ll(1)
  lonn = lon + diff_rot(anytstep/daylong, lat)
  centre = ROUND(hel2arcmin(lat,lonn,date = anytim(itime,/yohkoh,/date))*60.)
ENDFOR
END