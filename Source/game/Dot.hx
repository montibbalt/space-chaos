package game;

import openfl.Assets;
import flash.display.Sprite;
import flash.events.*;

class Dot extends Sprite {
    public var pDotMan(get, null):DotManager;

    private var hMin:Float = 0;
    private var vMin:Float = 0;
    private var hMax:Float = 550;
    private var vMax:Float = 400;

    public var dx:Float = 0;
    public var dy:Float = 0;

    private var speed:Float;

    public var rotSpeed(get, null):Float;

    private var halfWidth:Float;

    public function new(aDotMan:DotManager):Void {
        super();

        pDotMan = aDotMan;

        this.addChild(Assets.getMovieClip('fl-lib:Game.Dot'));
        this.addEventListener(Event.ADDED_TO_STAGE, addedToStage);
    }

    public function addedToStage(anEvent:Event):Void {
        rotSpeed = (Math.random() * 2) - 1;
        halfWidth = this.width * 0.5;
        generateRandomSpawnPosition();
    }

    public function update():Void {
        graphics.clear();
        graphics.lineStyle(1, 0xFFFFFF, 100);
        graphics.moveTo(0, 0);
        graphics.lineTo(dx*15, dy*15);
        //graphics.lineTo(dx*60, dy*60);
    }

    private function generateRandomSpawnPosition():Void {
        var startingSide:Int = Math.round(Math.random() * 3);
        switch (startingSide) {
            case RockSpawn.LT:
                this.x = -halfWidth;
                this.y = Math.round((Math.random() * (vMax - vMin)) + vMin);

            case RockSpawn.TP:
                this.x = Math.round((Math.random() * (hMax - hMin)) + hMin);
                this.y = -halfWidth;

            case RockSpawn.RT:
                this.x = 550 + halfWidth;
                this.y = Math.round((Math.random() * (vMax - vMin)) + vMin);

            case RockSpawn.BT:
                this.x = Math.round((Math.random() * (hMax - hMin)) + hMin);
                this.y = 400 + halfWidth;

            default:
                this.x = 0;
                this.y = 0;
                trace("WARNING: Spawn default");
        }
    }

    public function get_rotSpeed():Float {
        return rotSpeed;
    }

    public function get_pDotMan():DotManager {
        return pDotMan;
    }
}
