package funfx.model
{
	import mx.automation.AutomationIDPart;
	
	[Bindable]
	public class FunFXRecordedCommand
	{
		public var locator:Object;
		public var eventName:String;
		public var args:Array;
		
		public function FunFXRecordedCommand(locator:Object, eventName:String, args:Array){
			this.locator = locator;
			this.eventName = eventName;
			this.args = args;
		}

	}
}