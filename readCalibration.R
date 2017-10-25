rm(list=ls())

library("devtools")
# install_github("syounkin/ITHIM", ref="master")
install_github("ITHIM/ITHIM", ref="devel", force=TRUE)
library("ITHIM")

xlFileName <- "./ITHIM/fromNeil/ITHIM_California2016-12-12SANDAG_Trends.xlsx"

ITHIMss <- readxl::read_excel(xlFileName, sheet="Calibration Data") 

holder <- createITHIM()

getParameterSet(holder)

holder@parameters@Rwt


##############################
# extract baseline Population
popTemp <-
  ITHIMss %>% filter(
    item_name == "Distribution of population by age and gender",
    scenario_id == 0,
    sex %in% c("M", "F", "m", "f")) %>%
  select(age_group, sex, unwt_n) %>%
  spread(key = sex, value = unwt_n) %>%
  mutate(ageClass = paste0("ageClass", (1:8))) %>%
  select(c(4, 3, 2))



##############################
# extract baseline realtive walking means
RwtTemp <-
    ITHIMss %>% filter(item_name == "Per capita mean daily travel time by mode",
                       scenario_id == 0,
                       sex %in% c("M","F","m","f"), 
                       mode %in% c("walk","Walk")) %>%
    select(age_group, sex, item_result) %>%
    spread(key = sex, value = item_result) %>%
    mutate(ageClass = paste0("ageClass", (1:8))) %>%
    select(c(4,3,2))

##############################
# extract baseline relative cycling means
RctTemp <-
  ITHIMss %>% filter(item_name == "Per capita mean daily travel time by mode",
                     scenario_id == 0,
                     sex %in% c("M","F","m","f"), 
                     mode %in% c("bike","Bike")) %>%
  select(age_group, sex, item_result) %>%
  spread(key = sex, value = item_result) %>%
  mutate(ageClass = paste0("ageClass", (1:8))) %>%
  select(c(4,3,2))
# add a line to replace NA with zeros?



##############################
# extract baseline mean walking time
muwtTemp <-
  ITHIMss %>% filter(
    item_name == "Per capita mean daily travel time",
    scenario_id == 0,
    mode %in% c("walk", "Walk")) %>%
  select(item_result)


##############################
# extract baseline mean cycling time
muctTemp <-
  ITHIMss %>% filter(
    item_name == "Per capita mean daily travel time",
    scenario_id == 0,
    mode %in% c("bike", "Bike")) %>%
  select(item_result) 


##############################
# extract coefficient of variation
cvTemp <- 
  ITHIMss %>% filter(
    item_name == "Standard deviation of mean daily active travel time") %>%
  select(cv) 



