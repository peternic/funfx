package flexlocator
{
	import custom.utilities.IFlexObjectLocatorUtilityHelper;
	import custom.utilities.MockFlexObjectLocatorUtility;
	import custom.utilities.MockFlexObjectLocatorUtilityHelper;
	
	import flexunit.framework.TestCase;
	
	import funfx.flexlocator.FlexObjectLocator;
	
	import mx.automation.IAutomationObject;
	import mx.core.UIComponent;
	
	public class LocatorTest extends TestCase {
		
		private var objLocator:FlexObjectLocator;
		
		private var object:UIComponent;
		private var childOne:UIComponent;
		private var childTwo:UIComponent;
		private var grandChildOne:UIComponent;
		private var grandChildTwo:UIComponent;
		private var parentLocator:Object;
		private var childLocator:Object;
		private var locator:Object;
		
		private var mockHelper:MockFlexObjectLocatorUtilityHelper;
		private var mockFlexObjectLocatorUtility:MockFlexObjectLocatorUtility;
		
		override public function setUp():void {
			mockFlexObjectLocatorUtility = new MockFlexObjectLocatorUtility();
			objLocator = new FlexObjectLocator();
			objLocator.flexObjectLocatorUtility = mockFlexObjectLocatorUtility;
						
			initializeValues();
		}
		
		private function initializeValues():void{
			object = new UIComponent();
			childOne = new UIComponent();
			childTwo = new UIComponent();
			grandChildOne = new UIComponent();
			grandChildTwo = new UIComponent();
			locator = new Object();
			parentLocator = new Object();
			childLocator = new Object();
			
			object.id = "-1";
			object.automationName = "-1";
			childOne.id = "-1";
			childOne.automationName = "-1";
			childTwo.id = "-1";
			childTwo.automationName = "-1";
			grandChildOne.id = "-1";
			grandChildOne.automationName = "-1";
			grandChildTwo.id = "-1";
			grandChildTwo.automationName = "-1";
		}
		
		public function testShouldLocateChildObjectWithoutSpecifyingAnyParent():void{
			childOne.id = "correctID";
			object.addChild(childOne);
			
			parentLocator["parent"] = null;
			parentLocator["id"] = {id: "correctID"};
			
			mockFlexObjectLocatorUtility.childList = object;
			var result:IAutomationObject = objLocator.findAutomationObject(parentLocator);
			assertNotNull(result);
			assertEquals(childOne.id, UIComponent(result).id);
		}
		
		  public function testShouldLocateGrandchildObjectWithoutSpecifyingAnyParent():void{
			grandChildOne.id = "correctID";
			childOne.addChild(grandChildOne);
			object.addChild(childOne);
			
			parentLocator["parent"] = null;
			parentLocator["id"] = {id: "correctID"};
			
			mockFlexObjectLocatorUtility.childList = object;
			var result:IAutomationObject = objLocator.findAutomationObject(parentLocator);
			assertNotNull(result);
			assertEquals(grandChildOne.id, UIComponent(result).id);
		}
		
		
		public function testShouldLocateChildObjectWhenSpecifyingAParent():void{
			grandChildOne.id = "correctID";
			grandChildOne.automationName = "grandChildOne";
			grandChildTwo.id = "correctID";
			grandChildTwo.automationName = "grandChildTwo";
			
			childOne.id = "childOne";
			childTwo.id = "childTwo";
			
			childOne.addChild(grandChildOne);
			childTwo.addChild(grandChildTwo);
			object.addChild(childOne);
			object.addChild(childTwo);
			
			
			parentLocator["id"] = {id: "childOne"};
			parentLocator["parent"] = null;
			childLocator["id"] = {id: "correctID"};
			childLocator["parent"] = parentLocator;			
						
			mockFlexObjectLocatorUtility.childList = object;
			var result:IAutomationObject = objLocator.findAutomationObject(childLocator);
			assertNotNull(result);
			assertEquals(grandChildOne.automationName, UIComponent(result).automationName);
		}
		
		public function testShouldReturnArrayWhenLocatingIdenticalObjects():void{
			mockHelper = new MockFlexObjectLocatorUtilityHelper();
			
			childOne.id = "correctID";
			childOne.automationName = "childOne";
			
			childTwo.id = "correctID";
			childTwo.automationName = "childTwo";
			
			object.addChildAt(childOne, 0);
			object.addChildAt(childTwo, 1);

			mockFlexObjectLocatorUtility.childList = object;
			
			locator["parent"] = null;
			locator["id"] = {id: "correctID", index: "index:0"};

			mockFlexObjectLocatorUtility.automationId = "index:0"; 
			objLocator.flexObjectLocatorUtility = mockFlexObjectLocatorUtility; 
						
			var result:IAutomationObject = objLocator.findAutomationObject(locator);
			assertNotNull(result);
			assertEquals(childOne.automationName, UIComponent(result).automationName);
		}
		
		public function testShouldFindChildOfOneContainerWhenThereIsOnlyOneChild():void{
			childOne.id = "correctID";
			object.addChild(childOne);
			
			locator["id"] = "correctID";
			
			var result:UIComponent = objLocator.findComponentUsingCustomFramework(locator, object);
			assertNotNull(result);
			assertEquals(childOne.id, result.id);
		}
		
		public function testShouldNotFindChildOfOneContainerWhenThereIsOnlyOneChild():void{
			childOne.id = "correctID";
			object.addChild(childOne);
			
			locator["id"] = "wrongId";
			
			var result:UIComponent = objLocator.findComponentUsingCustomFramework(locator, object);
			assertNull(result);
		}
		
		public function testShouldFindGrandChildOfOneContainer():void{
			grandChildOne.id = "correctID";
			childOne.addChild(grandChildOne);
			object.addChild(childOne);
			
			locator["id"] = "correctID";
			
			var result:UIComponent = objLocator.findComponentUsingCustomFramework(locator, object);
			assertNotNull(result);
			assertEquals(grandChildOne.id, result.id);
		}
		
		public function testShouldChekIfChildHasTheCorrectIDShallReturnTrue():void {
			object.id = "correctID";
			locator["id"] = "correctID";
			
			var result:Boolean = objLocator.childMatch(object, locator);
			assertTrue(result);
		}
		
		public function testShouldChekIfChildHasTheCorrectIDShallReturnFalse():void {
			object.id = "correctID";
			locator["id"] = "wrongId";
			
			var result:Boolean = objLocator.childMatch(object, locator);
			assertFalse(result);
		}
		
		public function testShouldCheckOnMultiplePropertiesAndReturnTrue():void{
			object.id = "correctId";
			object.automationName = "correctAutName";
			locator["id"] = "correctId";
			locator["automationName"] = "correctAutName";
			
			var result:Boolean = objLocator.childMatch(object, locator);
			assertTrue(result);
		}
		
		public function testShouldCheckOnMultiplePropertiesAndReturnFalseWhenOneIsWrong():void{
			object.id = "correctId";
			object.automationName = "wrongAutName";
			locator["id"] = "correctId";
			locator["automationName"] = "correctAutName";
			
			var result:Boolean = objLocator.childMatch(object, locator);
			assertFalse(result);
		} 

	}
}