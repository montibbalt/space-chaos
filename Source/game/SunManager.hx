package game
{
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.utils.Timer;

	public class SunManager extends MovieClip
	{
		private var pDocClass:GameApp;
		private var maxTime:Number = 12;
		private var minTime:Number = 10;
		private var sunWarnTimer:Timer;
		private var sunTimer:Timer;
		private var added = false;
		public var completed:Boolean = false;

		private var sun:SunGuy;

		public function SunManager(aDocClass:GameApp):void
		{
			trace("SunManager Constructor");
			pDocClass = aDocClass;
			this.addEventListener(Event.ADDED, init);
		}

		public function init(anEvent:Event):void
		{
			this.addEventListener(Event.ENTER_FRAME, update);
			sun = new SunGuy(this);

			var time:Number = (Math.round((Math.random() * (maxTime - minTime)) + minTime)) * 1000;
			sunTimer = new Timer(1, 0);
			sunWarnTimer = new Timer(time, 1);
			sunWarnTimer.addEventListener(TimerEvent.TIMER, toggleSunWarning);
			sunWarnTimer.start();
		}

		public function toggleSunWarning(anEvent:TimerEvent):void
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

			pDocClass.sunWarning.visible = !pDocClass.sunWarning.visible;

		}

		public function addSun(anEvent:TimerEvent):void
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

		public function removeSun(anEvent:TimerEvent):void
		{
			//added = false;
			sun.removeEventListener(Event.ENTER_FRAME, sun.moveIn);
			sun.removeEventListener(Event.ENTER_FRAME, sun.update);
			sun.addEventListener(Event.ENTER_FRAME, sun.moveOut);
			sun.gotoAndPlay("rollout");
			var time:Number = (Math.round((Math.random() * (maxTime - minTime)) + minTime)) * 1000;
			sunWarnTimer = new Timer(time, 1);
			sunWarnTimer.addEventListener(TimerEvent.TIMER, toggleSunWarning);
			sunWarnTimer.start();
		}

		public function update(anEvent:Event):void
		{
			if(pDocClass.GameOver)
			{
				KillAll();

				GameManager(this.parent).removeChild(this);
			}
		}

		public function KillAll():void
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

		public function killSun():void
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

		public function get DocClass():GameApp
		{
			return pDocClass;
		}
		public function get Added():Boolean
		{
			return added;
		}
	}
}