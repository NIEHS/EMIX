# EMIX
Repository of statistical methods for environmental mixtures analyses in epidemiology.

## Description

EMIX provides a repository of statistical methods for environmental mixtures analyses in epidemiology. The EMIX_Methods file lists example statistical methods, including the summary, original methods publication, and link to R code for implementation. For each method, column headers also describe alignment to steps 3-5 of a workflow that can be used to identify methods for a given application/scenario, described in Joubert et al., medRxiv 2024 (https://doi.org/10.1101/2024.12.20.24318087; in press with Environmental Health Perspectives DOI 10.1289/EHP16791. 

## Background

Human exposure to complex, changing, and variably correlated mixtures of environmental exposures is a common analytical challenge for epidemiologists and human health researchers. Fortunately, a wide variety of statistical methods for analyzing mixtures data exists, and most methods have open-source software for implementation. However, there is no one-size-fits-all method for analyzing mixtures data given the considerable heterogeneity in scientific focus and study design. For example, some methods focus on predicting the overall health effect of a mixture and others seek to disentangle main effects and pairwise interactions. Some methods are only appropriate for cross-sectional designs, while other methods can accommodate longitudinally measured exposures or outcomes.

A recently published article presents a workflow researchers can apply to statistical analysis considerations in environmental mixtures data (Joubert et al., medRxiv 2024, doi 10.1101/2024.12.20.24318087; Environmental Health Perspectives 2025 DOI 10.1289/EHP16791, in press). The strategy builds on epidemiological and statistical principles, tailored to specific nuances of the mixtures’ context. The workflow involves six steps (Figure 1), three of which can be considered by using the accompanying EMIX_Methods table.  

## Workflow Overview

The workflow considers the context of a researcher with an existing dataset or hypothesis of interest. Researchers can address each step sequentially to determine which method(s) may be most appropriate for a given scenario. Common epidemiological/statistical practice is incorporated, considering unique nuances of the environmental mixtures data such as chemical properties, correlation of exposures, and longitudinal study designs with multiple timepoints. The steps are summarized in Figure 1 and Supplementary Table 1 of the noted publication and listed briefly below. 

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

* Click on the excel file and view raw data, or download to a preferred location. 
* Ensure column filters are on
* To address workflow steps 3-5, select “1” to indicate a “yes” response for columns where a restriction is known. E.g., 
* A “0” indicates the response “no” and can be selected or left alone.

## Method Updates

Methods can be updated, and new methods added by original methodologists. To do this, download and edit the table, then submit a pull request. The update will be reviewed by NIEHS staff and posted to the site once updates are final. 

Corrections, clarifications, or questions can also be submitted via email to the EMIX repository owners.

