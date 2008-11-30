/**
 * Portions Copyright 2008 Gorilla Logic, Inc. Licensed under the Apache License, Version 2.0 (the "License"	)
 */
package funfx {
    import custom.utilities.CSVUtility;
    import custom.utilities.FlexObjectLocatorUtility;
    import custom.utilities.FlexObjectLocatorUtilityHelper;
    
    import flash.display.DisplayObject;
    import flash.external.ExternalInterface;
    
    import funfx.flexlocator.FlexObjectLocator;
    
    import mx.automation.IAutomationManager;
    import mx.automation.IAutomationObject;
    
    public class Proxy
    {
    	private var flexObjectlocator:FlexObjectLocator;
    	
        public function Proxy()
        {
        	flexObjectlocator = new FlexObjectLocator();
        	flexObjectlocator.flexObjectLocatorUtility = new FlexObjectLocatorUtility();
        	flexObjectlocator.flexObjectLocatorUtility.flexLocatorhelper = new FlexObjectLocatorUtilityHelper();
        	
	        ExternalInterface.addCallback("fireFunFXEvent", fireFunFXEvent);
	        ExternalInterface.addCallback("getFunFXPropertyValue", getFunFXPropertyValue);
	        ExternalInterface.addCallback("getFunFXTabularPropertyValue", getFunFXTabularPropertyValue);
	        ExternalInterface.addCallback("invokeFunFXTabularMethod", invokeFunFXTabularMethod);
        }
        
        private function fireFunFXEvent(locator:Object, eventName:String, args:String) : String{
        	return replayFunFXEvent(locator, eventName, convertArrayFromStringToAs(args));
        }
        

        public function replayFunFXEvent(locator:Object, eventName:String, args:Array) : String
        {
            if(!automationManager.isSynchronized(null)) {
                return null;
            }
            try {
                var target:IAutomationObject = flexObjectlocator.findAutomationObject(locator);
                if (!target || !automationManager.isSynchronized(target)) {
                  return null;
                }
                if (!automationManager.isVisible(target as DisplayObject)){
                  return null;
                }
                var result:Object = AQAdapter.aqAdapter.replay(target, eventName, args);
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
                var target:IAutomationObject = flexObjectlocator.findAutomationObject(locator);
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
                var target:IAutomationObject = flexObjectlocator.findAutomationObject(locator);
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
                var target:IAutomationObject = flexObjectlocator.findAutomationObject(locator);              
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
	}
}
