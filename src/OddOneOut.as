package {
import flash.display.Shape;
import flash.display.Sprite;
import flash.geom.Point;
import flash.text.TextField;

import view.AssetManager;
import view.GameOverView;
import view.GameView;
import view.MainMenu;

[SWF(width=879,height=632)]
public class OddOneOut extends Sprite {
    private var loadingBar:Shape;
    private var loadingText : TextField;
    private var currentView:Sprite;
    public function OddOneOut() {
        loadAssets();
    }

    private function loadAssets() : void{
        var assetManager : AssetManager = AssetManager.getInstance();
        var assetsToLoad : Array = [];
        assetsToLoad.push("Logo.png");
        assetsToLoad.push("ButtonOrange.jpg");
        assetsToLoad.push("ButtonPurple.jpg");
        assetsToLoad.push("GameFrame.png");
        assetsToLoad.push("GameOverScreen.png");
        assetsToLoad.push("PlayGameTxtOrange.png");
        assetsToLoad.push("MainMenuTxtOrange.png");
        assetsToLoad.push("PlayGameTxtPurple.png");
        assetsToLoad.push("MainMenuTxtPurple.png");
        assetsToLoad.push("MainMenuTxtPurple.png");
        assetsToLoad.push("Life.png");
        assetsToLoad.push("TimeBar.png");
        assetsToLoad.push("ScoreBar.png");
        assetsToLoad.push("MuteOff.png");
        assetsToLoad.push("MuteOn.png");

        for(var robotCounter = 1; robotCounter <= 10; robotCounter++)
       	{
           assetsToLoad.push("Robot"+robotCounter+"Good.png");
           assetsToLoad.push("Robot"+robotCounter+"BadEasy.png");
           assetsToLoad.push("Robot"+robotCounter+"BadMedium.png");
           assetsToLoad.push("Robot"+robotCounter+"BadHard.png");
       	}
        assetManager.loadAssets(assetsToLoad,onAssetsLoaded, onLoadProgressUpdate);
    }

    private function onAssetsLoaded():void{
        //remove the loading screen and create the main menu
        removeLoadingBar();
        changeView("menu");
    }

    private function onLoadProgressUpdate(progress : Number) : void{
        var start : Point = new Point(315,320);
        if(!loadingBar)
        {
            loadingBar = new Shape();
            addChild(loadingBar);
            loadingText = new TextField();
            loadingText.text = "Loading";
            loadingText.scaleX = 1.5;
            loadingText.scaleY = 1.5;
            addChild(loadingText);
            loadingText.x = start.x + 90;
            loadingText.y = start.y - 30;
        }
        loadingBar.graphics.lineStyle(3,0x000000);
        loadingBar.graphics.drawRect(start.x,start.y,250,30);
        loadingBar.graphics.lineStyle(0,0x000000);
        loadingBar.graphics.beginFill(0x000000);
        loadingBar.graphics.drawRect(start.x,start.y,(2.5*progress),30);
        loadingBar.graphics.endFill();
    }

        private function removeLoadingBar():void{
            removeChild(loadingText);
            removeChild(loadingBar);
            loadingText = null;
            loadingBar = null;
        }

    private function changeView(viewId : String): void{
        if(currentView){
            removeChild(currentView);
        }
        switch(viewId){
            case "menu":
                currentView = new MainMenu(changeView);
                break;
            case "game":
                currentView = new GameView(changeView);
                break;
            case "game-over":
                currentView = new GameOverView(changeView);
                break;
        }
        addChild(currentView);
    }
}
}
