/*
 * Homework 7: Machine Learning / Data Mining
 * Name: Brian Barbu
 * Computing ID: brb9da
 * Sources referenced:
 * 
 * http://data-mining.business-intelligence.uoc.edu/home/j48-decision-tree
 * 
 * Referenced Libraries:
 * 		- weka.jar
 * 		- weka-src.jar
 * 
 * Datasets:
 * 		- iris
 * 		- labor
 * 		- nursery
 */

/* Import statements */
import java.util.*;
import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import weka.classifiers.Classifier;
import weka.classifiers.Evaluation;
import weka.classifiers.evaluation.NominalPrediction;
import weka.classifiers.rules.PART;
import weka.classifiers.trees.J48;
import weka.classifiers.rules.JRip;
import weka.core.FastVector;
import weka.core.Instances;

@SuppressWarnings("deprecation")

public class WekaMachineLearning {
	public static Scanner in = new Scanner(System.in);

	// main method: predictive learning experiment
	public static void main(String[] args) throws Exception {
		do {
			int dataChoice = getInput();
			int k = 5;
			BufferedReader datafile;
			// You may edit the files to read here.
			// Make sure to change options ( getInput() )
			if (dataChoice == 1) {
				datafile = readDataFile("iris.arff");
			} else if (dataChoice == 2) {
				datafile = readDataFile("labor.arff");
			} else{
				datafile = readDataFile("nursery.arff");
			}

			Instances data = new Instances(datafile);
			// If we were using the iris data set...
			// Each instance of the data set has 5 attributes. (sepallength,
			// sepalwidth, petallength, petalwidth, class)
			// We are interested in classifying our data with the class it's
			// associated with.
			// Here, we are indicating that the class label is the last
			// attribute
			// (in the last position)
			data.setClassIndex(data.numAttributes() - 1);

			// K-Fold Cross Validation
			k = getK(); // Ask for k input from user
			Instances[][] split = crossValidationSplit(data, k);

			// Separate split into training and testing arrays
			Instances[] trainingSplits = split[0];
			Instances[] testingSplits = split[1];

			// Selecting classifier. (Algorithm)
			Classifier algo;
			int sel = selectAlgo();
			if (sel == 1) {
				algo = new J48();
			} else if (sel == 2) {
				algo = new JRip();
			} else {
				algo = new PART();
			}

			FastVector predictions = new FastVector();
			// For each training-testing split pair, train and test the
			// classifier
			for (int i = 0; i < trainingSplits.length; i++) {
				Evaluation validation = classify(algo, trainingSplits[i], testingSplits[i]);
				predictions.appendElements(validation.predictions());
			}

			// Prints rules and decision trees
			System.out.println(algo.toString());

			// Calculate overall accuracy of current classifier on all splits
			double accuracy = calculateAccuracy(predictions);

			// Print current classifier's name and accuracy
			System.out.println("Using " + k + "-fold cross validation in this experiment.");
			System.out.println("Accuracy of " + algo.getClass().getSimpleName() + ": "
					+ String.format("%.2f%%", accuracy) + "\n---------------------------------");
		} while (repeat());

	}

	// ******************************
	// Method: getInput()
	// Purpose: this method offers the user a series of choices in which the user chooses the data set to test and the
	// method checks to make sure input matches an available data set, will ask user repeatedly until valid input is given
	public static int getInput() {
		int choice = 1;
		do {
			// Ask user for the data set they wish to use.
			// User selects one from the given text menu.
			// Edit this menu if you wish to add datasets or change them.
			System.out.println("Enter the integer of the corresponding data set you would like to use.");
			System.out.println("1. Iris");
			System.out.println("2. Labor");
			System.out.println("3. Nursery");
			choice = in.nextInt();
			in.nextLine();
			if (choice < 1 || choice > 3) {
				System.out.println("ERROR. Please enter either the integer in the range 1 - 3.");
			}
		} while (choice < 1 || choice > 3); // keep user in loop until user
											// enters valid input

		return choice;

	}

	// ******************************
	// Method: getK()
	// Purpose: to prompt user for the number of folds for
	// k-fold cross validation
	public static int getK() {
		// *** TODO: Write this method! ***
		Scanner input = new Scanner(System.in);
		System.out.println("Enter the number of folds (k) split cross validations.\");\n (Entering '5' will give you 80% Training and 20% Testing.)\n (Entering '10' will give you 90% Training and 10% Testing.)");
		int k = input.nextInt();
		while(k<2){
			System.out.println("ERROR: Please enter an integer greater than or equal to 2.");
			k = input.nextInt();
		}
		return k;
	}

	// ******************************
	// Method: selectAlgo()
	// Purpose: this methods asks the user to choose a machine learning algorithm to implement in the experiment 
	// with the data set. If a valid algorithm choice is not chosen, the user will be repeatedly prompted for input
	public static int selectAlgo() {
		int choice = 1;
		do {

			System.out.println("Enter the integer of the corresponding algorithm you would like to use.");
			System.out.println("1. J48 (C4.5)");
			System.out.println("2. JRip (RIPPER)");
			System.out.println("3. PART");
			choice = in.nextInt();
			in.nextLine();
			if (choice < 1 || choice > 3) {
				System.out.println("ERROR. Please enter either the integer 1, 2, or 3.");
			}
		} while (choice < 1 || choice > 3);

		return choice;
	}

	// ******************************
	// Method: repeat()
	// Purpose: once the program has reached the end of its main application, this method is used to ask the
	// user whether they would like to restart the testing. if yes, it returns true if no it returns false
	public static boolean repeat() {
		int choice;

		do {
			System.out.println("Do you want to run another test? 1. Yes or 2. No");
			choice = in.nextInt();
			in.nextLine();
			if (choice < 1 || choice > 2) {
				System.out.println(choice + " is an invalid choice. " + "Please enter \"1\" or \"2\".");
			}
		} while (choice < 1 || choice > 2);

		if(choice == 1){
			return true;
		}
		else{
			return false;
		}
	}

	// ******************************
	// Method: readDataFile()
	// Purpose: this methods reads the data file and makes sure that the data file is found
	// this objective is implemented using the BufferedReader and FileReader classes which finds the inputed file name
	// returns the file as a BufferedReader
	public static BufferedReader readDataFile(String filename) {
		BufferedReader inputReader = null;

		try {
			inputReader = new BufferedReader(new FileReader(filename));
		} catch (FileNotFoundException ex) {
			System.err.println("File not found: " + filename);
		}

		return inputReader;
	}

	// ******************************
	// Method: classify()
	// Purpose: this method uses other important methods buildClassifier and evaluateModel to classify the inputed data
	// returns as an evaluation
	// to evaluate the classifier (evaluating how well it performed on testing
	// set)
	public static Evaluation classify(Classifier model, Instances trainingSet, Instances testingSet) throws Exception {
		Evaluation evaluation = new Evaluation(trainingSet);

		model.buildClassifier(trainingSet); //
		evaluation.evaluateModel(model, testingSet); // passing classifier (e.g.
														// J48) and testing data

		return evaluation;
	}

	// ******************************
	// Method: calculate Accuracy()
	// Purpose: this methods gives a measurement based on the predicted results vs the actual results of the 
	// experiments. it returns this accuracy measurement as a double
	public static double calculateAccuracy(FastVector predictions) {
		double correct = 0;

		for (int i = 0; i < predictions.size(); i++) {
			NominalPrediction np = (NominalPrediction) predictions.elementAt(i);
			if (np.predicted() == np.actual()) {
				correct++;
			}
		}
		System.out.println("Number of Instances: " + predictions.size());
		return 100 * correct / predictions.size();
	}

	// ******************************
	// Method: crossValidationSplit()
	// Purpose: this method returns a two dimensional array of Instances that represents data computed
	// by the algorithms based on the number of folds
	public static Instances[][] crossValidationSplit(Instances data, int numberOfFolds) {

		Instances[][] split = new Instances[2][numberOfFolds];

		for (int i = 0; i < numberOfFolds; i++) {
			split[0][i] = data.trainCV(numberOfFolds, i);
			split[1][i] = data.testCV(numberOfFolds, i);
		}

		return split;
	}

}