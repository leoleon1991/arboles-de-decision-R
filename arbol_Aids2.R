# Clasificacion por arbol de decision a la data Aids2 con el paquete rpart

#PAQUETES NECESARIOS
library(tidyverse)
library(rpart)
library(rpart.plot)
library(caret)

# Resumen - summary de la data 
summary(Aids2)

# Attach para manipulacion de columnas
attach(Aids2)

# Datos de entrenamiento
set.seed(101)

# Set de entrenamiento 70%
Aids2_train <- sample_frac(Aids2, .7)

# SUbconjunto de datos 30% set de prueba
Aids2_test <-  setdiff(Aids2, Aids2_train)

# Entrenar modelo: clasificar variable "status" con el resto de variables predictoras
Aids2_tree <- rpart(formula = T.categ ~ sex+status+age, data = Aids2_train)

# Detalles del modelo
Aids2_tree

# Graficar Arbol
rpart.plot(Aids2_tree)

#Predicciones del modelo
Aids2_pred <- predict(object = Aids2_tree, newdata = Aids2_test, type = "class")

#Cruzar prediccion con datos reales - Matriz de confusion
confusionMatrix(Aids2_pred, Aids2_test[["T.categ"]])
