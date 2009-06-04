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

  import mx.logging.ILogger;
  import mx.logging.Log;

  import funfx.Logging;

  import mx.automation.IAutomationManager;
  import mx.automation.IAutomationObject;

  public class Proxy
  {
    private var log:ILogger = Log.getLogger("funfx.Proxy");
    
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
      log.debug(Logging.toString("Started fire event", "Locator", Logging.convertLocator(locator), "Event", eventName, "Args", args));

      return replayFunFXEvent(locator, eventName, convertArrayFromStringToAs(args));
    }

    public function replayFunFXEvent(locator:Object, eventName:String, args:Array) : String
    {
      if(!automationManager.isSynchronized(null)) {
        log.error("AutomationManager is not synchronized");
        return null;
      }
      try {
        var target:IAutomationObject = flexObjectlocator.findAutomationObject(locator);
        if(!target){
          log.error(Logging.toString("Target is null", "Locator", Logging.convertLocator(locator), "Event", eventName));
          throw new Error("Unable to resolve child with locator: " + flexObjectlocator.toString(locator["id"]) + (locator["parent"] != null ? ", and parent: " + flexObjectlocator.toString(locator["parent"]["id"]) : ""));
        }
        if (!automationManager.isSynchronized(target)) {
          log.error(Logging.toString("Target is not synchronized", 
                                     "Target", Logging.createComponentText(target as DisplayObject), 
                                     "Locator", Logging.convertLocator(locator)));
          throw new Error("Target is not synchronized: " + flexObjectlocator.toString(locator["id"]) + (locator["parent"] != null ? ", and parent: " + flexObjectlocator.toString(locator["parent"]["id"]) : ""));
        }
        if (!automationManager.isVisible(target as DisplayObject)){
          log.error(Logging.toString("Target is not visible", "Target", Logging.createComponentText(target as DisplayObject), "Locator", Logging.convertLocator(locator)));
          throw new Error("Target is not visible: " + flexObjectlocator.toString(locator["id"]) + (locator["parent"] != null ? ", and parent: " + flexObjectlocator.toString(locator["parent"]["id"]) : ""));
        }

        var result:Object = AQAdapter.aqAdapter.replay(target, eventName, args);
        log.debug(Logging.toString("Replay ended successfully"));
        return "OK";
      } catch(e:Error) {
        return errorMessage(e);
      }
      return null;
    }

    private function getFunFXPropertyValue(locator:Object, fieldName:String) : String
    {
      log.debug(Logging.toString("Started finding property", "Locator", Logging.convertLocator(locator), "Property", fieldName));
      if(!automationManager.isSynchronized(null)) {
        log.error("AutomationManager is not synchronized");
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
          log.error(Logging.toString("Field not found", 
                                     "Property", fieldName, 
                                     "Target", Logging.createComponentText(target as DisplayObject), 
                                     "Locator", Logging.convertLocator(locator)));
          throw new Error("Field not found: " + target + " doesn't have a field named '" + fieldName + "'");
        }
      } catch(e:Error) {
        return errorMessage(e);
      }
      return null;
    }

    private function getFunFXTabularPropertyValue(locator:Object, fieldName:String) : String
    {
      log.debug(Logging.toString("Started finding tabular property", "Locator", Logging.convertLocator(locator), "Property", fieldName));
      if(!automationManager.isSynchronized(null)) {
        log.error("AutomationManager is not synchronized");
        return null;
      }
      try {
        var target:IAutomationObject = flexObjectlocator.findAutomationObject(locator);
        var tab:Object = target.automationTabularData;
        if (tab.hasOwnProperty(fieldName)) {
          return tab[fieldName];
        } else {
          log.error(Logging.toString("Field not found", "Property", fieldName, "Target", Logging.createComponentText(target as DisplayObject), "Locator", Logging.convertLocator(locator)));
          throw new Error("Field not found: " + target + " doesn't have a field named '" + fieldName + "'");
        }
      } catch(e:Error) {
        return errorMessage(e);
      }
      return null;
    }

    private function invokeFunFXTabularMethod(locator:Object, methodName:String, ... args) : String
    {
      log.debug(Logging.toString("Started finding property", "Locator", Logging.convertLocator(locator), "Property", methodName));
      if(!automationManager.isSynchronized(null)) {
        log.error("AutomationManager is not synchronized");
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
          log.error(Logging.toString("Method not found", "Method", methodName, "Target", Logging.createComponentText(target as DisplayObject), "Locator", Logging.convertLocator(locator)));
          throw new Error("Method not found: " + target + " doesn't have a method named '" + methodName + "'");
        }
      } catch(e:Error) {
        return errorMessage(e);
      }
      return null;
    }

    private function errorMessage(e:Error) : String {
      // We have to escape backslashes or else they get interpreted as meta characters on the Ruby side.
      log.error(Logging.toString("FunFX faild", "Error", e.message, "Stacktrace", e.getStackTrace()));
      
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
