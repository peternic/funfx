package custom.utilities
{
	import mx.core.IChildList;
	import mx.core.UIComponent;

	public class MockFlexObjectLocatorUtility implements IFlexObjectLocatorUtility
	{
		public var childList:IChildList;
		public var automationId:String;
		
		public function MockFlexObjectLocatorUtility()
		{
		}

		public function getApplicationChildren():IChildList
		{
			return childList;
		}
		
		public function createLocatorFromRecording(object:UIComponent):Object{
			return null;
		}

		public function createAutomationID(object:UIComponent):String{
			return automationId;
		}
		
		public function set flexLocatorhelper(helper:IFlexObjectLocatorUtilityHelper):void{
			
		}
		
	}
}