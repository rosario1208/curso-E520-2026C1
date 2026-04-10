"Hello World!"
5+5
plot(1:10)
5
10
15
print("Hola")

#ciclo con for
for (x in 1:10){
  print("Hello World")
}
#Esto es un comentario
saludo_mundial <- "Hola mundo" #Otro comentario

#Estos van a 
#ser muchos
#comentarios

#Creación de variables; asignar un valor a una variable

nombre <- "Rosario"
edad <- 21
#print / output variables
nombre
edad
print(nombre)

#for: print números del 1 al 10

for (x in 1:10){
  print(x)
}

#Concatenar textos

texto <- "maravilloso"
concatenación <- paste("R es", texto)
concatenación

texto1 <- "R es"
texto2 <- "maravilloso"

paste(texto1,texto2)

#cuentas
n1 <- 8
n2 <- 10
n1+n2

#no se pueden realizar operaciones aritméticas con distintos tipos de datos
#ejemplo string + integer

#Asignación del mismo valor a distintas variables

var1 <- var2 <- var3 <- "Naranja"
var1
var2
var3

# Legal variable names:
myvar <- "John"
my_var <- "John"
myVar <- "John"
MYVAR <- "John"
myvar2 <- "John"
.myvar <- "John"

#Data types
# numeric
x <- 10.5
class(x)

# integer
x <- 1000L
class(x)

# complex
x <- 9i + 3
class(x)

# character/string
x <- "R is exciting"
class(x)

# logical/boolean
x <- TRUE
class(x)

#R numbers

#Numeric: puede contener o no decimales
x <- 10.5
y <- 55
class(x)
class(y)

#Integer: números enteros, no contiene decimales; se usa la letra L
x <- 1000L
y <- 55L
class(x)
class(y)

#Complex: números complejos, i es la parte imaginaria
x <- 3+5i
y <- 0i

class(x)
class(y)

#Cambiar el tipo de dato: usar as.tipo_a_cambiar()
x <- 1L
y <-2
#pasar de integer a numeric
a <- as.numeric(x) 
class(a)
#pasar de numeric a integer
b <- as.integer(y)
class(b)
a
b

#R math
#operaciones básicas
10+5
10-5
#máximos y mínimos
max(8,9,0,10,6,2)
min(2,3,1,0,-9,8,3)
#raíz cuadrada
sqrt(64)
#valor absoluto
abs(-96.34)
#redondear: ceiling() redondea para arriba y floor para abajo hacia el entero más cercano
ceiling(1.4)

floor(1.4)

#Strings:
"hola"
'hello'

saludo <- "buen día"
class(saludo)

str <- "Lorem ipsum dolor sit amet,
consectetur adipiscing elit,
sed do eiusmod tempor incididunt
ut labore et dolore magna aliqua."

str  #\n es un salto de línea

cat(str) #no se ve el \n

#longitud de un string: nchar()
nchar(saludo)

#chequear si se encuentra un string: grepl()

grepl("hola","hola a todos")
grepl("chau","hola a todos")

#Concatenar: paste()
str1 <- "buenas"
str2 <- "tardes"

paste(str1,str2)

#Escape characters
str <-"Laura publicó su libro \"Terrazas\" ayer"
str
cat(str)

str <- "We are the so-called \"Vikings\", from the north."

str
cat(str)

#Booleanos: TRUE O FALSE
10<7
5>=6
50==50

a <- 5
b <-7
a<b

#se usan en condicionales
a <- 200
b <- 33

if (b > a) {
  print ("b is greater than a")
} else {
  print("b is not greater than a")
}

#Operadores
#Aritméticos
suma <- 2+6
resta <- 8-4
multiplicacion <- 8*8
division <- 9/5
exponencial <- 4^2
resto_modulo <- 10%%2
division_entera <- 11 %/%2

suma
resta
multiplicacion
division
exponenencial
resto_modulo
division_entera

#Formas de asignar valor a variables
my_var <- 3
my_var <<- 3 #asignador global
3 -> my_var
3 ->> my_var
my_var # print my_var

#Operadores de comparación
8<4
5==5
5!=4
7>1
9<=8
9>=8

#Operadores lógicos
#& devuelve verdadero si todas las condiciones se cumplen
(8<16) & (5+4==9) #True
(8<16) & (5+4!=9) #False
#&&(usa lógica de cortocircuito)devuelve verdadero si todas las condiciones se cumplen
#or (|): devuelve verdadero si se cumple al menos una condición
3<10 | 5+1==4
## (||): usa lógica de cortocircuito
#!(negación)
8!=5

# Miscellaneous Operators
x <- 1:10 #crea secuencia de números
1 %in% c(1,2,3) #pertenencia de un elemento a un vector
#multiplicación de matrices
matriz1 <- matrix(c(1,2,3,4), nrow=2)
matriz2 <- matrix(c(5,6,7,8), nrow=2)
matriz1%*%matriz2

# Condicionales
#if
a <- 33
b <- 200

if (b > a) {
  print("b is greater than a")
}


#if..else if

if (b > a) {
  print("b is greater than a")
} else if (a == b) {
  print ("a and b are equal")
}

#else
if (b > a) {
  print("b is greater than a")
} else if (a == b) {
  print("a and b are equal")
} else {
  print("a is greater than b")
}

if (b > a) {
  print("b is greater than a")
} else {
  print("b is not greater than a")
}

#if anidados
x <- 41

if (x > 10) {
  print("Above ten")
  if (x > 20) {
    print("and also above 20!")
  } else {
    print("but not above 20.")
  }
} else {
  print("below 10.")
}

#uso de and en un condicional

a <- 200
b <- 33
c <- 500
if (a > b & c > a) {
  print("Both conditions are true")
}

#uso de or en el condicional if
if (a > b | a > c) {
  print("At least one of the conditions is true")
}

#ciclos

#while: el ciclo se repite siempre que se cumpla la condición
i <- 1
while (i<6){
  print(i)
  i <- i+1 #incrementar i
}

#break: terminar el loop
i <- 1
while (i < 6) {
  print(i)
  i <- i + 1
  if (i == 4) {
    break
  }
}#el loop se va a ejecutar tres veces

#next: skipea una iteración del loop
i <- 0
while (i < 6) {
  i <- i + 1
  if (i == 3) {
    next
  }
  print(i)
}#no imprime el 3

#combina condicionales en un loop
dice <- 1
while (dice <= 6) {
  if (dice < 6) {
    print("No Yahtzee")
  } else {
    print("Yahtzee!")
  }
  dice <- dice + 1
}

#for : para iterar en una secuencia; se cúantas veces voy a iterar
for (x in 1:10) {
  print(x)
}
dice <- c(1, 2, 3, 4, 5, 6)

for (x in dice) {
  print(x)
}

#break en un for
fruits <- list("apple", "banana", "cherry")

for (x in fruits) {
  if (x == "cherry") {
    break
  }
  print(x)
}

#next:skipea "banana"
fruits <- list("apple", "banana", "cherry")

for (x in fruits) {
  if (x == "banana") {
    next
  }
  print(x)
}
#if en un for
dice <- 1:6

for(x in dice) {
  if (x == 6) {
    print(paste("The dice number is", x, "Yahtzee!"))
  } else {
    print(paste("The dice number is", x, "Not Yahtzee"))
  }
}

#Ciclos anidados
adj <- list("red", "big", "tasty")

fruits <- list("apple", "banana", "cherry")
for (x in adj) {
  for (y in fruits) {
    print(paste(x, y))
  }
}

for (i in 1:length(adj)){
    print(paste(adj[i],fruits[i]))
  }

# Funciones
funcion_saludo <- function(){
  print("hola")
}
funcion_saludo()

#Argumentos de una función
my_function <- function(fname) {
  paste(fname, "Griffin")
}

my_function("Peter")
my_function("Lois")
my_function("Stewie")

#función con más de un parámetro
my_function <- function(fname, lname) {
  paste(fname, lname)
}

my_function("Peter", "Griffin")

#valor del parámetro por default
nueva_funcion <- function(anio=2026){
  paste("archivo del año:", anio)
}
nueva_funcion(2024)
nueva_funcion()
#función que retorna un resultado 
funcion_suma<-function(a,b){
  return (a+b)
}
funcion_suma(5,6)

#funciones anidadas
#llamar a una función dentro de otra función
funcion_anidada1 <-function(x,y){
  a <- x+y
  return (a)
}
funcion_anidada1(funcion_anidada1(2,5),funcion_anidada1(3,2))
#escribir una función dentro de otra función
Outer_func <- function(x) {
  Inner_func <- function(y) {
    a <- x + y
    return(a)
  }
  return (Inner_func)
}
output <- Outer_func(3) # To call the Outer_func
output(5)

#recursión: una función se llama a sí misma
tri_recursion <- function(k) {
  if (k > 0) {
    result <- k + tri_recursion(k - 1)
    print(result)
  } else {
    result = 0
    return(result)
  }
}
tri_recursion(6)

#Variables globales: se pueden leer adentro y afuera de una función
txt <- "awesome"
my_function <- function() {
  paste("R is", txt)
}
#variables globales y locales
my_function()
txt <- "global variable"
my_function <- function() {
  txt = "fantastic"
  paste("R is", txt)
}

my_function()

txt

#asignador de variables locales <<-
my_function <- function() {
  txt <<- "fantastic"
  paste("R is", txt)
}

my_function()

print(txt)

# cambiar el valor de una variable global dentro de una función
txt <- "awesome"
my_function <- function() {
  txt <<- "fantastic"
  paste("R is", txt)
}

my_function()

paste("R is", txt)

#R data structures
#vectores: todos los elementos del mismo tipo
vector <-c(1,2,3)
vector
fruits <- c("banana", "apple", "orange")
fruits
#vector con secuencia de valores numéricos
numbers <- 1:10
numbers 
#con decimales
numbers1 <- 1.5:5.5
numbers2 <- 1.5:5.3
numbers1
numbers2
#vector de valores lógicos
vector_logico <- c(TRUE,FALSE,TRUE,FALSE,FALSE)
vector_logico

#longitud de un vector : length()
length(fruits)
#ordenar un vector alfabéticamente o numericamente: sort()
sort(fruits)
nums <- c(5,9,0,-5,-6,8,3)
sort(nums)

#acceder a un elemento de un vector
fruits[1] #me da el primer elemento
#acceder a varios elementos de un vector
fruits <- c("banana", "apple", "orange", "mango", "lemon")
fruits[c(1, 3)] #banana, orange
#acceder a todos los items menos uno:signo negativo
fruits[-2] #todos menos apple

#cambiar el valor de un item
fruits[2] <- "manzana"
fruits

#repetir un vector: rep()
repeat_each <- rep(c(1,2,3), each = 3)
repeat_each #repite cada item tres veces
#repetir la secunencia de un vector: times
repeat_times <- rep(c(1,2,3), times=3)
repeat_times
#distintas repeticiones por item
repeat_independent <- rep(c(1,2,3), times=c(5,4,2))
repeat_independent
#crear secuencia de números:
secuencia <- seq(from=0,to=100, by=20)
secuencia

#lista: combina distintos tipos de datos

lista <- c("Mario", 25L, 89.3)
lista

#acceder a un item de la lista
lista[3]
#cambiar un item
lista[1] <- "Laura"
lista
#longitud
length(lista)
#chequear si un item pertenece: %in%
"Mario"%in%lista
"Laura"%in%lista
#agregar elementos: append()
lista <-append(lista,"capricornio")
#agregar en una determinada posicion
append(lista,"matematica", after=1)
#remover elementos: indexar con el elemento en negativo
nueva_lista<-lista[-2]
nueva_lista
#devolver una secuencia de items
nueva_lista[1:3]
#loop en una lista(un ciclo)
for (x in nueva_lista){
  print(x)
}

#concatenar listas:
lista1 <- list(1,2,3)
lista2 <- list("a","b","c")
lista3 <- c(lista1,lista2)
lista3
length(lista3)

#matrices: estrcutura 2D (filas y columnas)con elementos del mismo tipo
matriz <- matrix(c(1,2,3,4,5,6), nrow=3, ncol=2)
matriz
#matriz de strings
mat_str <- matrix(c("wanda","ana","nico","mabel","lichu","amelie"), nrow=2,ncol=3)
mat_str
#acceder a una matriz
mat_str[2, 1] #fila 2 columna 1
#acceder a toda una fila
mat_str[2,]
#acceder a toda una columna
mat_str[,3]
#acceder a más de una fila
mat_str[c(1,2),]
#acceder a más de una columna
mat_str[,c(1,3)]
#agregar filas y columnas:
#agregar columnas:
nueva_matriz <- cbind(mat_str,c("nueva_columna1","nueva_Columna2"))
nueva_matriz
#agregar filas
nueva_matriz2 <-rbind(mat_str,c("agrego","nueva","fila"))
nueva_matriz2
#remover filas y columnas:con c()
nueva3 <- mat_str[c(-1),c(-1)] 
nueva3 #saca primera fila y primera columna
#chequear si se encunetra un item %in%
"mabel" %in% mat_str
"mabe" %in% mat_str
#obtener la dimensión de una matriz
dim(mat_str)
#longitud:cantidad de elementos
length(mat_str)
#loop en una matriz:
for (rows in 1:nrow( mat_str)){
  for (columns in 1:ncol(mat_str)){
    print(mat_str[rows,columns])
  }
}
#combinar dos matrices
mat_num <-matrix(c(1,2,3,4,5,6),nrow=2,ncol=3)
matriz_combinada<-rbind(mat_str,mat_num) #agrego como fila
matriz_combinada
matriz_combinada <-cbind(mat_str,mat_num) #agrego como columna
matriz_combinada


#arreglos: se puede tener más de dos dimensiones, tienen el mismo tipo de dato
arreglo <- c(1:24) #una dimensión
arreglo

#multiples dimensiones
multiples_dimensiones <- array(arreglo,dim=c(4,3,2))
#filas 4, 3 columnas, 2 matices

multiples_dimensiones
#acceder a los items de un array
multiples_dimensiones[1,2,2]
#acceder a una fila
multiples_dimensiones[c(1),,2]
#acceder a una columna
multiples_dimensiones[,c(1),1]
#chequear si existe un item
12 %in% multiples_dimensiones
#dimension
dim(multiples_dimensiones)
#longitud
length(multiples_dimensiones)
#loop en un array
for (x in multiples_dimensiones){
  print(x)
}

#data frames: data en formato de tabla

Data_frame <- data.frame(
  nombres=c("carlos","pedro","sabrina"),
  edades=c(15L,18L,40L),
  signo=c("leo","tauro","capricornio")
)
Data_frame

summary(Data_frame) #resume la data
#formas de acceder a un data frame
Data_frame[1] #primera columna(nombres)
Data_frame$nombres #primera columna (nombres)
Data_frame[["nombres"]]

#agregar filas
nueva_fila <- c("moni",20,"tauro")
Df_nuevo <- rbind (Data_frame,nueva_fila)
Df_nuevo

#agregar columnas
nueva_columna <- c("san luis","san juan","misiones","corrientes")
Df_nuevo <-cbind(Df_nuevo,provincias =nueva_columna)
Df_nuevo

#remover columnas y filas
Df_nuevo[c(-1),c(-2)] #elimina primera fila y segunda columna

#dimension
dim(Df_nuevo)
#cant filas
nrow(Df_nuevo)
#cant columnas; también se puede usar length()
ncol(Df_nuevo)

#combinar dos data frames: usar rbind para agregar filas
df2 <- data.frame(
  nombres=c("mario","carla"),
  edades=c(20,85),
  signo=c("virgo","tauro"),
  provincias=c("mendoza","salta")
)
df_combinado <- rbind(Df_nuevo,df2)
df_combinado
#usar cbind para agregar atributos
cant_hijos <- c(1,2,2,0)
color_favorito <- c("rosa","rojo","amarillo","celeste")
df_combinado2 <- cbind(Df_nuevo,cant_hijos=cant_hijos, color_favorito=color_favorito)
df_combinado2

#factors: sirven para categorizar data
clubes <- factor(c("boca","river","san lorenzo","ferro","racing","lanús","boca","river","river"))
clubes #6 niveles
levels(clubes)
#longitud
length(clubes)
#acceder a un factor
clubes[4]
#cambiar un item(Debe ser por uno que está en levels)
clubes[2] <- "ferro"
clubes
levels(clubes) <- c(levels(clubes),"morón")
clubes[2] <-"morón"
clubes


