package com.example.ondevice;
import org.tensorflow.lite.Interpreter;
import android.os.Bundle;
import java.util.ArrayList;
import java.lang.Integer;
import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import java.io.FileInputStream;
import java.io.IOException;
import java.nio.MappedByteBuffer;
import java.nio.channels.FileChannel;
import android.content.res.AssetFileDescriptor;


public class MainActivity extends FlutterActivity {
private static final String CHANNEL = "ondeviceML";
protected Interpreter tflite;
protected Interpreter tflite_chat;
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);

    try {
      tflite = new Interpreter(loadModelFile());
      tflite_chat = new Interpreter(loadModelFile2());
      System.out.println("Loaded both models");
    } catch (Exception e) {
      //TODO: handle exception
    }

   
    new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
    new MethodCallHandler() {
        @Override
        public void onMethodCall(MethodCall call, Result result) {
          if (call.method.equals("predictData")) {
            ArrayList<Integer> args  = new ArrayList<>();
            args = call.argument("arg");
            String prediction = predictData(args);
            if (prediction !=null) {
                result.success(prediction);
            } else {
                result.error("UNAVAILABLE", "prediction  not available.", null);
            }
        }
          else if (call.method.equals("predictDataChat")) {
              System.out.println("Reached JAVA file");
              ArrayList<Integer> args  = new ArrayList<>();
              args = call.argument("arg");
              String prediction = predictDataChat(args);
              if (prediction !=null) {
                  result.success(prediction);
              } else {
                  result.error("UNAVAILABLE", "prediction  not available.", null);
              }
          }

          else {
            result.notImplemented();

        }}
    });
  }
  
 
  String predictData(ArrayList<Integer> input_data)
  {
    float intArray[][] = new float[1][input_data.size()];
    int i =0;
    for(Integer e : input_data)
    { intArray[0][i] = e;
      i++;
    }
     System.out.println(intArray);
     float [][] output_datas= new float[1][1];
     tflite.run(intArray,output_datas);
     System.out.println(output_datas);
     if (output_datas[0][0]>0.5)
     {
      return "1";
     }
     else
      {
        return "0";
      }}
    String predictDataChat(ArrayList<Integer> input_data)
    {
        System.out.println("Reached inside predictDataChat where everything takes place");
        float intArray[][] = new float[1][input_data.size()];
        int i =0;
        for(Integer e : input_data)
        { intArray[0][i] = e;
            i++;
        }
        System.out.println(intArray);
        float [][] output_datas= new float[1][6];
        tflite_chat.run(intArray,output_datas);
        System.out.println("Here is the output_datas matrix");
        System.out.println(output_datas[0][0]);
        System.out.println(output_datas[0][1]);
        System.out.println(output_datas[0][2]);
        System.out.println(output_datas[0][3]);
        System.out.println(output_datas[0][4]);
        System.out.println(output_datas[0][5]);
        System.out.println("Printed individual elements");

        double argmax = 0.0;
        int argmax_index = 0;

        for(int tj = 0; tj<6; tj++){
            if(output_datas[0][tj] > argmax)
            {
                argmax = output_datas[0][tj];
                argmax_index = tj;
            }
        }

        System.out.println(String.valueOf(argmax_index));
        return String.valueOf(argmax_index);

        }

  // method to load tflite file from device 
  
  private MappedByteBuffer loadModelFile() throws Exception {
  AssetFileDescriptor fileDescriptor = this.getAssets().openFd("santa_brain.tflite");
  FileInputStream inputStream = new FileInputStream(fileDescriptor.getFileDescriptor());
  FileChannel fileChannel = inputStream.getChannel();
  long startOffset = fileDescriptor.getStartOffset();
  long declaredLength = fileDescriptor.getDeclaredLength();
  return fileChannel.map(FileChannel.MapMode.READ_ONLY, startOffset, declaredLength);
  }

private MappedByteBuffer loadModelFile2() throws Exception {
    AssetFileDescriptor fileDescriptor2 = this.getAssets().openFd("model_chat.tflite");
    FileInputStream inputStream2 = new FileInputStream(fileDescriptor2.getFileDescriptor());
    FileChannel fileChannel2 = inputStream2.getChannel();
    long startOffset2 = fileDescriptor2.getStartOffset();
    long declaredLength2 = fileDescriptor2.getDeclaredLength();
    return fileChannel2.map(FileChannel.MapMode.READ_ONLY, startOffset2, declaredLength2);
}


  
}
 
  
  





