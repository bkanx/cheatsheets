# dplyr - vector functions

library(dplyr,, warn.conflicts = FALSE)
df = data.frame(not=rep(c(100, 50, 30),2))
df %>% lead()
df %>% lag()

# Detaylı örnek
df = data.frame(isim = rep(c('A','B'),3), not = rep(c(100, 50, 30),2))

# Now I try to find out lead() and lag() scores for each person. 
# If I sort it using arrange(), I can get the correct answer:

df %>%
  group_by(isim) %>%
  mutate(sonraki.not = lead(not, order_by=isim),
         onceki.not = lag(not, order_by=isim))

# Göreli değişimi hesaplamak için, diff() kullanımına benzer
mutate(df, not_delta = not - lag(not))

# kümülatif Toplamlar (cumulative aggregates)
df = data.frame(arasinav1 = rep(c(100, 50, 30),1), arasinav2 = rep(c(100, 40, 70),1),final = rep(c(90, 90, 50),1))

# cumall(df)
# Finalden 70 üzerinde not alan öğrencileri listelemek için
filter(df, cumall(final > 70))

#cumany()
# Finalden 70 ve üzerinde not alan öğrencileri listelemek için
filter(df, cumany(final > 70))
filter(df, cumany(final == 50))

#cummean() ve cumsum()
# Sınav ortalamalarını listelemek için
mutate(df, cumsum( arasinav1))
mutate(df, cummean( arasinav1))

# cumprod() 
cumprod(1:10)


# Sıralamalar

x <- c(NA, 15, 1, 3, 12, 12)

row_number(x)   # veya benzeri  rank(x,ties.method = "first")
# NA  5  1  2  3  4
min_rank(x)
# NA  5  1  2  3  3
dense_rank(x)
# NA  4  1  2  3  3
percent_rank(x)   # function (x){(min_rank(x) - 1)/(sum(!is.na(x)) - 1)}
# NA 1.00 0.00 0.25 0.50 0.50

# 1 değeri için çözüm: 
# 5-1/(5-1) = 1 
# 2 değeri için çözüm:
# 1-1 /5-1 = 0

# Değerlerin ağırlıklı sıraları 0-1 arasında sayılara dönüştürülür.
cume_dist(x) # function (x) {rank(x, ties.method = "max", na.last = "keep")/sum(!is.na(x))}
# NA 1.0 0.2 0.4 0.8 0.8
rank(x, ties.method = "max", na.last = "keep")
# NA  5  1  2  4  4

# n' ye kadar olan değerleri gruplar
ntile(1:9,3)

# between() vektör içinde belirli bir aralıkta değerler var mı?
filter(df, between(final,30,60)) # tibble olarak çıkarır

x    # nümerik vektör üzerinden örneklendirelim
# NA 15  1  3 12 12
between(x,10,15)
# NA  TRUE FALSE FALSE  TRUE  TRUE
x[between(x,10,15)]
# NA 15 12 12

# near()
near(x,12)
#  NA FALSE FALSE FALSE  TRUE  TRUE
x[near(x,12)]
# NA 12 12


# coalesce(x,y) # kayıp değeri her hangi bir değer ile değiştirmek
y <- c(3,7,0,8,NA,12) 
data.frame(x,y) %>% mutate(new = coalesce(x,y))

# na_if()
na_if(1:10,5)  # herhangi bir değeri NA ile değiştirmek

# replace_na  # NA olan değerleri her hangi bir değerle değiştirmek
replace_na(x,100)  

# recode()    
z <- c("math","stat","geo")
recode(z, math = "mathematics") # karakter vektörler için yeni atama
z <- rep(c("math","stat","geo"),2)
recode_factor(z, math= "mathematics") # düzeyleri alfabetik sırada sıralamaz
factor(z) # düzeyleri alfabetik sırada sıralae

# pmax() ve pmin()
pmax(data.frame(x,y)[1],data.frame(x,y)[2])  # karşılaştırma sonrası en büyükleri listeler
pmin(data.frame(x,y)[1],data.frame(x,y)[2],na.rm = TRUE)  # karşılaştırma sonrası en küçükleri listeler



# Özet Fonksiyonları

# n() satır sayısını verir, nrow(df) ile benzerdir
df = data.frame(not=rep(c(100, 50, 30),2))
df %>% summarise(n=n())

# n_distinct() nümerik değer verir, distinct() tibble çıkarır
df = data.frame(arasinav1 = rep(c(100, 50, 30),1), arasinav2 = rep(c(100, 40, 70),1),final = rep(c(90, 90, 50),1))
df2 <- rbind(df,df) # kopya satırları yaratılır
n_distinct(df2)   # kopya satırlar bulunur, nrow(distinct(df2)) ile benzerdir
distinct(df2, new = arasinav1-arasinav2) # yeni işlemler de yapılabilir

# Değişken ismi arama için 
distinct(df,across(contains("sinav")))


# tibble içinde NA var mı sorgulanır
sum(is.na(df2))  # sayısal değer çıkarır, is.na() tibble çıkarır

# Konum için ortalamalar
df2 %>% summarise(mean(arasinav1)) # veya median()

# İlk veya son değer sorgulama
df2 %>% summarise(first(arasinav1))
df2 %>% summarise(nth(arasinav1,2))  # tibble içindeki 2 satır elemanlarını çıkarır


# quantile()
df %>% summarise(quantile = quantile(final, c(0.25, 0.5, 0.75)))

# Tüm sutunlara uygulanan işlemler
df = data.frame(isim = rep(c('A','B'),3), not = c(100, 50, 30,80,90,80),odev =rep(c(15,25,65),2))
df %>% summarise(across(not:odev,mean))
df %>% group_by(isim) %>% summarise(across(not:odev,mean))

# Tüm sütunlara uygulanan işlemler
df %>% group_by(isim) %>% summarise_all(sd)

# Tüm sutunlara birden fazla işlem
df %>% group_by(isim) %>% summarise_all(list(ort=mean,varyans=var,st.sapma=sd))
df %>% group_by(isim) %>% summarise(across(everything(),list(ort=mean,st.sapma=sd)))

# rownnames_to_column()   # satır isimlerini ilk sütuna taşır
df = data.frame(arasinav1 = rep(c(100, 50, 30),1), arasinav2 = rep(c(100, 40, 70),1),final = rep(c(90, 90, 50),1))
rownames(df)=c("Mart","Nisan","Haziran")
df
rownames_to_column(df)


              