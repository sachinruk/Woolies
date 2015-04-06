setwd('Documents/thesis/Woolies/')
products=read.csv('products.csv')
train_data=read.csv('train2.csv')
train_data$date=as.Date(train_data$date,format="%d/%m/%y")

library(ggplot2)
library(gridExtra)
library(rpart)

idx=train_data$product_store_id=='3a';
g.top=ggplot()+
  geom_line(aes(x=train_data$date[idx],y=train_data$sales[idx]))
g.bottom=ggplot()+
  geom_line(aes(x=train_data$date[idx],y=train_data$promotion[idx]))

grid.arrange(g.top,g.bottom, heights = c(4/5, 1/5))
View(cbind(train_data$date[idx],train_data$sales[idx]))
#take the FFT
a=fft(train_data$sales[idx])
qplot(1:sum(idx),log(abs(a)),geom="line")

#take last weeks sales to predict todays
err=diff(train_data$sales[idx])^2
rmse=sqrt(sum(err)/length(err))

#concatenate promotions
udate=unique(train_data$date)
products=sort(unique(train_data$product_name))
product_shops=sort(unique(train_data$product_store_id))

x=data.frame(row.names=udate)
for (i in 1:length(product_shops)){
  for (j in 1:length(udate)){
    idx=train_data$date==udate[j] & train_data$product_store_id==product_shops[i]
    if (sum(idx))
      x[j,i]=train_data$promotion[idx]
  }
}
colnames(x)<-product_shops

#View all coke promotions across stores
View(x[,6:10])
#View all yoplait promotions across stores
y=x[,21:25]; View(cbind(y,rowSums(y)))

#eater dates brought forward to Wednesdat
easter=c("2013-04-03","2014-04-23","2015-04-08")
xmas=c("2013-12-25")
View(x[easter[1:2],])

#check correlations
prod_date=data.frame(matrix(nrow = 0,ncol = length(product_shops)))
names(prod_date)=product_shops
for (i in 1:length(udate)){
  x=train_data[train_data$date==udate[i],c("product_store_id","sales")]
}

