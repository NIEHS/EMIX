## Data Prep - HHEAR ReCHARGE Dataset
## For Mixtures Methods Testing 
## Bonnie Joubert - Aug 2023
## Updated for mixtures analysis workflow step 2 example application - May 2025
##################################################

#install.packages("devtools")
#install.packages("tidyverse")
#install.packages("grpreg")
#install.packages("janitor")
#install.packages("corrplot")
#install.packages("ggplot2")
#Note, gplot may also be needed depending on version of R installed

library(devtools)
library(tidyverse)
library(grpreg)
library(janitor)
library(dplyr)
library(tidyr)
library(corrplot)
library(ggplot2)
#Note, gplot may also be needed depending on version of R installed


#Turn off scientific notation
options(scipen = 999)

setwd(".")
getwd()

##################################################
# EPID DATA (autism phenotypes and covariates)

epid_data <- read.table("1461_EPI_DATA.csv", header=TRUE,sep=",")

# make all column headers lower case, convert key variables to factors 
epid_data = epid_data %>% 
  clean_names(case = c("old_janitor"))
   
# scale/format continuous variables and create indicator terms for categorical variables
epid_data$age_z         <- scale(epid_data$agemomyrs)         ## center and scale age
epid_data$age_zsq       <- epid_data$age_z^2                 ## square this age variable
#epid_data$lnmsl_z       <- scale(log(epid_data$mslelcstandard)) ##  MSLvrDQ (Composite Developmental Quotient - visual reception
epid_data$lncompdq_z      <- scale(log(epid_data$vincompdq)) ##  VINcompDQ (Composite Developmental Quotient)

epid_data$male          <- as.numeric(epid_data$correctsex == "M" )      ## male sex of child
epid_data$educat1       <- as.numeric(epid_data$momedu_4cat==2) ## high school diploma or less
epid_data$educat2       <- as.numeric(epid_data$momedu_4cat==3) ## some college, vocational, or 2-yr degree
epid_data$educat3       <- as.numeric(epid_data$momedu_4cat==4)  ## bachelor degree
epid_data$educat4       <- as.numeric(epid_data$momedu_4cat==5)  ## graduate or professional degree
epid_data$white_nh      <- as.numeric(epid_data$childrace_3cat==1) ## White Non Hispanic 
epid_data$nonwhite_nh      <- as.numeric(epid_data$childrace_3cat==2) ## White Non Hispanic 
epid_data$hisp_anyrace      <- as.numeric(epid_data$childrace_3cat==3) ## White Non Hispanic 
epid_data$momsmkpreg    <- as.numeric(epid_data$momsmokedany_bporpreg==1) ## Mom smoked during pregnancy - not many NAs
epid_data$momsmkchild1  <- as.numeric(epid_data$momsmokedcig_childyr1==1) ## Mom smoked during pregnancy - not many NAs
epid_data$momsmkchild2plus  <- as.numeric(epid_data$momsmokedcig_childyr2plus==1) ## Mom smoked during pregnancy - not many NAs


#dichotomous outcome - ASD yes/no
epid_data$asd <- 0
epid_data$asd[epid_data$dx2_group == 2] <- 1

#subset to covariates and outcome of interest 
epid_data2 = epid_data[, c("child_pid","dx2_group","asd","lncompdq_z","age_z","age_zsq","male","educat1","educat2","educat3","nonwhite_nh","hisp_anyrace","momsmkpreg","momsmkchild1","momsmkchild2plus")]

##################################################
# TARGETED CHEMICAL DATA

#Chemical data wihtout PFAS due to missingness of PFAS data
chem_data  <- read.table("1461_TARGETED_DATA.csv", header=TRUE,sep=",")

# Make all column headers lower case and clean data
chem_data2 = chem_data %>%
  clean_names(case = c("old_janitor")) %>%
  filter(comment_code !=17) #quantity of sample insufficient for analysis
 
#Replace chemical row values below LOD with LOD/sqrt(2)
chem_data2$concentration2 = chem_data2$concentration
chem_data2$concentration2[chem_data2$comment_code == 97] <- chem_data2$lod[chem_data2$comment_code == 97]/sqrt(2)

#print for careful review and checking
#write.csv(chem_data2, file="recharge_data_LODimpute_check.csv", quote=FALSE, row.names=FALSE)


#Subset to key variables
#replace concentration variable with new variable including imputed values
chem_data2$concentration = chem_data2$concentration2

chem_data3 = chem_data2[, c("child_pid","analyte_code","concentration")]


#Transform data 
chem_data4 <- chem_data3 %>% 
  group_by(analyte_code) %>% 
    pivot_wider(
    names_from = analyte_code, 
    values_from = concentration,
    values_fn = mean
)

##################################################
#Merge epid and chem data 

dat <- merge(epid_data2, chem_data4, by="child_pid",all=TRUE)


##################################################
#omit NAs
dat2 <- dat[,1:76] #remove PFAS - too many missing values
data2 <- na.omit(dat2)
dim(data2)

##################################################
#Set up data for analyses

#outcomes
y = data2$lncompdq_z
asd = data2$asd

#covariates
covariates = data2[, c("age_z","age_zsq","male","educat1","educat2","educat3","nonwhite_nh","hisp_anyrace","momsmkpreg")]

## exposure matrix
mixture <- as.matrix(data2[,16:76])

#log transforming generates missing values
#if(doLog==TRUE){
#  lnmixture   <- apply(mixture, 2, log)
#}else{
#  lnmixture   <- mixture
#}

#X <- scale(lnmixture)

# scale
X <- scale(mixture)

#Put back into data frame for some methods (e.g. wqs)
dat <- as.data.frame(cbind(X,covariates,y,asd))

#Chem group specific matrices (listed alphabetically by chemical group name)
metals = X[, c("As","Be","Cd","Mo","Tl","U")] 
parabens = X[,c("BUPB","BZPB","ETPB","HEPB","MEPB","PRPB")] 
pest  = X[, c("DEDP","DEP","DETP","DMDP","DMP","DMTP")] 
phenols = X[,c("BP1","BP2","BP3","BP8","BPA","BPAF","BPAP","BPB","BPF","BPP","BPS","BPZ",
              "DCP24","DCP25","DHB34","HB4","OH4BP","OHETP","OHMEP","PCP","TCC","TCP24","TCS")] 
phthalates = X[,c("MBZP","MCHP","MCHPP","MCINP","MCIOP","MCMHP","MCPP","MECPP","MEHHP","MEOHP",
              "MEP","MHPP","MHXP","MIBP","MINP","MIPP","MMP","MNBP","MOP","MPEP")] 

#Matrices for some models

covariates = as.matrix(covariates)
X = as.matrix(cbind(metals,parabens,pest,phenols,phthalates)) 

X2 = as.matrix(cbind(metals,parabens,pest,phenols,phthalates,covariates)) 

#Output data for analyses
#write.csv(dat,file="recharge_data_foranalysis.csv", quote=FALSE, row.names=FALSE)


###########################################
## DESCRIPTIVE PLOTS 

colnames(dat)
colnames(covariates)
dim(X)
length(y)
table(asd)
table(dat$male)
table(dat$educat1)
table(dat$educat2)
#etc. - continue as needed for variables of interest


# Histograms
#Outcome
png(file="recharge.hist.outcome.png")
  hist(y)
dev.off()


# Generate correlation coefficients
cor_chem = cor(X, use="complete.obs")
cor_chem = cor(X)

cor_pest = cor(pest, use="complete.obs")
cor_metals = cor(metals, use="complete.obs")
cor_phenols = cor(phenols, use="complete.obs")
cor_parabens = cor(parabens, use="complete.obs")
cor_phthalates = cor(phthalates, use="complete.obs")

#Correlation across all chemicals, all groups
pdf(file="recharge.cor.all.pdf", width=12, height=12)
  corrplot(cor_chem, method = 'color')
dev.off()


#Chemical correlations by group
pdf(file="recharge.cor.pest.pdf", width=12, height=12)
  corrplot.mixed(cor_pest, upper = "ellipse", lower.col="black")
dev.off()
pdf(file="recharge.cor.metals.pdf", width=12, height=12)
  corrplot.mixed(cor_metals, upper = "ellipse", lower.col="black")
dev.off()
pdf(file="recharge.cor.phenols.pdf", width=12, height=12)
  corrplot.mixed(cor_phenols, upper = "ellipse", lower.col="black")
dev.off()
pdf(file="recharge.cor.parabens.pdf", width=12, height=12)
  corrplot.mixed(cor_parabens, upper = "ellipse", lower.col="black")
dev.off()
pdf(file="recharge.cor.phthalates.pdf", width=12, height=12)
  corrplot.mixed(cor_phthalates, upper = "ellipse", lower.col="black")
dev.off()


#Chemical distribution by group
png(file="recharge.hist.allchems.png")
  hist(X)
dev.off()
png(file="recharge.hist.pest.png")
  hist(pest)
dev.off()
png(file="recharge.hist.metals.png")
  hist(metals)
dev.off()
png(file="recharge.hist.phenols.png")
  hist(phenols)
dev.off()
png(file="recharge.hist.parabens.png")
  hist(parabens)
dev.off()
png(file="recharge.hist.phthalates.png")
  hist(phthalates)
dev.off()



