package preprocessing;

import ai.h2o.pojo.PredictMain;
import au.com.bytecode.opencsv.CSVReader;

import java.io.*;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Random;

/**
 * Created by huss on 16-01-18.
 */
public class DetectConstantColumns {
    public static void main(String[] args) throws IOException {
        ClassLoader classLoader = PredictMain.class.getClassLoader();

        // Loading training data set
        File file = new File(classLoader.getResource("gisette_train.data").getFile());
        FileReader fileReader = new FileReader(file);
        CSVReader reader = new CSVReader(fileReader, ' ');
        List myEntries = reader.readAll();

        // Loading classification data
        File classificationFile = new File(classLoader.getResource("gisette_train.labels").getFile());
        FileReader classificationfileReader = new FileReader(classificationFile);
        CSVReader classificationreader = new CSVReader(classificationfileReader, ' ');
        List classificationEntries = classificationreader.readAll();


        // Random generator to divide the data into Training and Validation datasets

        Random rand = new Random();


        List<List<String>> trainData = new java.util.ArrayList<>();
        List<List<String>> validationData = new java.util.ArrayList<>();


        PrintWriter writerTrain = new PrintWriter("gisette_train_train.csv", "UTF-8");
        PrintWriter writerValid = new PrintWriter("gisette_train_valid.csv", "UTF-8");

        for (int i = 1; i < ((String []) myEntries.get(0)).length; i++){

            writerTrain.print("C" + i + ",");
            writerValid.print("C" + i + ",");
        }
        writerTrain.println("classification");
        writerValid.println("classification");



        StringBuilder stringBuilder = new StringBuilder();
        for (int i = 0; i < myEntries.size(); i++) {
//            System.out.println(i);
            List<String> row = new java.util.ArrayList<>(Arrays.asList((String[]) myEntries.get(i))); //new ArrayList is only needed if you absolutely need an ArrayList
            // Add the classification entry to the row
            String[] classificationEntry = (String[]) classificationEntries.get(i);
            String classification = classificationEntry[0];
            row.add(classification);
            if (rand.nextFloat() <= 0.8)
                print(writerTrain, row);
            else
                print(writerValid, row);
        }

        List<String> dummRow = new ArrayList<>();
        for(int i=0; i < 5001; i++)
            dummRow.add("1");

        print(writerTrain, dummRow);
        print(writerValid, dummRow);

        writerTrain.close();
        writerValid.close();




//        printArrayListToFile(trainData);


//        List<String[]> trainEntries = new java.util.ArrayList<>();
//        List<String[]> validEntries = new java.util.ArrayList<>();
//
//        //Split 80% 20%
//        Random rand = new Random();
//        for (int i = 1; i < myEntries.size(); i++) {
//            if( rand.nextFloat() >= 0.8)
//                trainEntries.add((String[]) myEntries.get(i));
//            else
//                validEntries.add((String[]) myEntries.get(i));
//
//        }


//        boolean[] isConstant = new boolean[5000];
//
//
//
//        for (int i = 0; i < 5000; i++)
//            isConstant[i] = true;
//
//        for (int i = 1; i < myEntries.size(); i++) {
//            String[] values = (String[]) myEntries.get(i);
//            for (int j = 0; j < values.length - 1; j++) {
////                System.out.println(values[j]);
//                if (!values[j].equals("0"))
//                    isConstant[j] = false;
//            }
//        }

//        for (int i = 0; i < 5000; i++)
//            if(isConstant[i])
//                System.out.println(i);

//        PrintWriter writer = new PrintWriter("gisette_train_clean.csv", "UTF-8");
//        for (int i = 0; i < myEntries.size(); i++) {
//            String[] values = (String[]) myEntries.get(i);
//            StringBuilder stringBuilder = new StringBuilder();
//            if (values.length != 5001)
//                System.out.println("Data issue");
//            for (int j=0; j < values.length - 1; j++) {
//                if (isConstant[j])
//                    continue;
//                stringBuilder.append(values[j]);
//                if (j < values.length - 2)
//                    stringBuilder.append(",");
//            }
//            writer.println(stringBuilder.toString());
//
//        }
//        writer.close();

    }

    private static void print(PrintWriter writer, List<String> row) {
        StringBuilder stringBuilder = new StringBuilder();
        for (int j = 0; j < row.size(); j++) {
            stringBuilder.append(row.get(j));
            if (j < row.size() - 2)
                stringBuilder.append(",");
        }
        writer.println(stringBuilder.toString());
    }


    private static void printArrayListToFile(List<List<String>> entries) throws FileNotFoundException, UnsupportedEncodingException {


        PrintWriter writer = new PrintWriter("gisette_train_all.csv", "UTF-8");
        for (int i = 0; i < entries.size(); i++) {
            List<String> values = entries.get(i);
            StringBuilder stringBuilder = new StringBuilder();
            if (values.size() != 5001)
                System.out.println("Data issue");
            for (int j = 0; j < values.size() - 1; j++) {
//                if (isConstant[j])
//                    continue;
                stringBuilder.append(values.get(j));
                if (j < values.size() - 2)
                    stringBuilder.append(",");
            }
            writer.println(stringBuilder.toString());

        }
        writer.close();
    }


}
