package
{
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.ui.ContextMenu;
	import flash.utils.getDefinitionByName;
	
	import feathers.system.DeviceCapabilities;
	
	import starling.core.Starling;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	public class MainWeb extends MovieClip	
	{
		public function MainWeb()
		{
			var menu:ContextMenu = new ContextMenu();
			menu.hideBuiltInItems();
			contextMenu = menu;
			
			if(stage)
			{
				stage.align = StageAlign.TOP_LEFT;
				stage.scaleMode = StageScaleMode.NO_SCALE;
			}
			
			//pretends to be an iPhone Retina screen
			DeviceCapabilities.dpi = 326;
			DeviceCapabilities.screenPixelWidth = 960;
			DeviceCapabilities.screenPixelHeight = 640;
			
			loaderInfo.addEventListener(Event.COMPLETE, loaderInfo_completeHandler);
		}
		
		private var _starling:Starling;
		
		private function start():void
		{
			gotoAndStop(2);
			graphics.clear();
			
			Starling.handleLostContext = true;
			Starling.multitouchEnabled = true;
			
			var MainType:Class = getDefinitionByName("com.company.Main") as Class;
			
			_starling = new Starling(MainType, stage);
			_starling.showStats = true;
			_starling.showStatsAt(HAlign.LEFT, VAlign.TOP);
			_starling.start();
			stage.addEventListener(Event.RESIZE, stage_resizeHandler, false, int.MAX_VALUE, true);
			stage.addEventListener(Event.DEACTIVATE, stage_deactivateHandler, false, 0, true);
		}
		
		private function stage_resizeHandler(event:Event):void
		{
			_starling.stage.stageWidth = stage.stageWidth;
			_starling.stage.stageHeight = stage.stageHeight;
			
			const viewPort:Rectangle = _starling.viewPort;
			viewPort.width = stage.stageWidth;
			viewPort.height = stage.stageHeight;
			try
			{
				_starling.viewPort = viewPort;
			}
			catch(error:Error) {}
			_starling.showStatsAt(HAlign.LEFT, VAlign.BOTTOM);
		}
		
		private function stage_deactivateHandler(event:Event):void
		{
			_starling.stop();
			stage.addEventListener(Event.ACTIVATE, stage_activateHandler, false, 0, true);
		}
		
		private function stage_activateHandler(event:Event):void
		{
			stage.removeEventListener(Event.ACTIVATE, stage_activateHandler);
			_starling.start();
		}
		
		private function loaderInfo_completeHandler(event:Event):void
		{
			start();
		}
	}
}