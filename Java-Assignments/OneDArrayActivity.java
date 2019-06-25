import java.util.Scanner;

public class OneDArrayActivity {

	public static void main(String[] args) {
		
		Scanner keyboard = new Scanner(System.in);
		System.out.println("How many values do you want in the array?");
		int x = keyboard.nextInt();
		int[] values = new int[x];
		for(int i = 0; i < x; i++){
			System.out.println("Enter the " + i + " value in the array");
			values[i] = keyboard.nextInt();
		}
		
		
		
		for(int j = 0; j < values.length; j++){
			System.out.print(values[j] + " ");
		}
		boolean decreasing = false;
		for(int k = 1; k < values.length; k++){
			int lastOne = values[k-1];
			if lastOne > values[k]:
				decreasing = true;
		}
		if decreasing == true:
			System.out.print("The Array is decreasing!");
		else 
			System.out.print("The Array is non-decreasing!");
		}
		
		keyboard.close();
	}

}
