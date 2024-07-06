package game;

import openfl.Assets;
import flash.display.MovieClip;
import flash.events.*;
import flash.ui.Mouse;

@:bind class Player extends MovieClip {
    public function new():Void {
        super();
        this.addChild(Assets.getMovieClip('fl-lib:Game.Player'));
        this.addEventListener(Event.ADDED_TO_STAGE, init);
    }

    public function init(anEvent:Event):Void {
        this.addEventListener(Event.ENTER_FRAME, update);
    }

    public function update(anEvent:Event):Void {
        Mouse.hide();
        this.x = stage.mouseX;
        this.y = stage.mouseY;
    }
}
