package funfx.flexlocator
{
	import custom.utilities.IFlexObjectLocatorUtility;
	
	import flash.display.DisplayObject;
	
	import mx.automation.Automation;
	import mx.automation.AutomationID;
	import mx.automation.IAutomationObject;
	import mx.controls.Alert;
	import mx.core.IChildList;
	import mx.core.UIComponent;
	
	public class FlexObjectLocator
	{
		public var flexObjectLocatorUtility:IFlexObjectLocatorUtility;
		
		public function FlexObjectLocator()
		{
		}
		
        public function findAutomationObject(locator:Object) : *
        {
        		return findComponentWith(locator["id"], findAutomationParent(locator["parent"]) as UIComponent);
        }
        
        public function findAutomationParent(locator:Object):UIComponent{
        	try {
            	if(locator)
                	return findComponentWith(locator["id"], findAutomationParent(locator["parent"]) as UIComponent);
                else
                	return null;
            } catch(e:Error) {
                throw e;
            } 
            return null;
        }
        
        /**
		 * From FlexMonkey source
		 *
		 * Find the first component with the specified property/value pair. If a container is specified, then
		 * only its children and descendents are searched. The search order is (currently) indeterminate. If no container is specified,
		 * then all components will be searched. If the prop value is "automationID", then the id is resolved directly without searching.
		 */
		public function findComponentWith(locator:Object, container:UIComponent=null):UIComponent {
			var automationID:String = automationID(locator);
			if (automationID) return findComponentUsingAutomationFramework(automationID);
			
			return findComponentUsingCustomFramework(locator, container);

		}
		
		private static function findComponentUsingAutomationFramework(automationID:String):UIComponent {
			var rid:AutomationID = AutomationID.parse(automationID);
			var obj:IAutomationObject = Automation.automationManager.resolveIDToSingleObject(rid);
			return UIComponent(obj);
		}
		
		public function findComponentUsingCustomFramework(locator:Object, container:UIComponent):UIComponent {
			var childContainer:IChildList = (container == null) ?
											flexObjectLocatorUtility.getApplicationChildren() :
											container;
			
			var numChildren:int = childContainer.numChildren;
			if (numChildren == 0) {
				return null;
			}
			
			for (var i:int=0; i < numChildren; i++) {
				var child:DisplayObject = childContainer.getChildAt(i);

				if (!(child is UIComponent)) {
					continue;
				}

				if (childMatch(child, locator)) {
					return UIComponent(child);
				}
				
				var grandChild:UIComponent = findComponentUsingCustomFramework(locator, UIComponent(child));
				if (grandChild != null) {
					return grandChild;
				}
			}
			return null;
		}
		
		
		public function childMatch(child:DisplayObject, locator:Object):Boolean {
			var indexValue:String = "";
			for (var property:String in locator) {
				var value:String = decodeURIComponent(locator[property]);
				
				if(property == "automationIndex"){
					indexValue = value;
				} else {
					if (!child.hasOwnProperty(property) || child[property] != value)
	 					return false;
	 			}
			}
			if(indexValue != ""){
				return checkIndex(child, indexValue);
			}
			else
				return true;
		}
		
		private function checkIndex(child:DisplayObject, value:String):Boolean{
			var index:String = flexObjectLocatorUtility.createAutomationID(child as UIComponent);
			return index == value;
		}
		
		private function automationID(locator:Object):String {
			var automationIdKey:String = 'automationID';
			if (locator.hasOwnProperty(automationIdKey)) {
				return locator[automationIdKey];
			}
			return null;
		}

	}
}