
# open a file for writing the data to
set OUTPUT0 [open "count-contact-water.dat" w]

# loop over all frames
for {set frame 0} {$frame < [molinfo top get numframes]} {incr frame 1} {

    	set wat0 [atomselect top "water and name OH2 and within 4 protein and resid *** " frame $frame]


   	set waterNumber0 [$wat0 num]
	
	# so we can see what is happening, write the output to the screen for the moment
	#puts "$frame $waterNumber0"


	# write out the frame number and number of water to file  (the bit in the quotes formats the data nicely)
	puts $OUTPUT0 [format "%0.1f %0.1f" $frame $waterNumber0]
}
	
# close the file 	
close $OUTPUT0
