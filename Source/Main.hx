package;

import openfl.Assets;
import game.*;
import openfl.display.Sprite;
using Main;

class Main extends Sprite {
    public function new() {
        super();
        var docInstance = Assets.getMovieClip('fl-lib:game.GameApp');
        docInstance.gotoAndStop('Start');
        var test = new GameApp(docInstance);
        this.addChild(test);
        var scale = (this.stage.stageHeight / this.height);
        this.scaleX = this.scaleY = scale;
        this.x = (this.stage.stageWidth / 2) - (this.width / 2);
        this.y = (this.stage.stageHeight / 2) - (this.height / 2);
        this.stage.color = 0x000000;
    }
}

class DOExt {
    public static function printDO(ob:openfl.display.DisplayObject):String {
        return '${ob.name}:${ob} (${ob.x}, ${ob.y})';
    }
}