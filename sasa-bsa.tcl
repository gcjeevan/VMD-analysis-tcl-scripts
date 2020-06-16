#gcjeevanb@gmail.com, June 15 2020
#jeevan.gc@wsu.edu
#The tcl script will calculate the solvent accesible surface area (sasa) of ligands, protein and complex from the MD trajectory.
#Buried surface are (BSA) will be calcuated using sasa values.
#BSA = (sasa_prot + sasa_lig - sasa_complex)/2

#USAGE: source sasa-bsa.tcl (in VMD TK console window)

#Load psf and dcd trajectory files in vmd
#mol new psf protein_lig.psf
#mol addfile protein_lig.dcd type dcd first 0 last -1 step 1 filebonds 1 autobonds 1 waitfor all

set nf [molinfo top get numframes]

#output text file
set outfile [open "sasa-bsa.txt" w]

#Three selections: protein only, ligand only and protein+ligand complex

#protein only
set prot [atomselect top "protein and noh"]

#Ligand only
set lig [atomselect top "resname L and noh"]

#protein and ligand complex
set complex [atomselect top "protein and noh or resname L and noh"]

#loop over all frames
for {set i 0} {$i < $nf} {incr i} {
	puts "frame $i of $nf"
	$prot frame $i
	$lig frame $i
	$complex frame $i

set sasa_prot [measure sasa 1.4 $prot]
set sasa_lig [measure sasa 1.4 $lig]
set sasa_complex [measure sasa 1.4 $complex]

#sasa_prot + sasa_lig

set sasa_prot_and_lig [vecadd $sasa_prot $sasa_lig]

#BSA = (sasa_prot + sasa_lig - sasa_complex)/2

set bsa [vecscale [vecsub $sasa_prot_and_lig $sasa_complex] 0.5]

puts $outfile [format "%0.1f %0.1f %0.1f %0.1f %0.1f %0.1f %0.1f" $nf $sasa_lig $sasa_prot $sasa_complex $sasa_prot_and_lig $sasa_complex $bsa]
}

close $outfile

