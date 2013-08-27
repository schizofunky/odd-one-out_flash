package view
{
import flash.display.DisplayObject;
import flash.display.Shape;
import flash.display.Sprite;
import flash.geom.Point;

public class TimerView extends Sprite
{
    private var timerBG:DisplayObject;
    private var timeBar:Shape;
    public function TimerView()
    {
        timerBG = AssetManager.getInstance().getAsset("TimeBar.png");
        addChild(timerBG);
        timeBar = new Shape();
        updateTimeBar(100);
        addChild(timeBar);
        x = 50;
        y = 20;
    }

    public function updateTimeBar(progress : Number):void{
        var start : Point = new Point(102,13);
        timeBar.graphics.clear();
        timeBar.graphics.beginFill(0x00FF00);
        timeBar.graphics.drawRect(start.x,start.y,(6.16*progress),24);
        timeBar.graphics.endFill();
    }
}
}
