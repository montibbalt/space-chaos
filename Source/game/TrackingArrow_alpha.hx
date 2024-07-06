package game;

import openfl.Assets;
import flash.display.MovieClip;
import flash.geom.Point;
import flash.events.*;

class TrackingArrow_a extends MovieClip {
    private var topLeft:Point;
    private var bottomLeft:Point;
    private var topRight:Point;
    private var bottomRight:Point;
    private var centerPoint:Point;

    private var a1:Float;
    private var a2:Float;
    private var b1:Float;
    private var b2:Float;
    private var c1:Float;
    private var c2:Float;
    private var pDot:Dot;
    private var intersect:Point;

    private var line_err:Bool = false;

    private var asset:MovieClip;

    public function new(aDot:Dot):Void {
        super();

        intersect = new Point();
        pDot = aDot;
        this.asset = Assets.getMovieClip('fl-lib:Game.TrackingArrow');
        this.asset.gotoAndPlay(1);
        this.asset.rotation = 90;
        this.addChild(asset);
        this.addEventListener(Event.ADDED_TO_STAGE, init);
    }

    public function init(anEvent:Event):Void {
        topLeft = new Point(0, 0);
        bottomLeft = new Point(0, 400);
        topRight = new Point(550, 0);
        bottomRight = new Point(550, 400);
        centerPoint = new Point(275, 200);
        this.addEventListener(Event.ENTER_FRAME, update);
    }

    public function update(anEvent:Event):Void {
        if (this.visible) {
            showIntersectPoint();
            // trace("TrackingArrow Visible");
        }
    }

    public function showIntersectPoint() {
        var xOff:Float = 0, yOff:Float = 0;
        if (pDot.x < 0)
            xOff = -1;
        else if (pDot.x > 550)
            xOff = 1;
        else
            xOff = 0;

        if (pDot.y < 0)
            yOff = -1;
        else if (pDot.y > 400)
            yOff = 1;
        else
            yOff = 0;

        switch (xOff) {
            case 0:
            case -1:
                findIntersectPoint(new Point(pDot.x, pDot.y), centerPoint, topLeft, bottomLeft, xOff);
                this.rotation = 90;
                this.x = intersect.x + 4;
                this.y = intersect.y;

            case 1:
                findIntersectPoint(new Point(pDot.x, pDot.y), centerPoint, topRight, bottomRight, xOff);
                this.rotation = -90;
                this.x = intersect.x - 4;
                this.y = intersect.y;
                return;
            default:
        }

        switch (yOff) {
            case 0:
            case -1:
                findIntersectPoint(new Point(pDot.x, pDot.y), centerPoint, topLeft, topRight, -yOff);
                this.rotation = 180;
                this.x = intersect.x;
                this.y = intersect.y + 4;
            case 1:
                findIntersectPoint(new Point(pDot.x, pDot.y), centerPoint, bottomLeft, bottomRight, yOff);
                this.rotation = 0;
                this.x = intersect.x;
                this.y = intersect.y - 4;
            default:
        }

        checkLineErr(xOff, yOff);
    }

    public function findIntersectPoint(ptA:Point, ptB:Point, ptY:Point, ptZ:Point, flip:Float, seg:Bool = true) {
        if (flip == -1) {
            a1 = ptA.y - ptB.y;
            b1 = ptB.x - ptA.x;
        } else if (flip == 1) {
            a1 = ptB.y - ptA.y;
            b1 = ptA.x - ptB.x;
        }

        c1 = (ptB.x * ptA.y) - (ptA.x * ptB.y);

        a2 = ptZ.y - ptY.y;
        b2 = ptY.x - ptZ.x;
        c2 = (ptZ.x * ptY.y) - (ptY.x * ptZ.y);

        var denom:Float = a1 * b2 - a2 * b1;
        if (denom == 0) {
            trace("Error: Divide by zero");
            return;
        }

        intersect.x = (b1 * c2 - b2 * c1) / denom;
        if (flip == -1)
            intersect.y = -(a2 * c1 - a1 * c2) / denom;
        else if (flip == 1)
            intersect.y = (a2 * c1 - a1 * c2) / denom;

        if (seg) {
            if (Point.distance(intersect, ptB) > Point.distance(ptA, ptB)) {
                line_err = true;
                return;
            }
            if (Point.distance(intersect, ptA) > Point.distance(ptA, ptB)) {
                line_err = true;
                return;
            }

            if (Point.distance(intersect, ptZ) > Point.distance(ptY, ptZ)) {
                line_err = true;
                return;
            }
            if (Point.distance(intersect, ptY) > Point.distance(ptY, ptZ)) {
                line_err = true;
                return;
            }
            line_err = false;
        }
    }

    public function checkLineErr(xOff:Float, yOff:Float):Void {
        if (line_err) {
            if (xOff > 0) {
                if (yOff > 0) {
                    this.rotation = -45;
                    this.x = bottomRight.x - 4;
                    this.y = bottomRight.y - 4;
                }

                if (yOff < 0) {
                    this.rotation = 225;
                    this.x = topRight.x - 4;
                    this.y = topRight.y + 4;
                }
            }
            if (xOff < 0) {
                if (yOff > 0) {
                    this.rotation = 45;
                    this.x = bottomLeft.x + 4;
                    this.y = bottomLeft.y - 4;
                }

                if (yOff < 0) {
                    this.rotation = 135;
                    this.x = topLeft.x + 4;
                    this.y = topLeft.y + 4;
                }
            }
        }
    }
}
