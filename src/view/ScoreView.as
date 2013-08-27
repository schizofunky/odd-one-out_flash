package view
{
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.text.TextField;

public class ScoreView extends Sprite
{
    private var scoreBg:DisplayObject;
    private var scoreText:TextField;
    public function ScoreView(score : String)
    {
        scoreBg = AssetManager.getInstance().getAsset("ScoreBar.png");
        x = 290;
        y = 550;
        addChild(scoreBg);
        scoreText = new TextField();
        scoreText.text = score;
        scoreText.scaleX = 2;
        scoreText.scaleY = 2;
        scoreText.x = 90;
        scoreText.y = 15;
        scoreText.autoSize = "center";
        addChild(scoreText);
    }

    public function destroy():void{
        removeChild(scoreBg);
        removeChild(scoreText);
    }

    public function updateScore(score : String):void{
        scoreText.text = score;
    }
}
}
