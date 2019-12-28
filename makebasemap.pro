PRO MAKE2DVTK, data, filename, id
  dim=size(data)

  ;curl, box.bx, box.by, box.bz, cx, cy, cz

  ;dim=size(jz)
  nx=dim(1)
  ny=dim(2)
  ntot = nx*ny
  openw,lun, filename,/get_lun
  printf,lun,'# vtk DataFile Version 2.0'
  printf,lun, id 
  printf,lun,'ASCII'
  printf,lun,'DATASET STRUCTURED_POINTS'
  printf,lun,'DIMENSIONS',nx,ny,1
  printf,lun,'ORIGIN', 0.000, 0.000, 0.000
  printf,lun,'SPACING', 1.000, 1.000, 1.000
  printf,lun,'POINT_DATA', ntot
  printf,lun,'SCALARS variable float'
  printf,lun,'LOOKUP_TABLE default'


  for j=0, ny-1 do begin
    for i=0, nx-1 do begin
      printf,lun,FLOAT(data(i,j))
    endfor
  endfor
  free_lun,lun
  undefine,lun

END

PRO makeBaseMap
;PROGRAM TO MAKE MAP WHICH HAVE THE SIZE OF THE BOTTOM OF THE GXBOX
files = DIALOG_PICKFILE(TITLE = 'SELECT BOXES TO MAKE MAPS', FILTER = '*.sav', /MULTIPLE_FILES)
szz = size(files)

; c speed of light in CGS units

c = 3.E10
dx_km = 1000.

;r_sun = 6.96d10 ; cm, SOLAR RADIUS ANFINOGENTOV GXBOX
setenv, 'WCS_RSUN=6.96d8'
newdir = 'BASEMAPS'
;file = DIALOG_PICKFILE(FILTER = '*NLFFFE.SAV')
FILE_MKDIR, newdir
FOR i=0, szz[1]-1 DO BEGIN
  print, 'task', i+1, 'of', szz[1]
  restore, files[i]
  sz = size(box.bx) ; temporary variable
  size_pix = sz[1:3]
  maps = *box.refmaps
  nmaps = N_ELEMENTS(maps.getlist())
  dirname = FILE_DIRNAME(files[i])
  
  IF nmaps ge 0 THEN BEGIN
    firstmap = maps.getmap(0)
    center = [firstmap.xc, firstmap.yc]
    FOR j = 0, nmaps-1 DO BEGIN
      cur_map = maps.getmap(j)
      data = cur_map.data
      map2wcs, cur_map, wcs0
      wcs2map,data, wcs0, map
      map2wcs, map, wcs0
      wcs_convert_from_coord,wcs0,center,'HG', lon, lat, /carrington
      DSUN_OBS  = wcs0.position.dsun_obs;
      dx_arcsec = dx_km*1d3 / (DSUN_OBS - wcs_rsun() ) * 180d/!dpi * 3600d
      WCS = WCS_2D_SIMULATE(size_pix[0], size_pix[1], CDELT=dx_arcsec, DSUN_OBS=DSUN_OBS ,$
        CRLN_OBS=lon, CRLT_OBS=lat, date_obs = cur_map.time);date_obs = index[0].date_obs)
      loc_base = wcs_remap(data, wcs0, wcs, /ssaa)
      ;help, loc_base
      mapw = make_map(loc_base)
      save,mapw,FILENAME = dirname +'\'+ newdir +'\'+ cur_map.id + FILE_BASENAME(files[i],'.sav') + '.sav'
      vtkname = dirname +'\'+ newdir +'\'+ cur_map.id + FILE_BASENAME(files[i],'.sav') + '.vtk'
      MAKE2DVTK,loc_base, vtkname, cur_map.id
    ENDFOR
  ENDIF
;  center = [15.,-270.]
  
;  dx_km = 1000.
;  DSUN_OBS  = wcs0.position.dsun_obs;
;  dx_arcsec = dx_km*1d3 / (DSUN_OBS - wcs_rsun() ) * 180d/!dpi * 3600d
;  ;read_sdo, file, index, data,/uncomp_delete
;  wcs0 = FITSHEAD2WCS(index[0])
;  wcs2map,data, wcs0, map
;  map2wcs, map, wcs0
;  
;  wcs_convert_from_coord,wcs0,center,'HG', lon, lat, /carrington
;  WCS = WCS_2D_SIMULATE(size_pix[0], size_pix[1], CDELT=dx_arcsec, DSUN_OBS=DSUN_OBS ,$
;    CRLN_OBS=lon, CRLT_OBS=lat, date_obs = index[0].date_obs)
;  ic = wcs_remap(data, wcs0, wcs, /ssaa)
;  
  undefine, box
ENDFOR

END