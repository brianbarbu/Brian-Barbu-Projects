
public class Sphere implements Solids {
	
	private double radius;
	
	public Sphere(double radius){
		this.radius = radius;
		
	}
	
	//Volume = 4/3*pi*r^3
	public double getVolume(){
		double vol = (((double)4)*Math.PI*Math.pow(radius,3))/3;
		
		return vol;
	}
	
}
