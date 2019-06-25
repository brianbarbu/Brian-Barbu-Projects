/* Brian Barbu (brb9da), Sean Shu (sys3bb) */
import java.util.ArrayList;

public class Course {
	
	private String id;
	private String dept;
	private ArrayList<Student> roll = new ArrayList<>();

	public Course(String id, String dept) {
		if(id instanceof String && dept instanceof String){ 
			this.id = id;
			this.dept = dept;
		}
		else{
			throw new IllegalArgumentException("Enter a proper ID and Department!");
		}
	}
	public String getId(){
		return id;
	}
	public String getDept(){
		return dept;
	}
	public ArrayList<Student> getRoll(){
		return roll;
	}
	public boolean add(Student aStudent){
		if(roll.contains(aStudent)){
			return false;
		}
		else{
			roll.add(aStudent);
			return true;
		}
	}
	public boolean drop(Student aStudent){
		if(roll.contains(aStudent)){
			roll.remove(aStudent);
			return true;
		}
		else{
			return false;
		}
	}
	public void cancel(){
		for(Student aStudent : roll){
			roll.remove(aStudent);	
		}
	}
	public double averageGPA(){
		double average = 0.0;
		double count = 0.0;
		if(roll.size()<= 0){
			return -1.0;
		}
		else{
			for(Student aStudent : roll){
				average+= aStudent.getGpa();
				count+=1.0;
			}
			return average / count;
		}
	}
	public static void main(String[] args) {
		Course c1 = new Course("cs2110", "CS");
		System.out.println(c1);
		Student s1 = new Student("bob");
		c1.enroll(s1);
		c1.enroll( new Student("ali") );
		c1.enroll( new Student("cat") );
		c1.enroll( new Student("don") );
		c1.enroll( new Student("tom") );
		
		
		Student result = c1.findStudent("don");
		if ( result == null ) {
			System.out.println("not found");
		}
		else{
			System.out.println("found: " + result);
		}
		System.out.println(c1);
		// Example: testing inClass(). Note we're passing a Student object
		Student target = new Student("tom");
		if ( c1.inClass(target) )
			System.out.println("inClass() found: " + target);
		else
			System.out.println("inClass() did not find: " + target);			
	}
	
	private boolean inClass(Student target) {
//		for ( Student item : this.roll ) {
//			System.out.println("* in inClass(): " + item); 
//			if ( item.equals(target) ) // depends on Student.equals()
//				return true;
//		}
//		return false;
		// you know what?  This can be even easier!  Just use contains() on the list!
		return this.roll.contains(target);
	}

	private Student findStudent(String studName) {
//		for (int i=0; i < this.roll.size(); ++i) {
//			if ( studName.equals(this.roll.get(i).getName()) )
//				return this.roll.get(i);
//		}
		for ( Student item : this.roll ) {
			if ( studName.equals(item.getName()) )
				return item;
		}
		return null;
	}

	private void enroll(Student newStudent) {
		this.roll.add(newStudent);
	}

	@Override
	public String toString() {
		return "<" + id + "," + dept + "," + roll + ">";
	}

}
