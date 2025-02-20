﻿package game;

import lime.utils.Log;
import flash.display.MovieClip;
import flash.events.*;
import openfl.Lib.getTimer;

class DotManager extends MovieClip {
    public var pDocClass(get, null):GameApp;

    private var dotsArray:Array<Dot>;
    private var arrowsArray:Array<TrackingArrow>;

    private var INITCOUNT:Int; // = 10;

    public var particleCount(get, null):Int; // = INITCOUNT;

    public var ppm(get, null):Float = 200;
    public var speed(get, null):Float = 1.6 * 0.00028 / 2; ///(60*60);

    private var adjustedSpeed:Float; // = speed * ppm;

    private var dx:Float = 0;
    private var dy:Float = 0;
    private var angle:Float;
    var time:Int = getTimer();

    public function new():Void {
        super();
        trace("DotManager Constructor");
    }

    public function init_Game(aDocClass:GameApp):Void {
        adjustedSpeed = speed * ppm;
        pDocClass = aDocClass;
        INITCOUNT = pDocClass.ROCKS;
        dotsArray = [];
        arrowsArray = [];

        addParticles(INITCOUNT);

        this.addEventListener(Event.ENTER_FRAME, update);
    }

    public function addParticles(numParts:Int):Void {
        var i:Int = -1;

        while (++i < numParts) {
            // I don't like using the new thing here but it won't work otherwise?
            var temp:Dot = new Dot(this);
            var temp2 = new TrackingArrow(temp);
            temp2.alpha = 1.0;
            pDocClass.gameContainer.addChildAt(temp, 2);
            pDocClass.gameContainer.addChildAt(temp2, 1);

            dotsArray.push(temp);
            arrowsArray.push(temp2);
        }

        particleCount += numParts;
        // trace(particleCount);
    }

    public function update(anEvent:Event):Void {
        var i:Int = -1;
        time = getTimer();
        while (++i < particleCount) {
            if (!pDocClass.GameOver) {
                var temp:Dot = dotsArray[i];
                dx = temp.x - pDocClass.gameContainer/*.stage.*/.mouseX;
                dy = temp.y - pDocClass.gameContainer/*.stage.*/.mouseY;

                angle = Math.atan2(dy, dx);
                /*var absAng:Float = angle > 0.0 ? angle : -angle;
                    var dySin = (((B * angle) + (C * angle * absAng)) * speed * ppm); */

                temp.dx -= (Math.cos(angle) * adjustedSpeed);
                temp.dy -= (Math.sin(angle) * adjustedSpeed);
                // temp.dy -= dySin;

                temp.x += temp.dx;
                temp.y += temp.dy;
                //temp.update();

                temp.rotation += temp.rotSpeed;

                if (temp.visible) {
                    if ((dx * dx) + (dy * dy) < 625) {
                        pDocClass.GameOver = true;
                        break;
                    }
                }

                if (checkIfOffStage(temp)) {
                    if (arrowsArray[i].alpha < 1) {
                        arrowsArray[i].alpha += .125 / 2;
                    }
                    temp.visible = false; // nice performance boost
                } else {
                    if (arrowsArray[i].alpha > 0) {
                        arrowsArray[i].alpha -= .125 / 2;
                    }
                    temp.visible = true;
                }
                dotsArray[i] = temp;
            }
        }
        if (pDocClass.GameOver) {
            KillAll();

            cast(this.parent, GameManager).removeChild(this);
        }
        // trace(getTimer() - time);
    }

    public function KillAll():Void {
        this.removeEventListener(Event.ENTER_FRAME, update);
        pDocClass.gameContainer.gotoAndStop("GameOver");

        var gameMan = cast(this.parent, GameManager);
        gameMan.scoreTimer.stop();
        gameMan.EndGame();
        //cast(this.parent, GameManager).scoreTimer.stop();

        trace("Removing Dots");
        while (dotsArray.length > 0) {
            pDocClass.gameContainer.removeChild(dotsArray[0]);
            dotsArray.splice(0, 1);
        }
        trace("Removing Arrows");
        while (arrowsArray.length > 0) {
            pDocClass.gameContainer.removeChild(arrowsArray[0]);
            arrowsArray.splice(0, 1);
        }
    }

    public function checkIfOffStage(dot:Dot):Bool {
        // Hardcoded bounds cause it's faster :P
        if (dot.x < -20 || dot.x > 570 || dot.y < -20 || dot.y > 420) {
            return true;
        }
        return false;
    }

    public function get_ppm():Float {
        return ppm;
    }

    public function get_speed():Float {
        return speed;
    }

    public function get_particleCount():Int {
        return particleCount;
    }

    public function get_pDocClass():GameApp {
        return pDocClass;
    }
}
