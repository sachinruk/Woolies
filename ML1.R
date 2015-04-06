#construct matrix with past 10 weeks of sales and past 10 weeks of promotions
idx=train_data$product_store_id=='3a';
x=train_data[idx,]
y_x=matrix(nrow = 0,ncol = 21);
k=1;
for (i in 11:106){
  inputs=as.vector(as.matrix(x[k:(k+9),c("sales","promotion")]))
  #browser()
  output=x[k+10,"promotion"]
  y_x=rbind(y_x,as.numeric(c(output,inputs)))
  k=k+1
}

#CART trees
y_x=as.data.frame(y_x)
sub=sample(dim(y_x)[1],50)
fit=rpart(V1~.,method = "class",data=y_x,subset=sub)
plot(fit); text(fit) #visualise the tree

table(predict(fit,y_x[-sub,],type="class"),y_x[-sub,"V1"])

sub <- c(sample(1:50, 25), sample(51:100, 25), sample(101:150, 25))
fit <- rpart(Species ~ ., data = iris, subset = sub)
fit
table(predict(fit, iris[-sub,], type = "class"), iris[-sub, "Species"])