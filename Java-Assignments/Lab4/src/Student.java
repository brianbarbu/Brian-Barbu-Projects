/* Brian Barbu (brb9da), Sean Shu (sys3bb) */
import java.util.ArrayList;

public class Student {

	private String name;
	private double gpa;
	private ArrayList<Course> courses = new ArrayList<>();
	private double gradePoints;
	private double creditsAttempted;

	public Student (String aName, double aGpa){
		name = aName;
		gpa = aGpa;
		
	}
	
	public Student (String aName) {
		//studentName = name;
		name = aName;
		gradePoints = 0.0;
		creditsAttempted = 0.0;
		this.gpa = 0.0;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public double getGpa() {
//		return gpa;
		return gradePoints  / creditsAttempted;
	}

	public void setGpa(double gpa) {
		if(getGpa() <= 4.0 && getGpa() >=0.0){
			this.gpa = getGpa();
		}
	}

	public ArrayList<Course> getCourses(){
		return courses;
	}
	
	public static void main(String[] args) {
		Student s1 = new Student("bob");
		s1.addCourseCredit(6.0, 4.0);
		System.out.println(s1 + " " + s1.getGpa());	
		Student s1Twin = new Student("bob");
		//s1Twin.addCourseCredit(6.0, 4.0);
		Student notS1 = new Student("joe");
		
		System.out.println(s1.equals(s1Twin));
		System.out.println(s1.equals(notS1));
		System.out.println(s1.equals(s1));
		System.out.println(s1.equals("hello"));
	}
	public boolean add(Course aCourse){
		if(courses.contains(aCourse)){
			return false;
		}
		else{
			courses.add(aCourse);
			return true;
		}
	}
	
	public boolean drop(Course aCourse){
		if(courses.contains(aCourse)){
			courses.remove(aCourse);
			return true;
		}
		else{
			return false;
		}
	
	public void dropAll(){
		for(Course aCourse : courses){
			courses.remove(aCourse);	
		}
	}
	// Without this method written correctly, Course.inClass() won't work!
	// Pages 153-154 in the MSD book says a bit about writing equals().
	public boolean equals(Object obj) {
		System.out.println("hi from Student.equals()");
		if ( obj instanceof Student ) {
			Student s = (Student) obj;
			if (s.getName().equals( this.name )){
				return true;
			}
			else {
				return false;
			}
		}
		else{
			return false;
		}
	}

	// The following is a version of equals() that works
	//   sometimes but not always. It's NOT the correct way
	//   to do it!
//	public boolean equals(Student s) {
//		System.out.println("hi from Student.equals()");
//		return s.getName().equals( this.name );
//	}
	

	private void addCourseCredit(double gradePoints, double credits) {
		this.creditsAttempted += credits;
		this.gradePoints += gradePoints;
}

	@Override
	public String toString() {
		return "(" + name + "," + gpa + ")";
	}

}
