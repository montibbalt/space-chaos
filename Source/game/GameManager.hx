package game;

	import flash.display.MovieClip;
	import flash.events.*;
	import flash.utils.Timer;
	import flash.text.*;
	import flash.ui.Mouse;

	class GameManager extends MovieClip
	{
		private var pDocClass:GameApp;
		private var DotMan:DotManager;
		private var SunMan:SunManager;
		public var gamePlayer(get, null):Player;
		public var scoreTimer:Timer;

		private var score = 0;
		private var seconds = 0;

		public function new():Void{
            super();
        }

		public function init_Game(aDocClass:GameApp):Void
		{
			pDocClass = aDocClass;
			DotMan = new DotManager();
			SunMan = new SunManager(pDocClass);
			gamePlayer = new Player();


            throw 'fix instance name access';
			//pDocClass.sunWarning.visible = false;
			scoreTimer = new Timer(1000, 1);
			scoreTimer.addEventListener(TimerEvent.TIMER, scoreTimerHandler);
			DotMan.init_Game(pDocClass);

			addChild(DotMan);
			addChild(SunMan);
			pDocClass.addChild(gamePlayer);

			var textFormat:TextFormat = new TextFormat();
			textFormat.bold = true;

            throw 'fix instance name access';
			//pDocClass.scoreBox.defaultTextFormat = textFormat;
			//pDocClass.dotCountBox.defaultTextFormat = textFormat;

			//pDocClass.dotCountBox.text = DotMan.particleCount + " ROCKS";
			scoreTimer.start();

		}

		public function scoreTimerHandler(anEvent:TimerEvent):Void
		{
			seconds++;
			score += seconds + DotMan.particleCount;
            throw 'fix instance name access';
			//pDocClass.scoreBox.text = score;

			//if(!(seconds & pDocClass.SpawnCycle))
			//{
			//	DotMan.addParticles(1);
			//	pDocClass.dotCountBox.text = DotMan.particleCount + " ROCKS";
			//}

			scoreTimer.reset();
			scoreTimer.start();
		}

		public function EndGame():Void
		{
			gamePlayer.removeEventListener(Event.ENTER_FRAME, gamePlayer.update);
			pDocClass.removeChild(gamePlayer);
			Mouse.show();

            throw 'fix instance name access';
			//pDocClass.playBtn.addEventListener(MouseEvent.MOUSE_DOWN, newGame);
			//pDocClass.scoreBoxF.text = score;
			//pDocClass.dotCountBoxF.text = DotMan.particleCount + " ROCKS";
		}

		public function newGame(anEvent:MouseEvent):Void
		{
			DotMan = new DotManager();
			SunMan = new SunManager(pDocClass);
			seconds = score = 0;
			pDocClass.gotoAndPlay("Gameplay");
			pDocClass.GameOver = false;
		}

		public function get_gamePlayer()
		{
			return gamePlayer;
		}
	}
