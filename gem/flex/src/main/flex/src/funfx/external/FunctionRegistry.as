package funfx.external {

    public class FunctionRegistry
    {
        private var _functionMap:Object = new Object();
        private var _functionNames:Array = new Array();

        public function registerFunction(functionName:String, closure:Function):void
        {
            _functionMap[functionName] = closure;
            _functionNames[_functionNames.length] = functionName;
        }

        public function getFunctionNames():Array
        {
            return _functionNames;
        }

        public function getFunctionCalled(functionName:String):Function
        {
            return _functionMap[functionName];
        }

    }
}