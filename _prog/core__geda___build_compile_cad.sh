_geda_compile_layers_cad() {
	_messageNormal "Compile: CAD"
	cd "$se_in_tmp"
	
	#"$intermediate_layers"/"$currentInput_name"
	
	local currentDPI
	#currentDPI="1200"
	currentDPI="1270"
	
	# DANGER: Although some SVG file inputs default to 72dpi or 96dpi, this is not explicit and must not be depended upon. Always verify imported SVG dimensions!
	local currentDPI_svg
	#currentDPI_svg=96
	currentDPI_svg=72
	
	#"$currentSpecific_work_cad"/
	local currentSpecific_work_cad
	currentSpecific_work_cad="$safeTmp"/_specific/cad/"$currentInput_name"
	mkdir -p "$currentSpecific_work_cad"
	
	echo "$currentDPI"x"$currentDPI" > "$currentSpecific_work_cad"/dpi.txt
	
	
	gerbv --units=mil -D"$currentDPI_svg"x"$currentDPI_svg" -b \#FFFFFF --export svg --output "$currentSpecific_work_cad"/dimension_top_copper.svg "$intermediate_layers"/"$currentInput_name".topsilk.gbr "$intermediate_layers"/"$currentInput_name".plated-drill.cnc "$intermediate_layers"/"$currentInput_name".topmask.gbr "$intermediate_layers"/"$currentInput_name".outline.gbr "$intermediate_layers"/"$currentInput_name".top.gbr
	
	gerbv --units=mil -D"$currentDPI_svg"x"$currentDPI_svg" -b \#FFFFFF --export svg --output "$currentSpecific_work_cad"/dimension_top.svg "$intermediate_layers"/"$currentInput_name".topsilk.gbr "$intermediate_layers"/"$currentInput_name".plated-drill.cnc "$intermediate_layers"/"$currentInput_name".topmask.gbr "$intermediate_layers"/"$currentInput_name".outline.gbr
	
	
	gerbv --units=mil -D"$currentDPI_svg"x"$currentDPI_svg" -b \#FFFFFF --export svg --output "$currentSpecific_work_cad"/dimension_bottom_copper.svg "$intermediate_layers"/"$currentInput_name".bottomsilk.gbr "$intermediate_layers"/"$currentInput_name".plated-drill.cnc "$intermediate_layers"/"$currentInput_name".bottommask.gbr "$intermediate_layers"/"$currentInput_name".outline.gbr "$intermediate_layers"/"$currentInput_name".bottom.gbr
	
	gerbv --units=mil -D"$currentDPI_svg"x"$currentDPI_svg" -b \#FFFFFF --export svg --output "$currentSpecific_work_cad"/dimension_bottom.svg "$intermediate_layers"/"$currentInput_name".bottomsilk.gbr "$intermediate_layers"/"$currentInput_name".plated-drill.cnc "$intermediate_layers"/"$currentInput_name".bottommask.gbr "$intermediate_layers"/"$currentInput_name".outline.gbr
	
	
	
	
	
	gerbv --units=mil -D"$currentDPI_svg"x"$currentDPI_svg" -b \#FFFFFF --export svg --output "$currentSpecific_work_cad"/combined.svg "$intermediate_layers"/"$currentInput_name".plated-drill.cnc "$intermediate_layers"/"$currentInput_name".outline.gbr
	
	#Inches. Circles will be approximate
	#inkscape --export-dpi="$currentDPI_svg" -E "$currentSpecific_work_cad"/combined_direct.dxf "$currentSpecific_work_cad"/combined.svg
	#inkscape --export-dpi="$currentDPI_svg" -E "$currentSpecific_work_cad"/combined.eps "$currentSpecific_work_cad"/combined.svg
	convert -units PixelsPerInch -density "$currentDPI_svg"x"$currentDPI_svg" "$currentSpecific_work_cad"/combined.svg "$currentSpecific_work_cad"/combined.eps
	
	
	# CAUTION: DXF export is considered unreliable. Prefer SVG.
	pstoedit -psarg '-r'"$currentDPI_svg"x"$currentDPI_svg" -dt -f dxf "$currentSpecific_work_cad"/combined.eps "$currentSpecific_work_cad"/combined.dxf
	
	
	
	gerbv --units=mil -D"$currentDPI"x"$currentDPI" -b \#cccccc --export png --dpi "$currentDPI"x"$currentDPI" --output "$currentSpecific_work_cad"/Top_Copper.png -f \#00000000 -b \#cccccc "$intermediate_layers"/"$currentInput_name".topmask.gbr -f \#ccccccFF "$intermediate_layers"/"$currentInput_name".plated-drill.cnc -f \#B18883FF "$intermediate_layers"/"$currentInput_name".top.gbr -f \#FFFFFFFF "$intermediate_layers"/"$currentInput_name".topsilk.gbr -f \#000000FF "$intermediate_layers"/"$currentInput_name".outline.gbr
	gerbv --units=mil -D"$currentDPI"x"$currentDPI" -b \#cccccc --export png --dpi "$currentDPI"x"$currentDPI" --output "$currentSpecific_work_cad"/Top_Mask.png -f \#ccccccFF -b \#102c10 "$intermediate_layers"/"$currentInput_name".topmask.gbr -f \#00000000 "$intermediate_layers"/"$currentInput_name".plated-drill.cnc -f \#00000000 "$intermediate_layers"/"$currentInput_name".top.gbr -f \#FFFFFFFF "$intermediate_layers"/"$currentInput_name".topsilk.gbr -f \#ccccccFF "$intermediate_layers"/"$currentInput_name".outline.gbr
	gerbv --units=mil -D"$currentDPI"x"$currentDPI" -a -b \#FFFFFF --export png --dpi "$currentDPI"x"$currentDPI" --output "$currentSpecific_work_cad"/Top_Outline.png -f \#00000000 "$intermediate_layers"/"$currentInput_name".topmask.gbr -f \#00000000 "$intermediate_layers"/"$currentInput_name".plated-drill.cnc -f \#00000000 "$intermediate_layers"/"$currentInput_name".top.gbr -f \#00000000 "$intermediate_layers"/"$currentInput_name".topsilk.gbr -f \#000000FF "$intermediate_layers"/"$currentInput_name".outline.gbr
	_imagemagick_limit_command convert -units PixelsPerInch -density "$currentDPI"x"$currentDPI" "$currentSpecific_work_cad"/Top_Copper.png -transparent \#cccccc "$currentSpecific_work_cad"/Top_Copper.png
	_imagemagick_limit_command convert -units PixelsPerInch -density "$currentDPI"x"$currentDPI" "$currentSpecific_work_cad"/Top_Mask.png -transparent \#cccccc "$currentSpecific_work_cad"/Top_Mask.png
	_imagemagick_limit_command convert -units PixelsPerInch -density "$currentDPI"x"$currentDPI" "$currentSpecific_work_cad"/Top_Outline.png -transparent \#cccccc "$currentSpecific_work_cad"/Top_Outline.png
	
	_imagemagick_limit_command convert -units PixelsPerInch -density "$currentDPI"x"$currentDPI" "$currentSpecific_work_cad"/Top_Outline.png -bordercolor white -border 1x1 -alpha set -channel RGBA -fuzz 10% -fill none -floodfill +0+0 white -shave 1x1 "$currentSpecific_work_cad"/Top_Outline.png
	_imagemagick_limit_command convert -units PixelsPerInch -density "$currentDPI"x"$currentDPI" "$currentSpecific_work_cad"/Top_Outline.png -fuzz 100% -fill \#0a1a0a -opaque white "$currentSpecific_work_cad"/Top_BG.png
	_imagemagick_limit_command convert -units PixelsPerInch -density "$currentDPI"x"$currentDPI" "$currentSpecific_work_cad"/Top_Outline.png -channel a -negate +channel -fill \#cccccc -colorize 100% "$currentSpecific_work_cad"/Top_Outline.png
	
	_imagemagick_limit_command convert -units PixelsPerInch -density "$currentDPI"x"$currentDPI" "$currentSpecific_work_cad"/Top_Mask.png -channel rgba -matte -fill "rgba(16,44,16,0.8)" -opaque \#102c10 "$currentSpecific_work_cad"/Top_Mask.png
	
	_imagemagick_limit_command composite -units PixelsPerInch -density "$currentDPI"x"$currentDPI" "$currentSpecific_work_cad"/Top_Outline.png "$currentSpecific_work_cad"/Top_Mask.png "$currentSpecific_work_cad"/Top_Mask_Real.png
	_imagemagick_limit_command convert -units PixelsPerInch -density "$currentDPI"x"$currentDPI" "$currentSpecific_work_cad"/Top_Mask_Real.png -transparent \#cccccc "$currentSpecific_work_cad"/Top_Mask_Real.png
	
	_imagemagick_limit_command composite -units PixelsPerInch -density "$currentDPI"x"$currentDPI" "$currentSpecific_work_cad"/Top_Mask_Real.png "$currentSpecific_work_cad"/Top_Copper.png "$currentSpecific_work_cad"/Top_All.png
	_imagemagick_limit_command composite -units PixelsPerInch -density "$currentDPI"x"$currentDPI" "$currentSpecific_work_cad"/Top_All.png "$currentSpecific_work_cad"/Top_BG.png "$currentSpecific_work_cad"/Top.png
	
	_imagemagick_limit_command convert -units PixelsPerInch -density "$currentDPI"x"$currentDPI" "$currentSpecific_work_cad"/Top.png -background "#cccccc" -flatten "$currentSpecific_work_cad"/Top.png
	
	mv "$currentSpecific_work_cad"/Top.png "$currentSpecific_work_cad"/RenderTop.png
	#rm "$currentSpecific_work_cad"/Top*.png
	
	
	
	
	gerbv --units=mil -D"$currentDPI"x"$currentDPI" -b \#cccccc --export png --dpi "$currentDPI"x"$currentDPI" --output "$currentSpecific_work_cad"/Bottom_Copper.png -f \#00000000 -b \#cccccc "$intermediate_layers"/"$currentInput_name".bottommask.gbr -f \#ccccccFF "$intermediate_layers"/"$currentInput_name".plated-drill.cnc -f \#B18883FF "$intermediate_layers"/"$currentInput_name".bottom.gbr -f \#FFFFFFFF "$intermediate_layers"/"$currentInput_name".bottomsilk.gbr -f \#000000FF "$intermediate_layers"/"$currentInput_name".outline.gbr
	gerbv --units=mil -D"$currentDPI"x"$currentDPI" -b \#cccccc --export png --dpi "$currentDPI"x"$currentDPI" --output "$currentSpecific_work_cad"/Bottom_Mask.png -f \#ccccccFF -b \#102c10 "$intermediate_layers"/"$currentInput_name".bottommask.gbr -f \#00000000 "$intermediate_layers"/"$currentInput_name".plated-drill.cnc -f \#00000000 "$intermediate_layers"/"$currentInput_name".bottom.gbr -f \#FFFFFFFF "$intermediate_layers"/"$currentInput_name".bottomsilk.gbr -f \#ccccccFF "$intermediate_layers"/"$currentInput_name".outline.gbr
	gerbv --units=mil -D"$currentDPI"x"$currentDPI" -a -b \#FFFFFF --export png --dpi "$currentDPI"x"$currentDPI" --output "$currentSpecific_work_cad"/Bottom_Outline.png -f \#00000000 "$intermediate_layers"/"$currentInput_name".bottommask.gbr -f \#00000000 "$intermediate_layers"/"$currentInput_name".plated-drill.cnc -f \#00000000 "$intermediate_layers"/"$currentInput_name".bottom.gbr -f \#00000000 "$intermediate_layers"/"$currentInput_name".bottomsilk.gbr -f \#000000FF "$intermediate_layers"/"$currentInput_name".outline.gbr
	_imagemagick_limit_command convert -units PixelsPerInch -density "$currentDPI"x"$currentDPI" "$currentSpecific_work_cad"/Bottom_Copper.png +flop -transparent \#cccccc "$currentSpecific_work_cad"/Bottom_Copper.png
	_imagemagick_limit_command convert -units PixelsPerInch -density "$currentDPI"x"$currentDPI" "$currentSpecific_work_cad"/Bottom_Mask.png +flop -transparent \#cccccc "$currentSpecific_work_cad"/Bottom_Mask.png
	_imagemagick_limit_command convert -units PixelsPerInch -density "$currentDPI"x"$currentDPI" "$currentSpecific_work_cad"/Bottom_Outline.png +flop -transparent \#cccccc "$currentSpecific_work_cad"/Bottom_Outline.png
	
	_imagemagick_limit_command convert -units PixelsPerInch -density "$currentDPI"x"$currentDPI" "$currentSpecific_work_cad"/Bottom_Outline.png -bordercolor white -border 1x1 -alpha set -channel RGBA -fuzz 10% -fill none -floodfill +0+0 white -shave 1x1 "$currentSpecific_work_cad"/Bottom_Outline.png
	_imagemagick_limit_command convert -units PixelsPerInch -density "$currentDPI"x"$currentDPI" "$currentSpecific_work_cad"/Bottom_Outline.png -fuzz 100% -fill \#0a1a0a -opaque white "$currentSpecific_work_cad"/Bottom_BG.png
	_imagemagick_limit_command convert -units PixelsPerInch -density "$currentDPI"x"$currentDPI" "$currentSpecific_work_cad"/Bottom_Outline.png -channel a -negate +channel -fill \#cccccc -colorize 100% "$currentSpecific_work_cad"/Bottom_Outline.png
	
	_imagemagick_limit_command convert -units PixelsPerInch -density "$currentDPI"x"$currentDPI" "$currentSpecific_work_cad"/Bottom_Mask.png -channel rgba -matte -fill "rgba(16,44,16,0.8)" -opaque \#102c10 "$currentSpecific_work_cad"/Bottom_Mask.png
	
	_imagemagick_limit_command composite -units PixelsPerInch -density "$currentDPI"x"$currentDPI" "$currentSpecific_work_cad"/Bottom_Outline.png "$currentSpecific_work_cad"/Bottom_Mask.png "$currentSpecific_work_cad"/Bottom_Mask_Real.png
	_imagemagick_limit_command convert -units PixelsPerInch -density "$currentDPI"x"$currentDPI" "$currentSpecific_work_cad"/Bottom_Mask_Real.png -transparent \#cccccc "$currentSpecific_work_cad"/Bottom_Mask_Real.png
	
	_imagemagick_limit_command composite -units PixelsPerInch -density "$currentDPI"x"$currentDPI" "$currentSpecific_work_cad"/Bottom_Mask_Real.png "$currentSpecific_work_cad"/Bottom_Copper.png "$currentSpecific_work_cad"/Bottom_All.png
	_imagemagick_limit_command composite -units PixelsPerInch -density "$currentDPI"x"$currentDPI" "$currentSpecific_work_cad"/Bottom_All.png "$currentSpecific_work_cad"/Bottom_BG.png "$currentSpecific_work_cad"/Bottom.png
	
	_imagemagick_limit_command convert -units PixelsPerInch -density "$currentDPI"x"$currentDPI" "$currentSpecific_work_cad"/Bottom.png -background "#cccccc" -flatten "$currentSpecific_work_cad"/Bottom.png
	
	mv "$currentSpecific_work_cad"/Bottom.png "$currentSpecific_work_cad"/RenderBottom.png
	#rm "$currentSpecific_work_cad"/Bottom*.png
	
	
	_imagemagick_limit_command convert -units PixelsPerInch -density "$currentDPI"x"$currentDPI" "$currentSpecific_work_cad"/RenderTop.png "$currentSpecific_work_cad"/RenderTop.pdf
	_imagemagick_limit_command convert -units PixelsPerInch -density "$currentDPI"x"$currentDPI" "$currentSpecific_work_cad"/RenderBottom.png "$currentSpecific_work_cad"/RenderBottom.pdf
	_imagemagick_limit_command montage -units PixelsPerInch -density "$currentDPI"x"$currentDPI" -mode concatenate -bordercolor \#000000 -border 4 -geometry '+300+300' "$currentSpecific_work_cad"/RenderTop.png "$currentSpecific_work_cad"/RenderBottom.png "$currentSpecific_work_cad"/Model.pdf
	
	# DANGER: Slim but significant possibility output may be of lower than original resolution.
	gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -r"$currentDPI"x"$currentDPI" -dNOPAUSE -dQUIET -dBATCH -sOutputFile="$currentSpecific_work_cad"/Model_compressed.pdf "$currentSpecific_work_cad"/Model.pdf
	mv "$currentSpecific_work_cad"/Model_compressed.pdf "$currentSpecific_work_cad"/Model.pdf
	
	
	mkdir -p "$se_out"/cad/"$currentInput_name"/
	cp "$currentSpecific_work_cad"/* "$se_out"/cad/"$currentInput_name"/
	
	_messageNormal "Compile: CAD: end"
}
