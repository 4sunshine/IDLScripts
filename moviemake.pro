PRO movieMake
files = DIALOG_PICKFILE(TITLE = 'SELECT PNGS', FILTER = '*.png', /MULTIPLE_FILES)
sz = size(files)

ok = QUERY_PNG(files[0],s)
;dimensions = [s.dimensions[0],s.dimensions[1]]

file = 'D:\IDL84\def_path\DATA_FINAL_CRIMEA19_ERRORSEARCH_TOTAL.sav'
restore,file
timear = data.timear

video_file = 'aa_movie.mp4'
video = idlffvideowrite(video_file)
framerate = 2
framedims = [s.dimensions[0],s.dimensions[1]]
stream = video.addvideostream(framedims[0], framedims[1], framerate)
device, set_resolution=framedims, set_pixel_depth=24, decomposed=0
nframes = sz[1]
for i=0, nframes-1 do begin
  im = IMAGE(files[i],/save)
  ;shade_surf, data, charsize=2.0, az=(15 + i), /save
  ;contour, data, nlevels=10, /t3d, zval=i/float(nframes), /overplot
  ;xyouts, 0.5, 0.9, 'IDL Movie Example - DG', align=0.5, charsize=2, /normal
  timestamp = video.put(stream, tvrd(true=1))
endfor

   device, /close
   set_plot, strlowcase(!version.os_family) eq 'windows' ? 'win' : 'x'
   video.cleanup
   print, 'File "' + video_file + '" written to current directory.'

END