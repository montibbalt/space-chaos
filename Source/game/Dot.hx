package game
{
	import flash.display.Sprite;
	import flash.events.*;

	public class Dot extends Sprite
	{
		private var pDotMan:DotManager;
		private var hMin:Number = 0, vMin:Number = 0;
		private var hMax:Number = 550, vMax:Number = 400;

		public var dx:Number = 0;
		public var dy:Number = 0;

		private var speed:Number;
		private var rotSpeed:Number;
		private var halfWidth:Number;


		public function Dot(aDotMan:DotManager):void
		{
			pDotMan = aDotMan;

			this.addEventListener(Event.ADDED_TO_STAGE, addedToStage);

		}

		public function addedToStage(anEvent:Event):void
		{
			rotSpeed = (Math.random() * 2) - 1;
			halfWidth = this.width >> 1;
			generateRandomSpawnPosition();
		}

		public function update():void
		{
			graphics.clear();
			graphics.lineStyle(1,0,100);
			graphics.moveTo(this.x, this.y);
			graphics.lineTo(mouseX, mouseY);
		}

		private function generateRandomSpawnPosition():void
		{
			var startingSide:Number = Math.round(Math.random() * 3);
			switch(startingSide)
			{
				case RockSpawn.LT:
					this.x = -halfWidth;
					this.y = Math.round((Math.random() * (vMax - vMin)) + vMin);

					break;

				case RockSpawn.TP:
					this.x = Math.round((Math.random() * (hMax - hMin)) + hMin);
					this.y = -halfWidth;

					break;

				case RockSpawn.RT:
					this.x = 550 + halfWidth;
					this.y = Math.round((Math.random() * (vMax - vMin)) + vMin);

					break;

				case RockSpawn.BT:
					this.x = Math.round((Math.random() * (hMax - hMin)) + hMin);
					this.y = 400 + halfWidth;

					break;

				default:
					this.x = 0;
					this.y = 0;
					trace("WARNING: Spawn default")
			}
		}

		public function get RotSpeed():Number
		{
			return rotSpeed;
		}
		public function get DotMan():DotManager
		{
			return pDotMan;
		}
	}
}