package custom.utilities
{
	import mx.core.UIComponent;
	
	public class FlexObjectLocatorUtilityHelper implements IFlexObjectLocatorUtilityHelper
	{
		public function FlexObjectLocatorUtilityHelper()
		{
		}
		
		public function createAutomationID(object:UIComponent):String{
			return AQAdapter.aqAdapter.createAutomationID(object).toString();
		}
		
	}
}