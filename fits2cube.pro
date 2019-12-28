;;;;ALL DATA SHOULD HAVE THE SAME 2D SIZE;;;;

PRO fits2cube
files = dialog_pickfile(/MULTIPLE_FILES,$
    filter=['*.fits','*.fts','*.fit','ipa*'],TITLE='Select FITS files to make dataCube')
aa = size(files)
mreadfits, files[0], header, data
times = STRARR(aa(1))
dataa = FLTARR(header.NAXIS1, header.NAXIS2, aa(1))
datas = FLTARR(header.NAXIS1, header.NAXIS2, aa(1))
FOR i=0,aa(1)-1 DO BEGIN
  mreadfits, files[i], header, data
  dataa[*,*,i] = data[*,*]
  undefine, data, header
  sfile = FILE_BASENAME(files[i]) ; SFILE IS A FILE CONTAINING STOCKES V PARAMETER DATA
  dirname = FILE_DIRNAME(files[i])
  STRPUT, sfile, 's', 2
  sfile = dirname + '\' + sfile
  mreadfits, sfile, header, data
  datas[*,*,i] = data[*,*]
  times[i] = anytim(header.DATE_OBS,/hxrbs)
  undefine, data, header  
ENDFOR
save, dataa, datas, times, FILENAME = 'datacube17GHz_gxboxestime.sav'
END