# Clasificacion por arbol de decision con el paquete "tree" a la data IRIS.

#Cargar libreria tree
library(tree)

# Selección muestra entrenamiento
train <- sample(seq(length(iris$Species)), length(iris$Species)*0.70, replace = FALSE)

# Modelo 
iris.tree <- tree(iris$Species ~ ., iris, subset = train)

# Summary del modelo
summary(iris.tree)

# Graficar el arbol
plot(iris.tree);text(iris.tree,pretty = 0)

# Detalles del arbol
iris.tree

# Predicciones 
tree.pred <- predict(iris.tree, iris[-train], type = "class")

# Summary de predicciones
summary(tree.pred)

# Matriz de confusion
with(iris[-train], table(tree.pred, iris$Species))

# Mediante validación cruzada se busca el mejor arbol de decision
cv.iris <- cv.tree(iris.tree, FUN = prune.misclass)
cv.iris

# Grafica
plot(cv.iris)

# Clasificacion por arbol de decision con el paquete "rpart" a la data IRIS.
library(tidyverse)
library(rpart)
library(rpart.plot)
library(caret)

#Crear un sets de entrenamiento y prueba
set.seed(101)

#Subconjunto de datos de 70%
iris_entrenamiento <- sample_frac(iris, .7)

#Subconjunto de datos complementarios para set de pruebas 30% restante
iris_test <- setdiff(iris, iris_entrenamiento)

# Entrenar el modelo
arbol_iris <- rpart(formula = iris_entrenamiento$Species ~ ., data = iris_entrenamiento)

# Evaluar el modelo
arbol_iris

# Graficar arbol
rpart.plot(arbol_iris)

#Predicciones del modelo
iris_pred <- predict(arbol_iris, newdata = iris_test, type = "class")

confusionMatrix(iris_pred, iris_test[["Species"]])
