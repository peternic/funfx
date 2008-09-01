package funfx {
    import flash.external.ExternalInterface;
    
    import mx.automation.AutomationID;
    import mx.automation.IAutomationObject;
    import mx.automation.IAutomationManager;
    
    public class Proxy
    {
        public function Proxy()
        {
            ExternalInterface.addCallback("fireFunFXEvent", fireEvent);
            ExternalInterface.addCallback("getFunFXPropertyValue", getPropertyValue);
        }

        private function fireEvent(objID:String, eventName:String, args:String) : String
        {
            if(!automationManager.isSynchronized(null)) {
                return null;
            }
            try {
                var target:IAutomationObject = findAutomationObject(objID);
                var result:Object = AQAdapter.aqAdapter.replay(target, eventName, convertArrayFromStringToAs(args));
                return "OK";
            } catch(e:Error) {
                return errorMessage(e);
            }
            return null;
        }

        private function getPropertyValue(objID:String, fieldName:String) : String
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

        /** 
         * Returns an automation object. If we're not synched, returns null, in which case the client must try again.
         */
        private function findAutomationObject(objID:String) : IAutomationObject
        {
            try {
                var rid:AutomationID = AutomationID.parse(objID);
                return automationManager.resolveIDToSingleObject(rid);
            } catch(e:Error) {
                throw new Error("Target not found: " + objID);
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
