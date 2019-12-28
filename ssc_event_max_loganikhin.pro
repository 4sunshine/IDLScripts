;LOGANIHIN
PRO SSC_WIDGET
  ssc_base = WIDGET_BASE(/GRID_LAYOUT,/COLUMN)
  ssc_base_datafields = WIDGET_BASE(ssc_base,/ROW)
  ssc_base_buttons = WIDGET_BASE(ssc_base,/COLUMN)
  ssc_base_wtext = WIDGET_BASE(ssc_base,/ROW)
  ssc_wtext = WIDGET_TEXT(ssc_base_wtext,UVALUE='txtfield',/SCROLL,XSIZE=40,YSIZE=4)
  ssc_wtext_t0 = WIDGET_TEXT(ssc_base_datafields,UVALUE='T0FIELD',/EDITABLE,XSIZE=10)
  ssc_wtext_t1 = WIDGET_TEXT(ssc_base_datafields,UVALUE='T1FIELD',/EDITABLE,XSIZE=10)
  ssc_wtext_gclass = WIDGET_TEXT(ssc_base_datafields,UVALUE="GCLASS_FIELD",/EDITABLE,XSIZE=5)
  ssc_wbutton_get_data = WIDGET_BUTTON(ssc_base_buttons,VALUE='Get flare data',UVALUE='FDATA_B')
  ssc_wbutton_exit = WIDGET_BUTTON(ssc_base_buttons,VALUE='Exit',UVALUE='EXIT')
  WIDGET_CONTROL,ssc_base,SET_UVALUE=[ssc_wtext,ssc_wtext_t0,ssc_wtext_t1,ssc_wtext_gclass]
  WIDGET_CONTROL,ssc_base,/REALIZE,BASE_SET_TITLE='SSC'
  XMANAGER,'SSC',ssc_base,/NO_BLOCK
END

PRO DATA_FDISP,text_field
  WIDGET_CONTROL,text_field[1],GET_VALUE=t0
  WIDGET_CONTROL,text_field[2],GET_VALUE=t1
  WIDGET_CONTROL,text_field[3],GET_VALUE=sclass
  data = get_flares_by_date(t0,t1,sclass)
  data_str = ''
  cnt = 1;
  FOREACH flare, data.fl DO BEGIN
    data_str += STRTRIM(STRING(cnt),1)+': '+ flare.EVENT_PEAKTIME + ', ' + flare.FL_GOESCLS + '-class flare;' + string(13B) + string(10B)
    cnt++;
  ENDFOREACH
  WIDGET_CONTROL,text_field[0],SET_VALUE=data_str
END

PRO SSC_EVENT,event
  WIDGET_CONTROL, event.ID, get_uvalue=uval
  CASE uval OF
    'FDATA_B' : BEGIN
      WIDGET_CONTROL,event.TOP,get_uvalue=te
      DATA_FDISP,te
      END
    'EXIT' : WIDGET_CONTROL,event.TOP, /DESTROY
  ENDCASE
END