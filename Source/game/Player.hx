package game
{
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.ui.Mouse;

	public class Player extends MovieClip
	{
		public function Player():void
		{
			this.addEventListener(Event.ADDED_TO_STAGE, init);
		}

		public function init(anEvent:Event):void
		{
			this.addEventListener(Event.ENTER_FRAME, update);
		}

		public function update(anEvent:Event):void
		{
			Mouse.hide();
			this.x = stage.mouseX;
			this.y = stage.mouseY;
		}
	}
}