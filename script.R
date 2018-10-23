install.packages("tidyverse", dependencies = TRUE)
library(tidyverse)

header <- scan("des_tratada.csv", nlines = 1, what = character(), sep = ",")
header2 <- scan("des_tratada.csv", nlines = 1, what = character(), sep = ",", skip = 1)
desocupados <- read.csv2('des_tratada.csv', sep = ",", header = FALSE, skip = 2)
names(desocupados) <- paste0(header, "||", header2)

desocupados2 <- desocupados %>% 
  gather("período", "quantidade", 2:131)

periodos <- str_extract(names(desocupados), "(?<=\\|\\|).*")

desocupados3 <- desocupados2 %>% 
mutate(PERIODO = periodos) 
  
periodos <- str_extract(desocupados2$período, "(?<=\\|\\|).*")

desocupados3$período <-  str_replace(desocupados3$período, "(?<=\\|\\|).*", "")

desocupados3$período <-  str_replace(desocupados3$período, "\\|\\|", "")

names(desocupados)

View(periodos)
