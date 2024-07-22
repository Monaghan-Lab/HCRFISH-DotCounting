#--------#
# This is a sample script for plotting proximodistal gene expression intensity
# using HCR-FISH data as used in Duerr, TJ et al., 2024. 
# Users can manipulate input with their own genes, conditions, and timepoints
# as relevant. 
# Ensure that file paths and CSVs of data are named consistently and intuitively.
# `for` loops concatenate data based on information extracted from file names and should be edited accordingly.
#   Ex: Time_Condition_Gene_Replicate.csv
# Columns in data exported from FIJI are assumed to be: ROI_number, X, Y, RawIntDen (Z)
#--------#
##### Libraries #####
library(tidyverse)
library(dplyr)
library(scales)
library(tools)
library(csv)
library(svglite)
# library(future)

##### Gene 1 #####
Gene1.Condition1.Time1.path <- "./Gene1/Condition1/Time1"
Gene1.Condition1.Time1.Files <- Sys.glob( file.path( Gene1.Condition1.Time1.path, "*.csv" ) )

Gene1.Condition1.Time1.data <- data.frame()
for (csv in Gene1.Condition1.Time1.Files){
  baseFilename <- basename( file_path_sans_ext(csv) )
  df <- read_csv(csv, col_names = TRUE, show_col_types = FALSE) 
    df <- df %>%
    drop_na() %>%
    `colnames<-`(c("ROI_Number", "X", "Y", "Z")) %>%
    filter(Z > 0) %>%
    select(Y, Z) %>%
    mutate(
      Time = unlist( str_split( baseFilename, "_") )[[1]],
      Condition = unlist( str_split( baseFilename, "_") )[[2]],
      Gene = unlist(str_split(baseFilename, "_"))[[3]],
      Replicate = unlist(str_split( baseFilename, "_"))[[4]],
      dist.Y = rescale(Y),
      Z = case_when(Z != 255 ~ "0",
                    Z == 255 ~ "1")) %>%
    mutate(Z = as.numeric(Z))
    Gene1.Condition1.Time1.data <- rbind(Gene1.Condition1.Time1.data, df)
}

gc()

# These are checks to make sure data is correct
# head(Gene1.Condition1.Time1.data)
# Gene1.Condition1.Time1.data %>%
#   select(Time, Condition, Gene, Replicate) %>%
#   unique()
# Gene1.Condition1.Time1.data %>%
#   select(Z) %>% # If there are NAs, redo measurement!
#   unique()
# To determine replicate with NAs
# Gene1.Condition1.Time1.data %>%
#   select(Time, Condition, Gene, Replicate, Z) %>%
#   unique()

Gene1.Condition1.Time1.data.mean <- Gene1.Condition1.Time1.data %>%
  filter(Gene == "Gene1") %>%
  group_by(Time, dist.Y, Gene, Replicate, Condition) %>%
  summarise_at(vars(Z), list(Z = mean))

Gene1.Condition2.Time1.path <- "./Gene1/Condition2/Time1"
Gene1.Condition2.Time1.Files <- Sys.glob( file.path( Gene1.Condition2.Time1.path, "*.csv" ) )

Gene1.Condition2.Time1.data <- data.frame()
for (csv in Gene1.Condition2.Time1.Files){
  baseFilename <- basename( file_path_sans_ext(csv) )
  df <- read_csv(csv, col_names = TRUE, show_col_types = FALSE) 
  df <- df %>%
    drop_na() %>%
    `colnames<-`(c("ROI_Number", "X", "Y", "Z")) %>%
    filter(Z > 0) %>%
    select(Y, Z) %>%
    mutate(
      Time = unlist( str_split( baseFilename, "_") )[[1]],
      Condition = unlist( str_split( baseFilename, "_") )[[2]],
      Gene = unlist(str_split(baseFilename, "_"))[[3]],
      Replicate = unlist(str_split( baseFilename, "_"))[[4]],
      dist.Y = rescale(Y),
      Z = case_when(Z != 255 ~ "0",
                    Z == 255 ~ "1")) %>%
    mutate(Z = as.numeric(Z))
  Gene1.Condition2.Time1.data <- rbind(Gene1.Condition2.Time1.data, df)
}

gc()

# head(Gene1.Condition2.Time1.data)
# Gene1.Condition2.Time1.data %>%
#   select(Time, Condition, Gene, Replicate) %>%
#   unique()
# Gene1.Condition2.Time1.data %>%
#   select(Z) %>% # If there are NAs, redo measurement!
#   unique()
# To determine replicate with NAs
# Gene1.Condition2.Time1.data %>%
#   select(Time, Condition, Gene, Replicate, Z) %>%
#   unique()

Gene1.Condition2.Time1.data.mean <- Gene1.Condition2.Time1.data %>%
  filter(Gene == "Gene1") %>%
  group_by(Time, dist.Y, Gene, Animal, Condition) %>%
  summarise_at(vars(Z), list(Z = mean))

Gene1.plot.data <- rbind(Gene1.Condition1.Time1.data.mean,
                         Gene1.Condition2.Time2.data.mean)

gc()

##### Plots #####
plot.data <- Gene1.plot.data # Use rbind() to add additional genes/conditions/timepoints
plot <- plot.data %>%
  filter(Gene %in% c("Gene1") &
           Time %in% c("Time1") &
           Condition %in% c("Condition1", "Condition2")) %>%
  ggplot(.,
         aes(x = dist.Y,
             y = sqrt(Z),
             color = Gene,
             linetype = Condition)) +
  stat_smooth(position = position_identity(), 
              se = FALSE, 
              n = 2000,
              fullrange = TRUE,
              orientation = "x") + 
  #scale_color_discrete(type = c("magenta",
  #                              "#FFCC00",
  #                              "cyan",
  #                             "gray40") ) +
  facet_grid(cols = vars(Condition),
             # rows = vars(Time),
             scales = "fixed",
             space = "fixed") + 
  xlab("Proximodistal location") +
  ylab("Expression") +
  xlim(0, 1) +
  theme_classic() +
  # guides(linetype = "none") +
  theme(legend.text = element_text(face = "italic"),
        axis.text.y = element_blank(),
        #axis.ticks.y = element_blank(),
        #axis.ticks.x = element_blank(),
        #axis.text.x = element_blank(),
        axis.title = element_text(face = "bold"),
        legend.position = "bottom",
        legend.title = element_blank())
plot
ggsave("Gene1_Time1.svg", 
       plot, 
       width = 7,
       height = 5)
gc()

##### Session #####
sessionInfo()
