package pojo;

import au.com.bytecode.opencsv.CSVReader;

import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.List;

/**
 * Created by huss on 16-01-18.
 */
public class DetectConstantColumns {
    public static void main(String[] args) throws IOException {
        ClassLoader classLoader = PredictMain.class.getClassLoader();
        File file = new File(classLoader.getResource("gisette_train.data").getFile());
        FileReader fileReader = new FileReader(file);
        CSVReader reader = new CSVReader(fileReader, ' ');
        List myEntries = reader.readAll();
        boolean[] isConstant = new boolean[5000];
        for (int i = 0; i < 5000; i++)
            isConstant[i] = true;

        for (int i = 0; i < myEntries.size(); i++) {
            String[] values = (String[]) myEntries.get(i);
            for (int j = 0; j < values.length - 1; j++) {
//                System.out.println(values[j]);
                if (!values[j].equals("0"))
                    isConstant[j] = false;
            }
        }

        for (int i = 0; i < 5000; i++)
            if(isConstant[i])
                System.out.println(i);

    }
}
