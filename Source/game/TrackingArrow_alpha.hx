package game
{
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.events.*;

	public class TrackingArrow extends MovieClip
	{
		private var topLeft:Point;
		private var bottomLeft:Point;
		private var topRight:Point;
		private var bottomRight:Point;
		private var centerPoint:Point;

		private var a1:Number;
		private var a2:Number;
		private var b1:Number;
		private var b2:Number;
		private var c1:Number;
		private var c2:Number;
		private var pDot:Dot;
		private var intersect:Point;

		private var line_err:Boolean = false;

		public function TrackingArrow(aDot:Dot):void
		{
			intersect = new Point();
			pDot = aDot;
			this.addEventListener(Event.ADDED_TO_STAGE, init);

		}

		public function init(anEvent:Event):void
		{
			topLeft = new Point(0,0);
			bottomLeft = new Point(0,400);
			topRight = new Point(550, 0);
			bottomRight = new Point(550, 400);
			centerPoint = new Point(275, 200);
			this.addEventListener(Event.ENTER_FRAME, update);
		}

		public function update(anEvent:Event):void
		{
			if(this.visible)
			{
				showIntersectPoint();
				//trace("TrackingArrow Visible");
			}
		}

		public function showIntersectPoint()
		{
			var xOff:Number = 0, yOff:Number = 0;
			if(pDot.x < 0)
				xOff = -1;
			else if(pDot.x > 550)
				xOff = 1;
			else
				xOff = 0;

			if(pDot.y < 0)
				yOff = -1;
			else if(pDot.y > 400)
				yOff = 1;
			else
				yOff = 0;

			switch(xOff)
			{
				case 0:
					break;
				case -1:
					findIntersectPoint(new Point(pDot.x, pDot.y), centerPoint, topLeft, bottomLeft, xOff);
					this.rotation = 90;
					this.x = intersect.x + 4;
					this.y = intersect.y;

					break;
				case 1:
					findIntersectPoint(new Point(pDot.x, pDot.y), centerPoint, topRight, bottomRight, xOff);
					this.rotation = -90;
					this.x = intersect.x - 4;
					this.y = intersect.y;
					return;
					break;
				default:
					break;
			}

			switch(yOff)
			{
				case 0:
					break;
				case -1:
					findIntersectPoint(new Point(pDot.x, pDot.y), centerPoint, topLeft, topRight, -yOff);
					this.rotation = 180;
					this.x = intersect.x;
					this.y = intersect.y + 4;
					break;
				case 1:
					findIntersectPoint(new Point(pDot.x, pDot.y), centerPoint, bottomLeft, bottomRight, yOff);
					this.rotation = 0;
					this.x = intersect.x;
					this.y = intersect.y - 4;
					break;
				default:
					break;
			}

			checkLineErr(xOff, yOff);

		}

		public function findIntersectPoint(ptA:Point, ptB:Point, ptY:Point, ptZ:Point, flip:Number, seg:Boolean = true)
		{
			if(flip == -1)
			{
				a1 = ptA.y - ptB.y;
				b1 = ptB.x - ptA.x;
			}
			else if(flip == 1)
			{
				a1 = ptB.y - ptA.y;
				b1 = ptA.x - ptB.x;
			}

			c1 = (ptB.x * ptA.y)-(ptA.x * ptB.y);

			a2 = ptZ.y - ptY.y;
			b2 = ptY.x - ptZ.x;
			c2 = (ptZ.x * ptY.y) - (ptY.x * ptZ.y);

			var denom:Number = a1 * b2 - a2 * b1;
			if(denom == 0)
			{
				trace("Error: Divide by zero");
				return;
			}

			intersect.x = (b1*c2 - b2*c1)/denom;
			if(flip == -1)
				intersect.y = -(a2*c1 - a1*c2)/denom;
			else if(flip == 1)
				intersect.y = (a2*c1 - a1*c2)/denom;

			if(seg)
			{
				if(Point.distance(intersect, ptB) > Point.distance(ptA, ptB))
				{
					line_err = true;
					return;
				}
				if(Point.distance(intersect,ptA) > Point.distance(ptA,ptB))
				{
					line_err = true;
					return;
				}

				if(Point.distance(intersect,ptZ) > Point.distance(ptY,ptZ))
				{
					line_err = true;
					return;

				}
				if(Point.distance(intersect,ptY) > Point.distance(ptY,ptZ))
				{
					line_err = true;
					return;
				}
				line_err = false;
			}


		}
		public function checkLineErr(xOff:Number, yOff:Number):void
		{
			if(line_err)
			{
				if(xOff > 0)
				{
					if(yOff > 0)
					{
						this.rotation = -45;
						this.x = bottomRight.x - 4;
						this.y = bottomRight.y - 4;
					}

					if(yOff < 0)
					{
						this.rotation = 225;
						this.x = topRight.x - 4;
						this.y = topRight.y + 4;
					}
				}
				if (xOff < 0)
				{
					if(yOff > 0)
					{
						this.rotation = 45;
						this.x = bottomLeft.x + 4;
						this.y = bottomLeft.y - 4;
					}

					if(yOff < 0)
					{
						this.rotation = 135;
						this.x = topLeft.x + 4;
						this.y = topLeft.y + 4;
					}
				}
			}
		}
	}
}