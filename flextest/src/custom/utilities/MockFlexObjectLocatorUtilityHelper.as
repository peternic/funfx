package custom.utilities
{
	import mx.core.UIComponent;
	
	public class MockFlexObjectLocatorUtilityHelper implements IFlexObjectLocatorUtilityHelper
	{
		public var automationId:String;
		
		public function MockFlexObjectLocatorUtilityHelper() 
		{
		}
		
		public function createAutomationID(object:UIComponent):String{
			return automationId;
		}

	}
}