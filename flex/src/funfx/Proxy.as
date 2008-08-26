package funfx {
    import flash.external.ExternalInterface;
    import mx.automation.IAutomationObject;
    import mx.automation.AutomationID;
    
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
                return "____ERROR_TARGET_NOT_FOUND:" + e.message;
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
                    return "____ERROR_FIELD_NOT_FOUND:class=" + o.className();
                }
            } catch(e:Error) {
                return "____ERROR_TARGET_NOT_FOUND:" + e.message;
            }
            return null;
        }

        private function findAutomationObject(objID:String) : IAutomationObject
        {
            var rid:AutomationID = AutomationID.parse(objID);
            var target:IAutomationObject = AQAdapter.aqAdapter.automationManager.resolveIDToSingleObject(rid);
            if (!target)
            {
                throw new Error("Target not found");
            } 
            else 
            {
                return target;
            }
        }

        private function convertArrayFromStringToAs(a:String):Array
        {
            var result:Array = a.split("_ARG_SEP_");
            return result;
        }
    }
}
