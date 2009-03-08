package funfx.log
{
	import flexunit.framework.TestCase;

	
	public class LogTest extends TestCase {
		
		
		override public function setUp():void {
			Logger.clear();
		}
		
		public function testCreateAInfoLogMessageWithoutArguments():void{
		  Logger.addInfo("Message");
		  assertEquals("INFO: Message\n", Logger.printLog());
		}
		
		public function testCreateAInfoLogMessageWithArguments():void{
		  Logger.addInfo("Message", new LogElement("Label", "Data"));
		  assertEquals("INFO: Message\n\tLabel: Data\n", Logger.printLog());
		}
		
		public function testPrintALocator():void{
			var locator:Object = {parent: null, id: {id: 'Test'}};
			var result:String = Logger.convertLocator(locator);
			assertEquals("{parent: null, id: {id: 'Test'}}", result);
		}
		
		public function testPrintALocatorWhereParentIsNullAndAutomationName():void{
			var locator:Object = {parent: null, id: {automationName: 'Test'}};
			var result:String = Logger.convertLocator(locator);
			assertEquals("{parent: null, id: {automationName: 'Test'}}", result);
		}
		
		public function testPrintALocatorForAutomation():void{
			var locator:Object = {automationName: 'Tull'};
			var result:String = Logger.convertLocator(locator);
			assertEquals("{automationName: 'Tull'}", result);
		}
		
		
		
		public function testPrintANestedLocator():void{
			var locator:Object = {parent: {parent: null, id: {id: 'id1'}}, id: {automationName: 'automationName1'}};
			var result:String = Logger.convertLocator(locator);
			assertEquals("{parent: {parent: null, id: {id: 'id1'}}, id: {automationName: 'automationName1'}}", result);
		}
	}
}


