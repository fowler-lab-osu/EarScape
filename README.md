# spatial_analysis
Code for statistical spatial analysis for EarVision paper. 

# Description of files 
1) spatial_analysis_for_paper_updated.rmd
   - The general code for the statistical outputs are from here.
   - Note that the path the file is uploaded from should be changed to match the path of the current user.
   - Places that the path should be edited include anywhere that say "/Users/michellebang/st research lab/spatialanalysis/SpatialAnalysisMichelle/SpatialAnalysis_Alleles_AmbigAdjust"
   - Other path changes include the top of the .rmd file where xml_to_coordinates.R, xml_to_coord_edited.R, and coordinates_to_xbins.R are sourced.
   - Remember to have the packages required at the top to be installed.
   - write.table(---) writes a .tsv table to the current folder the .rmd file resides.
   - Currently, the bins sizes are set to be 16 bins with the ends being removed to result in 14 bins at the end. Should be fairly straightforward to switch bin sizes are needed as documented in the code. 
2) spatial_graphs_for_paper.rmd
   - The general code for the graph outputs. This include scatterplots and bar graphs.
   - Similar to before, remember to change the path to match the path of the current user.
   - A new folder, spatial_graphs_files should be created to store all the graphs created.
   - Graphs are stored in a pdf corresponding to the specific allele and type of graph. In other words, all observations of an allele of a particular graph (ex. scatterplot vs bar graph) should be stored in one pdf. 
3) xml_to_coordinates.R
   - Converts .xml files into coordinate form for old .xml files. 
4) xml_to_coord_edited.R
   - Converts .xml files into coordinate form for the new, EarVision, .xml files. 
5) coordinates_to_xbins.R
   - Converts coordinates into bins. 

# Description of output files 
1) 
