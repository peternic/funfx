package funfx {
    import flash.external.ExternalInterface;
    
    import mx.automation.AutomationID;
    import mx.automation.IAutomationObject;
    
    public class Proxy
    {
        public function Proxy()
        {
            ExternalInterface.addCallback("fireFunFXEvent", fireEvent);
            ExternalInterface.addCallback("getFunFXPropertyValue", getPropertyValue);
        }

        private function fireEvent(objID:String, eventName:String, args:String) : String
        {
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
            try {
                var target:IAutomationObject = findAutomationObject(objID);
                var o:Object = Object(target);
                if (o.hasOwnProperty(fieldName)) {
                    return o[fieldName];
                } else {
                    throw new Error("Field not found: " + objID + ". Class=" + o.className());
                }
            } catch(e:Error) {
                return errorMessage(e);
            }
            return null;
        }

        private function findAutomationObject(objID:String) : IAutomationObject
        {
            try {
                var rid:AutomationID = AutomationID.parse(objID);
                var target:IAutomationObject = AQAdapter.aqAdapter.automationManager.resolveIDToSingleObject(rid);
                if (!target)
                {
                    // We probably never get here...
                    throw new Error("Target not found: " + objID);
                } 
                else 
                {
                    return target;
                }
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
    }
}
