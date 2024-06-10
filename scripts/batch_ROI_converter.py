#@ File (label = "Input directory", style = "directory") imgdir
#@ File (label = "Output directory", style = "directory") outdir

from ij.plugin.frame import RoiManager
from ij import IJ
from ij.gui import PolygonRoi
from ij.gui import Roi
from java.awt import FileDialog
import os
import re

#####
# This script is a modification of the individual ROI converter created by Cellpose.
#####

# Edit to contain tissue types of interest
tissues = ("Tissue1", "Tissue2", "Tissue3")
# Edit to be stain used for segmentation
stain = "Stain"

# Need to call the ROI Manager to open
RM = RoiManager()

# In- and output directories defined when starting run
imgdir = str(imgdir)
outdir = str(outdir)

# Pulling images from input directory
# Images MUST have "_Maxima.tif" at the end to be found
imgs = os.listdir(imgdir)
maxima = [f for f in imgs if f.split("_")[-1] == "Maxima.tif"]

def ROI_converter(max_img, gene, basename, ROIs):
	rm = RM.getRoiManager()
	tissue = ROIs.split("_")[-4] # Getting tissue type from the outlines.txt file
	imp = IJ.openImage(imgdir+'/'+max_img)
    
	textfile = open(ROIs, "r")
	for line in textfile:
		xy = map(int, line.rstrip().split(","))
		X = xy[::2]
		Y = xy[1::2]
		imp.setRoi(PolygonRoi(X, Y, Roi.POLYGON))
		roi = imp.getRoi()
		print(roi)
		rm.addRoi(roi)
	textfile.close()
	rm.runCommand("Show all without labels");
	rm.runCommand("Associate", "true");
	rm.runCommand(imp,"Measure");
	IJ.saveAs("Results", outdir+'/'+basename+"_"+gene+"_"+tissue+".csv");
	IJ.selectWindow("Results");
	IJ.run("Close");
	rm.close();
	imp.close();

for tif in maxima:
	# To troubleshoot, un-comment the line below to make sure the right images are being found
	# print(tif)

	for tissue in tissues:
	  gene_name = tif.split("_")[-2]
	  basename = re.sub("_Whole-Tissue_[.\w+]*","",tif, flags=re.IGNORECASE) # base name is the full file name sans "_Whole-Tissue_[anything else]" to match to outlines
	  tissueROI = str(imgdir+'/'+basename+"_"+tissue+"_"+stain+"_cp_outlines.txt") # Creates full object matching image to outlines
	  
	  ROI_converter(tif, gene_name, basename, tissueROI)
