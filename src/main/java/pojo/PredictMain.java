package pojo;

import au.com.bytecode.opencsv.CSVReader;
import hex.genmodel.easy.EasyPredictModelWrapper;
import hex.genmodel.easy.RowData;
import hex.genmodel.easy.exception.PredictException;

import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.List;
import ai.h2o.hive.udf.GBMModel;
import hex.genmodel.easy.prediction.RegressionModelPrediction;

/**
 * Created by huss on 16-01-06.
 */
public class PredictMain {
    static EasyPredictModelWrapper prostateModel;

    public static void main(String[] args) throws IOException {
        System.out.println("prediction...");
        GBMModel rawProstateModel = new GBMModel();
        prostateModel = new EasyPredictModelWrapper(rawProstateModel);

        ClassLoader classLoader = PredictMain.class.getClassLoader();


        File file = new File(classLoader.getResource("pred_test_1.csv").getFile());
        FileReader fileReader  = new FileReader(file);
        CSVReader reader = new CSVReader(fileReader);
        List myEntries = reader.readAll();
        String[] header = (String []) myEntries.get(0);
        String[] values = (String []) myEntries.get(1);
        RowData test1 = new RowData();
        for (int i=0; i < values.length; i++){
            test1.put(header[i], values[i]);
        }

        file = new File(classLoader.getResource("pred_test_2.csv").getFile());
        fileReader  = new FileReader(file);
        reader = new CSVReader(fileReader);
        myEntries = reader.readAll();
        header = (String []) myEntries.get(0);
        values = (String []) myEntries.get(1);
        RowData test2 = new RowData();
        for (int i=0; i < values.length; i++){
            test2.put(header[i], values[i]);
        }

        try {
            RegressionModelPrediction p1 = predictProstate(test1);
            System.out.println(p1.value);

            RegressionModelPrediction p2 = predictProstate(test2);
            System.out.println(p2.value);

        } catch (PredictException p) {
            System.out.println(p.getStackTrace());
        }
    }


    private static RegressionModelPrediction predictProstate(RowData row) throws PredictException {
        return prostateModel.predictRegression(row);
    }
}