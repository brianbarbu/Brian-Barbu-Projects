/*
Name: Brian Barbu
Computing ID: brb9da

Answers to reading questions:

*/


public class Queue {

	final int INITIAL_SIZE = 10;
	String[] elements;
	int currentSize, head, tail;
	
	public Queue(){
		this.elements = new String[this.INITIAL_SIZE];
		this.currentSize = this.head = this.tail = 0;
	}
	
	public void add(String s){
		// TODO: Complete this method to implement the add() method for a Queue
       elements[tail] = s;
       tail= (tail+1) % elements.length;
       currentSize+=1;
	}
	
	public String remove(){
		// TODO: Complete this method to implement the remove() method for a Queue
        String removed = elements[head];
        for(int i = 0; i< elements.length - 1; i++){
        	elements[i] = elements[i+=1];
        	
        }
        elements[elements.length -1] = null;
        currentSize-=1;
        return removed;
	}
	
	private void growIfNecessary(){
		if(currentSize == elements.length){
			String[] newElements = new String[2*elements.length];
			for(int i = 0; i < elements.length; i++){
				newElements[i] = elements[(head+i)%elements.length];
			}
			elements = newElements;
			head = 0;
			tail = currentSize;
		}
	}
	
	public static void main(String[] args) {
        // TODO: Use main-method testing to test your code!
        // Optional suggestion: Write a print method to show the contents of the queue and maybe even your pointers
		Queue trial = new Queue();
		trial.remove();
		trial.add();
		

	}

}
