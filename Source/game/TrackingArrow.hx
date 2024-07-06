﻿package game;

import flash.display.MovieClip;
import flash.geom.Point;
import flash.events.Event;

class TrackingArrow extends MovieClip {
    private var centerPoint:Point = new Point(275, 200);
    private var deltaPoint:Point = new Point();
    private var rads:Float;
    private var pDot:Dot;

    public function new(aDot:Dot):Void {
        pDot = aDot;
        this.alpha = 0;
        this.addEventListener(Event.ENTER_FRAME, update);
        super();
    }

    public function update(anEvent:Event):Void {
        deltaPoint.x = pDot.x - centerPoint.x;
        deltaPoint.y = pDot.y - centerPoint.y;
        rads = Math.atan2(deltaPoint.y, deltaPoint.x);
        this.x = centerPoint.x + Math.cos(rads) * 200;
        this.y = centerPoint.y + Math.sin(rads) * 200;
        this.rotation = Math.round((rads * 180 / Math.PI));
    }
}
