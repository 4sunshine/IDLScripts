out_dir = 'D:/IDL84/def_path/out'
tmp_dir = 'D:/IDL84/def_path/temp';1111
dx_km=750.
size_pix=[200,240,100]
;timef='2012-01-23 03:50:40'
;timef='2013-10-28 02:00:51'
;timef='2011-09-25 02:46:57'
timef='2017-09-03 22:30:00'
centre=[15.,-270.];//-260 was
gx_box_prepare_box, timef, centre, size_pix, dx_km, out_dir = out_dir,/cea, tmp_dir = tmp_dir, /aia_euv
;--------------------------
timef='2017-09-03 23:00:00'
;centre=[-496.,-319.]
gx_box_prepare_box, timef, centre, size_pix, dx_km, out_dir = out_dir,/cea, tmp_dir = tmp_dir, /aia_euv
;--------------------------
timef='2017-09-03 23:30:00'
;centre=[-437.,-147.]
gx_box_prepare_box, timef, centre, size_pix, dx_km, out_dir = out_dir,/cea, tmp_dir = tmp_dir, /aia_euv
;--------------------------
timef='2017-09-04 00:00:00'
;centre=[447.,-300.]
gx_box_prepare_box, timef, centre, size_pix, dx_km, out_dir = out_dir,/cea, tmp_dir = tmp_dir, /aia_euv
;--------------------------
timef='2017-09-04 00:30:00'
;centre=[-653.,275.]
gx_box_prepare_box, timef, centre, size_pix, dx_km, out_dir = out_dir,/cea, tmp_dir = tmp_dir, /aia_euv
;--------------------------
timef='2017-09-04 01:00:00'
;centre=[781.,246.]
gx_box_prepare_box, timef, centre, size_pix, dx_km, out_dir = out_dir,/cea, tmp_dir = tmp_dir, /aia_euv
;--------------------------
timef='2017-09-04 01:30:00'
;centre=[521.,-172.]
gx_box_prepare_box, timef, centre, size_pix, dx_km, out_dir = out_dir,/cea, tmp_dir = tmp_dir, /aia_euv

timef='2017-09-04 02:00:00'
;centre=[521.,-172.]
gx_box_prepare_box, timef, centre, size_pix, dx_km, out_dir = out_dir,/cea, tmp_dir = tmp_dir, /aia_euv

timef='2017-09-04 02:30:00'
;centre=[521.,-172.]
gx_box_prepare_box, timef, centre, size_pix, dx_km, out_dir = out_dir,/cea, tmp_dir = tmp_dir, /aia_euv

timef='2017-09-04 03:00:00'
;centre=[521.,-172.]
gx_box_prepare_box, timef, centre, size_pix, dx_km, out_dir = out_dir,/cea, tmp_dir = tmp_dir, /aia_euv

timef='2017-09-04 03:30:00'
;centre=[521.,-172.]
gx_box_prepare_box, timef, centre, size_pix, dx_km, out_dir = out_dir,/cea, tmp_dir = tmp_dir, /aia_euv

timef='2017-09-04 04:00:00'
;centre=[521.,-172.]
gx_box_prepare_box, timef, centre, size_pix, dx_km, out_dir = out_dir,/cea, tmp_dir = tmp_dir, /aia_euv

timef='2017-09-04 04:30:00'
;centre=[521.,-172.]
gx_box_prepare_box, timef, centre, size_pix, dx_km, out_dir = out_dir,/cea, tmp_dir = tmp_dir, /aia_euv

timef='2017-09-04 05:00:00'
;centre=[521.,-172.]
gx_box_prepare_box, timef, centre, size_pix, dx_km, out_dir = out_dir,/cea, tmp_dir = tmp_dir, /aia_euv
END