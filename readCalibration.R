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


# grab scenario Population
calibPop <-function(scenario){
  popTemp <-
    ITHIMss %>% filter(item_name == "Distribution of population by age and gender",
                       scenario_id == 1,
                       sex %in% c("M","F","m","f")) %>%
    select(age_group, sex, unwt_n) %>%
    spread(key = sex, value = unwt_n) %>%
    mutate(ageClass = paste0("ageClass", (1:8))) %>%
    select(c(4,3,2))
  
  return(popTemp)
  
}


update(holder, F = select(pop0, "F","M"))
