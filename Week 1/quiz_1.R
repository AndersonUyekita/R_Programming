# Packages
library(tidyverse)


# Question 3
is.atomic(numeric())
is.atomic(data.frame())
is.atomic(logical())
is.atomic(matrix())
is.atomic(complex())
is.atomic(list())
is.atomic(array())
is.atomic(character())
is.atomic(integer())

# Question 4
class(x <- 4L)

# Question 5
class(x <- c(4, "a", TRUE))

# Question 6
dim(cbind(x <- c(1,3, 5), y <- c(3, 2, 10)))

# Question 8
x <- list(2, "a", "b", TRUE)

x[[2]]
class(x[[2]])

# Question 9
x <- 1:4
y <- 2:3

x + y
class(x + y)

# Question 10
x <- c(3, 5, 1, 10, 12, 6)
x[x < 6] <- 0
x


x <- c(3, 5, 1, 10, 12, 6)
x[x <= 5] <- 0
x

x <- c(3, 5, 1, 10, 12, 6)
x[x %in% 1:5] <- 0
x

# Criando diretório para armazenar os dados
dir.create(path = "./coursera")

# Baixar os dados da Quiz Week 1
download.file(url = "https://d396qusza40orc.cloudfront.net/rprog/data/quiz1_data.zip",
              destfile = "./coursera/quiz1_data.zip")

# Fazer o Unzip
unzip(zipfile = "./coursera/quiz1_data.zip", exdir = "./coursera/data")

# Nome do Arquivo
dir("./coursera/data")

# Criação do Path
path <- paste0("./coursera/data/", dir("./coursera/data"))

# Importação dos dados
df <- read.csv(file = path)

# Nome das Colunas
colnames(df)

# head
head(x = df, 2)

# nrows
nrow(df)

# tail
tail(df, 2)

# N 47
tail(head(df, 47), 1)

df[47,]

# missing value in Ozone Column
sum(is.na(df$Ozone))

# Ozone Mean excluding NA
df %>% filter(!is.na(Ozone)) %>% select(Ozone) %>% summarise(mean(Ozone))

mean(df$Ozone, na.rm = TRUE)

# Ozone above 31 and Temp above 90
df %>% filter(Ozone > 31 & Temp > 90) %>% summarise(mean(Solar.R))

mean(df[df$Ozone > 31 & df$Temp > 90,]$Solar.R, na.rm = TRUE)

# Mean Temp when Month is equal to 6
df %>% filter(Month == 6) %>% summarise(mean(Temp))

mean(df[df$Month == 6,]$Temp, na.rm = TRUE)

# maximum Ozone in May
df %>% filter(Month == 5) %>% summarise(max(Ozone, na.rm = TRUE))

max(df[df$Month == 5,]$Ozone, na.rm = TRUE)
