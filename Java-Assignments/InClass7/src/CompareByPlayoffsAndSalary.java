import java.util.Comparator;

public class CompareByPlayoffsAndSalary implements Comparator<BasketBallTeam> {
	
	public int compare(BasketBallTeam a, BasketBallTeam b){
		if(a.isPlayoffTeam() == b.isPlayoffTeam()){
			if(a.getSalaryInMillions() < b.getSalaryInMillions()){
				return -1;
			}
			else if(a.getSalaryInMillions() > b.getSalaryInMillions()){
				return 1;
			}
			else{
				return 0;
			}
		}
		else if(a.isPlayoffTeam()){
			return 1;
		}
		else
			return -1;
		
	}

}
