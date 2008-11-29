package custom.utilities
{
	import flexunit.framework.TestCase;
	
	import mx.core.Application;
	import mx.core.UIComponent;
	
	public class FlexObjectLocatorUtilityTest extends TestCase
	{
		private var object:UIComponent;
		private var parent:UIComponent;
		private var grandParent:UIComponent;
		
		private var locator:FlexObjectLocatorUtility;
		private var helper:IFlexObjectLocatorUtilityHelper;
		
		public function FlexObjectLocatorUtilityTest()
		{
			helper = new MockFlexObjectLocatorUtilityHelper();
			locator = new FlexObjectLocatorUtility();
			locator.flexLocatorhelper = helper;
			
			iniatializeComponents();
		}
		
		private function iniatializeComponents():void{
			object = new UIComponent();
			object.id = "objectID";
			object.automationName = "objectAutName";
			parent = new UIComponent();
			parent.id = "parentID";
			parent.automationName = "parentAutName";
			grandParent = new UIComponent();
			grandParent.id = "grandParentID";
			grandParent.automationName = "grandParentAutName";
		}
		
		public function testCreationOfLocatorOfObjectWithoutParent():void{
			var result:Object = locator.createLocatorFromRecording(object);
			assertNotNull(result);
			assertNull(result["parent"]);
			assertEquals(result["id"]["id"], object.id);
			assertEquals(result["id"]["automationName"], object.automationName);
		}
		
		public function testCreationOfLocatorOfObjectWithoutParentAndCheckClassName():void{
			var result:Object = locator.createLocatorFromRecording(object);
			assertNotNull(result);
			assertNull(result["parent"]);
			assertEquals(result["className"], "UIComponent");
			assertEquals(result["id"]["id"], object.id);
			assertEquals(result["id"]["automationName"], object.automationName);
		}
		
		public function testCreationOfLocatorObjectWithOneParent():void{
			parent.addChild(object);
			
			var result:Object = locator.createLocatorFromRecording(object);
			assertNotNull(result);
			assertEquals(result["id"]["id"], object.id);
			assertEquals(result["id"]["automationName"], object.automationName);
			
			var resultParent:Object = result["parent"];
			assertNotNull(resultParent);
			assertEquals(resultParent["id"]["id"], parent.id);
			assertEquals(resultParent["id"]["automationName"], parent.automationName);
		}
		
		public function testCreationOfLocatorObjectWithOneParentWhereParentIsApplication():void{
			parent = new Application();
			parent.id = "parentID";
			parent.automationName = "parentAutName";
			
			parent.addChild(object);
			
			var result:Object = locator.createLocatorFromRecording(object);
			assertNotNull(result);
			assertEquals(result["id"]["id"], object.id);
			assertEquals(result["id"]["automationName"], object.automationName);
			
			assertNull(result["parent"]);
		}
		
		public function testCreationOfLocatorObjectWithOneParentAndGrandparent():void{
			parent.addChild(object);
			grandParent.addChild(parent);
			
			var result:Object = locator.createLocatorFromRecording(object);
			assertNotNull(result);
			assertEquals(result["id"]["id"], object.id);
			assertEquals(result["id"]["automationName"], object.automationName);
			
			var resultParent:Object = result["parent"];
			assertNotNull(resultParent);
			assertEquals(resultParent["id"]["id"], parent.id);
			assertEquals(resultParent["id"]["automationName"], parent.automationName);
			
			var resultGrandParent:Object = resultParent["parent"];
			assertNotNull(resultGrandParent);
			assertEquals(resultGrandParent["id"]["id"], grandParent.id);
			assertEquals(resultGrandParent["id"]["automationName"], grandParent.automationName);
		}
		
		public function testShouldExtractAutomationIndexFromAutomationID():void{
			var testString:String = "id{null object}automationIndex{index:1 string}automationName{FlexObjectTest string}";
			var result:String = locator.getAutomationIndexForObject(testString);
			assertEquals("index:1", result);
		}
		
		public function testShouldExtractAutomationIndexFromLongAutomationID():void{
			var testString:String = "automationClassName{FlexTextInput string}automationIndex{index:1 string}displayAsPassword{false boolean}className{mx.controls.TextInput string}editable{true boolean}id{tTextInput string}automationName{ string}";
			var result:String = locator.getAutomationIndexForObject(testString);
			assertEquals("index:1", result);
		}
		
		
		public function testShouldExtractAutomationIndexFromAutomationIDAndReturNull():void{
			var testString:String = "id{null object}automationIndex{index:-1 string}automationName{FlexObjectTest string}";
			var result:String = locator.getAutomationIndexForObject(testString);
			assertNull(result);
		}
		
		public function testShouldExtractAutomationIndexFromAutomationIDWhereTheValueIsColumnName():void{
			var testString:String = "id{null object}automationIndex{phone:1 string}automationName{FlexObjectTest string}";
			var result:String = locator.getAutomationIndexForObject(testString);
			assertEquals("phone:1", result);
		}

	}
}