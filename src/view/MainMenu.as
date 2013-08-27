package view
{
import flash.display.DisplayObject;
import flash.events.Event;

public class MainMenu extends OneButtonView
{
    private var logo:DisplayObject;
    public function MainMenu(onViewChangeCallback : Function)
    {
        super(onViewChangeCallback,"game","PlayGame");
        addLogo();
        addEventListener(Event.ENTER_FRAME,animateMenu);
    }

    override public function destroy() : void{
        removeEventListener(Event.ENTER_FRAME,animateMenu);
        removeChild(logo);
        super.destroy();
    }

    private function addLogo():void{
        logo = assetManager.getAsset("Logo.png");
        logo.x = 220;
        logo.y = 0;
        addChild(logo);
    }

    private function animateMenu(event:Event):void
    {
        if(logo.y < 100){
            logo.y+=20;
        }
        super.animateButton();
    }
}
}
