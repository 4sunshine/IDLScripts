PRO FOR20120710
  datef = '20120710'
  norht = '120710_050107'
  out_dir = 'D:/IDL84/def_path/out'
  tmp_dir = 'D:/IDL84/def_path/temp'
  centre=[-496.,-319.]
  dx_km=750.
  size_pix=[256,256,200]
  aiaf = 'D:\IDL84\def_path\temp\2012-07-10\aia.lev1_euv_12s.2012-07-10T050101Z.image.'
  folder = 'D:\IDL84\def_path\temp\2012-07-10\hmi.B_720s.20120710_050000_TAI.'
  box = gx_box_create(folder+'field.fits', folder+'inclination.fits', folder+'azimuth.fits',folder+'disambig.fits',$
    'D:\IDL84\def_path\temp\2012-07-10\hmi.Ic_noLimbDark_720s.20120710_050000_TAI.continuum.fits',$
     centre, size_pix, dx_km,/cea)
  gx_box_add_refmap, box, 'D:\IDL84\def_path\temp\2012-07-10\hmi.Ic_noLimbDark_720s.20120710_050000_TAI.continuum.fits', id = 'Continuum'
  gx_box_add_refmap, box, 'D:\IDL84\def_path\temp\2012-07-10\hmi.M_720s.20120710_050000_TAI.magnetogram.fits', id = 'LOS_magnetogram'
  gx_box_add_refmap, box, aiaf+'94.fits',  id = 'AIA_94'
  gx_box_add_refmap, box, aiaf+'131.fits', id = 'AIA_131'
  gx_box_add_refmap, box, aiaf+'171.fits', id = 'AIA_171'
  gx_box_add_refmap, box, aiaf+'193.fits', id = 'AIA_193'
  gx_box_add_refmap, box, aiaf+'211.fits', id = 'AIA_211'
  gx_box_add_refmap, box, aiaf+'304.fits', id = 'AIA_304'
  gx_box_add_refmap, box, aiaf+'335.fits', id = 'AIA_335'
  gx_box_add_refmap_norh,box,'D:\IDL84\def_path\'+datef+'\ipa'+norht+'.fits',id = '17 GHz (R+L), K'
  gx_box_add_refmap_norh,box,'D:\IDL84\def_path\'+datef+'\ips'+norht+'.fits',id = '17 GHz (R-L), K'
  gx_box_add_refmap_norh,box,'D:\IDL84\def_path\'+datef+'\ipz'+norht+'.fits',id = '34 GHz (R+L), K'
  gx_box_make_potential_field, box
  save,box,FILENAME=box.id.substring(11,18)+'_POT.sav'
  return_code = gx_box_make_nlfff_wwas_field("D:\ssw\packages\gx_simulator\gxbox\WWNLFFFReconstruction.dll", box)
  save,box,FILENAME=box.id.substring(11,18)+'_NLFFFE_MANUAL.sav'
END