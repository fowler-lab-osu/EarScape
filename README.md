# EarScape Spatial Analysis
Code for statistical spatial analysis for paper "Spatial inheritance patterns    across maize ears are associated with alleles that reduce pollen fitness".

Repo non-final.

Documentation in progress.

# Description of files 
Top Directory:
1) spatial_analysis_GLM.Rmd
   - The general code for the spatial analysis GLMs (Linear and Quadratic models) and Fisher combination tests.
   - Note that the path the file is uploaded from should be changed to match the path of the current user.
   - Other path changes include the top of the .rmd file where xml_to_coordinates.R, xml_to_coord_edited.R, and coordinates_to_xbins.R are sourced.
   - Remember to have the packages required at the top to be installed.
   - write.table(---) writes a .tsv table to the current folder the .rmd file resides.
   - Currently, the bins sizes are set to be 16 bins with the ends being removed to result in 14 bins at the end. Should be fairly straightforward to switch bin sizes are needed as documented in the code.
2) transmission_rate_GLM.Rmd
   - Transmission Rate GLM pipeline from Luis + additional edits that computes additional statistics such as SD, total count, etc. 
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
(to write)

(All from spatial_graphs_for_paper.rmd)
1) {allele}_basic.pdf
   - Bar graph of WT vs. GFP for all observations.
   - Scatter plot of X and Y coords colored by WT and GFP. 
2) {allele}_graphs.pdf
   - Bar graph of WT count depending on bin.
   - Bar graph of GFP count depending on bin.
   - Stacked bar graph of WT/GFP count depending on bin.
   - Stacked bar graph of WT/GFP count depending on bin, colored and horizontal version.
3) {allele}_xcoordsbytr_linear_ends.pdf
   - Scatterplot of transmission rate vs. bins/x-coord with Linear GLM line fit.
4) {allele}_xcoordsbytr_quad_ends.pdf
   - Scatterplot of transmission rate vs. bins/x-coord with Quadratic GLM line fit. 

