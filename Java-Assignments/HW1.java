import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.Arrays;

public class HW1 {
	
	public static void main(String[] args){
		System.out.println(HW1.pi(8));
		/* 3.14159265 */
		System.out.println(HW1.pi(4));
		/* 3.1415 */
		
		System.out.println(HW1.easter(2017));
		/* In 2017, Easter Sunday falls on April 16 */
		System.out.println(HW1.easter(2035));
		/* In 2035, Easter Sunday falls on March 25 */
		
		System.out.println(HW1.escape(1000));
		/* The astronaut will return to Halley's Comet!*/
		System.out.println(HW1.escape(1300));
		/* The astronaut will not return to Halley's Comet. In order for the astronaut to return, the comet would need to have a mass larger than 1.4606971514242879E22 */
		
		HW1.random(2, 3, 4, 3);
		/* 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1  */
		System.out.println("");
		HW1.random(6, 5, 5, 7);
		/* 6 0 5 2 1 3 6 0 5 2 1 3 6 0 5 2 1 3 6 0 */
		
			
	}
	public static double pi(int n){
		double bottom = 3;
		double value = 4;
		double neg = -1;
		for(int i =0; i<=1000000000; i++){
			value = value +((4/bottom)*neg);
			bottom = bottom+2;
			neg= neg*-1;
		}
		String fvalue = Double.toString(value);
		String trunc = fvalue.substring(0,n+2);
		double ffvalue = Double.parseDouble(trunc);
		return ffvalue;
	}
	public static String easter(int y){
		int a = y%19;
		int c = y%100;
		int b = (y-c) / 100;
		int e = b%4;
		int d = (b-e)/4;
		int g = ((8*b)+13)/25;
		int h = ((19*a)+b-d-g+15)%30;
		int k = c%4;
		int j = c/4;
		int m = (a+(11*h))/319;
		int r = ((2*e)+(2*j)-k-h+m+32)%7;
		int n = ((h-m+r+90)/25);
		int p = (h-m+r+n+19)%32;
		ArrayList<String> months = new ArrayList<String>(Arrays.asList("January", "February", "March","April","May","June","July","August","September","October","November","December"));
		String month = months.get(n-1);
		String statement = "In " + y+", Easter Sunday falls on "+month +" "+p;
	return statement;
	}
	public static String escape(double v){
		double G = 6.67 * Math.pow(10, -11);
		double M = 1.3 * Math.pow(10, 22);
		double R = 1.153 *Math.pow(10, 6);
		double escape = Math.sqrt((2*G*M)/R);
		String esc = Double.toString(escape);
		double Mmin = ((Math.pow(v, 2))* R)/(2*G);
		String min = Double.toString(Mmin);
		if (v>=escape){
			String state1 = "The astronaut will not return to Halley's Comet. In order for the astronaut to return, the comet would need to have a mass larger than "+ min;
			return state1;
		}
		else{
			String state2 = "The astronaut will return to Halley's Comet!";
			return state2;
		}
		
	
	}
	public static int[] random(int r, int a, int b, int m){
		int[] list = new int[25];
		int rold = r;
		for(int i=0;i<25;i++){
			int rnext = (a*rold+b)%m;
			list[i] = rnext;
			rold = rnext;
		}
		for(int j=0;j<list.length;j++){
			System.out.print(list[j]+" ");
		
		}
		return list;
	}
}
