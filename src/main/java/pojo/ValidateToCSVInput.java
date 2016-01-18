package pojo;

import au.com.bytecode.opencsv.CSVReader;
import hex.genmodel.easy.RowData;

import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

/**
 * Created by huss on 16-01-17.
 */
public class ValidateToCSVInput {
    public static void main(String[] args) throws IOException {
        ClassLoader classLoader = PredictMain.class.getClassLoader();
        File file = new File(classLoader.getResource("gisette_train.data").getFile());
        FileReader fileReader = new FileReader(file);
        CSVReader reader = new CSVReader(fileReader, ' ');
        List myEntries = reader.readAll();
        PrintWriter writer = new PrintWriter("gisette_train.csv", "UTF-8");

        for (int i = 0; i < myEntries.size(); i++) {
            String[] values = (String[]) myEntries.get(i);
            StringBuilder stringBuilder = new StringBuilder();
            if (values.length != 5001)
             System.out.println("Data issue");
            for (int j=0; j < values.length - 1; j++) {
                stringBuilder.append(values[j]);
                if (j < values.length - 2)
                stringBuilder.append(",");
            }
            writer.println(stringBuilder.toString());

        }
        writer.close();
    }
}