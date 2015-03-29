setwd('Documents/Woolies/')
products=read.csv('products.csv')
train_data=read.csv('train2.csv')
train_data$date=as.Date(train_data$date,format="%d/%m/%y")

library(ggplot2)
library(gridExtra)
idx=train_data$product_store_id=='2e';
g.top=ggplot()+
  geom_line(aes(x=train_data$date[idx],y=train_data$sales[idx]))
g.bottom=ggplot()+
  geom_line(aes(x=train_data$date[idx],y=train_data$promotion[idx]))

grid.arrange(g.top,g.bottom, heights = c(4/5, 1/5)) 
plot(p)
#take the FFT
a=fft(train_data$sales[idx])
qplot(1:sum(idx),log(abs(a)),geom="line")

#take last weeks sales to predict todays
err=diff(train_data$sales[idx])^2
rmse=sqrt(sum(err)/length(err))