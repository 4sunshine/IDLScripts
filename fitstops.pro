PRO fitstops
COMMON COLORS, R_orig, G_orig, B_orig, R_curr, G_curr, B_curr ;���� ������������ �������� RGB ������ �������� (_orig) � ������� (_curr) �������� �������

loadct,0    ;���������� ���������� �������� �������
;tvlct,reverse(R_orig),reverse(G_orig),reverse(B_orig)  ;������ ������� �������� �������, ���������� �����
file=DIALOG_PICKFILE(path='C:\solarsoft\packages\gx_simulator\workdata\',FILTER=['*.fits'],$
  TITLE='Select fits file to plot')
;restore,file
fits2map,file,mapa
;restore,'E:\Morgachev\2014-10-22 R-Lbt_nlfffe [Gauss].map'

set_plot,'png'    ;������� ps ����
device, ysize=23., xsize=23,xof=0,yof=3, filename='C:\solarsoft\packages\gx_simulator\workdata\Image.png',/col ;��������� ps �����
!p.multi=[0,1,1]; ���������� �������� ���������. 1,1 - ���� ������, ���� �������
!p.thick=3.5  ;������� �����
!p.charsize=1.5 ;������ ��������
!p.charthick=3  ;������� ��������
xmar=[0,1] ;������ ������� ����� ��������� ������ � �����
ymar=[2,2] ;������ ������� ����� ��������� ������ � �����
!p.color=0  ; ������ ���� ����� �  ��������
plot_map,mapa,cbar=0,tit='Polarization,K',grid_spacing=2,xran=[30,235],yran=[-400,-230];col=255
;file=DIALOG_PICKFILE(path='C:\solarsoft\packages\gx_simulator\workdata\',FILTER=['*.sav','*.map'],$
;  TITLE='Select map file to contour 1')
;restore,file
;plot_map,map,/overlay,col=0,thick=5,c_linest=2,levels=[100.,200.,300.],c_labels=[100,200,300]
;file=DIALOG_PICKFILE(path='C:\solarsoft\packages\gx_simulator\workdata\',FILTER=['*.sav','*.map'],$
;  TITLE='Select map file to contour 2')
;restore,file
;plot_map,map,/overlay,col=255,thick=5,c_linest=1,levels=[5.,20.],c_labels=[5,20];[0.1,0.3,0.5,0.7,0.9]*max(map.data)
color_bar,mapa.data,0.1,0.9,0.97,1, /NORMAL,ticklen=-0.5;,col=255,

device,/close ;��������� ����
!p.multi=0
set_plot,'win'

END