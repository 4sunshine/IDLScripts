PRO timePlot
file = 'D:\IDL84\def_path\DATA_FINAL_CRIMEA19_ERRORSEARCH_TOTAL.sav'
restore,file
timear = data.timear
depart = data.depart[*,1]
;DEVICE,file = '1try.png'
;utplot,timear,depart
;DEVICE,/CLOSE
;SET_PLOT,mydevice
; The NAME field of the !D system variable contains the name of the
; current plotting device.
mydevice = !D.NAME
; Set plotting to PostScript:
SET_PLOT, 'PS'

; Use DEVICE to set some PostScript device options:
DEVICE, FILENAME='myfile1.ps'
; Make a simple plot to the PostScript file:
utplot, timear,depart
; Close the PostScript file:
DEVICE, /CLOSE
; Return plotting to the original device:
SET_PLOT, mydevice


END