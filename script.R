library(h2o)
#h2o.init()
localH2O <- h2o.init(ip = "ch2-slave-2.citation.io", port = 54321, startH2O = FALSE)
train_all  <- h2o.importFile(path = "hdfs://ch2-master.citation.io/user/root/GisetteScoreTest/gisette_train.data")
preset <- names(train_all)


train_label  <- h2o.importFile(path = "hdfs://ch2-master.citation.io/user/root/GisetteScoreTestLabels/gisette_train.labels")
names(train_label)[names(train_label)=="C1"] <- "CLASSIFICATION"
train_all$CLASSIFICATION <- train_label;
train_all$CLASSIFICATION = as.numeric(train_all$CLASSIFICATION)
#
rand_vec <- h2o.runif(train_all, seed = 1234)
train <- train_all[rand_vec <= 0.8,]
valid <- train_all[(rand_vec > 0.8),]



gisette_model <- h2o.gbm(x = preset,
                             y = "CLASSIFICATION",
                             training_frame = train,
                             validation_frame  = valid,
                             model_id  = "GBMModel",
                             distribution = "gaussian",
                             max_depth = 5,
                             ntrees = 110)
test1 <- train_all[1, ]
test2 <- train_all[2, ]

pred_test_1 = h2o.predict(gisette_model, test1)
pred_test_2 = h2o.predict(gisette_model, test2)
print(pred_test_1)
print(pred_test_2)

if (! file.exists("tmp")) {
  dir.create("tmp")
}

h2o.exportFile(test1, "tmp/pred_test_1.csv", force = TRUE)
h2o.exportFile(test2, "tmp/pred_test_2.csv", force = TRUE)

h2o.download_pojo(gisette_model , path = "tmp")



#
## Make and export predictions.
#h2o_single_test_1  <- h2o.importFile(path = "data/prostate_test_actual0.csv")
#h2o_single_test_2  <- h2o.importFile(path = "data/prostate_test_actual1.csv")
#
#pred_test_1 = h2o.predict(binomial.fit, h2o_single_test_1)
#pred_test_2 = h2o.predict(binomial.fit, h2o_single_test_2)
#
#if (! file.exists("tmp")) {
#  dir.create("tmp")
#}
#
#h2o.exportFile(pred_test_1, "tmp/pred_test_1.csv", force = TRUE)
#h2o.exportFile(pred_test_2, "tmp/pred_test_2.csv", force = TRUE)
#h2o.download_pojo(binomial.fit , path = "tmp")
#
## Or you can export the predictions to hdfs:
##   h2o.exportFile(pred, "hdfs://namenode/path/to/file.csv")1718
#
## Calculate metrics.
##perf = h2o.performance(binomial.fit, test)
##print(perf)