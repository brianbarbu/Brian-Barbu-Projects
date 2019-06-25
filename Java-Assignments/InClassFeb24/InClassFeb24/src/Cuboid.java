
public class Cuboid implements Solids {

	private double length, width, height;
	
	public Cuboid(double length, double width, double height){
		this.length = length;
		this.width = width;
		this.height = height;
	
	}
	
	//Volume = length*width*height
	public double getVolume(){
		double vol = length*width*height;
		return vol;
	}
	
	
}
