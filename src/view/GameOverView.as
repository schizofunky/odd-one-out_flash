package view
{
import controller.SoundManager;

import flash.display.DisplayObject;
import flash.events.Event;

public class GameOverView extends OneButtonView
{
    private var gameOverText:DisplayObject;
    private var scoreView:ScoreView;
    public function GameOverView(onViewChangeCallback : Function)
    {
        super(onViewChangeCallback,"menu","MainMenu");
        addLogo();
        addScore();
        SoundManager.getInstance().playSfx("gameover.mp3");
        addEventListener(Event.ENTER_FRAME,animateView);
    }

    override public  function destroy():void{
        removeChild(gameOverText);
        removeChild(scoreView);
        gameOverText = null;
        scoreView = null;
        removeEventListener(Event.ENTER_FRAME,animateView);
        super.destroy();
    }

    private function addLogo():void{
        gameOverText = assetManager.getAsset("GameOverScreen.png");
        gameOverText.x = 250;
        gameOverText.y = 0;
        addChild(gameOverText);
    }

    private function addScore():void{
        scoreView = new ScoreView(String(GameView.currentScore));
        addChild(scoreView);
    }

    private function animateView(event:Event):void
    {
        if(gameOverText.y < 100){
            gameOverText.y+=20;
        }
        super.animateButton();
    }

}
}
