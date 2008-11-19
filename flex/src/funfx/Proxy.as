/**
 * Portions Copyright 2008 Gorilla Logic, Inc. Licensed under the Apache License, Version 2.0 (the "License"	)
 */
package funfx {
    import custom.utilities.CSVUtility;
    
    import flash.display.DisplayObject;
    import flash.external.ExternalInterface;
    
    import mx.automation.Automation;
    import mx.automation.AutomationID;
    import mx.automation.IAutomationManager;
    import mx.automation.IAutomationObject;
    import mx.core.Application;
    import mx.core.IChildList;
    import mx.core.UIComponent;
    
    public class Proxy
    {
        public function Proxy()
        {
            ExternalInterface.addCallback("fireFunFXEvent", fireFunFXEvent);
            ExternalInterface.addCallback("getFunFXPropertyValue", getFunFXPropertyValue);
            ExternalInterface.addCallback("getFunFXTabularPropertyValue", getFunFXTabularPropertyValue);
            ExternalInterface.addCallback("invokeFunFXTabularMethod", invokeFunFXTabularMethod);
        }

        private function fireFunFXEvent(locator:Object, eventName:String, args:String) : String
        {
            if(!automationManager.isSynchronized(null)) {
                return null;
            }
            try {
                var target:IAutomationObject = findAutomationObject(locator);
                if (!target || !automationManager.isSynchronized(target)) {
                  return null;
                }
                if (!automationManager.isVisible(target as DisplayObject)){
                  return null;
                }
                var result:Object = AQAdapter.aqAdapter.replay(target, eventName, convertArrayFromStringToAs(args));
                return "OK";
            } catch(e:Error) {
                return errorMessage(e);
            }
            return null;
        }

        private function getFunFXPropertyValue(locator:Object, fieldName:String) : String
        {
            if(!automationManager.isSynchronized(null)) {
                return null;
            }
            try {
                var target:IAutomationObject = findAutomationObject(locator);
                var o:Object = Object(target);
                if (o.hasOwnProperty(fieldName)) {
                    return o[fieldName];
                } else {
                    throw new Error("Field not found: " + target + " doesn't have a field named '" + fieldName + "'");
                }
            } catch(e:Error) {
                return errorMessage(e);
            }
            return null;
        }

        private function getFunFXTabularPropertyValue(locator:Object, fieldName:String) : String
        {
            if(!automationManager.isSynchronized(null)) {
                return null;
            }
            try {
                var target:IAutomationObject = findAutomationObject(locator);
                var tab:Object = target.automationTabularData;
                if (tab.hasOwnProperty(fieldName)) {
                    return tab[fieldName];
                } else {
                    throw new Error("Field not found: " + target + " doesn't have a field named '" + fieldName + "'");
                }
            } catch(e:Error) {
                return errorMessage(e);
            }
            return null;
        }

        private function invokeFunFXTabularMethod(locator:Object, methodName:String, ... args) : String
        {
            if(!automationManager.isSynchronized(null)) {
                return null;
            }
           
            try {
                var target:IAutomationObject = findAutomationObject(locator);              
                var tab:Object = target.automationTabularData;
                if (tab.hasOwnProperty(methodName)) {
                	var result:* = tab[methodName].apply(null, args);
					if (result is Array) {
						result = CSVUtility.encode(result);
					}
                    
                    return result;
                } else {
                    throw new Error("Method not found: " + target + " doesn't have a method named '" + methodName + "'");
                }
            } catch(e:Error) {
                return errorMessage(e);
            }
            return null;
        }
        
        /** 
         * Returns an automation object. If we're not synched, returns null, in which case the client must try again.
         */
        private function findAutomationObject(locator:Object) : IAutomationObject
        {
            try {
                return Proxy.findComponentWith(locator);
            } catch(e:Error) {
                throw e;
//                throw new Error("Target not found: " + objID);
            }
            return null;
        }
        
        private function errorMessage(e:Error) : String {
            // We have to escape backslashes or else they get interpreted as meta characters on the Ruby side.
            return "____FUNFX_ERROR:\n" + e.getStackTrace().replace(/\\/gm, "\\\\");
        }

        private function convertArrayFromStringToAs(a:String):Array
        {
            var result:Array = a.split("_ARG_SEP_");
            return result;
        }

        private function get automationManager():IAutomationManager
        {
            return AQAdapter.aqAdapter.automationManager;
        }
        
        /**
		 * From FlexMonkey source
		 *
		 * Find the first component with the specified property/value pair. If a container is specified, then
		 * only its children and descendents are searched. The search order is (currently) indeterminate. If no container is specified,
		 * then all components will be searched. If the prop value is "automationID", then the id is resolved directly without searching.
		 */
		public static function findComponentWith(locator:Object, container:UIComponent=null):UIComponent {
			var automationID:String = automationID(locator);
			if (automationID) return findComponentUsingAutomationFramework(automationID);
			
			return findComponentUsingCustomFramework(locator, container);

		}
		
		private static function findComponentUsingAutomationFramework(automationID:String):UIComponent {
			var rid:AutomationID = AutomationID.parse(automationID);
			var obj:IAutomationObject = Automation.automationManager.resolveIDToSingleObject(rid);
			return UIComponent(obj);
		}
		
		private static function findComponentUsingCustomFramework(locator:Object, container:UIComponent):UIComponent {
			var childContainer:IChildList = (container == null) ?
											UIComponent(Application.application).systemManager.rawChildren :
											container;

			var numChildren:int = childContainer.numChildren;
			if (numChildren == 0) {
				return null;
			}

			var component:UIComponent;
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
	
		private static function childMatch(child:DisplayObject, locator:Object):Boolean {
			for (var property:String in locator) {
				var value:String = decodeURIComponent(locator[property]);
				if (!child.hasOwnProperty(property) || child[property] != value) {
 					return false;
				}
			}
			return true;
		}
		
		private static function automationID(locator:Object):String {
			var automationIdKey:String = 'automationID';
			if (locator.hasOwnProperty(automationIdKey)) {
				return locator[automationIdKey];
			}
			return null;
		}
	}
}
