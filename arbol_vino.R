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
attach(vino)

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

#Renombrar cada columna de la data
nombres <- readLines("wines_names.txt")[58:70] %>% 
  gsub("[[:cntrl:]].*\\)", "", .) %>% 
  trimws() %>% 
  tolower() %>% 
  gsub(" |/", "_", .) %>% 
  # Agregamos el nombre "tipo", para nuestra primera columna con los tipos de vino
  c("tipo", .)    
  
# Cambiar nombre de los datos
names(vino) <- nombres

#Cambiar tipo de dato de la columna 'tipo' a factor
vino <- vino %>%
  mutate_at("tipo", factor)

#Crear un sets de entrenamiento y prueba
#Se necesita un set de entrenamiento para generar un modelo predictivo, y un set de 
#prueba, para comprobar la eficacia de este modelo para hacer predicciones correctas.

#Hacer el ejemplo reproducible
set.seed(1649)

#Subconjunto de datos de 70%
vino_entrenamiento <- sample_frac(vino, .7)
View(vino_entrenamiento)

#Subconjunto de datos complementarios para set de pruebas 30% restante
vino_prueba <- setdiff(vino, vino_entrenamiento)
View(vino_prueba)

# Entrenar modelo: clasificar variable "tipo" con el resto de variables predictoras
arbol_1 <- rpart(formula = tipo ~ ., data = vino_entrenamiento)

# Evaluar el modelo
arbol_1

# Graficar el arbol
rpart.plot(arbol_1)
