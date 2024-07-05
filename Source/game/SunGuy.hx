package game
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.TimerEvent;

	public class SunGuy extends MovieClip
	{
		private var pSunMan:SunManager;
		public var Added:Boolean = true;
		public var completed:Boolean = false;

		private var halfWidth:Number;
		public function SunGuy(aSunMan:SunManager):void
		{
			pSunMan = aSunMan;
			this.addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e:Event):void
		{
			halfWidth = this.width >> 1;
			this.y = 200;
			this.x = 550 + halfWidth;
			trace("SunGuy created");

		}

		public function update(anEvent:Event):void
		{
			if(Math.sqrt((Math.pow(this.x - pSunMan.DocClass.gameMan.GamePlayer.x , 2)) + (Math.pow(this.y - pSunMan.DocClass.gameMan.GamePlayer.y, 2))) < 200)
			{
				pSunMan.DocClass.GameOver = true;
			}
		}
		public function moveIn(anEvent:Event):void
		{
			if (this.x > 500)
			{
				this.x -= 6.1;
			}
			else
			{
				pSunMan.DocClass.sunWarning.visible = false;
			}
		}
		public function moveOut(anEvent:Event):void
		{
			if(this.x < 550 + halfWidth)
			{
				this.x += 6.1;
			}
			if(this.currentFrame == 120 && this.x > this.x < 550 + halfWidth)
			{
				trace("wat");
				pSunMan.killSun();
			}
		}
	}
}