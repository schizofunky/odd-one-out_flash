package view
{
import flash.display.DisplayObject;
import flash.display.Sprite;

public class HeartView extends Sprite
{
    private var heartAssets:Array;
    public function HeartView(numberOfLives : uint)
    {
        const assetManager : AssetManager = AssetManager.getInstance();
        var heart : DisplayObject;
        heartAssets = [];
        for (var heartID : uint = 0; heartID < numberOfLives; heartID++){
            heart = assetManager.getAsset("Life.png");
            heartAssets.push(heart);
            heart.x = 757;
            heart.y = 486 - (heartID * 58);
            addChild(heart);
        }
    }

    public function loseLife() : void{
        if(heartAssets.length > 0){
            removeChild(heartAssets.pop());
        }
    }
}
}
