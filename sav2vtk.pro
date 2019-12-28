pro sav2vtk
;restore,'b12297_0315_0024.sav'
;restore,'11263_0424.sav'
;restore,'b12297_0036_H.sav'
;restore,'../current/current11263.sav'
;restore,'/home/wr/data/12297/boundary2/0036_L_pre_mu4005/0036_L_pre_mu4005.sav'
;restore,'./b12192_2100.sav'
files = DIALOG_PICKFILE(TITLE = 'NLFFE BOXES SELECT', FILTER = 'NORH_DONE_NLFFFE_EXPLORE*', /MULTIPLE_FILES)
sz = size(files)

FOR m=0, sz[1]-1 DO BEGIN

  restore, files[m]
  print,'task',m+1,' of',sz[1]
;restore,'hmi.B_720s.20170903_230000_TAI._NLFFFE.sav'

;stop

;dim=size(b3dz)
  dim=size(box.bx)

;curl, box.bx, box.by, box.bz, cx, cy, cz

;dim=size(jz)
  nx=dim(1)
  ny=dim(2)
  nz=dim(3)

  openw,lun,FILE_BASENAME(files[m], '.sav') + '.vtk',/get_lun
  printf,lun,'# vtk DataFile Version 2.0'
  printf,lun,'Vector magnetic field B';'Curl of magnetic field';'Vector magnetic field b'  
  printf,lun,'ASCII'
  printf,lun,'DATASET STRUCTURED_POINTS'
  printf,lun,'DIMENSIONS',nx,ny,nz
  printf,lun,'ORIGIN', 0.000, 0.000, 0.000
  printf,lun,'SPACING', 1.000, 1.000, 1.000
  printf,lun,'POINT_DATA', nx*ny*nz
  printf,lun,'VECTORS Bpot float';vector
  for k=0, nz-1 do begin 
    for j=0, ny-1 do begin 
      for i=0, nx-1 do begin
;printf,lun,bxp(i,j,k),byp(i,j,k),bzp(i,j,k)
;printf,lun,cx(i,j,k),cy(i,j,k),cz(i,j,k)
        printf,lun,box.bx(i,j,k),box.by(i,j,k),box.bz(i,j,k)
;printf,lun,b3dx(i,j,k),b3dy(i,j,k),b3dz(i,j,k)
;printf,lun,jx(i,j,k),jy(i,j,k),jz(i,j,k)
      endfor
    endfor 
  endfor
  free_lun,lun
  undefine, box
ENDFOR
end




