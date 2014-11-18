package
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.filters.BlurFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import ui.BlackRect;
	import ui.Empty;
	import ui.Logo;
	
	public class WordParticle extends Sprite
	{
		public var xx:int;
		
		public var logobm:Bitmap;
		
		public var yy:int;
		
		public var particels:Vector.<Particle>;
		
		public var blur:BlurFilter;
		
		public var pixel:Number;
		
		public var tbmd:BitmapData;
		
		public var bounds:Rectangle;
		
		public var tbm:Bitmap;
		
		public var pickArray:Object;
		
		public var base:BitmapData;
		
		public var logobmd:BitmapData;
		private var empty:Empty;
		private var logo:Logo;
		private var blackRect:BlackRect = new BlackRect();
		private var BACKGROUND_WIDTH:Number = 800;
		private var BACKGROUND_HEIGHT:Number = 450;
		private var _layer:Sprite = new Sprite();
		public function WordParticle()
		{
			super();
			if( null != stage )
			{
				initUI();
				return;
			}
			
			addEventListener( Event.ADDED_TO_STAGE, initUI );
		}
		private function initUI( e:Event = null ):void
		{
			if( null != e )
			{
				removeEventListener( Event.ADDED_TO_STAGE, initUI );
			}
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.addEventListener( Event.RESIZE, onStageResize );
			addChild( _layer );
			base = new BitmapData(960,450,true,0);
			tbmd = new BitmapData(960,450,true,0);
			tbm = new Bitmap( tbmd );
			empty = new Empty();
			empty.addChild( tbm );
			_layer.addChild( empty );
			logo = new Logo();
			_layer.addChild( logo );
			bounds = logo.getBounds( logo );
			logobmd = new BitmapData( bounds.width, bounds.height, true, 0 );
			logobm = new Bitmap( logobmd );
			_layer.addChild( logobm );
			logo.visible = false;
			logobmd.draw( logo );
			pickArray = [];
			particels = new Vector.<Particle>();
			logobm.x = 400 - bounds.width / 2;
			logobm.y = 225 - bounds.height / 2;
			logobm.visible = false;
			yy = bounds.y;
			while( yy < bounds.height )
			{
				xx = bounds.x;
				while(xx < bounds.width)
				{
					pixel = logobmd.getPixel32( xx, yy );
					if( pixel != 0 )
					{
						particels.push( new Particle( xx + logobm.x, yy + logobm.y, pixel,base ) );
					}
					xx = xx + 2;
				}
				yy = yy + 2;
			}
			addEventListener( Event.ENTER_FRAME, onEnterFrame );
			onStageResize();
		}
		
		private function onEnterFrame( e:Event ):void
		{
			tbmd.draw( blackRect );
			tbmd.draw(tbmd,undefined,undefined,BlendMode.HARDLIGHT);
			blur = new BlurFilter(30,30);
			tbmd.applyFilter(tbmd,tbmd.rect,new Point(0,0),blur);
			tbmd.draw( blackRect );
			base.fillRect( tbmd.rect,0);
			particels.forEach( forEach );
			tbmd.draw(base,undefined,undefined,BlendMode.SCREEN);
		}
		private function forEach( p:Particle, p1:*, p2:* ):void
		{
			p.Tick( mouseX, mouseY );
		}
		
		private function onStageResize( e:Event = null ):void
		{
			var newScaleX:Number = stage.stageWidth / BACKGROUND_WIDTH;
			var newScaleY:Number = stage.stageHeight/ BACKGROUND_HEIGHT;
//			_layer.x = stage.stageWidth / 2;
			_layer.scaleX = _layer.scaleY = newScaleX < newScaleY ? newScaleX : newScaleY;
		}		
	}
}