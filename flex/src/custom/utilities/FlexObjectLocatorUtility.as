package custom.utilities
{
	import mx.controls.Alert;
	import mx.core.Application;
	import mx.core.IChildList;
	import mx.core.UIComponent;
	
	public class FlexObjectLocatorUtility implements IFlexObjectLocatorUtility{
		
		private var helper:IFlexObjectLocatorUtilityHelper;
		
		public function FlexObjectLocatorUtility(){
		}
		
		public function set flexLocatorhelper(helper:IFlexObjectLocatorUtilityHelper):void{
			this.helper = helper; 
		}
		
		public function getApplicationChildren():IChildList{
			return UIComponent(Application.application).systemManager.rawChildren;
		}
		
		public function createLocatorFromRecording(object:UIComponent):Object{
			if(object && !(object is Application)){
				if(!object.showInAutomationHierarchy) return createLocatorFromRecording(object.parent as UIComponent);
				var id:String = createAutomationID(object);
				return {parent: createLocatorFromRecording(object.parent as UIComponent), className: object.className, id: createIdLocatorForObject(object, id)};
			}
			else
				return null;
		}
		
		public function createAutomationID(object:UIComponent):String{
			return getAutomationIndexForObject(helper.createAutomationID(object));
		}
		
		public function getAutomationIndexForObject(automationString:String):String{
			var automationIndexPattern:RegExp = new RegExp("\.*automationIndex{([A-Za-z0-9-!\"#$%&'()*+,./:;<>=?@[\\\]_|]*) string|object}\.*", "i");
			var resultAutomationIndex:Array = automationIndexPattern.exec(automationString);
			if(resultAutomationIndex == null || resultAutomationIndex.length < 2) return null;
			else if(resultAutomationIndex[1].match("index:-1"))
				return null;
			else return resultAutomationIndex[1];
		}
		
		private function createIdLocatorForObject(object:UIComponent, automationString:String):Object{
			var locator:Object = new Object();
			if(object.automationName && object.automationName != "")
				locator["automationName"] = object.automationName;
			if(object.id && object.id != "")
				locator["id"] = object.id;
			if(automationString)
				locator["automationIndex"] = automationString;
			if(object.automationValue && object.automationValue.length > 0)
				locator["automationValue"] = object.automationValue;
			return locator;
		}

	}
}