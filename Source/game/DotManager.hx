package game
{
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.utils.getTimer;

	public class DotManager extends MovieClip
	{
		private var pDocClass:GameApp;
		private var dotsArray:Array;
		private var arrowsArray:Array;

		private var INITCOUNT:int;// = 10;
		private var particleCount:int;// = INITCOUNT;

		private var ppm:Number = 200;
		private var speed:Number = 1.6 * 0.00028///(60*60);
		private var adjustedSpeed:Number = speed * ppm;

		private var dx:Number = 0, dy:Number = 0;
		private var angle:Number;
		var time:int = getTimer();

		public function DotManager():void
		{
			trace("DotManager Constructor");
		}

		public function init_Game(aDocClass:GameApp):void
		{
			pDocClass = aDocClass;
			INITCOUNT = pDocClass.ROCKS;
			dotsArray = new Array();
			arrowsArray = new Array();

			addParticles(INITCOUNT);

			this.addEventListener(Event.ENTER_FRAME, update);
		}

		public function addParticles(numParts:int):void
		{

			var i:int = -1;

			while(++i < numParts)
			{
				// I don't like using the new thing here but it won't work otherwise?
				var temp:Dot = new Dot(this);
				var temp2:TrackingArrow = new TrackingArrow(temp);
				pDocClass.addChildAt(temp, 2);
				pDocClass.addChildAt(temp2, 1);

				dotsArray.push(temp);
				arrowsArray.push(temp2);
			}

			particleCount += numParts;
			//trace(particleCount);
		}

		public function update(anEvent:Event):void
		{

			var i:int = -1;
			time = getTimer();
			while(++i < particleCount)
			{
				if(!pDocClass.GameOver)
				{
					var temp:Dot = dotsArray[i];
					dx = temp.x - pDocClass.stage.mouseX;
					dy = temp.y - pDocClass.stage.mouseY;

					angle = Math.atan2(dy, dx);
					/*var absAng:Number = angle > 0.0 ? angle : -angle;
					var dySin = (((B * angle) + (C * angle * absAng)) * speed * ppm);*/

					temp.dx -= (Math.cos(angle) * adjustedSpeed);
					temp.dy -= (Math.sin(angle) * adjustedSpeed);
					//temp.dy -= dySin;

					temp.x += temp.dx;
					temp.y += temp.dy;

					temp.rotation += temp.RotSpeed;


					if(temp.visible)
					{
						if((dx * dx)+(dy * dy) < 625)
						{
							pDocClass.GameOver = true;
							break;
						}
					}


					if(checkIfOffStage(temp))
					{
						if(arrowsArray[i].alpha < 1)
						{
							arrowsArray[i].alpha+=.125;
						}
						temp.visible = false; // nice performance boost
					}
					else
					{
						if(arrowsArray[i].alpha > 0)
						{
							arrowsArray[i].alpha-=.125;

						}
						temp.visible = true;
					}
					dotsArray[i] = temp;
				}
			}
			if(pDocClass.GameOver)
			{
				KillAll();

				GameManager(this.parent).removeChild(this);
			}
			//trace(getTimer() - time);
		}

		public function KillAll():void
		{
			GameManager(this.parent).scoreTimer.stop();

			trace("Removing Dots");
			while(dotsArray.length > 0)
			{
				pDocClass.removeChild(dotsArray[0]);
				dotsArray.splice(0,1);
			}
			trace("Removing Arrows");
			while(arrowsArray.length > 0)
			{
				pDocClass.removeChild(arrowsArray[0]);
				arrowsArray.splice(0,1);
			}

			this.removeEventListener(Event.ENTER_FRAME, update);
			pDocClass.gotoAndStop("GameOver");

		}

		public function checkIfOffStage(dot:Dot):Boolean
		{
			// Hardcoded bounds cause it's faster :P
			if(dot.x < -20 || dot.x > 570 || dot.y < -20 || dot.y > 420)
			{
				return true;
			}
			return false;
		}

		public function get PPM():Number
		{
			return ppm;
		}
		public function get Speed():Number
		{
			return speed;
		}
		public function get ParticleCount():Number
		{
			return particleCount;
		}
		public function get DocClass():GameApp
		{
			return pDocClass;
		}
	}
}