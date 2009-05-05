package funfx.external
{
    import flash.external.ExternalInterface;
    public class BrowserExternal implements External
    {
        public function addCallback(functionName:String, closure:Function):void
        {
            ExternalInterface.addCallback(functionName, closure);
        }
    }
}