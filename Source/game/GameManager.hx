package game
{
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.utils.Timer;
	import flash.text.*;
	import flash.ui.Mouse;

	public class GameManager extends MovieClip
	{
		private var pDocClass:GameApp;
		private var DotMan:DotManager;
		private var SunMan:SunManager;
		private var gamePlayer:Player;
		public var scoreTimer:Timer;

		private var score = 0;
		private var seconds = 0;

		public function GameManager():void{}

		public function init_Game(aDocClass:GameApp):void
		{
			pDocClass = aDocClass;
			DotMan = new DotManager();
			SunMan = new SunManager(pDocClass);
			gamePlayer = new Player();


			pDocClass.sunWarning.visible = false;
			scoreTimer = new Timer(1000, 1);
			scoreTimer.addEventListener(TimerEvent.TIMER, scoreTimerHandler);
			DotMan.init_Game(pDocClass);

			addChild(DotMan);
			addChild(SunMan);
			pDocClass.addChild(GamePlayer);

			var textFormat:TextFormat = new TextFormat();
			textFormat.bold = true;

			pDocClass.scoreBox.defaultTextFormat = textFormat;
			pDocClass.dotCountBox.defaultTextFormat = textFormat;

			pDocClass.dotCountBox.text = DotMan.ParticleCount + " ROCKS"
			scoreTimer.start();

		}

		public function scoreTimerHandler(anEvent:TimerEvent):void
		{
			seconds++;
			score += seconds + DotMan.ParticleCount;
			pDocClass.scoreBox.text = score;

			if(!(seconds & pDocClass.SpawnCycle))
			{
				DotMan.addParticles(1);
				pDocClass.dotCountBox.text = DotMan.ParticleCount + " ROCKS"
			}

			scoreTimer.reset();
			scoreTimer.start();
		}

		public function EndGame():void
		{
			GamePlayer.removeEventListener(Event.ENTER_FRAME, gamePlayer.update);
			pDocClass.removeChild(gamePlayer);
			Mouse.show();
			pDocClass.playBtn.addEventListener(MouseEvent.MOUSE_DOWN, newGame);
			pDocClass.scoreBoxF.text = score;
			pDocClass.dotCountBoxF.text = DotMan.ParticleCount + " ROCKS"
		}

		public function newGame(anEvent:MouseEvent):void
		{
			DotMan = new DotManager();
			SunMan = new SunManager(pDocClass);
			seconds = score = 0;
			pDocClass.gotoAndPlay("Gameplay");
			pDocClass.GameOver = false;
		}

		public function get GamePlayer()
		{
			return gamePlayer;
		}
	}
}