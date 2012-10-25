package com.company
{
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.ScreenNavigator;
	import feathers.motion.transitions.ScreenSlidingStackTransitionManager;
	import feathers.skins.IFeathersTheme;
	import feathers.themes.MetalWorksMobileTheme;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Core extends Sprite
	{
		private var _label:Label;
		
		public function Core()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		private var _theme:IFeathersTheme;
		
		private var _navigator:ScreenNavigator;
		private var _transitionManager:ScreenSlidingStackTransitionManager;
		private var _button:Button;
		
		private function addedToStageHandler(event:Event):void
		{
			attachTheme();
			
			_label = new Label();
			_label.text = "Hello World!";
			addChild(_label);
			_label.validate();
			_label.x = (stage.stageWidth - _label.width) / 2;
			_label.y = (stage.stageHeight - _label.height) / 2;
		}
		
		private function attachTheme():void
		{
			_theme = new MetalWorksMobileTheme(stage);
		}
	}
}