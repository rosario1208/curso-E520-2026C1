
# Cargo librerías ---------------------------------------------------------


library(tidyverse)
library("nycflights13")
?flights

#View(flights)
#View(airlines)
#View(airports)
#View(planes)
#View(weather)
#print(flights, width = Inf) #ver todas las columnas
#glimpse(flights)

# R4DS-capítulo 3- Transformación de datos ----------------------------------------------------------------


flights |>
  filter(dest == "IAH") |> 
  group_by(year, month, day) |> 
  summarize(
    arr_delay = mean(arr_delay, na.rm = TRUE)
  )


# rows : filter(), arrange(), distinct() -------------------------------------

# filter()
flights |> 
  filter(dep_delay>120) 

flights |>
  filter(month==1 & day==1)


flights |>
  filter(month %in% c(1,2))

#asigno las consultas a variables

jan1 <- flights |>
  filter(month ==1 & day==1)


# arrange()
#ordenar según salida de vuelos
flights |>
  arrange(year,month,day,dep_time)
#en orden descendente
flights |>
  arrange(desc(dep_delay))

#distinct():elimina duplicados
flights |> 
  distinct()
#únicos pares origen-destino
flights |> 
  distinct(origin, dest)

#si me quiero quedar con el resto de columnas

flights |> 
  distinct(origin, dest, .keep_all = TRUE)

#contar las repeticiones: count()
flights |>
  count(origin,dest, sort=TRUE) #orden descendente


# ejercicios sección 3.2.5 ------------------------------------------------

#1.
#retraso de más de dos horas
flights|>
  filter(arr_delay>=120) 
#destinos IAH o HOU
flights |>
  filter(dest=="IAH" | dest=="HOU")
#operados por United, American o Delta
flights |>
  filter(carrier %in% c("AA","UA","DL"))
#partieron en verano
flights |>
  filter(month %in% c(7,8,9))
#más de dos horas de retraso pero no salió tarde
flights|>
  filter(arr_delay>120 & dep_delay<=0)
#retraso de al menos una hora pero ganó 30 minutos en el vuelo
flights |>
  filter(dep_delay>=60 & (dep_delay - arr_delay)>=30)

#2. ordenar por los que tardaron más en salir
retrasados <- flights |>
  arrange(desc(dep_delay))
#los que salieron más temprano
orden_temprano <-flights |>
  arrange(dep_time)

#3. los vuelos más rápidos
rapidos <- flights |>
  arrange(desc(distance/air_time))

#4.vuelos todos los días?
flights |>
  count(month,day) 
#hay 365 filas así que hubo vuelos todos los días

#5. vuelos de mayor distancia
flights |>
  arrange(desc(distance)) 
#vuelos de menor distancia
flights |>
  arrange(distance)
#6. orden de arrange y filter
#ordenar antes u ordenar después no va a importar la cantidad de registros que se obtengan al filtrar
f1 <-flights |>
  arrange(hour,minute) |>
  filter(day==1 & month==1)
f2 <- flights |>
  filter(day==1 & month==1) |>
  arrange(hour,minute)
#sin embargo es más eficeinte filtrar y luego ordenar, ya que deberá ordenar menos filas

# columns: mutate(),select(),rename(),relocate() --------------------------

#mutate():agrega nuevas columnas con operaciones de las columnnas ya existentes
flights |> 
  mutate(
    gain = dep_delay - arr_delay,
    speed = distance / air_time * 60)
#si quiero ver las columnas creadas a la izquiera .before
flights |> 
  mutate(
    gain = dep_delay - arr_delay,
    speed = distance / air_time * 60,
    .before=1)
#para elegir donde las quiero ver .after y .before
flights |> 
  mutate(
    gain = dep_delay - arr_delay,
    speed = distance / air_time * 60,
    .before=3)
flights |> 
  mutate(
    gain = dep_delay - arr_delay,
    speed = distance / air_time * 60,
    .after=2)

flights |> 
  mutate(
    gain = dep_delay - arr_delay,
    speed = distance / air_time * 60,
    .after = day
  )
#si nos quedamos solo con las columnas involucradas .keep="used"
flights |> 
  mutate(
    gain = dep_delay - arr_delay,
    hours = air_time / 60,
    gain_per_hour = gain / hours,
    .keep = "used"
  )
#select(): selecciona las columnas del dataset
flights |>
  select(year,month,day)
#atributos entre columnas
flights |>
  select(year:day)
#todas las columnas excepto...
flights |>
  select(!year:day)#inclusive
#todas las columnas que son caracteres
flights |>
  select(where(is.character))

#starts_with("abc"): matches names that begin with “abc”.
flights |>
  select(starts_with("arr"))
#ends_with("xyz"): matches names that end with “xyz”.
#contains("ijk"): matches names that contain “ijk”.
#num_range("x", 1:3): matches x1, x2 and x3.
#renombrar variables
flights |>
  select(tail_num=tailnum)

#rename()
flights |> 
  rename(tail_num = tailnum)
#janitor::clean_names() para limpiar incosistencias en nombres automaticamente

#relocate(): mover variables, por defecto van al inicio
flights |>
  relocate(time_hour,distance)
flights |> 
  relocate(year:dep_time, .after = time_hour)
flights |> 
  relocate(starts_with("arr"), .before = dep_time)


# ejercicios sección 3.3.5 -----------------------------------------------
#1.dep_delay es igual a dep_time-sched_dep_time en minutos,
#sched_dep_time y dep_time están en HHMM por lo que hay que transformalo en minutos
#ejemplo 533: 5 horas 33 minutos = 5*60+33

#2.seleciconar dep_time, dep_delay, arr_time, y arr_delay de flights.
flights |>
  select(dep_time, dep_delay, arr_time,  arr_delay)

flights |>
  relocate(dep_time, dep_delay, arr_time,  arr_delay) |>
  select(dep_time:arr_delay)

#3.repetir la variable en select
flights |>
  select(day,day,month,month) #toma una sola repetición
#4.any_of()
variables <- c("year", "month", "day", "dep_delay", "arr_delay")

flights |>
  select(any_of(variables))
#selecciona todas las columnas que pertenezcan a la lista
#5.
flights |> 
  select(contains("TIME"))
#toma mayúsculas las funciones auxiliares; son case-insensitive
#flights |> 
#  select(DAY) --NO FUNCIONA
#uso ignore.case
flights |> 
  select(contains("TIME", ignore.case=FALSE))
#6
flights |> 
  rename(air_time_min=air_time)|>
  relocate(air_time_min)
#7.
#flights |> 
# select(tailnum) |> 
#arrange(arr_delay)
#no funciona porque se selecciona solo tailnum primero y 
#luego no está presente la variable arr_delay para ordenar
#si quiero solo tailnum pero que esté ordenado por arr_delay, primero debo ordenar
flights |> 
  arrange(arr_delay) |>
  select(tailnum)


# the pipe ----------------------------------------------------------------
flights |> 
  filter(dest == "IAH") |> 
  mutate(speed = distance / air_time * 60) |> 
  select(year:day, dep_time, carrier, flight, speed) |> 
  arrange(desc(speed))

arrange(
  select(
    mutate(
      filter(
        flights, 
        dest == "IAH"
      ),
      speed = distance / air_time * 60
    ),
    year:day, dep_time, carrier, flight, speed
  ),
  desc(speed)
)

flights1 <- filter(flights, dest == "IAH")
flights2 <- mutate(flights1, speed = distance / air_time * 60)
flights3 <- select(flights2, year:day, dep_time, carrier, flight, speed)
arrange(flights3, desc(speed))


# groups ------------------------------------------------------------------

#group_by()
flights |> 
  group_by(month)

#summarize()
flights |> 
  group_by(month) |> 
  summarize(
    avg_delay = mean(dep_delay, na.rm=TRUE) #IGNORA VALORES NULOS
  )

flights |> 
  group_by(month) |> 
  summarize(
    avg_delay = mean(dep_delay, na.rm = TRUE), 
    n = n() #da el nro de columnas de cada grupo
  )

#slice functions
#df |> slice_head(n = 1) takes the first row from each group.
#df |> slice_tail(n = 1) takes the last row in each group.
#df |> slice_min(x, n = 1) takes the row with the smallest value of column x.
#df |> slice_max(x, n = 1) takes the row with the largest value of column x.
#df |> slice_sample(n = 1) takes one random row.

flights |> 
  group_by(dest) |> 
  slice_max(arr_delay, n = 1) |>
  relocate(dest)

#with_ties = FALSE: da solo una fila en caso de empate

flights |> 
  group_by(dest) |> 
  slice_max(arr_delay, n = 1, with_ties=FALSE) |>
  relocate(dest)

#agrupar por múltiples variables
daily <- flights |>  
  group_by(year, month, day)
daily

daily_flights <- daily |> 
  summarize(n = n())

daily_flights <- daily |> 
  summarize(
    n = n(), 
    .groups = "drop_last" #sino keep o drop
  )

#ungroup

daily |> 
  ungroup()

daily |> 
  ungroup() |>
  summarize(
    avg_delay = mean(dep_delay, na.rm = TRUE), 
    flights = n()
  )

#.by()

flights |> 
  summarize(
    delay = mean(dep_delay, na.rm = TRUE), 
    n = n(),
    .by = month
  )
flights |> 
  summarize(
    delay = mean(dep_delay, na.rm = TRUE), 
    n = n(),
    .by = c(origin, dest)
  )

# ejercicios sección 3.5.7 ------------------------------------------------
#1.
flights |>
  group_by(carrier) |> 
  summarize(promedio_delay=mean(dep_delay, na.rm=TRUE), cantidad_de_vuelos=n()) |> 
  arrange(desc(promedio_delay))

flights |>
  group_by(carrier,dest) |> 
  summarize(promedio_delay=mean(dep_delay, na.rm=TRUE), cantidad_de_vuelos=n()) |> 
  arrange(desc(promedio_delay))

#puedo observar que el aeropuerto influye en los retrasos, por lo que
#el ranking por aerolínea puede verse afectado por los destinos que esta concurre.

#2.
flights |> 
  group_by(dest) |> 
  slice_max(dep_delay,n=1,with_ties=FALSE)

#3. retrasos a lo largo del día
retrasos_por_dia <- flights |> 
  group_by(hour) |> 
  summarize(promedio_retrasos=mean(arr_delay,na.rm=TRUE),viajes_por_hora=n()) |> 
  filter(!is.nan(promedio_retrasos))

grafico<- ggplot(retrasos_por_dia,aes(x=hour,y=promedio_retrasos))+
  geom_line(linewidth = 1)+labs(
    title="Promedio de retrasos a lo largo del día",
    x="Hora del día",y="Promedio retraso"
  )
grafico
#los vuelos se empiezan a retrasar más a la tarde/noche
#4
slice_min(flights, dep_delay, n=1)
#pruebo un número negativo
slice_min(flights, dep_delay, n=-2) #la función devuelve simplemente flights

#5. count() cuenta las filas por agrupación
flights |> 
  count(dest)
#sort() con count()
flights |> 
  count(dest, sort=TRUE) #mayor a menor
#6.
df <- tibble(
  x = 1:5,
  y = c("a", "b", "a", "a", "b"),
  z = c("K", "K", "L", "L", "K")
)
df |> 
  group_by(y)
#por el momento no hace nada porque no se asignó ninguna operación para agrupar

df |>
  arrange(y)
#ordena alfabeticamente
#arrange ordena por columnas, group_by agrupa para luego realizar operaciones
df |>
  group_by(y) |>
  summarize(mean_x = mean(x))
#va a agrupar por y(a,b) y va a poner el promedio de x

df |>
  group_by(y, z) |>
  summarize(mean_x = mean(x), .groups = "drop")
#agrupa por (a,b) y por (L,K) o sea hay como máximo todas las combinaciones posibles, y saca el promedio de x

df |>
  group_by(y, z) |>
  summarize(mean_x = mean(x))
#solo coloca las variables de agrupación y las creadas
df |>
  group_by(y, z) |>
  mutate(mean_x = mean(x))
#crea una nueva variable, por lo tanto hay 4 columnas
install.packages("Lahman")
batters <- Lahman::Batting |> 
  group_by(playerID) |> 
  summarize(
    performance = sum(H, na.rm = TRUE) / sum(AB, na.rm = TRUE),
    n = sum(AB, na.rm = TRUE)
  )

batters |> 
  filter(n > 100) |> 
  ggplot(aes(x = n, y = performance)) +
  geom_point(alpha = 1 / 10) + 
  geom_smooth(se = FALSE)

batters |> 
  arrange(desc(performance))


# R4DS- capítulo 19 - Joins -----------------------------------------------

#View(planes)
planes |> 
  count(tailnum) |> 
  filter (n>1)
#View(weather)
weather |> 
  count(time_hour,origin) |> 
  filter(n>1)
#como ambas dan cero filas, las claves primaria están bien porque todas 
#se corresponden a un único registro

#chequear no haya claves faltantes
planes |> 
  filter(is.na(tailnum))
weather|> 
  filter(is.na(time_hour)|is.na(origin))
#surrogate keys
#clave primaria de flights
flights |> 
  count(time_hour, carrier, flight) |> 
  filter(n > 1)

airports |>
  count(alt, lat) |> 
  filter(n > 1)

#claves sustitutas
flights2 <- flights |> 
  mutate(id = row_number(), .before = 1)
flights2


# ejercicios sección 19.2.4 -----------------------------------------------------

#1 
#View(weather)
#la relación entre weather y airports es que 
#weather$origin es foreign key de la clave primaria airports$faa ,
#se representa con una flecha de weather$origin a airports$faa
#2. Si weather tuviera el clima de todos los aeropuertos de USA, se podría
#conectar con flights a través de dest y time_hour(se podría saber el clima del destino)
#3.
weather |> 
  count(year,month,day,hour,origin) |> 
  filter(n>1)
#el 3/11/2013 fue el día de cambio de horario; el reloj se atrasa una hora
#4.
dias_con_menos_viajes <- flights |> 
  group_by(year,month,day) |>
  summarize(vuelos_por_dia=n()) |> 
  arrange(vuelos_por_dia)

#el primero fue thanksgiving
#year,month y day son clave primaria del nuevo dataset dias_con_menos_viajes
#year, month y day son clave foránea del dataset de flights

#5.
install.packages("Lahman")   
library(Lahman)

library(Lahman)
?Lahman
#View(Lahman::Batting)
#View(Lahman::People)
#View(Lahman::Salaries)
#busco claves primarias

Lahman::Batting |> 
  count(playerID, yearID,teamID,stint) |> 
  filter(n > 1)

Lahman::People|> 
  count(playerID) |> 
  filter(n>1)

Lahman::Salaries|> 
  count(playerID,yearID, teamID) |> 
  filter(n>1)

#chequeo no tenga valores nulos
Lahman::Batting |> 
  filter(is.na(playerID)| is.na(yearID) | is.na(teamID) | is.na(stint) )

Lahman::People|> 
  filter(is.na(playerID) )


Lahman::Salaries|> 
  filter(is.na(playerID) | is.na(yearID) | is.na(teamID)) 

#View(Lahman::Managers)
#View(Lahman::AwardsManagers)
?Lahman::Managers


Lahman::Managers|> 
  count(playerID,yearID,teamID,inseason) |> 
  filter(n>1)

Lahman::Managers|> 
  filter(is.na(playerID)| is.na(yearID)|is.na(teamID)|is.na(inseason)) 

Lahman::AwardsManagers|> 
  count(playerID,awardID,yearID) |> 
  filter(n>1)
Lahman::AwardsManagers|> 
  filter(is.na(playerID)| is.na(yearID)|is.na(awardID)) 

#View(Pitching)
#View(Fielding)
?Fielding
Lahman::Fielding |> 
  count(playerID, yearID,teamID,stint, lgID,POS) |> 
  filter(n > 1)

Lahman::Fielding|> 
  filter(is.na(playerID)| is.na(yearID)|is.na(teamID)|is.na(stint)|is.na(lgID)|is.na(POS)) 
Lahman::Pitching |> 
  count(playerID, yearID,teamID,stint) |> 
  filter(n > 1)
Lahman::Pitching|> 
  filter(is.na(playerID)| is.na(yearID)|is.na(stint)|is.na(teamID)) 
#Batting y Pitching tienen la misma clave primaria, luego Fielding además de tener
#los atributos de las otras dos tablas como clave primaria tiene POS.
#son tablas con características de juego para cada jugador en un determinado equipo y momento

#Acá están los gráficos:https://canva.link/ktrs0twyzvegkmz

# Basic joins -------------------------------------------------------------

#Mutating joins

flights2 <- flights |> 
  select(year, time_hour, origin, dest, tailnum, carrier)
flights2

#left_join()
#agrego nombre de la aerolínea
flights2 |>
  left_join(airlines)

flights2 |> 
  left_join(weather |> select(origin, time_hour, temp, wind_speed))

flights2 |> 
  left_join(planes |> select(tailnum, type, engines, seats))
#si no encuentra un match, pone na
flights2 |> 
  filter(tailnum == "N3ALAA") |> 
  left_join(planes |> select(tailnum, type, engines, seats))

#especificar la clave
flights2 |> 
  left_join(planes, join_by(tailnum)) #join_by(tailnum == tailnum)

flights2 |> 
  left_join(airports, join_by(dest == faa))

flights2 |> 
  left_join(airports, join_by(origin == faa))
#inner_join(), right_join(), full_join() 

# Filtering joins
#semi_join
airports |> 
  semi_join(flights2, join_by(faa == origin))

airports |> 
  semi_join(flights2, join_by(faa == dest))

#anti_join: sirve para encontrar valores que faltan
flights2 |> 
  anti_join(airports, join_by(dest == faa)) |> 
  distinct(dest)
flights2 |>
  anti_join(planes, join_by(tailnum)) |> 
  distinct(tailnum)

# ejercicios sección 19.3.4  -----------------------------------------------------
#1.
flights_weather <- flights |> 
  left_join(weather,join_by(origin,time_hour)) 

retrasos_por_hora <- flights_weather |>
  group_by(time_hour) |>
  summarize(promedio_delay = mean(arr_delay, na.rm = TRUE),
            visib = mean(visib, na.rm = TRUE),
            wind_speed = mean(wind_speed, na.rm = TRUE),
            precip = mean(precip, na.rm = TRUE)) |>
  arrange(desc(promedio_delay)) |>
  head(n = 48)
#hay más retrasos si hay mal clima

#2.
top_dest <- flights2 |>
  count(dest, sort = TRUE) |>
  head(10)

vuelos_top <- top_dest |> 
  left_join(flights, join_by(dest))

#3.
info_weather <- flights |>
  anti_join(weather, join_by(origin,time_hour))
#no todos los vuelos tienen información del clima

#4
#View(planes)
tail_numbers <- flights |> 
  anti_join(planes, join_by(tailnum)) |> 
  count(carrier) |> 
  arrange(desc(n))
#MQ y AA no registraron varios de sus aviones en planes

#5.
carrier_planes <- flights |>
  select(tailnum, carrier) |>
  distinct() |>
  group_by(tailnum) |>
  mutate(n = n()) |>
  filter(n > 1)
#hay aviones que fueron usados por más de una aerolínea
#6
#View(flights)
#View(airports)
flights2 <- flights |>
  left_join(airports, join_by(origin == faa)) |>
  rename(
    lat_origin = lat,
    lon_origin = lon
  )
lat_long<-flights2 |> 
  left_join(airports,join_by(dest==faa)) |> 
  rename(lat_dest=lat,
         lon_dest=lon)
#mejor renombrarlas después del join

#7.
install.packages("maps")
library(maps)
retraso_promedio_dest<-flights |> 
  group_by(dest) |> 
  summarize(promedio_retraso=mean(arr_delay,na.rm=TRUE))

mapa <- airports |>
  left_join(retraso_promedio_dest, join_by(faa == dest)) |>
  ggplot(aes(x = lon, y = lat)) +
  borders("state") +
  geom_point(aes(color=promedio_retraso)) +
  coord_quickmap()
mapa
#8: 13-06-2013
retraso_13_06 <- flights |> 
  filter(day==13 & month==6) |> 
  group_by(dest) |> 
  summarize(promedio_dest=mean(arr_delay,na.rm=TRUE)) |> 
  arrange(desc(promedio_dest)) 

mapa_13_06 <- airports |> 
  left_join(retraso_13_06 , join_by(faa==dest)) |> 
  ggplot(aes(x=lon,y=lat))+
  borders("state")+
  geom_point(aes(color=promedio_dest))+
  coord_quickmap()
mapa_13_06
#ese día se presentaron tormentes muy fuertes