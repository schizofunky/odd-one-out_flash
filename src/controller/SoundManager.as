package controller
{
import flash.media.Sound;
import flash.media.SoundChannel;
import flash.media.SoundTransform;
import flash.net.URLRequest;

public class SoundManager
{
    private var musicSoundChannel:SoundChannel;
    private var muted:Boolean;
    private static var instance:SoundManager;
    public function SoundManager()
    {
        muted = false;
    }

    public static function getInstance():SoundManager{
        if(!instance){
            instance = new SoundManager();
        }
        return instance;
    }

    public function playSfx(soundFile : String):void{
        if(!muted){
            var sfx : Sound = new Sound(new URLRequest("sounds/"+soundFile));
            sfx.play();
        }
    }

    public function playBgm(soundFile : String):void{
        var music : Sound = new Sound(new URLRequest("sounds/"+soundFile));
        musicSoundChannel = music.play(0,999,new SoundTransform(muted?0:1));
    }

    public function stopBgm():void{
        musicSoundChannel.stop();
    }

    public function mute():void{
        if(!muted){
            if(musicSoundChannel){
                musicSoundChannel.soundTransform = new SoundTransform(0);
            }
            muted = true;
        }
        else{
            if(musicSoundChannel){
                musicSoundChannel.soundTransform = new SoundTransform(1);
            }
            muted = false;
        }
    }
}
}
