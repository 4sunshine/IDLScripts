;IMAGE SYNTHESIS PROGRAM SHAIN
;-------------INPUTS------------------
freq =34;17 ;Observing Frequency
date = '2015-03-11'
st_time=date+' '+'00:00:00'
ed_time=date+' '+'00:15:00'
center=[-437.,-155.] ; image center
int=600; interval in seconds
;-------------------------------------
root = '/nfs/home/AlexanderShain/data/'
;root = '/nfs/scr03/shain/'
dir=root+date
imgdir=dir
if freq eq 34 then program='hanaoka' else program='fujiki'
spawn, 'mkdir '+root+date
if freq eq 34 then $
norh_trans, st_time, ed_time, int, rawdir=dir, freq=34 ;,/event
if freq eq 17 then $
norh_trans, st_time, ed_time, int, rawdir=dir ;,/event
norh_synth, st_time, ed_time, int, $
imgdir=imgdir, $
cenunit=1, cenfnl=center, $
rawdir=dir, $
prog=program, $
outfile='par_f'+strtrim(frequency,2)+'_'+  $
    strtrim(long(systime(1) mod 86400.000),2), $
size=128, $
freq=freq
END