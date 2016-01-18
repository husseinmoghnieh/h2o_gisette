package pojo;

import au.com.bytecode.opencsv.CSVReader;

import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by huss on 16-01-17.
 */
public class ConvertToCSVInput {
    public static void main(String[] args) throws IOException {
        ClassLoader classLoader = PredictMain.class.getClassLoader();
        File file = new File(classLoader.getResource("gisette_train.data").getFile());
        FileReader fileReader = new FileReader(file);
        CSVReader reader = new CSVReader(fileReader, ' ');
        List myEntries = reader.readAll();
        PrintWriter writer = new PrintWriter("gisette_train.csv", "UTF-8");
        String constantColumns = "C22, C29, C108, C112, C120, C138, C197, C351, C391, C422, C480, C609, C626, C794, C877, C1005, C1038, C1041, C1103, C1180, C1268, C1400, C1435, C1640, C1677, C1737, C1793, C1836, C1905, C2023, C2034, C2087, C2199, C2249, C2349, C2464, C2586, C2603, C2605, C2687, C2692, C2700, C2812, C2902, C2910, C2953, C3008, C3015, C3019, C3027, C3158, C3194, C3262, C3477, C3557, C3632, C3707, C3746, C3865, C3897, C4067, C4101, C4217, C4256, C4389, C4635, C4873, C4965, 97, C101, C109, C186, C232, C380, C410, C464, C468, C779, C782, C865, C993, C1026, C1029, C1168, C1256, C1423, C1628, C1665, C1670, C1725, C1781, C1814, C1824, C1893, C2011, C2059, C2075, C2187, C2237, C2337, C2378, C2452, C2537, C2574, C2591, C2593, C2675, C2680, C2726, C2800, C2813, C2890, C2898, C2941, C2956, C2996, C3015, C3146, C3182, C3250, C3465, C3545, C3620, C3695, C3734, C3853, C4055, C4089, C4244, C4377, C4638, C4639, C4861, C4926, C4953";
        for (int i = 0; i < myEntries.size(); i++) {
            String[] values = (String[]) myEntries.get(i);
            StringBuilder stringBuilder = new StringBuilder();
            if (values.length != 5001)
             System.out.println("Data issue");
            for (int j=0; j < values.length - 1; j++) {
                if (constantColumns.contains("C" + j+1))
                    continue;;

                stringBuilder.append(values[j]);
                if (j < values.length - 2)
                stringBuilder.append(",");
            }
            writer.println(stringBuilder.toString());

        }
        writer.close();
    }
}