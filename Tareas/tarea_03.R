#install.packages("tidyverse")
library(tidyverse)
#install.packages("palmerpenguins")
library(palmerpenguins)
#install.packages("ggthemes")
library(ggthemes)
penguins
#ejercicio de práctica en clase
grafico_clase<-ggplot(data=penguins, mapping=aes(x=flipper_length_mm,y=body_mass_g))+
  geom_point(mapping=aes(color=species,shape=species))+
  geom_smooth(method=lm)+
  labs(title="Relación entre el peso corporal y longitud de la aleta en pingüinos",
       subtitle="Dimensiones para las especies Adelie, Chinstrap, y Gentoo",
       x = "Longitud de la aleta (mm)", y = "Peso corporal (g)",
       color = "Epecies", shape = "Especies")+
  scale_color_colorblind()
View(penguins) #visor de datos interactivos
#EJERCICIOS DE LA TAREA Nº3:

#1. Penguins es un dataset con 8 columnas y 344 filas

?penguins

#2. bill_depth_mm describe la profundidad del pico( en milímetros) de los pingüinos que se usaron
#de muestra en el dataset

#3. gráfico que relaciona las variables profundidad del pico y longitud del pico
grafico3<-ggplot(data=penguins,mapping=aes(x=bill_length_mm, y=bill_depth_mm))+
  geom_point(mapping=aes(color=species,shape=species))+
  labs(title="Relación entre la profundidad del pico y el largo del pico en pingüinos ",
       subtitle="Muestras de las especies Adelie, Chinstrap, y Gentoo",
       x="Largo del pico (mm)",y="Profundidad del pico (mm)",
       color="Especies", shape="Especies")+ scale_color_discrete()

#Creo otro gráfico con la línea de tendencia para cada especie

grafico3_2<-ggplot(data=penguins,mapping=aes(x=bill_length_mm, y=bill_depth_mm,color=species))+
  geom_point(mapping=aes(shape=species))+
  labs(title="Relación entre la profundidad del pico y el largo del pico en pingüinos",
       subtitle="Muestras de las especies Adelie, Chinstrap, y Gentoo",
       x="Largo del pico (mm)",y="Profundidad del pico (mm)",
       color="Especies", shape="Especies")+ scale_color_discrete()+
  geom_smooth(method=lm)

#Al ver los gráficos que hice puedo decir que las variables tienen una dependencia linea
#una de la otra; mientas más largo es el pico más profundo es;
#y esto se cumple para las tres espcies.

#4.
grafico4<-ggplot(data=penguins,mapping=aes(x=species, y=bill_depth_mm))+geom_point()
#Al realizar este gráfico simplemente se observan los puntos de dispersión como
#columnas debido a que para relacionar una variable numérica como la profundidad del pico
#con una categórica(las especies), es mejor realizar un boxplot

grafico4_2<-ggplot(data=penguins,mapping=aes(x=species,y=bill_depth_mm,color=species))+geom_boxplot()+
  labs(title="Profundidad del pico según especies",
        x="Especies",y="Profundidad del pico (mm)",
       color="Especies")+ scale_color_colorblind()
#La línea dentro de cada caja es la mediana

#5.ggplot(data = penguins) + geom_point()
#El error ocurre porque no se asignan las variables del gráfico de dispersión es decir falta
#lo que se llama la parte estética, por ejemplo en el ejercicio 3 se 
#agregaron esas  variables con el comando mapping=aes(x=...,y=...)

#6.Para ver lo que realiza el comando na.rm hago un gráfico de dispersión de
#flipper_length_mm vs body_mass_g
grafico6<- ggplot(data=penguins,mapping=aes(x=body_mass_g, y=flipper_length_mm))+
  geom_point(mapping=aes(color=species,shape=species),na.rm=TRUE)+
  labs(title="Relación entre la masa corporal y la longitud de la aleta",
    x="Peso corporal (g)", y= "Longitud de la aleta (mm)", colour="Especies",shape="Especies")
#na.rm elimina los valores faltantes del dataset, por lo que desaparecen los warnings

#7. Cambio el título al gráfico del ejercicio 6

grafico7<- ggplot(data=penguins,mapping=aes(x=body_mass_g, y=flipper_length_mm))+
  geom_point(mapping=aes(color=species,shape=species),na.rm=TRUE)+
  labs(title= "Los datos provienen del paquete palmerpenguins", tag="Gráfico7",
       x="Peso corporal (g)", y= "Longitud de la aleta (mm)", colour="Especies",shape="Especies")
?labs #Probé el comando tag

#8. Recreo el gráfico

grafico8 <- ggplot(data=penguins,mapping=aes(x=flipper_length_mm, y=body_mass_g))+
  geom_point(mapping=aes(color=bill_depth_mm),na.rm=TRUE)+geom_smooth()

#bill_depth_math fue asignado a %>%  la estética de color, los puntos más oscuros 
#representan los pingüinos con picos menos profundos
#Se asigna a nivel geométrico, dentro de geom_point 
#para que el color solo afecte a los puntos y no a la línea de tendencia

#9.Al verl el código va a ser un gráfico de dispersión, con las variables 
#longitud de la aleta y masa corporal y los puntos se van a distinguir según la
#isla en la que se encuetre cada pingüino
grafico9 <- ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g, color = island)
) +
  geom_point() +
  geom_smooth(se = FALSE)

#Me fijo cómo es el gráfico con se=TRUE(por defecto)

grafico9_2 <- ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g, color = island)
) +
  geom_point() +
  geom_smooth()

#Observo que el graficador de la línea de tendencia pinta 
#una sombra alrededor de cada línea. 
#Esta representa el margen de error respecto a la línea.

#10Se van a ver iguales porque el 2º gráfico define a nivel local
#la data y  estéticas que ya están asignadas a nivel global 
#en el 1º gráfico en la función ggplot().

grafico10 <-ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g)
) +
  geom_point() +
  geom_smooth()

grafico10_2 <- ggplot() +
  geom_point(
    data = penguins,
    mapping = aes(x = flipper_length_mm, y = body_mass_g)
  ) +
  geom_smooth(
    data = penguins,
    mapping = aes(x = flipper_length_mm, y = body_mass_g)
  )

#Sección llamadas a ggplot2
#Otra notación:
graf_notacion <-ggplot(penguins, aes(x = flipper_length_mm, y = body_mass_g)) + 
  geom_point()

graf_notacion2 <- penguins |> 
  ggplot(aes(x = flipper_length_mm, y = body_mass_g)) + 
  geom_point()

#Sección visualización de distribuciones:
#Variables categóricas:

graf_barras <- ggplot(penguins, aes(x=species))+geom_bar()

graf_barras_frecuencias <- ggplot(penguins, aes(x=fct_infreq(species)))+geom_bar()

#Variables numéricas:
#Histogramas
graf_histograma <- ggplot(penguins, aes(x = body_mass_g)) +
  geom_histogram(binwidth = 200)
#Diferencia de anchos entre las barras
ggplot(penguins, aes(x = body_mass_g)) +
  geom_histogram(binwidth = 20)#muchas barras

ggplot(penguins, aes(x = body_mass_g)) +
  geom_histogram(binwidth = 2000)#pocas barras

#Gráfico de densidad

graf_densidad <- ggplot(penguins, aes(x=body_mass_g)) + geom_density()

#Ejercicios de la sección 1.4.3

#1.
grafico_barras1 <- ggplot(penguins, aes(y=species)) + 
  geom_bar(aes(fill=species)) + 
  labs(title= "Cantidad de pingüinos por especie",
       x="Cantidad",y="Especies") + scale_fill_colorblind()

#Al poner a nivel global las especies en el eje y las barras son horizontales
#fill rellena de color las barras

#2.
graf_barras_color <- ggplot(penguins, aes(x = species)) +
  geom_bar(color = "red")

graf_barras_fill <- ggplot(penguins, aes(x = species)) +
  geom_bar(fill = "red")
#Es mejor fill, color solamente marca los bordes.

#3. El argumento bins en geom_histogram() define la división entre el rango
#de datos, por ejemplo si hay 20 bins los datos se agrupan en 20 cajas iguales.
#Muy pocos bins muestra barras muy anchas(pocas), varios bins muestra varias barras finitas.
#Hay que regular los bins para no obtener ruido y que el gráfico no pierda muchos detalles.
#Bins marca la división (cantidad), binwidth marca el ancho de las barras".

#4

View(diamonds)

?diamonds

#Experimentar distintos binwidths con la variable carat

graf4_1 <- ggplot(diamonds, aes(x=carat)) + geom_histogram(binwidth=0.1) +
  labs(title="Peso de los diamantes (binwidth=0.1)",x="Cantidad de quilates")

graf4_2 <- ggplot(diamonds, aes(x=carat)) + geom_histogram(binwidth=0.2) +
  labs(title="Peso de los diamantes (binwidth=0.2)",x="Cantidad de quilates")

graf4_3 <- ggplot(diamonds, aes(x=carat)) + geom_histogram(binwidth=0.5) +
  labs(title="Peso de los diamantes (binwidth=0.5)",x="Cantidad de quilates")

graf4_4 <- ggplot(diamonds, aes(x=carat)) + geom_histogram(binwidth=1) +
  labs(title="Peso de los diamantes (binwidth=1)",x="Cantidad de quilates")

graf4_5 <- ggplot(diamonds, aes(x=carat)) + geom_histogram(binwidth=3) +
  labs(title="Peso de los diamantes (binwidth=3)",x="Cantidad de quilates")

#considero que el gráfico 4_3 representa mejor los patrones
#se observa que gran parte de los diamantes de la muestra pesan poco

#1.5 Visualizar relaciones entre variables:
#Variable numérica y categórica
#boxplot tiene cuatro cuartiles y se pueden ver outliers; la mediana

ggplot(data=penguins, mapping=aes(x=species,y=body_mass_g))+
  geom_boxplot()

#gráfico de densidad
ggplot(penguins,aes(x=body_mass_g,color=species))+
  geom_density(linewidth = 0.75)
#linewidth es para el grosor de las líneas
#gráfico de densidad con relleno
ggplot(penguins,aes(x=body_mass_g,color=species,fill=species))+
  geom_density(alpha=0.5) #alpha mido las transparencias

#Dos variables categóricas
#barras apiladas
ggplot(penguins, aes(x = island, fill = species)) +
  geom_bar()
#frecuencia relativa; cómo es la distribución de especies en la isla;
#no se ve afectado por la cantidad desigual de pingüinos
#usar position="fill"
ggplot(penguins, aes(x = island, fill = species)) +
  geom_bar(position = "fill")+labs(
    y="proporción"
  )
#para sacar el count(viene por defecto) agregamos labs

#Dos variables numéricas
#de dispersión
ggplot(penguins, aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point()

#Tres o más variables
ggplot(penguins, aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point(aes(color = species, shape = island))
#el color me dice la especie y la forma me dice la isla
#el gráfico está muy cargado; mejor dividrlo en facetas

ggplot(penguins, aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point(aes(color = species, shape = species)) +
  facet_wrap(~island)

#la variable que se pasa a facet_wrap debe ser categórica

#ejercicios sección 1.5.5
View(mpg)
?mpg
glimpse(mpg)
#1. variables categóricas: manufacturer,model, trans, drv,fl,class
#variables numéricas: 
#discretas:year,cyl 
#continuas: displ,cty,hwy

#2. 
ggplot(mpg,aes(x=hwy,y=displ))+geom_point(aes(color=year))+
  labs(title="displ vs hwy",
       subtitle="tercer variable numérica con estética color ")#utiliza escala de colores
ggplot(mpg,aes(x=hwy,y=displ))+geom_point(aes(size=year))+
  labs(title="displ vs hwy",
       subtitle="tercer variable numérica con estética size") #utiliza escala de tamaños

ggplot(mpg,aes(x=hwy,y=displ))+geom_point(aes(color=year,size=year))+
  labs(title="displ vs hwy",
       subtitle="tercer variable con dos estéticas(color y size)")

#ggplot(mpg,aes(x=hwy,y=displ))+geom_point(aes(shape=year))+
 # labs(title="displ vs hwy",
  #     subtitle="tercer variable numérica con estética shape")

#el último lanza error porque una variable continua no puede
#ser categorizada por una determinada figura

#3.
ggplot(mpg,aes(x=hwy,y=displ))+geom_point(aes(linewidth=year))
#no pasa nada porque linewidth no se aplica a puntos
ggplot(mpg,aes(x=hwy,y=displ))+geom_point()+
  geom_smooth(linewidth=1)
#4. mapear la misma variable a múltiples estéticas
#lo que sucede es que el gráfico va a quedar my cargado y confuso
ggplot(mpg,aes(x=hwy,y=displ))+
  geom_point(aes(color=drv, shape=drv,size=drv))

#5 
ggplot(penguins,aes(x=bill_depth_mm,y=bill_length_mm))+
  geom_point(aes(color=species))
#agregar el color me ayuda a observar el rango de valores que toman las 
#especies respecto a las variables, en particular podemos agrupar esos datos(claustering)
ggplot(penguins,aes(x=bill_depth_mm,y=bill_length_mm))+
  geom_point()+facet_wrap(~species) #cada especie se ve por separado

#6.
ggplot(
  data = penguins,
  mapping = aes(
    x = bill_length_mm, y = bill_depth_mm, 
    color = species, shape = species
  )
) +
  geom_point() +
  labs(color = "Species")
#aparecen dos leyendas porque se usaron dos estéticas(shape y color);
#si les asigno el mismo nombre enlabs se unifican
ggplot(
  data = penguins,
  mapping = aes(
    x = bill_length_mm, y = bill_depth_mm, 
    color = species, shape = species
  )
) +
  geom_point() +
  labs(color = "Species", shape="Species")

#7. 
ggplot(penguins, aes(x = island, fill = species)) +
  geom_bar(position = "fill")
#pregunta gráfico1:
#¿Cómo es la distribución de especies en cada isla?
ggplot(penguins, aes(x = species, fill = island)) +
  geom_bar(position = "fill")
#pregunta gráfico2:
#Respecto a cada espcie,¿Cómo es su distribución geográfica?

#sección 1.6: guardar los gráficos
ggplot(penguins, aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point()
ggsave(filename = "penguin-plot.png")
#ejercicios
#1. 
ggplot(mpg, aes(x = class)) +
  geom_bar()
ggplot(mpg, aes(x = cty, y = hwy)) +
  geom_point()
ggsave("mpg-plot.png")
#se guardo el segundo porque fue el último que se creó
#para guardar el primero
g1<- ggplot(mpg, aes(x = class)) +
  geom_bar()
ggsave(filename="grafico1mpg.png",plot=g1)
#2.guardar como pfd
ggsave(filename="grafico1.pdf",plot=g1)
?ggsave()