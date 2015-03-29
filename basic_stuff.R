setwd('Documents/Woolies/')
products=read.csv('products.csv')
train_data=read.csv('train2.csv')
train_data$date=as.Date(train_data$date,format="%d/%m/%y")

library(ggplot2)
library(gridExtra)
idx=train_data$product_store_id=='3e';
g.top=ggplot()+
  geom_line(aes(x=train_data$date[idx],y=train_data$sales[idx]))
g.bottom=ggplot()+
  geom_line(aes(x=train_data$date[idx],y=train_data$promotion[idx]))

grid.arrange(g.top,g.bottom, heights = c(4/5, 1/5)) 
#take the FFT
a=fft(train_data$sales[idx])
qplot(1:sum(idx),log(abs(a)),geom="line")

#take last weeks sales to predict todays
err=diff(train_data$sales[idx])^2
rmse=sqrt(sum(err)/length(err))

#aggregate products and see correlations
products=unique(train_data$product_name)
product_shops=unique(train_data$product_store_id)
x=matrix()
for (i in 1:44){
  x=rbind(x,train_data$sales[train_data$product_store_id==product_shops[i]])
}
