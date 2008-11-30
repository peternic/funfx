package custom.utilities
{
	import mx.controls.Alert;
	import mx.core.UIComponent;
	
	public class FlexObjectLocatorUtilityHelper implements IFlexObjectLocatorUtilityHelper
	{
		public function FlexObjectLocatorUtilityHelper()
		{
		}
		
		public function createAutomationID(object:UIComponent):String{
			try{
				var str:String = AQAdapter.aqAdapter.createAutomationID(object).toString();
				return str;
			} catch(e:Error){
				return "null";
			}
			return "null";
		}
		
	}
}