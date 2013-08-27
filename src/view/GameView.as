package view
{
import controller.DifficultyManager;

import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

public class GameView extends Sprite
{
    public static var currentScore:uint;
    private const maximumLives : uint = 5;
    private var assetManager : AssetManager;
    private var frame:DisplayObject;
    private var currentRobot:uint;
    private var timeLimit:int;
    private var imagesCreated:uint;
    private var difficultyController:DifficultyManager;
    private var imagesForLevel:Array;
    private var lives:int;
    private var gameOver:Boolean;
    private var oViewChangeFunction:Function;
    private var scoreView:ScoreView;
    private var timeView:TimerView;
    private var heartView:HeartView;

    public function GameView(onViewChangeCallback : Function){
        assetManager = AssetManager.getInstance();
        difficultyController = new DifficultyManager();
        currentScore = 0;
        lives = maximumLives;
        oViewChangeFunction = onViewChangeCallback;
        gameOver = false;
        addHUD();
        createLevel();
        addEventListener(Event.ENTER_FRAME,update);
    }

    public function destroy():void{
        removeChild(frame);
        removeChild(scoreView);
        removeChild(timeView);
        removeChild(heartView);
    }

    private function addHUD():void{
        frame = assetManager.getAsset("GameFrame.png");
        addChild(frame);
        scoreView = new ScoreView("0");
        addChild(scoreView);
        timeView = new TimerView();
        addChild(timeView);
        heartView = new HeartView(maximumLives);
        addChild(heartView);
    }

    private function update(event : Event):void{
        if(gameOver){
            removeEventListener(Event.ENTER_FRAME,update);
            destroy();
            oViewChangeFunction("game-over");
        }
        else{
            timeLimit -= difficultyController.getTimeDecaySpeed();

            if(timeLimit <= 0){
                onWrongClick(new Event(""));
            }
            else{
                timeView.updateTimeBar(timeLimit);
            }
        }
    }

    private function createLevel():void{
		destroyLevel();
		currentRobot = getRobotType();
		timeLimit = 100;
		imagesCreated = 0;
        imagesForLevel = [];
		var levelCoordinates : Array = difficultyController.getLevelCoordinates();
		var badIndex : int = Math.round(Math.random()*(levelCoordinates.length-1));
		for (var imageCounter : int = 0; imageCounter < levelCoordinates.length; imageCounter++){
			if(imageCounter == badIndex){
				createImageObject(levelCoordinates[imageCounter],difficultyController.getOddAsset(currentRobot),"Bad");
            }
			else{
				createImageObject(levelCoordinates[imageCounter],assetManager.getAsset("Robot"+currentRobot+"Good.png"),"Good");
			}
		}
        timeView.updateTimeBar(timeLimit);
	}

	private function getRobotType():uint{
		return 1+Math.round(Math.random()*9);
	}

	private function destroyLevel():void{
		//need to destroy all of the robots we have created
		for(var i : int = 0; i < imagesCreated; i++)
		{
			removeChild(imagesForLevel[i]);
			imagesForLevel[i] = null;
		}
		imagesForLevel = null;
	}


	private function createImageObject(coordinates : Array, robotImage : DisplayObject,type : String):void{
        var robotSprite : Sprite = new Sprite();
        robotSprite.addChild(robotImage);
        imagesForLevel[imagesCreated] = robotSprite;
        robotSprite.x = coordinates[0];
        robotSprite.y = coordinates[1];

        if(difficultyController.canImagesRotate()){
            robotSprite.rotationX = Math.random()*360;
        }
        addChild(robotSprite);
        if(type == "Good"){
            robotSprite.addEventListener(MouseEvent.CLICK,onWrongClick);
        }
        else{
            robotSprite.addEventListener(MouseEvent.CLICK,onCorrectClick);
        }
		imagesCreated++;
	}

    public function onCorrectClick(event : Event) : void{
        if(!gameOver){
            //TODO: Play correct sfx
            updateScore();
            createLevel();
        }
    }

    public function onWrongClick(event : Event) : void{
        if(!gameOver){
            //TODO: Play wrong sfx
            reduceLives();
            if(!gameOver){
                createLevel();
            }
        }
    }

    private function updateScore() : void{
        currentScore += Math.round(1*timeLimit);
        difficultyController.updateDifficulty(currentScore);
        scoreView.updateScore(String(currentScore));
    }

    private function reduceLives() : void{
        lives--;
        heartView.loseLife();
        if(lives <= 0){
            gameOver = true;
        }
    }
}
}
