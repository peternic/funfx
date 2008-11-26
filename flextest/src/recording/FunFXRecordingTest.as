package recording
{
	import custom.utilities.IFlexObjectLocatorUtilityHelper;
	import custom.utilities.MockFlexObjectLocatorUtilityHelper;
	
	import flexunit.framework.TestCase;
	
	import funfx.recording.FunFXRecording;
	
	import mx.automation.IAutomationManager;
	import mx.automation.events.AutomationRecordEvent;
	import mx.core.UIComponent;
	
	public class FunFXRecordingTest extends TestCase
	{
		private var recorder:FunFXRecording;
		private var mockHelper:IFlexObjectLocatorUtilityHelper;
		private var mockAutomationManager:IAutomationManager;
		
		private var object:UIComponent;
		private var parent:UIComponent;
		private var grandParent:UIComponent;
		private var event:AutomationRecordEvent;
		private var secondEvent:AutomationRecordEvent;
		
		private var CLICK:String = "Click";
		private var INPUT:String = "Input";
		private var DRAG_DROP:String = "DragDrop";
		private var TESTEVENT:String = "TestEvent";
		
		
		override public function setUp():void
		{
			mockHelper = new MockFlexObjectLocatorUtilityHelper();
			recorder = new FunFXRecording();
			recorder.locatorUtility.flexLocatorhelper = mockHelper;
			
			initializeObjects();
		}
		
		private function initializeObjects():void{
			event = new AutomationRecordEvent();
			secondEvent = new AutomationRecordEvent();
			
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
		
		public function testShouldRecordAnObjectWithNoParents():void{
			assertEquals(0, recorder.records.length);
			
			event.automationObject = object;
			event.name = CLICK;
			
			recorder.addRecord(event);
			assertEquals(1, recorder.records.length);
		}
		
		public function testShouldRecordAnObjectWithOneParent():void{
			assertEquals(0, recorder.records.length);
			
			parent.addChild(object);
			
			event.automationObject = object;
			event.name = CLICK;
			
			recorder.addRecord(event);
			assertEquals(1, recorder.records.length);
		}
		
		public function testShouldPrintOneRecordWithoutArgumentsFunFXStyle():void{
			event.automationObject = object;
			event.name = CLICK;
			
			recorder.addRecord(event);
			
			var result:String = recorder.printRecords();
			assertEquals("@flex.u_i_component({:id => 'objectID', :automationName => 'objectAutName'}).click", result);
		}
		
		public function testShouldPrintOneRecordWithArgumentsFunFXStyle():void{
			event.automationObject = object;
			event.name = INPUT;
			event.args = ["This text", true, 1];
			
			recorder.addRecord(event);
			
			var result:String = recorder.printRecords();
			assertEquals("@flex.u_i_component({:id => 'objectID', :automationName => 'objectAutName'}).input('This text', 'true', '1')", result);
		}
		
		public function testShouldPrintOneRecordWithParent():void{
			parent.automationName = "";
			object.automationName = "";
			
			parent.addChild(object);
			
			event.automationObject = object;
			event.name = INPUT;
			event.args = ["This text", true, 1];
			
			recorder.addRecord(event);
			var result:String = recorder.printRecords();
			assertEquals("@flex.u_i_component({:id => 'parentID'}).u_i_component({:id => 'objectID'}).input('This text', 'true', '1')", result);
		}
		
		public function testShouldPrintOneRecordWithGrandParent():void{
			grandParent.automationName = "";
			parent.automationName = "";
			object.automationName = "";
			
			parent.addChild(object);
			grandParent.addChild(parent);
			
			event.automationObject = object;
			event.name = INPUT;
			event.args = ["This text", true, 1];
			
			recorder.addRecord(event);
			var result:String = recorder.printRecords();
			assertEquals("@flex.u_i_component({:id => 'grandParentID'}).u_i_component({:id => 'parentID'}).u_i_component({:id => 'objectID'}).input('This text', 'true', '1')", result);
		}
		
		public function testShouldPrintOneRecordWithGrandParentWhereParentIsNotShownInAutomationHierarchy():void{
			grandParent.automationName = "";
			parent.automationName = "";
			object.automationName = "";
			
			parent.showInAutomationHierarchy = false;
			parent.addChild(object);
			grandParent.addChild(parent);
			
			event.automationObject = object;
			event.name = INPUT;
			event.args = ["This text", true, 1];
			
			recorder.addRecord(event);
			var result:String = recorder.printRecords();
			assertEquals("@flex.u_i_component({:id => 'grandParentID'}).u_i_component({:id => 'objectID'}).input('This text', 'true', '1')", result);
		}
		
		public function testShouldPrintTwoRecords():void{
			parent.automationName = "";
			object.automationName = "";
			
			event.automationObject = object;
			event.name = CLICK;
			secondEvent.automationObject = parent;
			secondEvent.name = DRAG_DROP;
			
			recorder.addRecord(event);
			recorder.addRecord(secondEvent);
			
			var result:String = recorder.printRecords();
			assertEquals("@flex.u_i_component({:id => 'objectID'}).click\n" + 
						 "@flex.u_i_component({:id => 'parentID'}).drag_drop", result);
		}
	}
}