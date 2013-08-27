package controller
{
import flash.display.DisplayObject;

import view.AssetManager;

public class DifficultyManager
{
    private var timeDecaySpeed : Number = 0.001;
    private var levelId : uint;
    private var imagesCanRotate : Boolean;
    private var assetDifficulties = ["Easy"];
    private var assetManager : AssetManager;
    private var levelData : Array = [];

    public function DifficultyManager(){
        assetManager = AssetManager.getInstance()
        levelData.push([[240,300],[440,300],[640,300]]);
        levelData.push([[240,220],[640,220],[240,420],[640,420]]);
        levelData.push([[240,300],[440,300],[640,300],[240,180],[440,180],[640,180],[240,420],[440,420],[640,420]]);
        levelData.push([[250,150],[250,260],[250,370],[250,480],[380,150],[380,260],[380,370],[380,480],[510,150],[510,260],[510,370],[510,480],[640,150],[640,260],[640,370],[640,480]]);
    }

    public function updateDifficulty(score : int){
    	//uses the players current score to activate and increase difficulty values
    	if(score > 1800){
    		assetDifficulties = ["Easy","Medium","Hard"];
    		this.makeImagesRotate();
    		this.increaseDecaySpeed(0.01);
    		levelId = 3;
    	}
    	else if(score > 1500){
    		assetDifficulties = ["Hard"];
    		this.increaseDecaySpeed(0.025);
    		levelId = 3;
    	}
    	else if(score > 800){
    		assetDifficulties = ["Medium"];
    		this.increaseDecaySpeed(0.05);
    		levelId = 2;
    	}
    	else if(score > 300){
    		assetDifficulties = ["Easy"];
    		this.increaseDecaySpeed(0.1);
    		levelId = 1;
    	}
    }

    public function getLevelCoordinates() : Array{
        return levelData[levelId];
    }

    public function getOddAsset(robotId : uint) : DisplayObject{
        return assetManager.getAsset("Robot"+robotId+"Bad"+assetDifficulties[Math.round(Math.random()*(assetDifficulties.length-1))]+".png");
    }

    public function getTimeDecaySpeed() : Number{
        return timeDecaySpeed;
    }

    public function increaseDecaySpeed(amount : Number) : void{
        timeDecaySpeed += amount;
    }

    public function canImagesRotate(): Boolean{
        return imagesCanRotate;
    }

    public function makeImagesRotate(): void{
        imagesCanRotate = true;
    }

    }
}
