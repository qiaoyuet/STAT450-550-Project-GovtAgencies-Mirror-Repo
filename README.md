# STAT450-Group-Project-Government Agencies

## Overview

This repository is for project (The organization of tax collection and environmental protection in China) of Stat450/550 @ University of British Columbia.

## Group Members

|   **Name**     |     **Program**           |    **Email/Contact**              |
|----------------|---------------------------|-----------------------------------|
| Wenzheng Zhou  |    MSc. in Statistics     |    `wenzheng.zhou@stat.ubc.ca`    |
| Shanshan Pi    |    MSc. in Statistics     |    `shanshan.pi@stat.ubc.ca`      |
| Qiaoyue Tang   |    MSc. in Statistics     |    `qiaoyue.tang@stat.ubc.ca`     |
| Katie Li       |    BSc. in Statistics     |    'katie.li@alumni.ubc.ca'       |
| Jenne Hui      |    BSc. in Statistics     |    `jenne.hui@gmail.com`          |
| Harry Xu       |    BSc. in Statistics     |    `harryxu.ubc@gmail.com`        |

## Client Information

- Name: Wei Cui 
- Department: Peter A. Allard School of Law at UBC
- [client's personal website](https://ubc.academia.edu/WeiCui)

## Case Summary

The project aims to better understand the distribution of the employment for China's government braches: taxation administration services and Environmental Protection Agencies (EPAs), and mainly, the number of staffing at each government level, from year 1992 to 2013. Employment in taxation services are diviede into two branches covering the state tax bureau (STB) and local tax bureau (LTB). 
The project is interested in finding whether there is, or when there is, and by how much there is a change in the organization of the tax offices. Are there any relationships among the age composition, education levels, and the amount of work force per area?

This project consists of the following objectives: 
- 1. To visualize data in a clear and appealing ways to identify any patterns and trends for government staffing.  
- 2. To formulate a hypthesis to test any factor's significance on the staffing numbers.
- 3. To create a model that defines the staffing at various levels

## Case Proposal

## Data Description

We have one dataset for each of the two civil service branches that we will analyze. The response variable for both datasets is the number of staff. Our data is structured as panel data because the measures of staffing vary in both time and other factors such as province, staffing level, and department. The environmental personnel branch dataset spans 1992 – 2011, and the explanatory variables are year, province, level of staffing, and department. The dataset for the tax administration branch includes more variables such as education level and age. There are also two different tax bureaus, state and local. We also have a third dataset of economic and demographic factors for each province and year, such as GDP and population – we can incorporate these variables in our panel regression.

## Analysis outline
  
  The first objective of the case study is to come up with meaningful ways to visualize the data. This is important because our dataset includes many variables and it is hard to grasp what trends are occurring without proper visualization. The client has stated that he would like the visualization to “tell a story”, meaning we should try to tie all the variables together and look at the big picture. We will use the Tableau software to explore the data – Tableau will allow us to plot multiple variables at once, apply dynamic filtering, and create dashboards to achieve the storytelling aspect. One aspect we might try to explore is the relationship between staffing levels and economic indicators – we could plot the staffing levels over time (filtering on certain provinces, levels, etc.) and overlay economic indicators on top, seeing if there are similar movements across time.  [**add more info about which variables/relations you want to illustrate, explore, etc?**]
 
 The next objective is to try to answer specific hypothesis using statistical models. There are two main panel regression models – fixed effects and random effects. Fixed effect models try to capture the effect of each individual on the response variable over time, removing all time-invariant characteristics. In random effect models, both differences across individuals and differences across time are captured. In our dataset, there might be both time-varying and time-invariant factors – therefore we would want to utilize a mixed effect panel model to capture both types.  One hypothesis we want to explore using mixed-effect models is if there are significant differences in staffing trends across the different provinces. The “individuals” in the model would be the provinces, and explanatory variables might include the “level” of staffing, province population, and others. If we see significant differences between different provinces for one dataset, we may also want to explore if similar patterns are seen in the other dataset. Besides investigating the variability in staffing levels across provinces, we also want to see if the staffing levels are correlated with any economic indicators. For example, do we see less staffing in times of lower GDP? **[more model specifics] [Specify which model assumptions need to be tested, why and how]**
