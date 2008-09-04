package funfx {
    import flash.external.ExternalInterface;
    
    import mx.automation.AutomationID;
    import mx.automation.IAutomationObject;
    import mx.automation.IAutomationManager;
    import mx.automation.IAutomationTabularData;
    import flash.display.DisplayObject;
    
    public class Proxy
    {
        public function Proxy()
        {
            ExternalInterface.addCallback("fireFunFXEvent", fireFunFXEvent);
            ExternalInterface.addCallback("getFunFXPropertyValue", getFunFXPropertyValue);
            ExternalInterface.addCallback("getFunFXTabularPropertyValue", getFunFXTabularPropertyValue);
            ExternalInterface.addCallback("invokeFunFXTabularMethod", invokeFunFXTabularMethod);
        }

        private function fireFunFXEvent(objID:String, eventName:String, args:String) : String
        {
            if(!automationManager.isSynchronized(null)) {
                return null;
            }
            try {
                var target:IAutomationObject = findAutomationObject(objID);
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

        private function getFunFXPropertyValue(objID:String, fieldName:String) : String
        {
            if(!automationManager.isSynchronized(null)) {
                return null;
            }
            try {
                var target:IAutomationObject = findAutomationObject(objID);
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

        private function getFunFXTabularPropertyValue(objID:String, fieldName:String) : String
        {
            if(!automationManager.isSynchronized(null)) {
                return null;
            }
            try {
                var target:IAutomationObject = findAutomationObject(objID);
                var tab:Object = target.automationTabularData;
                var o:Object = Object(tab);
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

        private function invokeFunFXTabularMethod(objID:String, methodName:String, ... args) : String
        {
            if(!automationManager.isSynchronized(null)) {
                return null;
            }
           
            try {
                var target:IAutomationObject = findAutomationObject(objID);              
                var tab:Object = target.automationTabularData;
                var o:Object = Object(tab);
                if (o.hasOwnProperty(methodName)) {
                    return o[methodName].apply(null, args);
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
        private function findAutomationObject(objID:String) : IAutomationObject
        {
            try {
                var rid:AutomationID = AutomationID.parse(objID);
                return automationManager.resolveIDToSingleObject(rid);
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

    }
}
