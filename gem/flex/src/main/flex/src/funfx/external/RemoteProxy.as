package funfx.external
{
    import flash.external.ExternalInterface;
    import flash.net.LocalConnection;

    public class RemoteProxy
    {
        public static const CLIENT_CONNECTION:String = "_clientLocalConnection";
        public static const REGISTER_METHOD:String = "registerLocalCallBacks";
        private static const callbackMethod:String = "onCompletion";

        private var _outgoing:LocalConnection;
        private var _incoming:LocalConnection;
        private var _response:String;

        public function RemoteProxy()
        {
            _incoming = new LocalConnection();
            _incoming.allowDomain("*");
            _incoming.connect(CLIENT_CONNECTION);
            _incoming.client = this;
            _outgoing = new LocalConnection();
        }

        public function initiateCommunication():void
        {
            _outgoing.send(AirExternal.FUNFX_CONNECTION, AirExternal.ESTABLISH_CONNECTION_METHOD, REGISTER_METHOD);
        }

        private function getFunFxResponse() : String
        {
            return _response;
        }

        public function onCompletion(response:String):void
        {
			_response = response;
        }

        public function registerLocalCallBacks(functionNames:Array):void
        {
            ExternalInterface.addCallback("getFunFxResponse", getFunFxResponse);
			for (var i:int = 0; i < functionNames.length; ++i)
            {
                registerCallback(functionNames[i]);
            }
        }

        private function registerCallback(functionName:String):void
        {
            ExternalInterface.addCallback(functionName, createFunction(functionName));
        }

        private function createFunction(functionName:String):Function
        {
            return function(...args):String
            {
 				_outgoing.send(AirExternal.FUNFX_CONNECTION, AirExternal.REMOTE_METHOD, functionName, callbackMethod, args);
                return null;
            };
        }

    }
}