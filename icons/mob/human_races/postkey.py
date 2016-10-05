import sys
from PIL import Image, PngImagePlugin

name = sys.argv[1]
try:
	n_name = sys.argv[2]
except:
	n_name = "output"

im = Image.open(name)
property = 'Description'
try:
	info = im.info[property]
except:
	info = ""

info = info.replace('_0','').replace('0"','"').replace('_1"','_slim"').replace('1"','_slim"')

if(name.find('.png') != -1):
	im.save("%s.png" %n_name, "PNG")
else:
	meta = PngImagePlugin.PngInfo()
	meta.add_text(property, info, 0)
	im.save("%s.dmi" %n_name, "PNG", pnginfo=meta)
