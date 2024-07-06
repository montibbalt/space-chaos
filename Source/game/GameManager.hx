package game;

import lime.utils.Log;
import flash.display.MovieClip;
import flash.events.*;
import flash.utils.Timer;
import flash.text.*;
import flash.ui.Mouse;
using Main.DOExt;

class GameManager extends MovieClip {
    private var pDocClass:GameApp;
    private var gameContainer:MovieClip;
    private var DotMan:DotManager;
    private var SunMan:SunManager;

    public var gamePlayer(get, null):Player;
    public var scoreTimer:Timer;

    private var score = 0;
    private var seconds = 0;

    public function new():Void {
        super();
    }

    public function init_Game(aDocClass:GameApp, container:MovieClip):Void {
        pDocClass = aDocClass;
        gameContainer = container;
        DotMan = new DotManager();
        SunMan = new SunManager(pDocClass);
        gamePlayer = new Player();

        gameContainer.getChildByName('sunWarning').visible = false;
        scoreTimer = new Timer(1000, 1);
        scoreTimer.addEventListener(TimerEvent.TIMER, scoreTimerHandler);
        DotMan.init_Game(pDocClass);

        addChild(DotMan);
        addChild(SunMan);
        gameContainer.addChild(gamePlayer);

        var textFormat:TextFormat = new TextFormat();
        textFormat.bold = true;

        cast(gameContainer.getChildByName('scoreBox'), TextField).defaultTextFormat = textFormat;
        cast(gameContainer.getChildByName('dotCountBox'), TextField).defaultTextFormat = textFormat;

        cast(gameContainer.getChildByName('dotCountBox'), TextField).text = DotMan.particleCount + " ROCKS";
        scoreTimer.start();
    }

    public function scoreTimerHandler(anEvent:TimerEvent):Void {
        seconds++;
        score += seconds + DotMan.particleCount;
        cast (gameContainer.getChildByName('scoreBox'), TextField).text = '$score';

        if ((seconds & pDocClass.SpawnCycle) != 0) {
            DotMan.addParticles(1);
            cast(gameContainer.getChildByName('dotCountBox'), TextField).text = DotMan.particleCount + " ROCKS";
        }

        scoreTimer.reset();
        scoreTimer.start();
    }

    public function EndGame():Void {
        gamePlayer.removeEventListener(Event.ENTER_FRAME, gamePlayer.update);
        gameContainer.removeChild(gamePlayer);
        Mouse.show();

        gameContainer.getChildByName('playBtn').addEventListener(MouseEvent.MOUSE_DOWN, newGame);
        cast(gameContainer.getChildByName('scoreBoxF'), TextField).text = '$score';
        cast(gameContainer.getChildByName('dotCountBoxF'), TextField).text = DotMan.particleCount + " ROCKS";
    }

    public function newGame(anEvent:MouseEvent):Void {
        //DotMan = new DotManager();
        //SunMan = new SunManager(pDocClass);
        gameContainer.gotoAndPlay("Gameplay");
        seconds = score = 0;
        pDocClass.GameOver = false;
        init_Game(pDocClass, gameContainer);
    }

    public function get_gamePlayer() {
        return gamePlayer;
    }
}
