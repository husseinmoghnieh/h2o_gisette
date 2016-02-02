library(h2o)

localH2O = h2o.init(max_mem_size = "5g")
train_all  <- h2o.importFile(path = "data/gisette_train.data")
preset <- names(train_all)


train_label  <- h2o.importFile(path = "data/gisette_train.labels")
names(train_label)[names(train_label)=="C1"] <- "CLASSIFICATION"

train_all$CLASSIFICATION <- train_label;
train_all$CLASSIFICATION = as.numeric(train_all$CLASSIFICATION)
train_all$CLASSIFICATION = as.factor(train_all$CLASSIFICATION)

rand_vec <- h2o.runif(train_all, seed = 1234)
train <- train_all[rand_vec <= 0.8,]
valid <- train_all[(rand_vec > 0.8),]


waterTrain.data.frame <- as.data.frame(train)


newrow <- numeric(5001)

for(i in 1:5000)
{
    column_sum = sum(waterTrain.data.frame[,i])
    if (column_sum == 0)
      newrow[i] = 1
}
waterTrain.data.frame <- rbind(waterTrain.data.frame, newrow)



train <- as.h2o(waterTrain.data.frame, destination_frame="train.hex")


print('starting model buildin')
gisette_model <- h2o.glm(x = preset,
                             y = "CLASSIFICATION",
                             training_frame = train,
                             validation_frame  = valid,
                             model_id  = "GBMModel",
                             family = "binomial")


if (! file.exists("tmp")) {
  dir.create("tmp")
}
#
#
h2o.download_pojo(gisette_model , path = "tmp")
#
test1 <- train_all[1, ]
test2 <- train_all[2, ]

pred_test_1 = h2o.predict(gisette_model, test1)
pred_test_2 = h2o.predict(gisette_model, test2)
#
print(pred_test_1)
print(pred_test_2)