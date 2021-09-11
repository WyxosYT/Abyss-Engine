import flixel.FlxG;

class Ratings
{   
    public static function rating():String // generate ratings
    {
        var rating:String = "N/A"; // NOT AVAILABLE

        if (PlayState.songMisses == 0) rating = "(FC)"; // FULL COMBO
        else if (PlayState.songMisses < 10) rating = "(SDM)"; // SINGLE DIGIT MISSES
        else rating = "(CLEAR)"; // CLEAR

        return rating;
    }
    public static function ranking():String // generate rankings
    {
        var ranking:String = "N/A";

        if (PlayState.songAcc == 100) ranking = "S+";
        else if (PlayState.songAcc >= 95) ranking = "S";
        else if (PlayState.songAcc >= 90) ranking = "A+";
        else if (PlayState.songAcc >= 85) ranking = "A";
        else if (PlayState.songAcc >= 80) ranking = "B+";
        else if (PlayState.songAcc >= 75) ranking = "B";
        else if (PlayState.songAcc >= 70) ranking = "C+";
        else if (PlayState.songAcc >= 65) ranking = "C";
        else if (PlayState.songAcc >= 60) ranking = "D+";
        else if (PlayState.songAcc >= 55) ranking = "D";
        else if (PlayState.songAcc >= 50) ranking = "F+";
        else if (PlayState.songAcc >= 45) ranking = "F";
        else if (PlayState.songAcc >= 0) ranking = "N/A";

        return ranking;
    }

    public static var timingWindows = [166.0,135.0,90.0,45.0];

    public static function judgeNote(noteDiff:Float)
    {
        var diff = Math.abs(noteDiff);
        for(index in 0...timingWindows.length) // based on 4 timing windows, will break with anything else
        {
            var time = timingWindows[index] * Conductor.timeScale;
            var nextTime = index + 1 > timingWindows.length - 1 ? 0 : timingWindows[index + 1];
            if (diff < time && diff >= nextTime * Conductor.timeScale)
            {
                switch(index)
                {
                    case 0: // shit
                        return "shit";
                    case 1: // bad
                        return "bad";
                    case 2: // good
                        return "good";
                    case 3: // sick
                        return "sick";
                }
            }
        }
        return "good";
    }

    public static function calculateRanking():String
    {
        return "Score - " 
        + PlayState.songScore 
        + " // Misses - " 
        + PlayState.songMisses 
        + " // Ratings - " 
        + rating() 
        + " "  
        + ranking() 
        + " // " 
        + PlayState.songAcc 
        + "%" ;
    }

}