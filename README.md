# Counting FISH dots using Cellpose and RS-FISH

This repository contains scripts and documentation for our method of quantifying v3 HCR-FISH signal.
Briefly, the steps are as follows:

  1. [Divide your multi-channel images into individual channels, and isolate tissues of interest](./Tissue_Isolation.md).
  2. [Segment cells and/or nuclei in tissues of interest](./Cellpose_Segmentation.md) using [Cellpose](https://github.com/MouseLand/cellpose).
  3. Identify dots with [the RS-FISH plugin](https://github.com/PreibischLab/RS-FISH) and [convert images into binary maxima images](./RS_FISH_Analysis.md).
  4. Overlay segmentation results on maxima images to [get measurements of dots per cell/nucleus](./ROI_Converters.md).
  5. [Create visualizations and run statistical analyses](./Data_Concatenation_Walkthrough.Rmd). Note that this RMarkdown file will need to be downloaded and ran locally.
  
If you find this repository useful or use our method in any of your work, please cite us :-) This method is currently unpublished outside of this repository, but we will update the citation when that is the case. As this pipeline utilizes techniques and software designed by other labs, be sure to cite them as well. Citations and links to their sources are contained in the relevant pipeline steps. 

If you have any questions, suggestions, or requests for new capabilities, feel free to reach out in the issues tab or using the email on the organization page. 

## Probe Generator
Our lab has also previously developed a web application to aid in designining HCR-FISH probes. [The documentation can be found in this organization](https://github.com/Monaghan-Lab/probegenerator), and [the web version of Probe Generator can be found here](http://ec2-44-211-232-78.compute-1.amazonaws.com/).
