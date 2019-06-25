
public class fib {

	public static int fib(int n)
	{
		int[] sequence;
		sequence = new int[n+1];
		sequence[0]=0;
		sequence[1]=1;
		for(int a = 2; a<sequence.length; a++){
			sequence[a]= sequence[a-2]+sequence[a-1];
		}
		return sequence[n];
	}
}
