library(h2o)

localH2O <- h2o.init(ip = "ch4-slave-1.citation.io", port = 54321, startH2O = FALSE)
train_all  <- h2o.importFile(path = "hdfs://ch4-master.citation.io/user/root/GisetteScoreTestCSV/gisette_train_clean.csv")
preset <- names(train_all)


train_label  <- h2o.importFile(path = "hdfs://ch4-master.citation.io/user/root/GisetteScoreTestLabels/gisette_train.labels")
names(train_label)[names(train_label)=="C1"] <- "CLASSIFICATION"
train_all$CLASSIFICATION <- train_label;
train_all$CLASSIFICATION = as.numeric(train_all$CLASSIFICATION)
train_all$CLASSIFICATION = as.factor(train_all$CLASSIFICATION)

# NOT NEEDED FOR THE TIME BEING
rand_vec <- h2o.runif(train_all, seed = 1234)
train <- train_all[rand_vec <= 0.8,]
valid <- train_all[(rand_vec > 0.8),]



gisette_model <- h2o.glm(x = preset,
                             y = "CLASSIFICATION",
                             training_frame = train_all,
#                             validation_frame  = valid,
                             model_id  = "GBMModel",
                             family = "binomial")


if (! file.exists("tmp")) {
  dir.create("tmp")
}


h2o.download_pojo(gisette_model , path = "tmp")

test1 <- train_all[1, ]
test2 <- train_all[2, ]

pred_test_1 = h2o.predict(gisette_model, test1)
pred_test_2 = h2o.predict(gisette_model, test2)

print(pred_test_1)
print(pred_test_2)
