package funfx.external
{
	import flash.external.ExternalInterface;
    public class ExternalFactory
    {
        public static function getExternal() : External
        {
            if (ExternalInterface.available)
            {
                return new BrowserExternal();
            }
            return new AirExternal();
        }
    }
}