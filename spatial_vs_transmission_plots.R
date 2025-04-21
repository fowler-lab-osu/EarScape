library(ggplot2)

pollen_df <- read.csv("stat_sum_fisher_pollen.tsv", sep="\t")
ear_df <- read.csv("stat_sum_fisher_ear.tsv", sep="\t")

tr_glm_pollen <- read.csv("transmission_rate_glm_male.tsv", sep="\t")
tr_glm_ear <- read.csv("transmission_rate_glm_female.tsv", sep="\t")

ear_sig<-tr_glm_ear[,c("allele","adj_p_value", "estimated_transmission_percentage")]
ear_df<-merge(ear_df, ear_sig, by.x="Allele", by.y="allele", all=TRUE)

pollen_sig<- tr_glm_pollen[,c("allele","adj_p_value", "estimated_transmission_percentage")]
pollen_df<-merge(pollen_df, pollen_sig, by.x="Allele", by.y="allele", all=TRUE)

the_theme <- theme(panel.background = element_rect(fill = '#f3f3f3'), 
plot.margin = margin(5,10,5,10) , legend.position="none", plot.title = element_text(hjust = 0.5, size=22),
axis.title = element_text(size=20), axis.text = element_text(size = 18) )
point_size <- 3.1
red_line_width <- 0.6

unit="in"
w = 4.33
h = 4
dpi = 300

color_pair_p<- c("#000000", "#4bd8ff")
#color_pair_e<- c("#000000", "#000000")
color_pair_e<- c("#000000", "#4bd8ff")


dir.create("./Spatial_Vs_Transmission_Plots")

benji_hoch <- function(u){
    #adapted Benjamini-Hochberg calculation code from sgof package, see https://github.com/cran/sgof/blob/master/R/BH.R
    alpha = 0.05  #false discovery rate for BH calc
    n=length(u)
    r=rank(u,ties.method="max")
    bh=max(c(r[u<=(r/n)*alpha],0),na.rm = T) 
    su<-sort(u)
    #end sgof adapted code
    return(su[bh])
}

BH_cutoff <- list()


u <-unlist(pollen_df["Quadratic"], use.names=FALSE)
BH_cutoff[["Pollen_Quadratic"]] <- benji_hoch(u)

plot <- ggplot(pollen_df, aes(x=Quadratic, y=Transmission.Rate, color=adj_p_value<=0.05)) + ylim(0,.6) + xlim(0,1) + 
ggtitle("Quadratic - Pollen") + xlab("p-val (combined)") + the_theme +
geom_hline(yintercept=0.5,linetype='dashed', color="blue",size=0.8) + 
geom_vline(xintercept=BH_cutoff$Pollen_Quadratic, linetype='dashed', color='#00b000', linewidth=red_line_width) +
geom_vline(xintercept=0.05, linetype='dashed', color='magenta', linewidth=red_line_width) +
geom_point(size=point_size) + scale_color_manual(values=color_pair_p)  + scale_x_reverse(limits = c(1.0,0)) +
ylab("Transmission Rate")

ggsave("Spatial_Vs_Transmission_Plots/pollen_quad.pdf", units=unit, width=w, height=h)
ggsave("Spatial_Vs_Transmission_Plots/pollen_quad.png", units=unit, width=w, height=h, dpi=dpi)


u <-unlist(ear_df["Quadratic"], use.names=FALSE)
BH_cutoff[["Ear_Quadratic"]] <- benji_hoch(u)

plot <- ggplot(ear_df, aes(x=Quadratic, y=Transmission.Rate, color=pollen_df$adj_p_value<=0.05))  + ylim(0,.6) + xlim(0,1) +
ggtitle("Quadratic - Ear") + xlab("p-val (combined)") + the_theme +
geom_hline(yintercept=0.5,linetype='dashed', color="blue",size=0.8 ) +  
geom_vline(xintercept=BH_cutoff$Ear_Quadratic, linetype='dashed', color='#00b000', linewidth=red_line_width) +
geom_vline(xintercept=0.05, linetype='dashed', color='magenta', linewidth=red_line_width) +
geom_point(size=point_size) + scale_color_manual(values=color_pair_e)  + scale_x_reverse(limits = c(1.0,0))  +
ylab("Transmission Rate")

ggsave("Spatial_Vs_Transmission_Plots/ear_quad.pdf", units=unit, width=w, height=h)
ggsave("Spatial_Vs_Transmission_Plots/ear_quad.png", units=unit, width=w, height=h, dpi=dpi)


u <-unlist(pollen_df["Increasing.Linear"], use.names=FALSE)
BH_cutoff[["Pollen_Linear_Increasing"]] <- benji_hoch(u)

plot <- ggplot(pollen_df, aes(x=Increasing.Linear, y=Transmission.Rate, color=adj_p_value<=0.05)) + ylim(0,.6) + xlim(0,1) +
ggtitle("Increasing Linear - Pollen") + xlab("p-val (combined)") + the_theme + 
geom_hline(yintercept=0.5,linetype='dashed', color="blue" ,size=0.8) +   
geom_vline(xintercept=BH_cutoff$Pollen_Linear_Increasing, linetype='dashed', color='#00b000', linewidth=red_line_width) +
geom_vline(xintercept=0.05, linetype='dashed', color='magenta', linewidth=red_line_width) +
geom_point(size=point_size) + scale_color_manual(values=color_pair_p) + scale_x_reverse(limits = c(1.0,0)) +
ylab("Transmission Rate")

ggsave("Spatial_Vs_Transmission_Plots/pollen_linear_increasing.pdf", units=unit, width=w, height=h)
ggsave("Spatial_Vs_Transmission_Plots/pollen_linear_increasing.png", units=unit, width=w, height=h, dpi=dpi)


u <-unlist(ear_df["Increasing.Linear"], use.names=FALSE)
BH_cutoff[["Ear_Linear_Increasing"]] <- benji_hoch(u)

plot <- ggplot(ear_df, aes(x=Increasing.Linear, y=Transmission.Rate, color=pollen_df$adj_p_value<=0.05)) + ylim(0,.6) + xlim(0,1) + 
ggtitle("Increasing Linear - Ear") + xlab("p-val (combined)")+ the_theme +
geom_hline(yintercept=0.5,linetype='dashed', color="blue",size=0.8 ) +   
geom_vline(xintercept=BH_cutoff$Ear_Linear_Increasing, linetype='dashed', color='#00b000', linewidth=red_line_width) +
geom_vline(xintercept=0.05, linetype='dashed', color='magenta', linewidth=red_line_width) +
geom_point(size=point_size) + scale_color_manual(values=color_pair_e) + scale_x_reverse(limits = c(1.0,0)) +
ylab("Transmission Rate") 

ggsave("Spatial_Vs_Transmission_Plots/ear_linear_increasing.pdf", units=unit, width=w, height=h)
ggsave("Spatial_Vs_Transmission_Plots/ear_linear_increasing.png", units=unit, width=w, height=h, dpi=dpi)

u <-unlist(pollen_df["Decreasing.Linear"], use.names=FALSE)
BH_cutoff[["Pollen_Linear_Decreasing"]] <- benji_hoch(u)

plot <- ggplot(pollen_df, aes(x=Decreasing.Linear, y=Transmission.Rate, color=adj_p_value<=0.05)) + ylim(0,.6) + xlim(0,1) +
ggtitle("Decreasing Linear - Pollen") + xlab("p-val (combined)") + the_theme + 
geom_hline(yintercept=0.5,linetype='dashed', color="blue",size=0.8) +   
geom_vline(xintercept=BH_cutoff$Pollen_Linear_Decreasing, linetype='dashed', color='#00b000', linewidth=red_line_width) +
geom_vline(xintercept=0.05, linetype='dashed', color='magenta', linewidth=red_line_width) +
geom_point(size=point_size) + scale_color_manual(values=color_pair_p) + scale_x_reverse(limits = c(1.0,0)) +
ylab("Transmission Rate")

ggsave("Spatial_Vs_Transmission_Plots/pollen_linear_decreasing.pdf", units=unit, width=w, height=h)
ggsave("Spatial_Vs_Transmission_Plots/pollen_linear_decreasing.png", units=unit, width=w, height=h, dpi=dpi)

u <-unlist(ear_df["Decreasing.Linear"], use.names=FALSE)
BH_cutoff[["Ear_Linear_Decreasing"]] <- benji_hoch(u)

plot <- ggplot(ear_df, aes(x=Decreasing.Linear, y=Transmission.Rate, color=pollen_df$adj_p_value<=0.05))  + ylim(0,.6) + xlim(0,1) + 
ggtitle("Decreasing Linear - Ear") + xlab("p-val (combined)")+ the_theme +
geom_hline(yintercept=0.5,linetype='dashed', color="blue",size=0.8) +   
geom_vline(xintercept=BH_cutoff$Ear_Linear_Decreasing, linetype='dashed', color='#00b000', linewidth=red_line_width) +
geom_vline(xintercept=0.05, linetype='dashed', color='magenta', linewidth=red_line_width) +
geom_point(size=point_size) + scale_color_manual(values=color_pair_e) + scale_x_reverse(limits = c(1.0,0)) +
ylab("Transmission Rate")

ggsave("Spatial_Vs_Transmission_Plots/ear_linear_decreasing.pdf", units=unit, width=w, height=h)
ggsave("Spatial_Vs_Transmission_Plots/ear_linear_decreasing.png", units=unit, width=w, height=h, dpi=dpi)

output_pollen <- pollen_df[c("Allele", "Increasing.Linear","Decreasing.Linear", "Quadratic")]
output_ear <- ear_df[c("Allele", "Increasing.Linear","Decreasing.Linear", "Quadratic")]

output_pollen["Inc_Linear_Benji_Pass"] <- pollen_df["Increasing.Linear"] <=BH_cutoff[["Pollen_Linear_Increasing"]]
output_pollen["Dec_Linear_Benji_Pass"] <- pollen_df["Decreasing.Linear"] <=BH_cutoff[["Pollen_Linear_Decreasing"]]
output_pollen["Quadratic_Benji_Pass"] <- pollen_df["Quadratic"] <=BH_cutoff[["Pollen_Quadratic"]]

output_pollen["Transmission_Rate_Spatial_GLM"] <- pollen_df["Transmission.Rate"]
output_pollen["Transmission_Defect"] <- pollen_df["adj_p_value"] <= 0.05 & pollen_df["Transmission.Rate"]<0.5
output_pollen["Transmission_Bias_Positive"] <-pollen_df["adj_p_value"] <= 0.05 & pollen_df["Transmission.Rate"]>0.5
output_pollen["TR_GLM_Adj_pval"] <-pollen_df["adj_p_value"]

output_pollen["Count"] <- pollen_df["Count"]
output_pollen["Transmission_Rate_TR_GLM"] <- pollen_df["estimated_transmission_percentage"]

output_pollen <- output_pollen[, c("Allele","Count","Increasing.Linear", "Inc_Linear_Benji_Pass",
"Decreasing.Linear", "Dec_Linear_Benji_Pass",
 "Quadratic", "Quadratic_Benji_Pass", "Transmission_Rate_Spatial_GLM","Transmission_Rate_TR_GLM","Transmission_Defect", "Transmission_Bias_Positive", "TR_GLM_Adj_pval")]

output_ear["Inc_Linear_Benji_Pass"] <- ear_df["Increasing.Linear"] <=BH_cutoff[["Ear_Linear_Increasing"]]
output_ear["Dec_Linear_Benji_Pass"] <- ear_df["Decreasing.Linear"] <=BH_cutoff[["Ear_Linear_Decreasing"]]
output_ear["Quadratic_Benji_Pass"] <- ear_df["Quadratic"] <=BH_cutoff[["Ear_Quadratic"]]

output_ear["Transmission_Rate_Spatial_GLM"] <- ear_df["Transmission.Rate"]
output_ear["Transmission_Defect"] <- ear_df["adj_p_value"] <= 0.05 & ear_df["Transmission.Rate"]<0.5
output_ear["Transmission_Bias_Positive"] <-ear_df["adj_p_value"] <= 0.05 & ear_df["Transmission.Rate"]>0.5
output_ear["TR_GLM_Adj_pval"] <-ear_df["adj_p_value"]

output_ear["Count"] <- ear_df["Count"]
output_ear["Transmission_Rate_TR_GLM"] <- ear_df["estimated_transmission_percentage"]

output_ear <- output_ear[, c("Allele", "Count", "Increasing.Linear", "Inc_Linear_Benji_Pass",
"Decreasing.Linear", "Dec_Linear_Benji_Pass",
 "Quadratic", "Quadratic_Benji_Pass", "Transmission_Rate_Spatial_GLM", "Transmission_Rate_TR_GLM", "Transmission_Defect", "Transmission_Bias_Positive", "TR_GLM_Adj_pval")]

write.csv(output_pollen, "allele_results_pollen.csv", row.names=FALSE)
write.csv(output_ear, "allele_results_ear.csv", row.names=FALSE)