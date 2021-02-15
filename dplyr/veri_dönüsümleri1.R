
library(ISLR)
library(dplyr)
library(tidyverse)

###VERÝ DÖNÜÞÜMLERÝ
mydata <- data.frame(Carseats)

#DURUMLARI (SATIRLARI) ÖZETLE 
summary
summarise(mydata, avg=mean(Sales))

count(mydata, Age)


#VARYASYONLAR
#summarise_all(mydata,funs(mean,median))

summarise_at(mydata, vars(Price,CompPrice), funs(mean, median))

summarise_if(mydata, is.numeric, funs(max, min))


#DURUMLARI GRUPLAMA
group_by(mydata,Age) %>% summarise(n = n())

group_by(mydata, ShelveLoc) %>%
  summarise(max = max(Income),
            min = min(Income),   
            n = n()) 


#DURUMLARI SEÇME
filter(mydata, Income > 110)

distinct(mydata, Age)

sample_frac(mydata, 0.1, replace = T)

sample_n(mydata, 10, replace = F)

slice(mydata, 10:15)

#slice_max(), slice_min()
top_n (mydata, 5, Sales)
top_n (mydata, -5, Sales)


#DURUMLARI SIRALAMA
arrange(mydata, Advertising) %>%
head()

arrange(mydata, desc(Advertising)) %>%
head()


#DURUM EKLEME
mydata<-add_row(mydata, Sales = 9.71, CompPrice = 134, Income = 53, Advertising = 5, Population = 50, 
                Price = 132, ShelveLoc = "Medium", Age = 5, Education = 12, Urban = "No", US = "Yes")

#DEÐÝÞKEN(SÜTUN)SEÇME
pull(mydata, Advertising)

select(mydata, Urban, US)%>%
 head()

select(mydata, 1:3)%>%
 head()


select(mydata, matches("P")) %>%
  head()

select(mydata, starts_with("P")) %>%
  head()

#YENÝ DEÐÝÞKENLER OLUÞTURMA
mutate(mydata, new = 1/Sales) %>%
  head()

mutate(mydata, Sales = 1/Sales) %>%
  head()

transmute(mydata, new = 1/Sales) %>%
  head()

mutate_if (mydata, is.numeric, funs(log(.)))%>%
  head()

mutate_at(mydata, vars(Sales,Income), funs(log(.)))%>%
  head()

add_column(mydata,new=1:401)

rename(mydata, Populasyon = Population)

-------------------------------------------------------------------------

