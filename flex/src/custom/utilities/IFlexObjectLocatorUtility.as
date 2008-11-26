package custom.utilities
{
	import mx.core.IChildList;
	import mx.core.UIComponent;
	
	public interface IFlexObjectLocatorUtility
	{
		function getApplicationChildren():IChildList;
		function createLocatorFromRecording(object:UIComponent):Object;
		function createAutomationID(object:UIComponent):String;
		
		function set flexLocatorhelper(helper:IFlexObjectLocatorUtilityHelper):void;
	}
}