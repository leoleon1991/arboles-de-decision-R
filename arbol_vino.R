#ARBOLES DE DECISION

#PAQUETES NECESARIOS
library(tidyverse)
library(rpart)
library(rpart.plot)
library(caret)

#Descargar archivos de datos
download.file("https://archive.ics.uci.edu/ml/machine-learning-databases/wine/wine.data", "wine.data")

#Descargar archivo de informacion de la data
download.file("https://archive.ics.uci.edu/ml/machine-learning-databases/wine/wine.names", "wine.names")

#Leer archivo linea por linea (Primeras 10 lineas)
readLines("wine.data", n = 10)

#Cargar data
vino <- read.table("wine.data", sep = ",", header = FALSE)

#Vizualizar datos 
View(vino)

#Archivo de informacion de la data
readLines("wine.names", n = 10)

#Crear copia
file.copy(from = "wine.names", to = "wines_names.txt")

#Leer archivo copia
file.show("wines_names.txt")

#Resumen estadistico de la data
summary(vino)
