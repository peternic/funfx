package funfx.external
{
    import flexunit.framework.TestCase;
    public class FunctionRegistryTest  extends TestCase
    {
        public function FunctionRegistryTest()
        {
            super();
        }

        public function testShouldReturnCorrectFunctionForName()
        {
            var functionRegistry:FunctionRegistry = new FunctionRegistry();
            functionRegistry.registerFunction("thisOne", first);
            functionRegistry.registerFunction("thatOne", second);
            assertEquals(first, functionRegistry.getFunctionCalled("thisOne"));
        }

        public function testShouldReturnCompleteListOfFunctionNames()
        {
            var functionRegistry:FunctionRegistry = new FunctionRegistry();
            functionRegistry.registerFunction("thisOne", first);
            functionRegistry.registerFunction("thatOne", second);
            var functionNames:Array = functionRegistry.getFunctionNames();
            assertEquals(2, functionNames.length);
            assertNotNull(functionRegistry.getFunctionCalled(functionNames[0]));
            assertNotNull(functionRegistry.getFunctionCalled(functionNames[1]));
        }

        private function second():void
        {
        }

        private function first():void
        {
        }
    }
}