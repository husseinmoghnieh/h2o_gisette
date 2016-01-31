library(h2o)
localH2O <- h2o.init()
train_all  <- h2o.importFile(path = "data/gisette_train.data")
rand_vec <- h2o.runif(train_all, seed = 1234)


train <- train_all[rand_vec <= 0.8,]
valid <- train_all[(rand_vec > 0.8),]


#Sum all columns
colums_sum <- apply(train, 2, sum)
#
# A column with 0 sum is considered to be a constant output
constantFunction = function(x){
    x == 0
}

#
non_constant <-apply(colums_sum, 1, constantFunction)
#print(non_constant)
dropss <- vector()
dropss <- c(dropss, 'C1')
for(i in 1:40)
{

        xx <- as.numeric(non_constant[,i])
        if ( xx[1,1] > 0 )
             dropss <- c(dropss, paste('C', i, sep=''))

}
#print(non_constant)
print(dropss)
drops <- c("C1","C2")
train <- train[,!(names(train) %in% drops)]
valid <- valid[,!(names(valid) %in% drops)]
#
print(dim(valid))

print(dim(train))


