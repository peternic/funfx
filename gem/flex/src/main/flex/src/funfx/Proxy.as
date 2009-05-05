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
    import funfx.log.LogElement;
    import funfx.log.Logger;

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
          Logger.addInfo("Started fire event", new LogElement("Locator", Logger.convertLocator(locator)), new LogElement("Event", eventName), new LogElement("Args", args));
        	return replayFunFXEvent(locator, eventName, convertArrayFromStringToAs(args));
        }

        public function replayFunFXEvent(locator:Object, eventName:String, args:Array) : String
        {
            if(!automationManager.isSynchronized(null)) {
                Logger.addError("AutomationManager is not synchronized");
                return null;
            }
            try {
                var target:IAutomationObject = flexObjectlocator.findAutomationObject(locator);
                if(!target){
                  Logger.addError("Target is null", new LogElement("Locator", Logger.convertLocator(locator)), new LogElement("Event", eventName));
                	throw new Error("Unable to resolve child with locator: " + flexObjectlocator.toString(locator["id"]) + (locator["parent"] != null ? ", and parent: " + flexObjectlocator.toString(locator["parent"]["id"]) : ""));
                }
                if (!automationManager.isSynchronized(target)) {
                  Logger.addError("Target is not synchronized", new LogElement("Target", Logger.createComponentText(target as DisplayObject)), new LogElement("Locator", Logger.convertLocator(locator)));
                  throw new Error("Target is not synchronized: " + flexObjectlocator.toString(locator["id"]) + (locator["parent"] != null ? ", and parent: " + flexObjectlocator.toString(locator["parent"]["id"]) : ""));
                }
                if (!automationManager.isVisible(target as DisplayObject)){
                  Logger.addError("Target is not visible", new LogElement("Target", Logger.createComponentText(target as DisplayObject)), new LogElement("Locator", Logger.convertLocator(locator)));
                  throw new Error("Target is not visible: " + flexObjectlocator.toString(locator["id"]) + (locator["parent"] != null ? ", and parent: " + flexObjectlocator.toString(locator["parent"]["id"]) : ""));
                }

                var result:Object = AQAdapter.aqAdapter.replay(target, eventName, args);
                Logger.addInfo("Replay ended successfully");
                return "OK";
            } catch(e:Error) {
                return errorMessage(e);
            }
            return null;
        }

        private function getFunFXPropertyValue(locator:Object, fieldName:String) : String
        {
          Logger.addInfo("Started finding property", new LogElement("Locator", Logger.convertLocator(locator)), new LogElement("Property", fieldName));
          if(!automationManager.isSynchronized(null)) {
              Logger.addError("AutomationManager is not synchronized");
              return null;
          }
          try {
              var target:IAutomationObject = flexObjectlocator.findAutomationObject(locator);
              var o:Object = Object(target);
              if (o.hasOwnProperty(fieldName)) {
                  return o[fieldName];
              } else if(fieldName == "null") {
                  if (target == null)
                      return "true";

                  return "false";
              } else {
                  Logger.addError("Field not found", new LogElement("Property", fieldName), new LogElement("Target", Logger.createComponentText(target as DisplayObject)), new LogElement("Locator", Logger.convertLocator(locator)));
                  throw new Error("Field not found: " + target + " doesn't have a field named '" + fieldName + "'");
              }
          } catch(e:Error) {
              return errorMessage(e);
          }
          return null;
        }

        private function getFunFXTabularPropertyValue(locator:Object, fieldName:String) : String
        {
          Logger.addInfo("Started finding tabular property", new LogElement("Locator", Logger.convertLocator(locator)), new LogElement("Property", fieldName));
          if(!automationManager.isSynchronized(null)) {
               Logger.addError("AutomationManager is not synchronized");
              return null;
          }
          try {
              var target:IAutomationObject = flexObjectlocator.findAutomationObject(locator);
              var tab:Object = target.automationTabularData;
              if (tab.hasOwnProperty(fieldName)) {
                  return tab[fieldName];
              } else {
                  Logger.addError("Field not found", new LogElement("Property", fieldName), new LogElement("Target", Logger.createComponentText(target as DisplayObject)), new LogElement("Locator", Logger.convertLocator(locator)));
                  throw new Error("Field not found: " + target + " doesn't have a field named '" + fieldName + "'");
              }
          } catch(e:Error) {
              return errorMessage(e);
          }
          return null;
        }

        private function invokeFunFXTabularMethod(locator:Object, methodName:String, ... args) : String
        {
          Logger.addInfo("Started finding property", new LogElement("Locator", Logger.convertLocator(locator)), new LogElement("Property", methodName));
            if(!automationManager.isSynchronized(null)) {
                 Logger.addError("AutomationManager is not synchronized");
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
                    Logger.addError("Method not found", new LogElement("Method", methodName), new LogElement("Target", Logger.createComponentText(target as DisplayObject)), new LogElement("Locator", Logger.convertLocator(locator)));
                    throw new Error("Method not found: " + target + " doesn't have a method named '" + methodName + "'");
                }
            } catch(e:Error) {
                return errorMessage(e);
            }
            return null;
        }

        private function errorMessage(e:Error) : String {
            // We have to escape backslashes or else they get interpreted as meta characters on the Ruby side.
            Logger.addError("FunFX faild", new LogElement("Error", e.message), new LogElement("Stacktrace", e.getStackTrace()));
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
