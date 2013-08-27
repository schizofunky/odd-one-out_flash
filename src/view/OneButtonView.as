package view
{
import controller.SoundManager;

import flash.display.DisplayObject;
import flash.display.Shape;
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
    private var background:Shape;

    public function OneButtonView(onViewChangeCallback : Function,viewToLoad : String, buttonText : String)
    {
        viewId = viewToLoad;
        buttonId = buttonText;
        assetManager = AssetManager.getInstance();
        onViewChangeRequest = onViewChangeCallback;
        drawWhiteBG();
        addFrame();
        addButton();
    }

    public function destroy() : void{
        buttonClip.removeEventListener(MouseEvent.MOUSE_OVER, onButtonMouseOver);
        buttonClip.removeEventListener(MouseEvent.MOUSE_OUT, onButtonMouseOut);
        buttonClip.removeEventListener(MouseEvent.MOUSE_DOWN, onButtonMouseDown);
        removeChild(buttonClip);
        removeChild(frame);
        removeChild(background);
        buttonClip.removeChild(buttonBG);
        buttonClip.removeChild(buttonText);
        buttonBG = null;
        buttonText = null;
        buttonClip = null;
        frame = null;
        background = null;
    }

    private function drawWhiteBG():void{
        background = new Shape();
        background.graphics.beginFill(0xffffff);
        background.graphics.drawRect(0,0,800,600);
        background.graphics.endFill();
        addChild(background);
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
        buttonBG.x = -buttonBG.width/2;
        buttonBG.y = -buttonBG.height/2;
        buttonText.x = -buttonText.width/2;
        buttonText.y = -buttonText.height/2;
        buttonClip.x = 440;
        buttonClip.y = 450;
        buttonClip.scaleX = 0.2;
        buttonClip.scaleY = 0.2;
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
        buttonBG.x = -buttonBG.width/2;
        buttonBG.y = -buttonBG.height/2;
        buttonText.x = -buttonText.width/2;
        buttonText.y = -buttonText.height/2;

        buttonClip.addChild(buttonBG);
        buttonClip.addChild(buttonText);
    }

    private function onButtonMouseOver(event:MouseEvent):void
    {
        buttonClip.removeChild(buttonBG);
        buttonClip.removeChild(buttonText);

        buttonBG = assetManager.getAsset("ButtonOrange.jpg");
        buttonText = assetManager.getAsset(buttonId+"TxtPurple.png");
        buttonBG.x = -buttonBG.width/2;
        buttonBG.y = -buttonBG.height/2;
        buttonText.x = -buttonText.width/2;
        buttonText.y = -buttonText.height/2;

        buttonClip.addChild(buttonBG);
        buttonClip.addChild(buttonText);

    }

    private function onButtonMouseDown(event:MouseEvent):void
    {
        SoundManager.getInstance().playSfx("button-click.mp3");
        destroy();
        onViewChangeRequest(viewId);
    }

    protected function animateButton():void{
        if(buttonClip.scaleX < 1){
            buttonClip.scaleX += 0.2;
            buttonClip.scaleY += 0.2;
        }
    }
}
}
