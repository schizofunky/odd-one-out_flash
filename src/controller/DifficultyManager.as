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
        levelData.push([[190,250],[390,250],[590,250]]);
        levelData.push([[190,170],[590,170],[190,370],[590,370]]);
        levelData.push([[190,250],[390,250],[590,250],[190,130],[390,130],[590,130],[190,370],[390,370],[590,370]]);
        levelData.push([[200,100],[200,210],[200,320],[200,430],[330,100],[330,210],[330,320],[330,430],[460,100],[460,210],[460,320],[460,430],[590,100],[590,210],[590,320],[590,430]]);
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
