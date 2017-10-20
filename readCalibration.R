library("devtools")
# install_github("syounkin/ITHIM", ref="master")
install_github("ITHIM/ITHIM", ref="devel", force=TRUE)
library("ITHIM")

csvFileName <- "./ITHIM/CA_ITHIM_tests/SANDAG_ITHIM.csv"
xlFileName <- "./ITHIM/fromNeil/ITHIM_California2016-12-12SANDAG_Trends.xlsx"

SANDAG <- read.csv(csvFileName, header = T, stringsAsFactors = FALSE)
SANDAG <- readxl::read_excel(xlFileName, sheet="Calibration Data") 



# colClasses = c("integer",
#                "integer",
#                "integer",
#                "character",
#                "character",
#                "integer",
#                "character",
#                "character",
#                "character",
#                "integer",
#                "factor",
#                "factor",
#                "character",
#                "character",
#                "factor",
#                "character",
#                "factor",
#                "numeric",
#                "numeric",
#                "numeric",
#                "numeric",
#                "numeric",
#                "date",
#                "character",
#                "character",
#                "character")


holder <- createITHIM()
