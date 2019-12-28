;NOBEYAMA RENAMER
file=dialog_pickfile(path='C:\solarsoft\packages\gx_simulator\workdata\');filter='*.fits'
;file='C:\solarsoft\packages\gx_simulator\workdata\2014-10-22 W\ipa141022_051435.fits'
mreadfits_header, file, index
mreadfits,file,index,data
help,index
index.origin='NoRH'+'_'+index.OBS_D$FREQ+'_'+index.polariz+'_'
fnadd=index.date_obs
fnadd=fnadd.replace(':',' ')
fnadd=fnadd.replace('\',' ')
fnadd=fnadd.replace('.',' ')
fnadd=fnadd.replace('-',' ')
fnadd=fnadd.compress()
fnadd=fnadd.remove(-3)
mwritefits,index,data,outfile=file_dirname(file)+'\'+index.origin+fnadd+'.fits'
END