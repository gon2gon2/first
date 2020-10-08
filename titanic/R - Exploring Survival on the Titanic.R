setwd("c:/kaggle/titanic")

# Load packages
library('ggplot2')   # visualization
library('ggthemes')  # visualization
library('scales')    # visualization
library('dplyr')     # data manipulation
library('mice')      # imputation
library('randomForest') # classification algorithm

# Load dataset
train <- read.csv('train.csv')
test <- read.csv('test.csv')

# full  <- bind_rows(train, test) #binding training & test data
full <- dplyr::bind_rows(train,test)
str(full)
View(full)

# Feature Engineering
## 2.1 What's in a name?

# Grab title from passenger names
full$Title <- gsub('(.*,)|(\\..*)','',full$Name)

# Show title counts by sex  
table(full$Sex,full$Title)  #table (row, col)

# Titles with very low cell counts to be combined to "rare" level
rare_title <- c('Dona', 'Lady', 'the Countess','Capt', 'Col', 'Don', 
                'Dr', 'Major', 'Rev', 'Sir', 'Jonkheer')

# Also reassign mlle, ms, and mme accordingly
full$Title[full$Title == 'Mlle']        <- 'Miss' 
full$Title[full$Title == 'Ms']          <- 'Miss'
full$Title[full$Title == 'Mme']         <- 'Mrs' 
full$Title[full$Title %in% rare_title]  <- 'Rare Title'

# Show title counts by sex again
table(full$Sex, full$Title)
