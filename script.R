install.packages("tidyverse", dependencies = TRUE)
install.packages("dplyr", dependencies = TRUE)
library(tidyverse)
library(dplyr)

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


#rename collumns
colnames(desocupados3) <- c("Region", "Trimester", "Quantity", "Period")

#reorder collumns
desocupados4 <- desocupados3[,c(1,2,4,3)]

#remanage tables
desocupados_raw <- desocupados
desocupados <- desocupados4
rm(desocupados2,desocupados3,desocupados4)

#convert value to real dimensions
desocupados$Quantity <- desocupados$Quantity * 1000

#Separating tables per region
desocupados_estado <- subset(desocupados, !(Region %in% c("Norte", "Nordeste", "Sul", "Centro-Oeste", "Sudeste", "Brasil")))
desocupados_regiao <- subset(desocupados, (Region %in% c("Norte", "Nordeste", "Sul", "Centro-Oeste", "Sudeste", "Brasil")))
desocupados_brasil <- subset(desocupados, Region == "Brasil")

#Remove total
desocupados_estado <- subset(desocupados_estado, Period != "Total")
desocupados_regiao <- subset(desocupados_regiao, Period != "Total")
desocupados_brasil <- subset(desocupados_brasil, Period != "Total")

#group by region
desocupados_regiao %>% 
  group_by(Region) %>% 
  summarise(Média = mean(Quantity))

desocupados_estado %>% 
  group_by(Region) %>% 
  summarise(Média = mean(Quantity))

#group by period
desocupados_regiao %>% 
  group_by(Period) %>% 
  summarise(Média = mean(Quantity))

desocupados_estado %>% 
  group_by(Period) %>% 
  summarise(Média = mean(Quantity))

#Plots
desocupados_regiao %>% 
  ggplot(aes(x = Period, y = Quantity)) +
  geom_bar(stat = "identity") +
  facet_wrap(~Region)
  
