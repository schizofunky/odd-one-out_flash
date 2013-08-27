package view
{
import controller.SoundManager;

import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

public class MuteButton extends Sprite
{
    private var muteImage:DisplayObject;
    private var muted:Boolean;
    public function MuteButton()
    {
        addEventListener(MouseEvent.CLICK, onMuteClick);
        muteImage = AssetManager.getInstance().getAsset("MuteOff.png");
        addChild(muteImage);
        muted = false;
        x = 810;
    }

    private function onMuteClick(event : Event):void{
        SoundManager.getInstance().mute();
        muted = !muted;
        removeChild(muteImage);
        if(muted){
            muteImage = AssetManager.getInstance().getAsset("MuteOn.png");
        }else{
            muteImage = AssetManager.getInstance().getAsset("MuteOff.png");
        }
        addChild(muteImage);
    }
}
}
