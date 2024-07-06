package game;

import flash.display.MovieClip;
import flash.events.*;
import flash.ui.Mouse;

class Player extends MovieClip {
    public function new():Void {
        this.addEventListener(Event.ADDED_TO_STAGE, init);
        super();
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
