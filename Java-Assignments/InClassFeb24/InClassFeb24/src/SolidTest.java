import java.util.ArrayList;

public class SolidTest {

	public static void main(String[] args) {
		
		Cuboid c = new Cuboid(3, 4, 5);
		Sphere s = new Sphere(5);
		Octahedron o = new Octahedron(6);
		Pyramid p = new Pyramid(1, 5, 7);
		
		ArrayList<Solids> sol = new ArrayList<Solids>();
		sol.add(c);
		sol.add(s);
		sol.add(o);
		sol.add(p);
		
		for(Solids so: sol){
			System.out.println(so.getClass() + " Volume: " + so.getVolume());
		}
		/*If your code is working correctly you should see the following output
		class Cuboid Volume: 60.0
		class Sphere Volume: 523.5987755982989
		class Octahedron Volume: 101.82337649086286
		class Pyramid Volume: 11.666666666666666
		*/

	}

}
