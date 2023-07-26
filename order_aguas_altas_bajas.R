rm(list = ls())

setwd('D:/trabajo/IGP/CLIM_PEZ/Variables_ordenadas/mensual/')

#D:\Maestria\MER\Intership\baleares\practicas_Daniel\datos_capturas\originales
dir()

library(dplyr)
library(purrr)
library(readxl)
library(gplots)
library(openxlsx)
library(writexl)
library(xlsx)


aguas_bajas<- read_excel("AGUAS_ALTAS_BAJAS.xlsx",'AGUAS_BAJAS')
aguas_altas<-read_excel("AGUAS_ALTAS_BAJAS.xlsx",'AGUAS ALTAS')

cols<-names(aguas_bajas)
#View(aguas_bajas)

aguas_bajas <- aguas_bajas %>%
  rename(YEAR = AÑO, MONTH = MES)

# Convert "MES" column to numeric (if it's stored as character)
aguas_bajas$MONTH <- as.numeric(aguas_bajas$MONTH)

pesca_aguasBajas <- aguas_bajas %>%
  group_by(YEAR) %>%
  summarise_at(vars(matches("^[^1-9]")), sum)

pesca_aguasBajas <- pesca_aguasBajas %>%select(-2)

## ahora aguas altas
aguas_altas <- aguas_altas %>%
  rename(YEAR = AÑO, MONTH = MES)

# Convert "MES" column to numeric (if it's stored as character)
aguas_altas$MONTH <- as.numeric(aguas_altas$MONTH)

pesca_aguasAltas <- aguas_altas %>%
  group_by(YEAR) %>%
  summarise_at(vars(matches("^[^1-9]")), sum)

pesca_aguasAltas <- pesca_aguasAltas %>%select(-2)

View(pesca_aguasAltas)
# Group by year and sum all rows from the 3rd to the last 

IQUITOS<-cbind(pesca_aguasAltas[1:14,1:6],pesca_aguasBajas[1:14,2:6])
NAUTA<-cbind(pesca_aguasAltas[1:14,7:11],pesca_aguasBajas[1:14,7:11])
REQUENA<-cbind(pesca_aguasAltas[1:14,12:16],pesca_aguasBajas[1:14,12:16])


### funcion para reordenar
#  reorder_columns_by_name <- function(df) {
    # Step 1: Get unique column names
    unique_cols <- unique(names(df))
    
    # Step 2: Group columns with the same name together
    reordered_cols <- vector("character", length(names(df)))
    idx <- 1
    for (col in unique_cols) {
      col_indices <- which(names(df) == col)
      reordered_cols[idx:(idx + length(col_indices) - 1)] <- names(df)[col_indices]
      idx <- idx + length(col_indices)
    }
    
    # Step 3: Create a new dataframe with reordered columns
    df_reordered <- df[reordered_cols]
    
    return(df_reordered)
  }

  # df_reordered <- reorder_columns_by_name(df)
#N_IQUI<- reorder_columns_by_name(IQUITOS)
#N_NAU<-reorder_columns_by_name(NAUTA)
#N_REQ<-reorder_columns_by_name(REQUENA)
  
  
  

##
# Create a list of dataframes
df_list <- list("IQUITOS" = IQUITOS, "NAUTA" = NAUTA, "REQUENA" = REQUENA)

# Specify the output file name
output_file <- "output2.xlsx"

# Export the list of dataframes to a single CSV file with three sheets
write_xlsx(df_list, path = output_file)




