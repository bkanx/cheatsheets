

library(ISLR)
library(dplyr)
mydata<-data.frame(Carseats)
  
summarise(mydata,avg=mean(Sales))
count(mydata,Age)

# VARYASYONLAR
# summarise all the column of dataframe
#summarise_all(mydata,funs(n(),mean,median))

# summarise the list of columns of dataframe
mydata %>% summarise_at(mydata, vars(Sales,CompPrice), funs(n(), mean, median))

# summarise all the list of numeric variable of dataframe
#summarise_if(mydata, is.numeric, funs(n(),mean,median))
#group_by(mydata,ShelveLoc)

#DURUMLARI SE?ME
filter(mydata,Income>110)
distinct(mydata,Age)
sample_frac(mydata,0.3,replace = T)
sample_n(mydata,10,replace = F)
slice(mydata,10:15)

#DURUMLARI SIRALAMA
arrange(mydata,desc(Income))

#DURUM EKLEME
add_row

#DE???KEN(S?TUN)SE?ME
pull(mydata,Advertising)
select(mydata,Urban,US)

select(mydata,contains("Urban"))

#YEN? DE???KENLER OLU?TURMA
mutate(mydata,gpm=1/Sales)

#mydata %>% 
#select_if(is.numeric) %>% 
#mutate_all(mydata,funs(log(.),log2(.)))

mutate_at(mydata, vars(Sales,Income), funs(log(.)))

library(tidyverse)
add_column(mydata,new=1:400)
rename(mydata,Populasyon=Population)


