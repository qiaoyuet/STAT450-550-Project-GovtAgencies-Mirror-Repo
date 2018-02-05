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

## Client Information

- Name: Wei Cui 
- Department: Peter A. Allard School of Law at UBC
- [Client's personal website](https://ubc.academia.edu/WeiCui)

# Case Proposal

### Case Summary

This project aims to better understand the distribution and trends of employment for two of China's civil government branches: Taxation Administration Services (TAS) and Environmental Protection Agencies (EPA). Specifically, we will be analyzing the number of staff at each government level from years 1992 to 2013. Employment in TAS are divided into two branches covering the state tax bureaus (STB) and local tax bureaus (LTB). The client expressed interests in finding different sources of influence on the organization of staffing in the different government branches, and also how the staffing structure behaves and changes over time. We will be forming our hypotheses using these interests as a basis.

The main objectives of this project are: 
  1.  To visualize data in a clear and appealing ways to identify any patterns and trends for government staffing.  
  2.  To formulate a hypothesis to test any factor's significance on the staffing numbers.
  3.  To create a model that defines the staffing at various levels

### Data Description

Our main analysis will be on the panel datasets relating to each of the civil service branches (TAS, EPA). For both collections of datasets, the measures of staffing varies by time and has a response variable being the number of staff. The two datasets varies greatly in terms of size and complexity.

The EPA dataset is the smaller of the two, containing staffing data spanning from 1992 to 2011. The data is separated by the factors Province, Government Level, and Department. On the otherhand, the TAS datasets are further separated into the branch levels of local and state tax bureaus (as mentioned above). These datasets contains the factors Age, Education Level, Government Level, Province, and Department. Interestingly, the time span of the staffing data depends on the factor we are looking at. For example, there are 8 years (1996, 2000 - 2007) of data by Age in contrast to the 3 years (2000 - 2003) by Government Level.

Lastly , we have a third dataset containing economic and demographic variables such as GDP, Urban Area, and Population, for each province; the data spans from ... . We can incorporate this dataset into our panel regressions to see if there are any causal relations between these variables and the overall staffing trends / patterns. 

### Analysis outline
  
  The first objective of the case study is to come up with meaningful ways to visualize the data. This is important because our dataset includes many variables and it is hard to grasp what trends are occurring without proper visualization. The client has stated that he would like the visualization to “tell a story”, meaning we should try to tie all the variables together and look at the big picture. We will use the Tableau software to explore the data – Tableau will allow us to plot multiple variables at once, apply dynamic filtering, and create dashboards to achieve the storytelling aspect. One aspect we might try to explore is the relationship between staffing levels and economic indicators – we could plot the staffing levels over time (filtering on certain provinces, levels, etc.) and overlay economic indicators on top, seeing if there are similar movements across time.  [**add more info about which variables/relations you want to illustrate, explore, etc?**]
 
 The next objective is to try to answer specific hypothesis using statistical models. There are two main panel regression models – fixed effects and random effects. Fixed effect models try to capture the effect of each individual on the response variable over time, removing all time-invariant characteristics. In random effect models, both differences across individuals and differences across time are captured. In our dataset, there might be both time-varying and time-invariant factors – therefore we would want to utilize a mixed effect panel model to capture both types.  One hypothesis we want to explore using mixed-effect models is if there are significant differences in staffing trends across the different provinces. The “individuals” in the model would be the provinces, and explanatory variables might include the “level” of staffing, province population, and others. If we see significant differences between different provinces for one dataset, we may also want to explore if similar patterns are seen in the other dataset. Besides investigating the variability in staffing levels across provinces, we also want to see if the staffing levels are correlated with any economic indicators. For example, do we see less staffing in times of lower GDP? **[more model specifics] [Specify which model assumptions need to be tested, why and how]**
