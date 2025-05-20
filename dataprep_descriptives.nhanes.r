#################################
## NHANES telmere data prep
## For Mixtures Methods Testing
## Adaptation of code from Katrina Devick, 2019 Columbia Mixtures Workshop
## Edited by Glen McGee (University of Waterloo) and Bonnie Joubert (NIEHS) - April 2023
## Updated for mixtures analysis workflow step 2 example application - NIEHS EMIX GitHub May 2025
#################################

#install.packages("devtools")
#install.packages("tidyverse")
#install.packages("grpreg")
#install.packages("janitor")
#install.packages("corrplot")


library(devtools)
library(tidyverse)
library(grpreg)
library(janitor)
library(corrplot)
library(ggplot2)


#Turn off scientific notation
options(scipen = 999)

setwd(".")
getwd()

# Read in data and omit rows with missing data
nhanes <- na.omit(read.table("studypop.csv", header=TRUE,sep=","))

## center/scale continous covariates and create indicators for categorical covariates
nhanes$age_z         <- scale(nhanes$age_cent)         ## center and scale age
nhanes$agez_sq       <- nhanes$age_z^2                 ## square this age variable
nhanes$bmicat2       <- as.numeric(nhanes$bmi_cat3==2) ## 25 <= BMI < 30
nhanes$bmicat3       <- as.numeric(nhanes$bmi_cat3==3) ## BMI >= 30 (BMI < 25 is the reference)
nhanes$educat1       <- as.numeric(nhanes$edu_cat==1)  ## no high school diploma
nhanes$educat3       <- as.numeric(nhanes$edu_cat==3)  ## some college or AA degree
nhanes$educat4       <- as.numeric(nhanes$edu_cat==4)  ## college grad or above (reference is high schol grad/GED or equivalent)
nhanes$otherhispanic <- as.numeric(nhanes$race_cat==1) ## other Hispanic or other race - including multi-racial
nhanes$mexamerican   <- as.numeric(nhanes$race_cat==2) ## Mexican American 
nhanes$black         <- as.numeric(nhanes$race_cat==3) ## non-Hispanic Black (non-Hispanic White as reference group)
nhanes$wbcc_z        <- scale(nhanes$LBXWBCSI)
nhanes$lymphocytes_z <- scale(nhanes$LBXLYPCT)
nhanes$monocytes_z   <- scale(nhanes$LBXMOPCT)
nhanes$neutrophils_z <- scale(nhanes$LBXNEPCT)
nhanes$eosinophils_z <- scale(nhanes$LBXEOPCT)
nhanes$basophils_z   <- scale(nhanes$LBXBAPCT)
nhanes$lncotinine_z  <- scale(nhanes$ln_lbxcot)         ## to access smoking status, scaled ln cotinine levels


## exposure matrix
mixture <- with(nhanes, cbind(LBX074LA, LBX099LA, LBX118LA, LBX138LA, LBX153LA, LBX170LA, LBX180LA, LBX187LA,LBX194LA, LBXHXCLA, LBXPCBLA,
                              LBXD03LA, LBXD05LA, LBXD07LA,
                              LBXF03LA, LBXF04LA, LBXF05LA, LBXF08LA)) 

## log transform exposure variables in the mixture
doLog=TRUE

if(doLog==TRUE){
  lnmixture   <- apply(mixture, 2, log)
}else{
  lnmixture   <- mixture
}

X <- scale(lnmixture)
colnames(X) <- c(paste0("PCB",c("074", "099", 118, 138, 153, 170, 180, 187, 194, 169, 126)),paste0("Dioxin",1:3), paste0("Furan",1:4)) 

## clean up exposure names and reorder
colnames(X)[c(1,2,4,5,6,7,8,9)] <- paste0("A-",colnames(X)[c(1,2,4,5,6,7,8,9)])
colnames(X)[c(10,11)] <- paste0("B-",colnames(X)[c(10,11)])
colnames(X)[c(3)] <- paste0("C--",colnames(X)[c(3)])
colnames(X)[c(12:18)] <- paste0("C-",colnames(X)[c(12:18)])
X <- X[,sort(colnames(X))]
colnames(X) <- substring(colnames(X),3); colnames(X)[substring(colnames(X),1,1)=="-"] <- substring(colnames(X)[substring(colnames(X),1,1)=="-"],2)

## covariates
covariates <- with(nhanes, cbind(age_z, agez_sq, male, bmicat2, bmicat3))
colnames(covariates)=c("age_z","agez_sq","male","bmicat2","bmicat3")

covariates2 <- with(nhanes, cbind(age_z, agez_sq, male, bmicat2, bmicat3, educat1, educat3, educat4, 
                                 otherhispanic, mexamerican, black, wbcc_z, lymphocytes_z, monocytes_z, 
                                 neutrophils_z, eosinophils_z, basophils_z, lncotinine_z)) 
                                 
colnames(covariates2)=c("age_z","agez_sq","male","bmicat2","bmicat3","educat1","educat3","educat4", 
                                 "otherhispanic", "mexamerican", "black", "wbcc_z", "lymphocytes_z", "monocytes_z", 
                                 "neutrophils_z", "eosinophils_z", "basophils_z", "lncotinine_z")

                               
## outcome
lnLTL_z <- scale(log(nhanes$TELOMEAN))

y <- lnLTL_z

#Put back into data frame for some methods (e.g. wqs)
dat <- as.data.frame(cbind(X,covariates2,y))

#add y to colnames (just list all again)
colnames(dat) <- c("PCB074" , "PCB099",  "PCB138",  "PCB153",  "PCB170",  "PCB180",  "PCB187",
        "PCB194"  ,"PCB126",  "PCB169" , "PCB118",  "Dioxin1", "Dioxin2", "Dioxin3",
        "Furan1" , "Furan2" , "Furan3"  ,"Furan4" , "age_z",   "agez_sq" ,"male",
         "bmicat2" ,"bmicat3", "educat1", "educat3" , "educat4" ,"otherhispanic", "mexamerican" ,  "black", 
         "wbcc_z", "lymphocytes_z" ,"monocytes_z" ,  "neutrophils_z", "eosinophils_z","basophils_z" ,  "lncotinine_z", "y")


## DESCRIPTIVE STATS

dim(dat)
summary(y)
summary(X)
summary(dat$age_z)
summary(dat$age_sq)
table(dat$bmicat3)
table(dat$educat1)


## DESCRIPTIVE PLOTS 
hist(y)


# Histogram of outcome variable
pdf(file="nhanes.hist.y.pdf", width=12, height=12)
  hist(y)
dev.off()

# Correlation of chemicals
cor_chem = cor(X, use="complete.obs")

pdf(file="nhanes.cor_chem.pdf", width=12, height=12)
  corrplot.mixed(cor_chem, upper = "ellipse", lower.col="black")
dev.off()



