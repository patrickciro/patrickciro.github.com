.SUFFIXES:
.SUFFIXES:	.jpg .png .ico .pdf .odt .xcf

%.jpg : %.xcf
	bash ./xcf2jpg.sh $< $@

%.png : %.xcf
	xcf2png $< -o $@

%.ico : %.png
	convert $< -bordercolor white -border 0  \
	\( -clone 0 -resize 16x16 \) \
	\( -clone 0 -resize 32x32 \) \
	\( -clone 0 -resize 48x48 \) \
	\( -clone 0 -resize 64x64 \) \
	-delete 0 -alpha off -colors 256 $@

%.ico : %.xcf
	xcf2png $< | \
	    convert png:- -bordercolor white -border 0  \
	\( -clone 0 -resize 16x16 \) \
	\( -clone 0 -resize 32x32 \) \
	\( -clone 0 -resize 48x48 \) \
	\( -clone 0 -resize 64x64 \) \
	-delete 0 -alpha off -colors 256 $@

%.pdf : %.odt
	libreoffice --nologo --invisible --convert-to pdf $<

VPATH = ~/Dropbox/patrickciro
FILES := patrick-ciro-8x10.jpg \
	patrick-ciro-8x10-bleed.jpg \
    	patrick-ciro-4x6.jpg \
	patrick-ciro-4-25x6.jpg \
	patrick-ciro-thumbnail.jpg \
	patrick-ciro-alt.jpg \
	patrick-ciro-alt-thumbnail.jpg \
	#card.jpg

OBJS := ../favicon.ico $(FILES)

all:	$(OBJS)

###################################################################################
# thumbnails for website
# Headshot link (half shot)
patrick-ciro-thumbnail.jpg : patrick-ciro.jpg
	convert $< -crop 2500x3900+480+50 -density 100x100 -scale 250x390 $@

# old headshot link
patrick-ciro-alt.jpg:
	curl -o $@ http://www.patrickciro.com/pr/$(@F)

patrick-ciro-alt-thumbnail.jpg : patrick-ciro-alt.jpg
	convert $< -scale x500 -quality 80 $@

# extract contact info from 4x6 postcard for web contact info
card.jpg : patrick-ciro-4x6.pdf
	convert -density 300x300 $< -flatten miff:- |\
	    convert - -crop 795x315+50+60 -resize 400x -quality 85 $@

# favicon
../favicon.ico : favicon.ico
	cp $< $@

###################################################################################
# 8x10 Headshot
# 8x9" == 2400x2700 px and add 1" == 300 px border on bottom
#patrick-ciro-8x10.jpg : patrick-ciro.jpg patrick-ciro-caption.png
#	convert $< -crop 2400x2700+480+120 -gravity south -splice 0x300 jpg:- | \
#	    composite -gravity center patrick-ciro-caption.png -geometry +0+1290 $@

# 8x10 bleed: 8.2x9.1" == 2460x2730 px + 1.1" == 330 px border on bottom
patrick-ciro-8x10-bleed.jpg : patrick-ciro.jpg patrick-ciro-caption.png
	convert $< -crop 2246x2489+490+95 \
	    -resize 2460x2730 \
	    -gravity south -splice 0x330 +depth miff:- | \
	    composite -gravity center patrick-ciro-caption.png -geometry +0+1300 - $@

# 8x10 bleed (crop bleed by 30 each side)
patrick-ciro-8x10.jpg : patrick-ciro-8x10-bleed.jpg
	convert $< -crop 2400x3000+30+30 $@

# 4.25x6 postcard exact
patrick-ciro-4-25x6.jpg : patrick-ciro.jpg
	convert $< -crop 2720x3840+448+112 -scale 1275x1800 -rotate 90  \
	    -gravity northwest -font URW-Gothic-Book -pointsize 65 -fill white \
	    -draw "text 60,1370 'Patrick Ciro • (212) 725-7684 • www.patrickciro.com'" \
	    -rotate -90 $@

# 4x6 postcard exact
patrick-ciro-4x6.jpg : patrick-ciro.jpg
	convert $< -crop 2550x3825+510+135 -scale 1200x1800 -rotate 90  \
	    -gravity northwest -font URW-Gothic-Book -pointsize 65 -fill white \
	    -draw "text 60,1340 'Patrick Ciro • (212) 725-7684 • www.patrickciro.com'" \
	    -rotate -90 $@

###################################################################################
# obsolete
# 4.25x6 postcard x3 on 8.5x14 (pic and text)
patrick-ciro-4x6-pic-3.jpg : patrick-ciro.jpg
	convert $< -crop 2600x3868+450+92 -scale 1230x1830 \
	    \( -clone 0 -clone 0 +append -rotate 90 \) +append  -rotate -90 $@

patrick-ciro-4x6-text-3.jpg : patrick-ciro-4x6.pdf
	convert -density 300x300 \
	    $< \( -clone 0 -clone 0 -append -rotate 90 \) \
	    -reverse -gravity east -append $@

# 4x7 postcard on 8.5x14 (single)
# 8.6x13.6 == 3180x4080 px,  add 1.5" == 450 px border on bottom, then scale by 50%
patrick-ciro-4x7.jpg : patrick-ciro.jpg patrick-ciro-caption.png
	convert $< -crop 2580x3780+440+120 -gravity south -splice 0x450 -scale 50% jpg:- | \
	    composite -gravity center patrick-ciro-caption.png -geometry +0+930 jpg:- $@

# 4x7 postcard on 8.5x14
patrick-ciro-4x7-4-pic.jpg : patrick-ciro-4x7.jpg
	convert $< -duplicate 1 +append \( +clone -rotate 180 \) -append  $@

patrick-ciro-4x7-4-text.jpg : patrick-ciro-4x7.pdf
	convert -density 300x300 $< -duplicate 1 -append \( +clone -rotate 180 \) +append -rotate 90 $@
# 4x5 postcard
patrick-ciro-4x5-4-pic.jpg : patrick-ciro.jpg
	convert $< -crop 1875x2427+590+160 -scale 1275x1650 \
		-duplicate 1 +append \( +clone -rotate 180 \) -append  $@

patrick-ciro-4x5-4-text.jpg : patrick-ciro-4x5.pdf
	convert -density 300x300 -rotate 180 $< -duplicate 1 -append \( +clone -rotate 180 \) +append -rotate 90 $@

# 8x10 exact: 8x9" == 2400x2700 px + 1" == 300 px border on bottom, name 
#patrick-ciro-8x10.jpg : patrick-ciro.jpg patrick-ciro-caption.png
#	convert $< -crop 2400x2700+495+135 -gravity south -splice 0x300 +depth miff:- | \
#	    composite -gravity center patrick-ciro-caption.png -geometry +0+1310 - $@

