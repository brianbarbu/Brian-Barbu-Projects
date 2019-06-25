import java.util.Scanner;
import java.io.File;
public class Lab2Scanner {

	public static void main(String[] args){
		/*
		Scanner theInput = new Scanner(System.in);
		double[] arr = new double[5];
		double sum = 0;
		for(int x = 0; x<5; x++){
			System.out.println("Enter number here:");
			arr[x]= theInput.nextDouble();
			sum+= arr[x];
		}
		double average = sum / arr.length;
		System.out.println("The average of "+arr[0]+", " +arr[1]+", "+ arr[2]+", "+arr[3]+", and "+arr[4]+ " is "+ average);
		*/
		File theFile = new File("data1.txt");
		long bytes = theFile.length();
		System.out.println("The amount of bytes is " + bytes);
		String fullPath = theFile.getAbsolutePath();
		System.out.println(fullPath);
		
	}
}
