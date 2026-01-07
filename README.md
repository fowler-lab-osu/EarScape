# EarScape Spatial Analysis
Code for statistical spatial analysis for paper "Spatial inheritance patterns    across maize ears are associated with alleles that reduce pollen fitness".

Repo non-final.

Documentation in progress.

# Description of files 
Top Directory:
1) transmission_rate_GLM.Rmd
   - Transmission Rate GLM pipeline from Luis + additional edits that computes additional statistics such as SD, total count, etc. 
   - Input: AllEarKernelCountData_58.csv  (the TR GLM gets all its kernel count data from this spreadsheet)
   - Output: transmission_rate_glm_{crossType}.tsv
2) spatial_analysis_GLM.Rmd
   - The general code for the spatial analysis GLMs (Linear and Quadratic models) and Fisher combination tests.
   - Note that the path the file is uploaded from should be changed to match the path of the current user.
   - Other path changes include the top of the .rmd file where xml_to_coordinates.R, xml_to_coord_edited.R, and coordinates_to_xbins.R are sourced.
   - Remember to have the packages required at the top to be installed.
   - write.table(---) writes a .tsv table to the current folder the .rmd file resides.
   - Currently, the bins sizes are set to be 16 bins with the ends being removed to result in 14 bins at the end. Should be fairly straightforward to switch bin sizes are needed as documented in the code.

3) allele_spatial_plots.Rmd
   - Code for the graph outputs, including scatterplots and bar graphs.
   - A new folder, spatial_graphs_files should be created to store all the graphs created.
   - Graphs are stored in a pdf corresponding to the specific allele and type of graph. In other words, all observations of an allele of a particular graph (ex. scatterplot vs bar graph) should be stored in one pdf.
4) spatial_vs_transmission_plots.R
   - Generates plots for spatial trend evidence vs. transmission rate

Posthoc_Analysis:
1) posthoc_analysis.R
   - Code for assigning pattern categories to ears
     
Helper_Code:
1) xml_to_coordinates.R
   - Converts .xml files into coordinate form for handcounted .xml files. 
2) xml_to_coord_edited.R
   - Converts .xml files into coordinate form for EarVision inference .xml files. 
3) coordinates_to_xbins.R
   - Converts coordinates into bins.


# Description of output files 
Data Files:
1) transmission_rate_glm_{crossType}.tsv

2) TODO 



Allele_Spatial_Plots:
1) {allele}_bin_graphs.pdf
   - Bar graph of WT count depending on bin.
   - Bar graph of GFP count depending on bin.
   - Stacked bar graph of WT/GFP count depending on bin.
   - Stacked bar graph of WT/GFP count depending on bin, colored and horizontal version.
2) {allele}_coord_plots.pdf
   - Ear Map: Scatter plot of X and Y coords colored by WT and GFP. 
3) {allele}_trends_lin_glm.pdf/.png
   - Shows plotted Linear GLM lines for all ears of an allele. Ears with one-tailed Linear GLM p-vals <= 0.05 are colored.
   Blue = Increasing Linear pattern, Red = Decreasing Linear pattern.
4) {allele}_xcoordsbytr_linear_ends.pdf
   - Scatterplot of transmission rate vs. bins/x-coord with Linear GLM line fit.
5) {allele}_xcoordsbytr_quad_ends.pdf
   - Scatterplot of transmission rate vs. bins/x-coord with Quadratic GLM line fit. 


# How to Run / Other Notes

- Run the code in the following order:
   1) transmission_rate_GLM.Rmd
   2) spatial_analysis.GLM.Rmd   ***Manually Adjust Cross Type (pollen/ear)
   3) spatial_vs_transmission_plots.R
   4) allele_spatial_plots.Rmd   ***Manually Adjust Cross Type (pollen/ear)
   5) posthoc_analysis.R
   
   ***These scripts must be run twice, and manually changed to run for either 'pollen' or 'ear' crosses. They each take a few minutes to run. Alter the 'cross' variable towards the top of the code appropriately.

- To run analysis with a different number of bins (instead of 16), change 'binNumber' variable in both spatial_analysis_GLM.Rmd and allele_spatial_plots.Rmd. First and last bin are never included in the spatial GLM (e.g, 16 bins means 14 are used in GLM).