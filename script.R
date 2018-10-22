header <- scan("des_tratada.csv", nlines = 1, what = character(), sep = ",")
header2 <- scan("des_tratada.csv", nlines = 1, what = character(), sep = ",", skip = 1)
desocupados <- read.csv2('des_tratada.csv', sep = ",")
names(desocupados) <- header

col.names <- c("Regiao", "Trimestre", "Período", "n")

Regiao	trimestre	periodo	n
