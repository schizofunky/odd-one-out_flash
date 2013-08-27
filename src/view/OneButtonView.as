package view
{
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.MouseEvent;

public class OneButtonView extends Sprite
{
    private var buttonClip:Sprite;
    private var buttonBG:DisplayObject;
    private var buttonText:DisplayObject;
    private var onViewChangeRequest:Function;
    private var frame:DisplayObject;
    protected var assetManager : AssetManager;
    private var viewId:String;
    private var buttonId:String;

    public function OneButtonView(onViewChangeCallback : Function,viewToLoad : String, buttonText : String)
    {
        viewId = viewToLoad;
        buttonId = buttonText;
        assetManager = AssetManager.getInstance();
        onViewChangeRequest = onViewChangeCallback;
        addFrame();
        addButton();
    }

    public function destroy() : void{
        buttonClip.removeEventListener(MouseEvent.MOUSE_OVER, onButtonMouseOver);
        buttonClip.removeEventListener(MouseEvent.MOUSE_OUT, onButtonMouseOut);
        buttonClip.removeEventListener(MouseEvent.MOUSE_DOWN, onButtonMouseDown);
        removeChild(buttonClip);
        removeChild(frame);
        buttonClip.removeChild(buttonBG);
        buttonClip.removeChild(buttonText);
        buttonBG = null;
        buttonText = null;
        buttonClip = null;
        frame = null;
    }

    private function addFrame():void{
        frame = assetManager.getAsset("GameFrame.png");
        addChild(frame);
    }


    protected function addButton():void{
        buttonClip = new Sprite();
        buttonBG = assetManager.getAsset("ButtonPurple.jpg");
        buttonText = assetManager.getAsset(buttonId+"TxtOrange.png");
        buttonClip.addChild(buttonBG);
        buttonClip.addChild(buttonText);
        buttonClip.x = 350;
        buttonClip.y = 400;
        addChild(buttonClip);
        buttonClip.addEventListener(MouseEvent.MOUSE_OVER, onButtonMouseOver);
        buttonClip.addEventListener(MouseEvent.MOUSE_OUT, onButtonMouseOut);
        buttonClip.addEventListener(MouseEvent.MOUSE_DOWN, onButtonMouseDown);
    }

    private function onButtonMouseOut(event:MouseEvent):void
    {
        buttonClip.removeChild(buttonBG);
        buttonClip.removeChild(buttonText);

        buttonBG = assetManager.getAsset("ButtonPurple.jpg");
        buttonText = assetManager.getAsset(buttonId+"TxtOrange.png");

        buttonClip.addChild(buttonBG);
        buttonClip.addChild(buttonText);
    }

    private function onButtonMouseOver(event:MouseEvent):void
    {
        buttonClip.removeChild(buttonBG);
        buttonClip.removeChild(buttonText);

        buttonBG = assetManager.getAsset("ButtonOrange.jpg");
        buttonText = assetManager.getAsset(buttonId+"TxtPurple.png");

        buttonClip.addChild(buttonBG);
        buttonClip.addChild(buttonText);

    }

    private function onButtonMouseDown(event:MouseEvent):void
    {
        destroy();
        onViewChangeRequest(viewId);
    }
}
}
