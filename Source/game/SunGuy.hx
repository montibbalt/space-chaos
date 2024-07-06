package game;

import lime.utils.Log;
import flash.display.MovieClip;
import flash.events.Event;
import flash.events.TimerEvent;

class SunGuy extends MovieClip {
    private var pSunMan:SunManager;

    public var Added:Bool = true;
    public var completed:Bool = false;

    private var halfWidth:Float;

    public function new(aSunMan:SunManager):Void {
        pSunMan = aSunMan;
        this.addEventListener(Event.ADDED_TO_STAGE, init);
        super();
    }

    private function init(e:Event):Void {
        halfWidth = this.width * 0.5;
        this.y = 200;
        this.x = 550 + halfWidth;
        trace("SunGuy created");
    }

    public function update(anEvent:Event):Void {
        if (Math.sqrt((Math.pow(this.x - pSunMan.pDocClass.gameMan.gamePlayer.x, 2)) + (Math.pow(this.y - pSunMan.pDocClass.gameMan.gamePlayer.y, 2))) < 200) {
            pSunMan.pDocClass.GameOver = true;
        }
    }

    public function moveIn(anEvent:Event):Void {
        if (this.x > 500) {
            this.x -= 6.1;
        } else {
            Log.error('fix instance name access');
            // pSunMan.pDocClass.sunWarning.visible = false;
        }
    }

    public function moveOut(anEvent:Event):Void {
        if (this.x < 550 + halfWidth) {
            this.x += 6.1;
        }
        Log.error('fix instance name access');
        // if(this.currentFrame == 120 && this.x > this.x < 550 + halfWidth)
        // {
        //	trace("wat");
        //	pSunMan.killSun();
        // }
    }
}
