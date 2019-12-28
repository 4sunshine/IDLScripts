PRO MAKE2DVTK, data, filename, id
  dim=size(data)

  ;curl, box.bx, box.by, box.bz, cx, cy, cz

  ;dim=size(jz)
  nx=dim(1)
  ny=dim(2)
  nz=dim(3)
  ntot = nx*ny*nz
  openw,lun, filename,/get_lun
  printf,lun,'# vtk DataFile Version 2.0'
  printf,lun, id
  printf,lun,'ASCII'
  printf,lun,'DATASET STRUCTURED_POINTS'
  printf,lun,'DIMENSIONS',nx,ny,nz
  printf,lun,'ORIGIN', 0.000, 0.000, 0.000
  printf,lun,'SPACING', 1.000, 1.000, 1.000
  printf,lun,'POINT_DATA', ntot
  printf,lun,'SCALARS jB_angle float'
  printf,lun,'LOOKUP_TABLE default'

  for k=0, nz-1 do begin
    for j=0, ny-1 do begin
      for i=0, nx-1 do begin
        printf,lun,FLOAT(data(i,j,k))
      endfor
    endfor
  endfor
  free_lun,lun
  undefine,lun

END


PRO makeJBAngles
  filesB = DIALOG_PICKFILE(TITLE = 'NLFFE BOXES SELECT', FILTER = 'NORH_DONE_NLFFFE_EXPLORE*', /MULTIPLE_FILES)
  sz = size(filesB)
  dirname = FILE_DIRNAME(filesB[0])
  filesJ = dirname+'\CURL_'+FILE_BASENAME(filesB)

  FOR i=0,sz[1]-1 DO BEGIN
    print, 'task',i+1,'of',sz[1]
    restore,filesB[i]
    bx = box.bx
    by = box.by
    bz = box.bz
    undefine,box
    restore,filesJ[i]
    jx = box.bx
    jy = box.by
    jz = box.bz
    undefine,box
    normb = (bx^2 + by^2 + bz^2)^0.5
    normj = (jx^2 + jy^2 + jz^2)^0.5
    maxb = MAX(normb)
    maxj = MAX(normj)
    cutb = 0.01*maxb ; CUTTING PARAMETER: ALL VALUES UNDER 1% OF MAX VALUE IGNORED
    cutj = 0.01*maxj ;
    ;indexb = WHERE(normb LT cutb, countb)
    ;indexj = WHERE(normj LT cutj, countj)
    ;ind = INTERSECT()
    bs = size(normb)
    jb = ACOS((bx*jx + by*jy + bz*jz)/normb/normj)*180./!pi
    ;jb = FLTARR(bsize[1],bsize[2],bsize[3])
    for k = 0, bs[1]-1 do begin
      for l = 0, bs[2]-1 do begin
        for m = 0, bs[3]-1 do begin
          if ( (normb[k,l,m] LT cutb) || (normj[k,l,m] LT cutj) ) then begin
            jb[k,l,m] = 0.0
            endif
        endfor
      endfor
    endfor
    
    ;normb[WHERE(normb LT cutb, /NULL)] = 0
    ;jb = ACOS((bx*jx + by*jy + bz*jz)/normb/normj)*180./!pi
    print,MEAN(jb)
    print,MAX(jb)
    vtkname = dirname +'\JBANGLE_'+ FILE_BASENAME(filesB[i],'.sav') + '.vtk'
    MAKE2DVTK, jb, vtkname, 'JBANGLE_OR1_'
    undefine,normb,normj,maxb,maxj,cutb,cutj,index,jb
  ENDFOR
  

END