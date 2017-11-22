package
{
	import com.adobe.air.gaming.*;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import nape.phys.BodyList;
	import nape.space.Space;
	import nape.shape.Polygon;
	import nape.phys.BodyType;
	import nape.phys.Body;
	import nape.util.ShapeDebug;
	import nape.geom.Vec2;
	
	
	/**
	 * ...
	 * @author Reece
	 */
	public class Main extends Sprite 
	{
		
		public var space:Space = new Space(new Vec2(0, 600));
		
		
		public function Main() 
		{
			
			
		}
		
		public function init(){
			stage.addEventListener(MouseEvent.CLICK, spawnBox);
			var debug:ShapeDebug = new ShapeDebug(600,600,0x333333);
			stage.addChild(debug.display);
			
			var border:Body = new Body(BodyType.STATIC);
			border.shapes.add(new Polygon(Polygon.rect(0,0,-40,600)));
			border.shapes.add(new Polygon(Polygon.rect(600,0,40,600)));
			border.shapes.add(new Polygon(Polygon.rect(0,0,600,-40)));
			border.shapes.add(new Polygon(Polygon.rect(0,600,600,40)));
			border.space = space;
			
			addEventListener(Event.ENTER_FRAME, function (_:Event):void{
				trace("frame");
				debug.clear();
				space.step(1 / stage.frameRate, 10, 10);
				
				
				var bodyList = space.bodies;
				for (var i:int = 0; i < bodyList.length; i++){
					var body:Body = bodyList.at(i);
					if (body.userData.sprite != null){
						body.userData.sprite.x = body.position.x;
						body.userData.sprite.y = body.position.y;
						body.userData.sprite.rotation = (body.rotation * 180 / Math.PI) % 360;
					}
				}
				debug.draw(space);
				debug.flush();
			});
		}
		
		private function spawnBox(e:MouseEvent):void 
		{
			//var xVec:Vec2 = new Vec2(mouseX, mouseY);
			trace("click");
			
			
			//var yVec:Vec2 = new Vec2(0, mouseY);
			/*
			var block:Polygon = new Polygon(Polygon.box(50,50));
			var body:Body = new Body();
			var sprite:Sprite = new Sprite();
			sprite.graphics.beginFill(0x00000, 1);
			sprite.graphics.drawRect(-25, -25 , 50, 50);
			sprite.graphics.endFill();
			//addChild(sprite);
			body.shapes.add(block);
			body.position.setxy(e.stageX,e.stageY);
			body.space = space;
			body.userData.sprite = sprite;
			stage.addChild(body.userData.sprite);
			*/
			
			var circle:Polygon = new Polygon(Polygon.regular(25, 25, 3));
			var body1:Body = new Body();
			body1.shapes.add(circle);
			body1.position.setxy(mouseX,mouseY);
			body1.space = space;
			
			
			
		}

	}
}