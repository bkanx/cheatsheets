
#TABLO BÝRLEÞTÝRME
library(dplyr)
library(tidyverse)

customer_id <- c(1, 2, 3, 4, 5, 6)

customer_id1 <- c(3, 6, 1, 4, 7, 8)

order_id <- c(12, 17, 11, 20, 21, 15)

cost <- c(180.25, 196 ,250.65, 236.10, 261, 175.12)

city <- c("Bristol", "Bath", "Durham", "Londra", "Londra", "Nottingham")

customer_name <- c("Gagnon", "Evans", "Lee", "Gelbero", "Wang","Megan")

df1 <- data.frame(customer_id, order_id,cost)
df2 <- data.frame(customer_id,cost, customer_name)
df3 <- data.frame(customer_id1, city)

#DEÐÝÞKENLERÝ (SÜTUNLARI) BÝRLEÞTÝRME
#cbind
bind_cols(df1, df2)

inner_join(df1, df2)

df1  %>%  inner_join( df2, by = "customer_id")

inner_join(df1, df3, by = c("customer_id"="customer_id1"))

left_join(df1, df3, by = c("customer_id"="customer_id1"))
left_join(df3, df1, by = c("customer_id1"="customer_id"))

right_join(df1, df3, by = c("customer_id"="customer_id1"))

full_join(df1, df3, by = c("customer_id"="customer_id1"))

left_join(df1,df2, by = "cost", suffix = c("df1", "df2"))

left_join(df2,df1, by = c("customer_id")) %>%
  filter(customer_name== "Lee")

left_join(df2,df1, by = c("cost","customer_id")) %>%
  filter(order_id > 15) %>%
  select(customer_name)

left_join(df3,df2, by = c("customer_id1"="customer_id")) %>%
  filter(cost > 100) %>%
  select(customer_id1,cost,city)

#DURUMLARI (SATIRLARI) BÝRLEÞTÝRME
#rbind
bind_rows(df1, df2)

intersect(df2$customer_id, df3$customer_id1)

setdiff(df2$customer_id, df3$customer_id1)

setequal(c("a","b"),c("a","b","b"))
setequal(df2$customer_id, df3$customer_id1)

union(df2$customer_id, df3$customer_id1)

semi_join(df3, df2, by = c("customer_id1" = "customer_id"))
semi_join(df2, df3, by = c("customer_id" = "customer_id1"))

anti_join(df3, df2, by = c("customer_id1" = "customer_id"))

--------------------------------------------------------------------------------

