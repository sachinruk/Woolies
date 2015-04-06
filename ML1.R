#construct matrix with past 10 weeks of sales and past 10 weeks of promotions
idx=train_data$product_store_id=='3a';
x=train_data[idx,]
y_x=matrix(nrow = 0,ncol = 21);
k=1;
lag=10;
for (i in 11:106){
  inputs=as.vector(as.matrix(x[k:(k+lag-1),c("sales","promotion")]))
  #browser()
  output=x[k+lag,"sales"]
  y_x=rbind(y_x,as.numeric(c(output,inputs)))
  k=k+1
}

#CART trees
y_x=as.data.frame(y_x)
sub=sample(dim(y_x)[1],50)
fit=rpart(V1~.,method = "anova",data=y_x,subset=sub)
#plot(fit); text(fit) #visualise the tree
norm(as.matrix(predict(fit,y_x[-sub,-1],method="anova"))-y_x[-sub,"V1"],"2")/sqrt(46)
#table(predict(fit,y_x[-sub,],type="anova"),y_x[-sub,"V1"])

library(randomForest)
fit=randomForest(x=y_x[sub,-1],y=y_x[sub,1])
#table(predict(fit,y_x[-sub,-1]),y_x[-sub,1])
norm(as.matrix(predict(fit,y_x[-sub,-1]))-y_x[-sub,"V1"],"2")/sqrt(46)