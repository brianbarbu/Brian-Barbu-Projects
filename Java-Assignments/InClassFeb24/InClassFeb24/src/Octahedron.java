
public class Octahedron implements Solids{
	
	private double edge;
	
	public Octahedron(double edge){
		this.edge = edge;
	}
	
	//Volume sqrt(2)/3 times edge^3
	public double getVolume(){
		double vol = (Math.sqrt(2)/3)*Math.pow(edge, 3);
		return vol;
	}
	
}
