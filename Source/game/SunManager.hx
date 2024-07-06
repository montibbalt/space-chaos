package game;

	import lime.utils.Log;
import flash.display.MovieClip;
	import flash.events.*;
	import flash.utils.Timer;

	class SunManager extends MovieClip
	{
		public var pDocClass(get, null):GameApp;
		private var maxTime:Float = 12;
		private var minTime:Float = 10;
		private var sunWarnTimer:Timer;
		private var sunTimer:Timer;
		public var added(get, null) = false;
		public var completed:Bool = false;

		private var sun:SunGuy;

		public function new(aDocClass:GameApp):Void
		{
			trace("SunManager Constructor");
			pDocClass = aDocClass;
			this.addEventListener(Event.ADDED, init);
            super();
		}

		public function init(anEvent:Event):Void
		{
			this.addEventListener(Event.ENTER_FRAME, update);
			sun = new SunGuy(this);

			var time:Float = (Math.round((Math.random() * (maxTime - minTime)) + minTime)) * 1000;
			sunTimer = new Timer(1, 0);
			sunWarnTimer = new Timer(time, 1);
			sunWarnTimer.addEventListener(TimerEvent.TIMER, toggleSunWarning);
			sunWarnTimer.start();
		}

		public function toggleSunWarning(anEvent:TimerEvent):Void
		{
			if (!added)
			{

				sunTimer = new Timer(2000, 1);
				sunTimer.addEventListener(TimerEvent.TIMER, addSun);
				sunTimer.start();
				//added = true;
			}
			else
			{

			}

            Log.error('fix instance name access');
			//pDocClass.sunWarning.visible = !pDocClass.sunWarning.visible;

		}

		public function addSun(anEvent:TimerEvent):Void
		{
			pDocClass.addChildAt(sun, 1);
			sun.addEventListener(Event.ENTER_FRAME, sun.moveIn);
			sun.addEventListener(Event.ENTER_FRAME, sun.update);
			sun.removeEventListener(Event.ENTER_FRAME, sun.moveOut);
			sun.gotoAndPlay("rollin");

			sunWarnTimer.removeEventListener(TimerEvent.TIMER, toggleSunWarning);

			sunTimer = new Timer(3000, 1);
			sunTimer.addEventListener(TimerEvent.TIMER, removeSun);
			sunTimer.start();

			added = true;
		}

		public function removeSun(anEvent:TimerEvent):Void
		{
			//added = false;
			sun.removeEventListener(Event.ENTER_FRAME, sun.moveIn);
			sun.removeEventListener(Event.ENTER_FRAME, sun.update);
			sun.addEventListener(Event.ENTER_FRAME, sun.moveOut);
			sun.gotoAndPlay("rollout");
			var time:Float = (Math.round((Math.random() * (maxTime - minTime)) + minTime)) * 1000;
			sunWarnTimer = new Timer(time, 1);
			sunWarnTimer.addEventListener(TimerEvent.TIMER, toggleSunWarning);
			sunWarnTimer.start();
		}

		public function update(anEvent:Event):Void
		{
			if(pDocClass.GameOver)
			{
				KillAll();

				cast (this.parent, GameManager).removeChild(this);
			}
		}

		public function KillAll():Void
		{
			killSun();

			added = false;

			sunWarnTimer.stop();

			sunWarnTimer.removeEventListener(TimerEvent.TIMER, toggleSunWarning);

			//sunTimer.stop();
			//sunTimer.removeEventListener(TimerEvent.TIMER, addSun);
			//sunTimer.removeEventListener(TimerEvent.TIMER, removeSun);

			this.removeEventListener(Event.ENTER_FRAME, update);
			pDocClass.gotoAndStop("GameOver");

			//if(added)
			{

				//pDocClass.removeChild(sun);
				sunTimer.stop();
				sunTimer.removeEventListener(TimerEvent.TIMER, addSun);
				sunTimer.removeEventListener(TimerEvent.TIMER, removeSun);
				added = false;
			}
		}

		public function killSun():Void
		{
			sun.removeEventListener(Event.ENTER_FRAME, sun.update);
			sun.removeEventListener(Event.ENTER_FRAME, sun.moveIn);
			sun.removeEventListener(Event.ENTER_FRAME, sun.moveOut);
			if(added)
			{
				pDocClass.removeChild(sun);
				added = false;
			}
		}

		public function get_pDocClass():GameApp
		{
			return pDocClass;
		}
		public function get_added():Bool
		{
			return added;
		}
	}
