rm(list=ls())

library("devtools")
# install_github("syounkin/ITHIM", ref="master")
install_github("ITHIM/ITHIM", ref="devel", force=TRUE)
library("ITHIM")

xlFileName <- "./ITHIM/fromNeil/ITHIM_California2016-12-12SANDAG_Trends.xlsx"

ITHIMss <- readxl::read_excel(xlFileName, sheet="Calibration Data") 

holder <- createITHIM()

getParameterSet(holder)

holder@parameters@F


# extract scenario Population
calibPop <-function(scenario){
  popTemp <-
    ITHIMss %>% filter(item_name == "Distribution of population by age and gender",
                       scenario_id == scenario,
                       sex %in% c("M","F","m","f")) %>%
    select(age_group, sex, unwt_n) %>%
    spread(key = sex, value = unwt_n) %>%
    mutate(ageClass = paste0("ageClass", (1:8))) %>%
    select(c(4,3,2))
  
  return(popTemp)
  
}


# extract scenario mean walking time
calibmuwt <-function(scenario){
  wtTemp <-
    ITHIMss %>% filter(item_name == "Per capita mean daily travel time by mode",
                       scenario_id == 1,
                       sex %in% c("M","F","m","f"), 
                       mode %in% c("walk","Walk")) %>%
    select(age_group, sex, item_result) %>%
    spread(key = sex, value = item_result) %>%
    mutate(ageClass = paste0("ageClass", (1:8))) %>%
    select(c(4,3,2))
  
  return(popTemp)
  
}

