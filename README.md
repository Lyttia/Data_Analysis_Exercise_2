# Data_Analysis_Exercise_2

Springboard Instructions:

Copy and paste the R code from the CHIS exercise in the ggplot2 tutorial into a file CHIS.R
Check in CHIS.R into your github repository
Submit the link to the appropriate file/folder in your github repository

Data Camp Instructions:

Exploring Data
In this chapter we're going to continuously build on our plotting functions and understanding to produce a mosaic plot (aka Marimekko plot). This is a visual representation of a contingency table, comparing two categorical variables. Essentially, our question is which groups are over or under represented in our dataset. To visualize this we'll color groups according to their Pearson residuals from a chi-squared test. At the end of it all we'll wrap up our script into a flexible function so that we can look at other variables.

We'll familiarize ourselves with a small number of variables from the 2009 CHIS adult-response dataset (as opposed to children). We have selected the following variables to explore:

RBMI: BMI Category description
BMI_P: BMI value
RACEHPR2: race
SRSEX: sex
SRAGE_P: age
MARIT2: Marital status
AB1: General Health Condition
ASTCUR: Current Asthma Status
AB51: Type I or Type II Diabetes
POVLL: Poverty level
We'll filter our dataset to plot a more reliable subset (we'll still retain over 95% of the data).

Before we get into mosaic plots it's worthwhile exploring the dataset using simple distribution plots - i.e. histograms.

ggplot2 is already loaded and the dataset, named adult, is already available in the workspace.

