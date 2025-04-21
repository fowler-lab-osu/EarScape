library(dplyr)

print("Trend Count Analysis")

cross <- "ear"

glm_data <- read.csv(paste("for_posthoc_analysis_",cross,".csv", sep=""))
BH_info <- read.csv(paste("../allele_results_", cross,".csv", sep=""))
all_df <- merge(glm_data, BH_info, by="Allele")

#print(head(all_df))

sigQuad <- all_df %>% filter(Quad_pval <= 0.05 & Lin_inc_pval > 0.05 & Lin_dec_pval >0.05)
write.csv(sigQuad,paste("quad_ears_", cross, ".csv",sep=""), row.names = FALSE)

all_df["Category"] <- ""
all_df$Category[all_df$Quad_pval <= 0.05 & all_df$Lin_inc_pval > 0.05 & all_df$Lin_dec_pval >0.05] <- "TrueQuad"
all_df$Category[all_df$Lin_inc_pval <= 0.05 & all_df$Lin_dec_pval > 0.05] <- "IncLin"
all_df$Category[all_df$Lin_inc_pval > 0.05 & all_df$Lin_dec_pval <= 0.05] <- "DecLin"

out_df <- all_df[c('Allele', 'Ear', 'Quad_pval', 'Lin_inc_pval', 'Lin_dec_pval','Category')]


write.csv(out_df,paste("posthoc_categories_",cross,".csv",sep=""), row.names = FALSE)

trend_counts <- data.frame(matrix(nrow=58, ncol=10))
colnames(trend_counts) <- c("Allele", "#Ears", "#IncLin", "#DecLin", "#TrueQuad", "#NoTrend", "%IncLin", "%DecLin", "%TrueQuad","%NoTrend")

ears_counts <- all_df %>% group_by(Allele) %>% count()

inc_lin_counts <- all_df %>% group_by(Allele) %>% summarize(count = sum(Lin_inc_pval <= 0.05 & Lin_dec_pval > 0.05)) #linear trend counts here override quadratic
dec_lin_counts <- all_df %>% group_by(Allele) %>% summarize(count = sum(Lin_inc_pval > 0.05 & Lin_dec_pval <= 0.05))
quad_counts <- all_df %>% group_by(Allele) %>% summarize(count = sum(Quad_pval <= 0.05 & Lin_inc_pval > 0.05 & Lin_dec_pval >0.05))
no_trend_counts <- all_df %>% group_by(Allele) %>% summarize(count = sum(Quad_pval > 0.05 & Lin_inc_pval > 0.05 & Lin_dec_pval >0.05))

trend_counts['Allele'] <- ears_counts['Allele']
trend_counts['#Ears'] <- ears_counts['n']

trend_counts['#IncLin'] <- inc_lin_counts['count']
trend_counts['#DecLin'] <- dec_lin_counts['count']
trend_counts['#TrueQuad'] <- quad_counts['count']
trend_counts['#NoTrend']<- no_trend_counts['count']

trend_counts['%IncLin'] <- round(trend_counts['#IncLin'] / trend_counts['#Ears'], digits = 2)
trend_counts['%DecLin'] <- round(trend_counts['#DecLin'] / trend_counts['#Ears'], digits = 2)
trend_counts['%TrueQuad'] <- round(trend_counts['#TrueQuad'] / trend_counts['#Ears'], digits = 2)
trend_counts['%NoTrend']<- round (trend_counts['#NoTrend'] / trend_counts['#Ears'], digits = 2)

trend_counts <- merge(trend_counts, BH_info, by="Allele")
trend_counts <- subset(trend_counts, select = -c(Count))

write.csv(trend_counts, paste("trend_counts_", cross,".csv",sep=""), row.names = FALSE)