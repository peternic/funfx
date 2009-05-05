package funfx.external
{
    import flash.net.LocalConnection;

    public class AirExternal implements External
    {

        public static const REMOTE_METHOD:String = "invokeFunctionCalled";
        public static const ESTABLISH_CONNECTION_METHOD:String = "establishConnection";
        public static const FUNFX_CONNECTION:String = "_funfxLocalConnection";
        
		private var _functionRegistry:FunctionRegistry;
        private var _incoming:LocalConnection;
        private var _outgoing:LocalConnection;

        public function AirExternal()
        {
            _incoming = new LocalConnection();
            _incoming.allowDomain("*");
            _incoming.connect(FUNFX_CONNECTION);
            _functionRegistry = new FunctionRegistry();
            _incoming.client = this;
        }

        public function establishConnection(callBackMethod:String):void
        {
            if (_outgoing == null)
            {
                _outgoing = new LocalConnection();
            }
            _outgoing.send(RemoteProxy.CLIENT_CONNECTION, callBackMethod, _functionRegistry.getFunctionNames());
        }

        public function invokeFunctionCalled(functionName:String, callBack:String, args:Array):void
        {
            var functionToCall:Function = _functionRegistry.getFunctionCalled(functionName);
            var response:String = functionToCall.apply(this, args);
            respondWith(response, callBack);
        }

        private function respondWith(response:String, callBack:String):void
        {
            _outgoing.send(RemoteProxy.CLIENT_CONNECTION, callBack, response);
        }

        public function addCallback(functionName:String, closure:Function):void
        {
            _functionRegistry.registerFunction(functionName, closure);
        }

    }
}