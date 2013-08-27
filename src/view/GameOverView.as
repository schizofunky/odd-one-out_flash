package view
{
import flash.display.DisplayObject;

public class GameOverView extends OneButtonView
{
    private var logo:DisplayObject;
    private var scoreView:ScoreView;
    public function GameOverView(onViewChangeCallback : Function)
    {
        super(onViewChangeCallback,"menu","MainMenu");
        addLogo();
        addScore();
    }

    override public  function destroy():void{
        removeChild(logo);
        removeChild(scoreView);
        logo = null;
        scoreView = null;
        super.destroy();
    }

    private function addLogo():void{
        logo = assetManager.getAsset("GameOverScreen.png");
        logo.x = 250;
        logo.y = 100;
        addChild(logo);
    }

    private function addScore():void{
        scoreView = new ScoreView(String(GameView.currentScore));
        addChild(scoreView);
    }

}
}
