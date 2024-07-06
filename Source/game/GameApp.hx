package game;

import lime.utils.Log;
import flash.display.MovieClip;
import flash.text.*;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.net.URLLoader;
import flash.net.URLRequest;

class GameApp extends MovieClip {
    public var gameMan:GameManager;
    public var GameOver:Bool = false;
    public var ROCKS:Int; // = 10;
    public var SpawnCycle:Int;

    private var xml:haxe.xml.Access; // = new Xml();
    private var xmlLoader = new URLLoader();
    private var urlRequest = new URLRequest("assets/config.xml");

    public function new():Void {
        trace("GameApp Constructor");

        xmlLoader.load(urlRequest);
        xmlLoader.addEventListener(Event.COMPLETE, configLoaded);

        super();
    }

    public function configLoaded(anEvent:Event):Void {
        xml = new haxe.xml.Access(Xml.parse(anEvent.target.data)).node.config;
        ROCKS = Std.parseInt(xml.node.rocks.att.count);
        SpawnCycle = Std.parseInt(xml.node.spawn.att.cycle) - 1;

        gameMan = new GameManager();

        Log.throwErrors = false;
        Log.error('fix instance name access');
        // this.startBtn.addEventListener(MouseEvent.MOUSE_UP, startGame);
        // this.insBtn.addEventListener(MouseEvent.MOUSE_UP, instructions);
    }

    public function startGame(anEvent:Event):Void {
        gotoAndPlay("Gameplay");
    }

    public function instructions(anEvent:Event):Void {
        gotoAndPlay("Instructions");
    }
}
