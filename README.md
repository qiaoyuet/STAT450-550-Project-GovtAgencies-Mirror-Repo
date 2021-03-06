# STAT450-Group-Project-Government Agencies

## Overview

This repository is for project (The organization of tax collection and environmental protection in China) of Stat450/550 @ University of British Columbia.

## Group Members

|   **Name**     |     **Program**           |    **Email/Contact**              |
|----------------|---------------------------|-----------------------------------|
| Wenzheng Zhou  |    MSc. in Statistics     |    `wenzheng.zhou@stat.ubc.ca`    |
| Shanshan Pi    |    MSc. in Statistics     |    `shanshan.pi@stat.ubc.ca`      |
| Qiaoyue Tang   |    MSc. in Statistics     |    `qiaoyue.tang@stat.ubc.ca`     |
| Katie Li       |    BSc. in Statistics     |    `katie.li@alumni.ubc.ca`       |
| Jenne Hui      |    BSc. in Statistics     |    `jenne.hui@gmail.com`          |
| Harry Xu       |    BSc. in Statistics     |    `harryxu.ubc@gmail.com`        |

## Project Menu

-- [STAT550](Stat550)

-- [STAT450](stat450)

## Client Information

- Name: Wei Cui 
- Department: Peter A. Allard School of Law at UBC
- [Client's personal website](https://ubc.academia.edu/WeiCui)

# Case Proposal

### Case Summary

This project aims to better understand the distribution and trends of employment for two of China's civil government branches: Taxation Administration Services (TAS) and Environmental Protection Agencies (EPA). Specifically, we will be analyzing the number of staff at each government level from years 1992 to 2013. Employment in TAS are divided into two branches covering the state tax bureaus (STB) and local tax bureaus (LTB). The client expressed interests in finding different sources of influence on the organization of staffing in the different government branches, and also how the staffing structure behaves and changes over time for both government branches. We will be forming our hypotheses using these interests as a basis.

The main objectives of this project are: 
  1.  To visualize data in a clear and appealing ways to identify any patterns and trends for government staffing.  
  2.  To formulate a hypothesis to test any factor's significance on the staffing numbers.
  3.  To create a model that defines the staffing at various levels

### Data Description

Our main analysis will be on the panel datasets relating to each of the civil service branches (TAS, EPA). For both collections of datasets, the measures of staffing varies by time and has a response variable being the number of staff. The two datasets varies greatly in terms of size and complexity.

The EPA dataset is the smaller of the two, containing staffing data spanning from 1992 to 2011 (missing year 1994). The data is separated by the factors Province, Government Level, and Department. On the otherhand, the TAS datasets are further separated into the branch levels of local and state tax bureaus (as mentioned above). These datasets contains the factors Age, Education Level, Government Level, Province, and Department. Interestingly, the time span of the staffing data depends on the factor we are looking at. For example, there are 8 years (1996, 2000 - 2007) of data by Age in contrast to the 3 years (2000 - 2003) by Government Level.

Lastly , we have a third dataset containing economic and demographic variables such as GDP, Urban Area, and Population, for each province. These variables were tracked annually, from the years 2000-2013. We hope to incorporate this dataset into our visualization and panel regressions to see if there are any causal relations between these variables and the overall staffing trends and patterns. 

### Analysis outline
  
Because we have panel-structured data, panel regressions would be most appropriate to apply to the data. Panel regression typically consists of a response variable and one or more explanatory variables where all variables vary across both time (t = 1, …, T), and individual (i = 1, …, N). There are two main panel regression models to consider - fixed effects and random effects. The difference between fixed and random effects is based on whether we assume the individual-specific effect on the response is correlated or uncorrelated with explanatory variables. There are tests, such as the Wu-Haussman test and Pooled OLS that can be used to test (respectively) whether the fixed effect assumption and random effect assumption are met.
Before we get into the model-building, the first objective of the case study is to come up with meaningful ways to visualize the data. This is an important aspect of the case because our dataset includes many variables and it is hard to grasp what trends are occurring without proper visualization tools. The client has stated that he would like the visualization to “tell a story”, meaning we should try to tie all the variables together and look at the big picture. We are exploring the option of using Tableau for this portion of the analysis. Tableau is a powerful software tool that will allow us to plot multiple variables at once, apply dynamic filtering, and create dashboards to achieve the storytelling aspect. There are many possible relations that we are looking to illustrate:

- One aspect of the data we will explore is the relationship between staffing levels and economic and demographic indicators. To do this, we could plot the staffing levels over time (filtering on certain provinces, government levels, etc.) and overlay economic indicators on top, seeing if there are similar movements across time.

- Because there are so many provinces in the dataset, it would be interesting to see if any of them behave similarly over time. This would allow us to create “groups” of provinces to filter on and drill deeper into the dataset.

- We will also want to plot staffing numbers against their lag. If the resulting plot looks random, then it is likely that there are no time series components. However, if we find patterns in the lags, we may want to incorporate an autoregressive or moving-average component into our statistical analysis. 

The benefit of doing thorough visualization analysis is that we can use the findings to guide our hypotheses in the statistical modeling portion of the case, which is the next objective. As mentioned earlier, when constructing panel regression models, we will have to decide which variables will be treated as fixed effects and which will be random. Our visualization will give us more insight into what those fixed and random effects are. As Professor Kroc suggested, it may be plausible that provinces with stronger industrial output (and thus larger GDP and urban area) will have higher staffing numbers. We can plot staffing trends for different GDP levels (for example, grouped into “low”, “medium”, and “high); if staffing behaves similarly over time for all “levels” of GDP, it could indicate that GDP is a fixed effect on the number of staff. Based on our dataset, we feel that a mixed effect panel model would be more appropriate as it would allow us to capture the effects of both time-varying and time-invariant factors. There are several hypotheses that we would like to explore:

- One hypothesis we want to explore using mixed-effect models is if there are significant differences in staffing trends across the different provinces. The “individuals” in the model would be the provinces, and explanatory variables might include the “level” of staffing, province population, and others. For the EPA dataset, we can also explore if the distribution of staff among the various departments vary with province and with time. For this hypothesis, the response variable would be the % of total staff in each department rather than the overall count.

- Besides analyzing the government branches separately, we would also like to investigate if there are any similarities in staffing trends between the EPA and TAS branches. Unfortunately, the only overlap between the two datasets is the Province and Government Level factors so our model would be restricted to those variables only. From some preliminary exploration, we’ve found that staffing as decreased in both datasets from 2000-2007 – we could then explore if there are certain provinces or government levels where this decrease is more pronounced in both datasets. If we do find such as relationship, we can then introduce economic indicators to possibly explain the association.

- We also want to see if the staffing levels are correlated with any economic indicators. For example, do we see less staffing in times of lower GDP? This was mentioned earlier as something we would like to create plots for. Depending on the results, it would be good to empirically test these relationships because ultimately, we would like to provide a possible explanation of why certain trends in staffing are occurring. For the model, we would include the potential economic indicators as additional explanatory variables.

Ultimately, panel data allows the ability to test a wide range of hypothesis. We are hoping that as we explore the dataset more thoroughly on Tableau, we can determine which hypothesis are worth investigating further, and narrow the scope of potential relationships to test.

