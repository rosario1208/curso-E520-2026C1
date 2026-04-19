
# cargar librerías --------------------------------------------------------

library(tidyverse)

# cargar datos ------------------------------------------------------------     

# vuelos AR 2025

anac_2025 <- read_csv2(file="Tareas/202512-informe-ministerio-actualizado-dic-final.csv")

# clima
# revisar si podemos encontrar una relación entre nombre de 
# estación  meteorológica y código de aeropuerto
clima<- read_fwf(file="Tareas/Registro_temperaturas-14042026/registro_temperatura365d_smn.txt",
                 col_positions=fwf_widths(c(8,6,6,200),c("fecha","tmax","tmin","nombre")),
                 skip=3)
# 

#se puede usar skip para eliminar filas
# |> select(-x,-y) elimina columnas


aeropuertos <- read_csv(file="Tareas/iata-icao.csv")
# análisis de los datos ---------------------------------------------------

glimpse(anac_2025)



anac_2025<-
  anac_2025 |> 
  mutate(
   # fecha=lubridate::(`Fecha UTC`),
    tipo_vuelo=factor(`Clase de Vuelo (todos los vuelos)`),
    clasif_vuelo=factor(`Clasificación Vuelo`),
    tipo_movimiento=factor(`Tipo de Movimiento`),
    aeropuerto=factor(Aeropuerto),
    origen_destino=factor(`Origen / Destino`),
    aerolinea=factor(`Aerolinea Nombre`),
    aeronave=factor(Aeronave),
    calidad_dato=factor(`Calidad dato`)
    
  )##como hacer para eliminar las columnas viejas
anac_2025 <- anac_2025[,c(-3,-4,-5,-6,-7,-8,-9,-12)] #elimino columnas viejas
#cambio nombre de fecha y hora
anac_2025 <-anac_2025 |> 
  rename("fecha_utc"=`Fecha UTC`,
         "hora_utc"=`Hora UTC`)
#summary(anac_2025)
#glimpse(anac_2025)

#mutate as factors columnas utiles como factores
#elegir despegues


# Análisis exploratorio ---------------------------------------------------
#los viajes internacionales en anac_2025 tienen códigos icao, y nacionales(domésticos) 
# tienen códigos iata

levels(anac_2025$aeropuerto)
levels(anac_2025$origen_destino)
cant_viajes_or_dest <- anac_2025 |> count(origen_destino)

aeropuertos <- aeropuertos |> 
  mutate(country_code=factor(country_code),
         region_name=factor(region_name),
         iata=factor(iata),
         icao=factor(icao))

summary(aeropuertos)
aeropuertos |> 
  filter(icao=="LFSB") #aparece dos veces porque está en la frontera
#ICAO: código técnico
#IATA: código comercial

codigos_internacionales<- anac_2025 |> 
  filter(clasif_vuelo=="Internacional") |> 
  select(aeropuerto, origen_destino)
codigos_nacionales<- anac_2025 |> 
  filter(clasif_vuelo=="Doméstico") |> 
  select(aeropuerto, origen_destino)

#chequeo con joins los códigos
codigos_nacionales <-  codigos_nacionales |> 
  left_join(aeropuertos, join_by("origen_destino"=="iata"))
codigos_internacionales <-  codigos_internacionales |> 
  left_join(aeropuertos, join_by("origen_destino"=="icao"))


# claves primarias --------------------------------------------------------

repetidos<- anac_2025 |> 
  count(fecha_utc,hora_utc,clasif_vuelo,tipo_vuelo,tipo_movimiento, 
        aeropuerto, aerolinea,aeronave,origen_destino,PAX, Pasajeros,calidad_dato) |> 
  filter(n>1)
#hay filas repetidas en anac_2025
#chequeo
anac_2025 |> 
  distinct() # en total tiene 597784 observaciones
#dio 596970

#para realizar las consultas voy a eliminar los duplicados del dataset
anac_2025 <- anac_2025 |> 
  distinct()
#ahora busco la clave primaria
clave_primaria<- anac_2025 |> 
  count(fecha_utc,hora_utc,aerolinea, aeropuerto, origen_destino, aeronave, 
        tipo_vuelo, tipo_movimiento, clasif_vuelo,PAX) |> 
  filter(n>1)
#chequeo que la clave primaria no tenga valores nulos
anac_2025 |> 
  filter(
    is.na(fecha_utc) |
      is.na(hora_utc) |
      is.na(aerolinea) |
      is.na(aeropuerto) |
      is.na(origen_destino) |
      is.na(aeronave) |
      is.na(tipo_vuelo) |
      is.na(tipo_movimiento) |
      is.na(clasif_vuelo) |
      is.na(PAX)
  )

#busco clave primaria de aeropuertos
clave_primaria2<- aeropuertos |> 
  count(iata,icao) |> 
  filter(n>1)

aeropuertos |> filter(is.na(iata)| is.na(icao))

#como hay valores nulos para la clave primaria, para limpiar
#le data set y luego hacer los joins lo voy a separar en aeropuertos_iata y aeropuertos_icao
aeropuertos_iata <- aeropuertos |> 
  filter(!is.na(iata), country_code == "AR") |> 
  distinct(iata, .keep_all = TRUE)

aeropuertos_icao <- aeropuertos |> 
  filter(!is.na(icao))

#voy a separar los datos mediante distintos joins en vuelos internacionales y nacionales


viajes_internacionales <- anac_2025 |> 
  filter(clasif_vuelo=="Internacional")
viajes_nacionales <- anac_2025 |> 
  filter(clasif_vuelo=="Doméstico")

#voy a tomar como punto de vista los despegues y ver cuántos vuelos salen internacionales
despegues_internacionales <- viajes_internacionales |> 
  filter(tipo_movimiento=="Despegue") |> 
  count(origen_destino) |> 
  arrange(desc(n))
#voy a realizar un join con aeropuertos_icao para saber qué países son
despegues_internacionales <- despegues_internacionales |> 
  inner_join(aeropuertos_icao, join_by("origen_destino"=="icao"))
#coloco la data en visualizaciones

install.packages("maps")
library(maps)
grafico_cant_viajes_internacionales <-ggplot(despegues_internacionales,
aes(x=longitude,y=latitude))+
            borders("world") +
    geom_point(aes(color=n)) +coord_quickmap()+ labs(
      title="Destinos internacionales más visitados"
    )
                                           
grafico_cant_viajes_internacionales

#ahora busco los aeropuertos más concurridos de argentina
aero_concurridos <- viajes_nacionales |> 
  filter(tipo_movimiento=="Despegue") |> 
  count(aeropuerto,  sort = TRUE)
aero_concurridos_join <- aero_concurridos |> 
  inner_join(aeropuertos_iata, join_by("aeropuerto"=="iata"))

grafico_aero_nacionales <-ggplot(aero_concurridos_join,
                                             aes(x=longitude,y=latitude))+
  borders("world") +
  geom_point(aes(color=n)) +coord_quickmap()+ labs(
    title="Aeropuertos nacionales más concurridos",
    color="Cantidad de vuelos"
  )+coord_quickmap(xlim = c(-75, -50), ylim = c(-55, -20))
grafico_aero_nacionales

graf_barras<- ggplot(aero_concurridos_join,
                     aes(x=reorder(aeropuerto,-n),y= n,fill=airport))+
  geom_col()+labs(
                       title="Aeropuertos más concurridos"
                     )
graf_barras


#viajes promedio por día que despegan de Argentina

promedio_dia_2025 <- anac_2025 |> 
  filter(tipo_movimiento=="Despegue") |> 
  count(fecha_utc) 
install.packages("janitor")
library(janitor)
anac_2024 <- read_csv2(file="Tareas/202412-informe-ministerio-actualizado-dic-final.csv") |> 
  janitor::clean_names()
anac_2023<-read_csv2(file="Tareas/202312-informe-ministerio-actualizado-dic.csv") |> 
  janitor::clean_names()
anac_2022<-read_csv2(file="Tareas/202212-informe-ministerio-actualizado-dic-final.csv") |> 
  clean_names()
anac_2021<-read_csv2(file="Tareas/202112-informe-ministerio-actualizado-dic-final.csv") |> 
  clean_names()
anac_2020<-read_csv2(file="Tareas/202012-informe-ministerio-actualizado-dic-final.csv") |> 
  clean_names()
anac_2019<-read_csv2(file="Tareas/201912-informe-ministerio-actualizado-dic-final.csv") |> 
  clean_names()


promedio_dia_2024 <- anac_2024 |> 
  filter(tipo_de_movimiento=="Despegue") |> 
  count(fecha_utc) 


promedio_dia_2023 <- anac_2023 |> 
  filter(tipo_de_movimiento=="Despegue") |> 
  count(fecha_utc) 

promedio_dia_2022 <- anac_2022 |> 
  filter(tipo_de_movimiento=="Despegue") |> 
  count(fecha_utc) 

promedio_dia_2021 <- anac_2021 |> 
  filter(tipo_de_movimiento=="Despegue") |> 
  count(fecha_utc) 


promedio_dia_2020 <- anac_2020 |> 
  filter(tipo_de_movimiento=="Despegue") |> 
  count(fecha_utc) 

promedio_dia_2019 <- anac_2019 |> 
  filter(tipo_de_movimiento=="DESPEGUE") |> 
  count(fecha_utc) 

library(lubridate)

lista_promedios <- list(
  promedio_dia_2019, promedio_dia_2020, promedio_dia_2021, 
  promedio_dia_2022, promedio_dia_2023, promedio_dia_2024, promedio_dia_2025
)

for (i in 1:length(lista_promedios)) {
  lista_promedios[[i]] <- lista_promedios[[i]] |> 
    mutate(fecha_utc = dmy(fecha_utc))
}
glimpse(promedio_dia_2021)

vuelos_historicos <- bind_rows(lista_promedios)
glimpse(vuelos_historicos)

grafico_historico<-ggplot(vuelos_historicos,aes(x=fecha_utc,y=n))+
  geom_line()+labs(title="Cantidad de viajes por día entre los años 2019-2026",
                   y="Cantidad de viajes", x="Tiempo")

grafico_historico
#Qué se observa en la pandemia?
#en la pandemia se observa una gran caída en la cantidad de viajes
#Cuánto tiempo se tarda en recuperar flujos pre–pandemia?
#en 2024 se observa que se recuperan por completo los flujos pre pandemia
#es decir aprox 3 años se tardó
#Se puede apreciar diferencias en los patrones de viajes antes/después?
caract_2025 <- anac_2025 |> 
  filter(tipo_movimiento=="Despegue") |> 
  summarize(pasajeros_total=sum(Pasajeros),
            vuelos_internacionales=sum(clasif_vuelo=="Internacional"),
            vuelos_nacionales=sum(clasif_vuelo=="Doméstico"))
caract_2024 <- anac_2024 |> 
  filter(tipo_de_movimiento=="Despegue") |> 
  summarize(pasajeros_total=sum(pasajeros),
            vuelos_internacionales=sum(clasificacion_vuelo=="Internacional"),
            vuelos_nacionales=sum(clasificacion_vuelo=="Doméstico"))

caract_2023 <- anac_2023 |> 
  filter(tipo_de_movimiento=="Despegue") |> 
  summarize(pasajeros_total=sum(pasajeros),
            vuelos_internacionales=sum(clasificacion_vuelo=="Internacional"),
            vuelos_nacionales=sum(clasificacion_vuelo=="Doméstico"))


caract_2022 <- anac_2022 |> 
  filter(tipo_de_movimiento=="Despegue") |> 
  summarize(pasajeros_total=sum(pasajeros),
            vuelos_internacionales=sum(clasificacion_vuelo=="Internacional"),
            vuelos_nacionales=sum(clasificacion_vuelo=="Doméstico"))


caract_2021 <- anac_2021 |> 
  filter(tipo_de_movimiento=="Despegue") |> 
  summarize(pasajeros_total=sum(pasajeros),
            vuelos_internacionales=sum(clasificacion_vuelo=="Internacional"),
            vuelos_nacionales=sum(clasificacion_vuelo=="Doméstico"))


caract_2020 <- anac_2020 |> 
  filter(tipo_de_movimiento=="Despegue") |> 
  summarize(pasajeros_total=sum(pasajeros),
            vuelos_internacionales=sum(clasificacion_vuelo=="Internacional"),
            vuelos_nacionales=sum(clasificacion_vuelo=="Doméstico"))


caract_2019 <- anac_2019 |> 
  filter(tipo_de_movimiento=="DESPEGUE") |> 
  summarize(pasajeros_total=sum(pasajeros),
            vuelos_internacionales=sum(clasificacion_vuelo=="Internacional"),
            vuelos_nacionales=sum(clasificacion_vuelo=="Domestico"))

# Juntamos todo y creamos la columna "anio" para distinguirlos
resumen_historico <- bind_rows(
  caract_2019 |> mutate(anio = 2019),
  caract_2020 |> mutate(anio = 2020),
  caract_2021 |> mutate(anio = 2021),
  caract_2022 |> mutate(anio = 2022),
  caract_2023 |> mutate(anio = 2023),
  caract_2024 |> mutate(anio = 2024),
  caract_2025 |> mutate(anio = 2025)
) |> relocate(anio)

#observo que aumentaron los vuelos internacionales en los últimos dos años