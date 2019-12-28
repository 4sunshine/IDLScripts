;IMAGE SYNTHESIS PROGRAM SHAIN
;-------------INPUTS------------------
freq = 17 ;34 ;Observing Frequency
date = '2016-07-24'
st_time=date+' '+'06:22:00'
ed_time=date+' '+'06:22:01'
center=[962.61,104.46] ; image center
int=1; interval in seconds
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
  norh_trans, st_time, ed_time, int, rawdir=dir, freq=17 ;,/event
norh_synth, st_time, ed_time, int, $
  imgdir=imgdir, $
  cenunit=1, cenfnl=center, $
  rawdir=dir, $
  prog=program, $
  outfile='par_f'+strtrim(freq,2)+'_'+  $
  strtrim(long(systime(1) mod 86400.000),2), $
  size=128, $
  freq=freq;,/event
END