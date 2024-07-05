package game
{
	import flash.display.MovieClip;
	import flash.text.*;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	public class GameApp extends MovieClip
	{
		public var gameMan:GameManager;
		public var GameOver:Boolean = false;
		public var ROCKS:int;// = 10;
		public var SpawnCycle:int;

		private var xml = new XML();
		private var xmlLoader = new URLLoader();
		private var urlRequest = new URLRequest("config.xml");

		public function GameApp():void
		{
			trace("GameApp Constructor");

			xmlLoader.load(urlRequest);
			xmlLoader.addEventListener(Event.COMPLETE, configLoaded);

		}
		public function configLoaded(anEvent:Event):void
		{
			xml = XML(anEvent.target.data);
			ROCKS = xml.rocks.@count;
			SpawnCycle = xml.spawn.@cycle - 1;

			gameMan = new GameManager();

			this.startBtn.addEventListener(MouseEvent.MOUSE_UP, startGame);
			this.insBtn.addEventListener(MouseEvent.MOUSE_UP, instructions);
		}

		public function startGame(anEvent:Event):void
		{
			gotoAndPlay("Gameplay");
		}

		public function instructions(anEvent:Event):void
		{
			gotoAndPlay("Instructions");
		}
	}
}