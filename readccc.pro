file = 'ribbon_catalog.csv'
data = READ_CSV(file, HEADER = headerr)
print,headerr
help,data,/STRUCT
print,size(data.FIELD5)
;res = WEBGET('ftp://solar-pub.mtk.nao.ac.jp/pub/nsro/norh/images/event/20131028_0438/ipz131028_043800')
files = 'ips131028_043800'
READ_FTP,'solar-pub.mtk.nao.ac.jp',files,'pub/nsro/norh/images/event/20131028_0438',/FILE,DATA=data
;print,res
;OPENW,1,'norhhh.fits'
;WRITEU,1,res
;CLOSE,1
help,data
END