library("devtools")
# install_github("syounkin/ITHIM", ref="master")
install_github("ITHIM/ITHIM", ref="devel", force=TRUE)
library("ITHIM")

xlFileName <- "./ITHIM/fromNeil/ITHIM_California2016-12-12SANDAG_Trends.xlsx"

ITHIMss <- readxl::read_excel(xlFileName, sheet="Calibration Data") 



holder <- createITHIM()

getParameterSet(holder)
