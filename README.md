# EarScape Spatial Analysis
Code for statistical spatial analysis for paper "Spatial inheritance patterns across maize ears are associated with alleles that reduce pollen fitness".

Repo non-final.

Documentation in progress.

# Description of Code 
**1. transmission_rate_GLM.Rmd**
   - Transmission Rate GLM pipeline from Luis + additional edits that computes additional statistics such as SD, total count, etc. 
   - **Input**: AllEarKernelCountData_58.csv  (The TR GLM gets all its kernel count data from this spreadsheet)
   - **Output**: transmission_rate_glm_{crossType}.tsv
   
**2. spatial_analysis_GLM.Rmd**
   - The general code for the spatial analysis GLMs (Linear and Quadratic models) and Fisher combination tests.
   - Currently, the bins sizes are set to be 16 bins with the ends being removed to result in 14 bins at the end.
   - **Input**: Todo

**3. spatial_vs_transmission_plots.R**
   - Generates plots for spatial trend evidence vs. transmission rate

**4. allele_spatial_plots.Rmd**
   - Code for the graph outputs, including scatterplots and bar graphs.
   - A new folder, spatial_graphs_files should be created to store all the graphs created.
   - Graphs are stored in a pdf corresponding to the specific allele and type of graph. In other words, all observations of an allele of a particular graph (ex. scatterplot vs bar graph) should be stored in one pdf.

**5. posthoc_analysis.R**
   - Code for assigning pattern categories to ears
     
Helper_Code:
1) xml_to_coordinates.R
   - Converts .xml files into coordinate form for handcounted .xml files. 
2) xml_to_coord_edited.R
   - Converts .xml files into coordinate form for EarVision inference .xml files. 
3) coordinates_to_xbins.R
   - Converts coordinates into bins.

# Description of Data Files 
Data Files:
1) SpatialAnalysis_Alleles_58/AllEarKernelCountData_58.csv
   - Kernel count data derived from EarVision.v2 GFP and WT kernel counts. Note: includes all kernels in ear image, including ends of ear. Transmission Rate here will vary slightly from Transmission Rate derived from data with end bins excluded.
   - Reflected in __Supporting DataS2_58_alleles_kernel_counts.xlsx__
2) transmission_rate_glm_{crossType}.tsv
   - Results of Transmission Rate GLM. 
      - Column *adj_p_value* used to determine significance (<=0.05)
      - Column *estimated_transmission_percentage* used for comparisons against spatial trend evidence.
   - Reflected in __Supporting DataS3_transmission_rate_glm.xlsx__

3) stat_sum_fisher_{crossType}.tsv
   - Results of Spatial Analysis GLM for each allele. Reports Fisher combined p-value for each spatial trend.


4) allele_results_{crossType}.csv
   - Results of Spatial Analysis GLM for each allele, with multiple testing threshold evaluation for each trend (Benjamini-Hochberg - Benji_Pass TRUE/FALSE/NA)
   - Also incorporates Transmission Rate and significance evaluation from Transmission Rate GLM.
   - Reflected in __Supporting DataS5_allele_results_fisher.xlsx__


?) Posthoc_Analysis/for_posthoc_analys_{crossType}.csv
   - Intermediary File...
?) Posthoc_Analysis/quad_ears_{crossType}.csv  <do we still need this even???>

5) Posthoc_Analysis/pattern_counts_{crpssType}.csv
   - Counts of ears per pattern category for each allele (IncLin, DecLin, TrueQuad)
   - Reflected in __Supporting DataS6_pattern_counts_per_allele.xlsx__

6) Posthoc_Analysis/posthoc_categories_{crossType}.csv
   - Spatial GLM p-values for each individual ear map, and Post-Hoc pattern category (IncLin, DecLin, TrueQuad)
   - Reflected in __SupportingDataS4_earscape_analyses_all_ears.xlsx__

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
Run the code in the following order:
   1. transmission_rate_GLM.Rmd
   2. spatial_analysis.GLM.Rmd   ***
   3. spatial_vs_transmission_plots.R
   4. allele_spatial_plots.Rmd   ***
   5. posthoc_analysis.R
   
   *** __Manually Adjusting Cross Type (pollen/ear)__: These scripts must be run twice, and manually changed to run for either 'pollen' or 'ear' crosses. They each take a few minutes to run. Alter the 'cross' variable towards the top of the code appropriately.

**Changing Bin Number**: To run analysis with a different number of bins (instead of 16), change 'binNumber' variable in both spatial_analysis_GLM.Rmd and allele_spatial_plots.Rmd. First and last bin are never included in the spatial GLM (e.g, 16 bins means 14 are used in GLM).

