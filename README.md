# EMIX
Repository of statistical methods for environmental mixtures analyses in epidemiology.

## Description

EMIX provides a repository of statistical methods for environmental mixtures analyses in epidemiology. The EMIX_Methods file lists example statistical methods, including the summary, original methods publication, and link to R code for implementation. For each method, column headers also describe alignment to steps 3-5 of a workflow that can be used to identify methods for a given application/scenario, described in Joubert et al., medRxiv 2024 (https://doi.org/10.1101/2024.12.20.24318087; in press with Environmental Health Perspectives DOI 10.1289/EHP16791. 

## Background

Human exposure to complex, changing, and variably correlated mixtures of environmental exposures is a common analytical challenge for epidemiologists and human health researchers. Fortunately, a wide variety of statistical methods for analyzing mixtures data exists, and most methods have open-source software for implementation. However, there is no one-size-fits-all method for analyzing mixtures data given the considerable heterogeneity in scientific focus and study design. For example, some methods focus on predicting the overall health effect of a mixture and others seek to disentangle main effects and pairwise interactions. Some methods are only appropriate for cross-sectional designs, while other methods can accommodate longitudinally measured exposures or outcomes.

A recently published article presents a workflow researchers can apply to statistical analysis considerations in environmental mixtures data (Joubert et al., medRxiv 2024, doi 10.1101/2024.12.20.24318087; Environmental Health Perspectives 2025 DOI 10.1289/EHP16791, in press). The strategy builds on epidemiological and statistical principles, tailored to specific nuances of the mixtures’ context. The workflow involves six steps (Figure 1), three of which can be considered by using the accompanying EMIX_Methods table.  

## Workflow Overview

The workflow considers the context of a researcher with an existing dataset or hypothesis of interest. Researchers can address each step sequentially to determine which method(s) may be most appropriate for a given scenario. Common epidemiological/statistical practice is incorporated, considering unique nuances of the environmental mixtures data such as chemical properties, correlation of exposures, and longitudinal study designs with multiple timepoints. The steps are summarized in the ! [Workflow Overview Figure] (https://github.com/NIEHS/EMIX/blob/main/WorkflowOverview.png) and briefly expanded below.   

### Step 1. Conceptual Model Development

* Direct Acyclic Graph (DAG) analysis and Covariate Selection

### Step 2. Data Processing and Exploratory Analysis

* Examine the correlation of exposures 
* Examine statistical power
* Exposure dimension reduction (optional)
* Variable transformation (optional)
* Manage missing data

### Step 3. Study Design and Data Characteristics

These steps can be addressed using the excel table column filters (0=no, 1=yes to the questions below).

* Single or repeated timepoints for exposures and outcomes: Is the study longitudinal, with repeated measurements of exposures and/or outcomes or is there only a single timepoint for the measurement of exposure and outcome variables?
* Spatial data: Does the study include data with spatial variation and/or does spatial correlation among outcomes need to be considered in the model?
* Distribution of the outcome: Does the dataset include a continuous, binary, categorical, count, or time-to-event (survival) outcome variable?
* Size of the dataset: How many individuals and how many exposures/variables are included in the dataset for analysis?
* Survey or sampling weights: Are there survey or sampling weights to include in the analysis?

### Step 4. Scientific Knowledge

These questions address the effects of exposures within a mixture on the outcome.

* Are exposures hypothesized to act in the same direction, or should the model allow for the possibility effects operate in different directions? 
* Is the exposure-response relationship likely to be non-linear? 
* Is there biological, toxicological, or other information about the potential effects of the exposures such as chemical groups that should be included in the statistical model? 
* Are there chemical properties/features to include in the model?

### Step 5. Research Questions

These questions address the research question(s) of interest for the analysis. 

* Overall effect estimation: Do you wish to determine the overall or aggregate effect of the mixture of exposures on a health outcome?
* Individual exposure effects: Do you wish to identify independent effects of mixtures components (“toxic agents” or “bad actors”)?
* Interactions: Do you wish to allow potential interaction effects among mixture components?
* Mediation: Do you wish to examine either the role of a mediator on the pathway between a mixture and an outcome, or the role of a mixture as a mediator on the pathway of another risk factor and an outcome?

### Step 6. Assessment and Evaluation

These prompts can be addressed after model implementation.

* Assumptions: Examine the underlying assumptions of each model identified relevant to a scenario (e.g., multivariate normal distribution, constant variance)
* Convergence: Confirm successful model convergence (e.g., by using trace plots, MCMC model output, etc.)
* Overfitting: Assess model results for fit and performance (e.g., evaluate “out-of-sample” data)

## How to use the table

* Click on the excel file and view raw data
* View a copy that can be edited in a browser, or download a copy of the excel file and enable editing 
* Ensure column filters can be modified. If not, revisit above to enable editing.
* To address workflow steps 3-5, select “1” to indicate a “yes” response for key features of the analysis application in mind. For example:
  * Continuous outcome
  * Multiple (2-5) timepoints of the exposure
  * Consider models that can address the research question, overall effect of the mixture
* A “0” indicates the response “no” and can be selected or left alone.
* After selecting key features of interest, the rows will be displayed only for methods relevant to the application.
* Click on the links for each method to view the original methods paper and the GitHub site for code and developer contact information.
* Proceed with analysis and step 6 – assessment and evaluation
* Return to the table to address other analysis datasets or research questions of interest. 


## Method Updates

Methods can be updated, and new methods added by original methodologists. To do this, download and edit the table, then submit a pull request. The update will be reviewed by NIEHS staff and posted to the site once updates are final. 

Corrections, clarifications, or questions can also be submitted via email to the EMIX repository owners.


# Example Applications

Two example scenarios describing broad decision making are presented in Joubert et al. EHP 2025. More details and links to data are available below. 

## R Packages

The examples use the following R packages:

* devtools
* tidyverse
* grpreg
* janitor
* dplyr
* tidyr
* corrplot
* ggplot2

# NHANES

## Step 1. Conceptual Model Development

* Direct Acyclic Graph (DAG) analysis and Covariate Selection
* This step is completed outside of R programming

## Step 2. Data Processing and Exploratory Analysis

Original data is from the cross-sectional 2001-2002 National Health and Nutrition Examination Survey (NHANES) dataset of 1,330 adults previously described and used by Mitro et al. 2016. 

* Mitro SD, Birnbaum LS, Needham BL, Zota AR. Cross-sectional Associations between Exposure to Persistent Organic Pollutants and Leukocyte Telomere Length among U.S. Adults in NHANES, 2001-2002. Environ Health Perspect. May 2016;124(5):651-8. doi:10.1289/ehp.1510187

Processed data has been previously deposited (open access) for the 2019 Columbia Mixtures workshop: 
 
* Columbia.Mixtures.Workshop.2019/Data at master · niehs-prime/Columbia.Mixtures.Workshop.2019
  * https://github.com/niehs-prime/Columbia.Mixtures.Workshop.2019/tree/master/Data/studypop.csv 
  * https://github.com/niehs-prime/Columbia.Mixtures.Workshop.2019/tree/master/Data/data_dictionary.xlsx 

* Data management/prep

Example data management and processing steps of this commonly used dataset have been previously published. For this example of mixtures methods testing, an adapted example is available in this EMIX repository. Note, the ordering of steps in the example code is slightly different than the order presented in the publication and can be adjusted to a researcher’s preference.

See full example script dataprep_descriptives.nhanes.r for the steps below

* Examine the correlation of exposures 

library(corrplot)
library(ggplot2)

cor_chem = cor(X, use="complete.obs")

pdf(file="nhanes.cor_chem.pdf", width=12, height=12)
corrplot.mixed(cor_chem, upper = "ellipse", lower.col="black")
dev.off()

* Variable transformation (optional)

Example code to center, scale, square, and categorize age, body mass index, and education variables.

nhanes <- na.omit(read.table("studypop.csv", header=TRUE,sep=","))

nhanes$age_z         <- scale(nhanes$age_cent)         ## center and scale age
nhanes$agez_sq       <- nhanes$age_z^2                 ## square this age variable
nhanes$bmicat2       <- as.numeric(nhanes$bmi_cat3==2) ## 25 <= BMI < 30
nhanes$bmicat3       <- as.numeric(nhanes$bmi_cat3==3) ## BMI >= 30 (BMI < 25 is the reference)
nhanes$educat1       <- as.numeric(nhanes$edu_cat==1)  ## no high school diploma
nhanes$educat3       <- as.numeric(nhanes$edu_cat==3)  ## some college or AA degree
nhanes$educat4       <- as.numeric(nhanes$edu_cat==4)  ## college grad or above (reference is high school grad/GED or equivalent)

## exposure matrix
mixture <- with(nhanes, cbind(LBX074LA, LBX099LA, LBX118LA, LBX138LA, LBX153LA, LBX170LA, LBX180LA, LBX187LA,LBX194LA, LBXHXCLA, LBXPCBLA, LBXD03LA, LBXD05LA, LBXD07LA,                           LBXF03LA, LBXF04LA, LBXF05LA, LBXF08LA)) 

if(doLog==TRUE){
  lnmixture   <- apply(mixture, 2, log)
} else {
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
                                 
colnames(covariates2)=c("age_z","agez_sq","male","bmicat2","bmicat3","educat1","educat3","educat4", "otherhispanic", "mexamerican", "black", "wbcc_z", "lymphocytes_z", "monocytes_z", 
                                 "neutrophils_z", "eosinophils_z", "basophils_z", "lncotinine_z")
   
## outcome
lnLTL_z <- scale(log(nhanes$TELOMEAN))

y <- lnLTL_z

#Put back into data frame for some methods (e.g., wqs)
dat <- as.data.frame(cbind(X,covariates2,y))

#add y to colnames (just list all again)
colnames(dat) <- c("PCB074" , "PCB099",  "PCB138",  "PCB153",  "PCB170",  "PCB180",  "PCB187",
"PCB194"  ,"PCB126",  "PCB169" , "PCB118",  "Dioxin1", "Dioxin2", "Dioxin3", "Furan1" , "Furan2" , "Furan3"  ,"Furan4" , "age_z",   "agez_sq" ,"male","bmicat2" ,"bmicat3", "educat1", "educat3" , "educat4" ,"otherhispanic", "mexamerican" ,  "black", "wbcc_z", "lymphocytes_z" ,"monocytes_z" ,  "neutrophils_z", "eosinophils_z","basophils_z" ,  "lncotinine_z", "y")

* Exposure dimension reduction (optional)

Example strategies for mixtures include Principal Component Pursuit for Environmental Epidemiology
https://columbia-prime.r-universe.dev/pcpr 

* Manage missing data

Example strategy for complete case analysis (assumes missing is at random)

cor_chem = cor(X, use="complete.obs")

## Step 3. Study Design and Data Characteristics

These steps can be addressed using the excel table column filters (0=no, 1=yes to the questions below).

* Single or repeated timepoints for exposures and outcomes: Is the study longitudinal, with repeated measurements of exposures and/or outcomes or is there only a single timepoint for the measurement of exposure and outcome variables?
  * Single timepoint for exposure and outcome

* Spatial data: Does the study include data with spatial variation and/or does spatial correlation among outcomes need to be considered in the model?
  * No spatial data

* Distribution of the outcome: Does the dataset include a continuous, binary, categorical, count, or time-to-event (survival) outcome variable?
  * Continuous outcome

* Size of the dataset: How many individuals and how many exposures/variables are included in the dataset for analysis?
  * 500-5K individuals, <20 exposures

* Survey or sampling weights: Are there survey or sampling weights to include in the analysis?
  * No (not for this analysis)

## Step 4. Scientific Knowledge

These questions address the effects of exposures within a mixture on the outcome.

* Are exposures hypothesized to act in the same direction, or should the model allow for the possibility effects operate in different directions? 
  * No preference

* Is the exposure-response relationship likely to be non-linear? 
  * No

* Is there biological, toxicological, or other information about the potential effects of the exposures such as chemical groups that should be included in the statistical model? 
  * No

* Are there chemical properties/features to include in the model?
  * No

## Step 5. Research Questions

These questions address the research question(s) of interest for the analysis. 

* Overall effect estimation: Do you wish to determine the overall or aggregate effect of the mixture of exposures on a health outcome?
  * Yes

* Individual exposure effects: Do you wish to identify independent effects of mixtures components (“toxic agents” or “bad actors”)?
  * Yes

* Interactions: Do you wish to allow potential interaction effects among mixture components?
  * No (not in this analysis)

* Mediation: Do you wish to examine either the role of a mediator on the pathway between a mixture and an outcome, or the role of a mixture as a mediator on the pathway of another risk factor and an outcome?
  * No (not in this analysis)

## Results

See Figure 2 of publication for example list of relevant methods


# ReCHARGE

## Step 1. Conceptual Model Development

* Direct Acyclic Graph (DAG) analysis and Covariate Selection
* This step is completed outside of R programming

## Step 2. Data Processing and Exploratory Analysis

The original RECHARGE data was obtained from the publicly available data in the Human Health Exposure Resource (HHEAR) Data Repository (https://hheardatacenter.mssm.edu/), project # 2016-1461; doi 10.36043/1461_222, 10.36043/1461_219, 10.36043/1461_630_2022.2. 

* Data management/prep

Example data management and processing steps of this commonly used dataset have been previously published. The code and ordering of steps presented here are slightly adjusted.

See full example script dataprep_descriptives.recharge.r for the steps to read and complete data transformation steps. 

* Manage missing data

Example strategy assigning missing values the value of LOD/sqrt(2)

#Replace chemical row values below LOD with LOD/sqrt(2)
chem_data2$concentration2 = chem_data2$concentration
chem_data2$concentration2[chem_data2$comment_code == 97] <- chem_data2$lod[chem_data2$comment_code == 97]/sqrt(2)

* Examine the correlation of exposures 

# Correlation plots
cor_chem = cor(X, use="complete.obs")
cor_pest = cor(pest, use="complete.obs")
cor_metals = cor(metals, use="complete.obs")
cor_phenols = cor(phenols, use="complete.obs")
cor_parabens = cor(parabens, use="complete.obs")
cor_phthalates = cor(phthalates, use="complete.obs")

pdf(file="/ddn/gs1/home/joubertbr/mixtures/results/recharge/recharge.cor.all.pdf", width=12, height=12)
  corrplot(cor_chem, method = 'color')
dev.off()

* Exposure dimension reduction (optional)
  * No applied in this example

* Examine statistical power

## Step 3. Study Design and Data Characteristics

These steps can be addressed using the excel table column filters (0=no, 1=yes to the questions below).

* Single or repeated timepoints for exposures and outcomes: Is the study longitudinal, with repeated measurements of exposures and/or outcomes or is there only a single timepoint for the measurement of exposure and outcome variables?
  * 2-5 timepoints for exposure, single timepoint for outcome
 
* Spatial data: Does the study include data with spatial variation and/or does spatial correlation among outcomes need to be considered in the model?
  * No spatial data

* Distribution of the outcome: Does the dataset include a continuous, binary, categorical, count, or time-to-event (survival) outcome variable?
  * Binary outcome

* Size of the dataset: How many individuals and how many exposures/variables are included in the dataset for analysis?
  * <500 individuals, 20-100 exposures
  
* Survey or sampling weights: Are there survey or sampling weights to include in the analysis?
  * No (not applicable)

## Step 4. Scientific Knowledge

These questions address the effects of exposures within a mixture on the outcome.

* Are exposures hypothesized to act in the same direction, or should the model allow for the possibility effects operate in different directions? 
  * No preference

* Is the exposure-response relationship likely to be non-linear? 
  * No

* Is there biological, toxicological, or other information about the potential effects of the exposures such as chemical groups that should be included in the statistical model? 
  * No

* Are there chemical properties/features to include in the model?
  * No

## Step 5. Research Questions

These questions address the research question(s) of interest for the analysis. 

* Overall effect estimation: Do you wish to determine the overall or aggregate effect of the mixture of exposures on a health outcome?
  * Yes

* Individual exposure effects: Do you wish to identify independent effects of mixtures components (“toxic agents” or “bad actors”)?
  * Yes

* Interactions: Do you wish to allow potential interaction effects among mixture components?
  * No

* Mediation: Do you wish to examine either the role of a mediator on the pathway between a mixture and an outcome, or the role of a mixture as a mediator on the pathway of another risk factor and an outcome?
  * No


## Results

See Figure 3 of publication for example list of relevant methods
