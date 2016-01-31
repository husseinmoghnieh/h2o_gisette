library(h2o)
localH2O = h2o.init(max_mem_size = "5g")
train_all  <- h2o.importFile(path = "data_clean/gisette_train_train.csv")
train_all$classification = as.numeric(train_all$classification)
train_all$classification = as.factor(train_all$classification)

valid_all  <- h2o.importFile(path = "data_clean/gisette_train_valid.csv")


preset <- names(train_all)
preset <- preset[preset != "classification"]




print(preset)
gisette_model <- h2o.glm(x = preset,
                             y = "classification",
                             training_frame = train_all,
                             validation_frame  = valid_all,
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


h2o.exportFile(test1, "pred_test_1_new.csv", force = TRUE)
h2o.exportFile(test2, "pred_test_2_new.csv", force = TRUE)


