package view
{
import flash.display.DisplayObject;

public class MainMenu extends OneButtonView
{
    private var logo:DisplayObject;
    public function MainMenu(onViewChangeCallback : Function)
    {
        super(onViewChangeCallback,"game","PlayGame");
        addLogo();
    }

    override public function destroy() : void{
        removeChild(logo);
        super.destroy();
    }

    private function addLogo():void{
        logo = assetManager.getAsset("Logo.png");
        logo.x = 250;
        logo.y = 100;
        addChild(logo);
    }
}
}
