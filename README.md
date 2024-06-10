# Counting FISH dots using Cellpose and RS-FISH

This repository contains scripts and documentation for our method of quantifying v3 HCR-FISH signal.
Briefly, the steps are as follows:

  1. [Divide your multi-channel images into individual channels, and isolate tissues of interest](./Tissue_Isolation.md).
  2. [Segment cells and/or nuclei in tissues of interest](./Cellpose_Segmentation.md) using [Cellpose](https://github.com/MouseLand/cellpose).
  3. Identify dots with [the RS-FISH plugin](https://github.com/PreibischLab/RS-FISH) and [convert images into binary maxima images](./RS_FISH_Analysis.md).
  4. Overlay segmentation results on maxima images to [get measurements of dots per cell/nucleus](./ROI_Converters.md).
  5. [Create visualizations and run statistical analyses](./Data_Concatenation_Walkthrough.Rmd). Note that this RMarkdown file will need to be downloaded and ran locally.
  
If you find this repository useful or use our method in any of your work, please cite us :-) This method is currently unpublished outside of this repository, but we will update the citation when that is the case. As this pipeline utilizes techniques and software designed by other labs, be sure to cite them as well.

If you have any questions, suggestions, or requests for new capabilities, feel free to reach out in the issues tab or using the email on the organization page. 

## Probe Generator
Our lab has also previously developed a web application to aid in designing probes for HCR-FISH. [The documentation can be found in this organization](https://github.com/Monaghan-Lab/probegenerator), and [the web version of Probe Generator can be found here](http://ec2-44-211-232-78.compute-1.amazonaws.com/).

# References
Bahry, Ella, Laura Breimann, Marwan Zouinkhi, Leo Epstein, Klim Kolyvanov, Nicholas Mamrak, Benjamin King, et al. 2022. “RS-FISH: Precise, Interactive, Fast, and Scalable FISH Spot Detection.” Journal Article. Nature Methods 19 (12): 1563–67. https://doi.org/10.1038/s41592-022-01669-y.

Choi, Harry M. T., Maayan Schwarzkopf, Mark E. Fornace, Aneesh Acharya, Georgios Artavanis, Johannes Stegmaier, Alexandre Cunha, and Niles A. Pierce. 2018. “Third-Generation in Situ Hybridization Chain Reaction: Multiplexed, Quantitative, Sensitive, Versatile, Robust.” Journal Article. Development 145 (12): dev165753. https://doi.org/10.1242/dev.165753.

Granger, Brian E., and Fernando Pérez. 2021. “Jupyter: Thinking and Storytelling with Code and Data.” Computing in Science & Engineering 23 (2): 7–14. https://doi.org/10.1109/MCSE.2021.3059263.

Pachitariu, Marius, and Carsen Stringer. 2022. “Cellpose 2.0: How to Train Your Own Model.” Journal Article. Nature Methods 19 (12): 1634–41. https://doi.org/10.1038/s41592-022-01663-4.

Schindelin, Johannes, Ignacio Arganda-Carreras, Erwin Frise, Verena Kaynig, Mark Longair, Tobias Pietzsch, Stephan Preibisch, et al. 2012. “Fiji: An Open-Source Platform for Biological-Image Analysis.” Journal Article. Nature Methods 9 (7): 676–82. https://doi.org/10.1038/nmeth.2019.

Stringer, Carsen, Tim Wang, Michalis Michaelos, and Marius Pachitariu. 2021. “Cellpose: A Generalist Algorithm for Cellular Segmentation.” Journal Article. Nature Methods 18 (1): 100–106. https://doi.org/10.1038/s41592-020-01018-x.
