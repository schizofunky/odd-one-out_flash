package view
{
import flash.display.Bitmap;
import flash.display.DisplayObject;
import flash.display.Loader;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.net.URLRequest;

public class AssetManager
{
    private const ASSET_DIRECTORY : String = "img/";
    private static var _instance : AssetManager;
    private var loadedAssets : Object;
    private var currentAssetName : String;
    private var assetLoadedCallback : Function;
    private var assetProgressCallback:Function;
    private var assetsToLoad:Array;
    private var numberOfAssets : uint;
    private var numberOfAssetsLoaded:int = 0;

    public function AssetManager()
    {
        loadedAssets = {};
    }

    public static function getInstance() : AssetManager{
        if(!_instance){
            _instance = new AssetManager();
        }
        return _instance;
    }

    public function loadAssets(assets : Array, onLoadCompleteCallback : Function, onLoadProgressCallback : Function) : void{
        assetsToLoad = assets;
        numberOfAssets = assetsToLoad.length;
        assetLoadedCallback = onLoadCompleteCallback;
        assetProgressCallback = onLoadProgressCallback;
        loadAsset(assetsToLoad.pop());
    }

    private function loadAsset(assetName : String) : void
    {
        var assetLoader : Loader = new Loader();
        currentAssetName = assetName;
        assetLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,onAssetLoaded);
        assetLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,onLoadError);
        assetLoader.load(new URLRequest(ASSET_DIRECTORY+assetName));
    }

    public function getAsset(assetName : String) : DisplayObject{
        return new Bitmap((loadedAssets[assetName] as Bitmap).bitmapData) as DisplayObject;
    }

    private function onAssetLoaded(event : Event) : void
    {
        loadedAssets[currentAssetName] = event.currentTarget.content;
        numberOfAssetsLoaded++;
        assetProgressCallback(numberOfAssetsLoaded* 100/numberOfAssets);
        if(assetsToLoad.length > 0){
            loadAsset(assetsToLoad.pop());
        }
        else
        {
            assetLoadedCallback();
        }
    }

    private function onLoadError(event : Event) : void
    {
        throw(new Error("Could not load file : ",currentAssetName));
    }
}
}
