package pojo;

import au.com.bytecode.opencsv.CSVReader;

import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.List;

/**
 * Created by huss on 16-01-18.
 */
public class CheckConstantColumn {
    public static void main(String[] args) throws IOException {
        ClassLoader classLoader = PredictMain.class.getClassLoader();
        File file = new File(classLoader.getResource("gisette_train.data").getFile());
        FileReader fileReader = new FileReader(file);
        CSVReader reader = new CSVReader(fileReader, ' ');
        List myEntries = reader.readAll();
        for (int i = 0; i < myEntries.size(); i++) {
            String[] values = (String[]) myEntries.get(i);
            if (!values[28].equals("0")) {
                System.out.println("not constant");
                break;
            }
        }
    }
}
