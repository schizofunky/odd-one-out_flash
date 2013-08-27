package view
{
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;

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
            var asset : DisplayObject = heartAssets.pop();
            asset.addEventListener(Event.ENTER_FRAME,onAssetFade);
        }
    }

    private function onAssetFade(event:Event):void
    {
        if(event.currentTarget.alpha > 0.1){
            event.currentTarget.alpha -= 0.1;
        }
        else{
            event.currentTarget.removeEventListener(Event.ENTER_FRAME,onAssetFade);
            removeChild(event.currentTarget as DisplayObject);
        }
    }
}
}
