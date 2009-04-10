package funfx.flexlocator
{
	import custom.utilities.IFlexObjectLocatorUtility;
	
	import flash.display.DisplayObject;
	
	import funfx.log.LogElement;
	import funfx.log.Logger;
	
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
          Logger.addInfo("Starting locating element", new LogElement("Locator", Logger.convertLocator(locator)));
          return findComponentWith(locator["id"], findAutomationParent(locator["parent"]) as UIComponent);
        }
        
        public function findAutomationParent(locator:Object):UIComponent{
          try {
              if(locator)
                  return findComponentWith(locator["id"], findAutomationParent(locator["parent"]) as UIComponent);
              else
                  return null;
            } catch(e:Error) {
                Logger.addError("FunFX faild", new LogElement("Error", e.message), new LogElement("Stacktrace", e.getStackTrace()));
                throw e;
            } 
            return null;
        }
        
    /**
    * From FlexMonkey source
    *
    * Find the first component with the specified property/value pair. If a container is specified, then
    * only its children and descendents are searched. The search order is (currently) indeterminate. If no container is specified,
    * then all components will be searched.
    */
		public function findComponentWith(locator:Object, container:UIComponent):UIComponent {
			var childContainer:IChildList = (container == null) ?
											flexObjectLocatorUtility.getApplicationChildren() :
											container;
			
			var numChildren:int = getNumberOfChildren(childContainer);
			
			Logger.addInfo("Locating element", new LogElement("Locator", Logger.convertLocator(locator)), new LogElement("Container", Logger.createComponentText(container)), new LogElement("Children", numChildren.toString()));
			
			if (numChildren == 0) {
				return null;
			}
			for (var i:int=0; i < numChildren; i++) {
			  var child:DisplayObject = getChild(childContainer, i);

				if (!(child is UIComponent)) {
					continue;
				}

				if (childMatch(DisplayObject(child), locator)) {
					return UIComponent(child);
				}
				
				var grandChild:UIComponent = findComponentWith(locator, UIComponent(child));
				if (grandChild != null) {
					return grandChild;
				}
			}
			return null;
		}
		
		public function getNumberOfChildren(container:IChildList):int{
		  if(container is UIComponent)
			  return UIComponent(container).numAutomationChildren != 0 ? UIComponent(container).numAutomationChildren : UIComponent(container).numChildren;
			else
			  return container.numChildren;
		}
		
		public function getChild(container:IChildList, position:int):DisplayObject{
		  if(container is UIComponent)
			  return UIComponent(container).numAutomationChildren != 0 ? (UIComponent(container).getAutomationChildAt(position) as DisplayObject) : container.getChildAt(position);
			else
			  return container.getChildAt(position);
		}
		
		
		public function childMatch(child:DisplayObject, locator:Object):Boolean {
		  Logger.addInfo("Child match", new LogElement("Locator", Logger.convertLocator(locator)), new LogElement("Child", Logger.createComponentText(child)));
			var indexValue:String = "";
			for (var property:String in locator) {
				var value:String = decodeURIComponent(locator[property]);
				
				if(property == "automationIndex"){
					indexValue = value;
				} else {
					if (!child.hasOwnProperty(property) || trim(child[property]) != trim(value)){
					  Logger.addInfo("NO MATCH", new LogElement("Locator", Logger.convertLocator(locator)), new LogElement("Child", Logger.createComponentText(child)));
					  Logger.addInfo("NO MATCH II", new LogElement("Property", property), new LogElement("HasOwnProperty", child.hasOwnProperty(property).toString()));
					  if(child.hasOwnProperty(property)){
					    Logger.addInfo("NO MATCH III", new LogElement("Child[property]", trim(child[property])), new LogElement("Value", value), new LogElement("Comparison", (child[property] == value).toString()));
					    Logger.addInfo("NO MATCH IV", new LogElement("Child[property].length", trim(child[property]) != null ? trim(child[property]).length.toString() : "null"), new LogElement("Value.length", value.length.toString()));
					  } else {
					    Logger.addInfo("NO MATCH V", new LogElement("Value", value));
					  }
	 					return false;
	 			 }
	 			}
			}
			if(indexValue != ""){
				return checkIndex(child, indexValue);
			}
			else {
			  Logger.addInfo("MATCH", new LogElement("Locator", Logger.convertLocator(locator)), new LogElement("Child", Logger.createComponentText(child)));
				return true;
			}
		}
		
		public function toString(locator:Object):String{
			var result:String = "{";
			for (var property:String in locator) {
				var value:String = decodeURIComponent(locator[property]);
					if(result != "{") result += ", ";
					result += ":" + property + " => '" + value + "'"; 
			}
			result += "}";
			return result;
		}

		private function checkIndex(child:DisplayObject, value:String):Boolean{
			var index:String = flexObjectLocatorUtility.createAutomationID(child as UIComponent);
			Logger.addInfo("Check index", new LogElement("Actual index", index), new LogElement("Provided index", value), new LogElement("Child", Logger.createComponentText(child)));
			return index == value;
		}
		
    private function trim(str:String):String
    {
        if(str == null) return str;
        for(var i:uint = 0; str.charCodeAt(i) < 33; i++);
        for(var j:uint = str.length-1; str.charCodeAt(j) < 33; j--);
        return str.substring(i, j+1);
    }


	}
}