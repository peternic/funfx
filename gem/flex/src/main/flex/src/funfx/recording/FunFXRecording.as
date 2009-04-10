package funfx.recording
{
	import custom.utilities.FlexObjectLocatorUtility;
	
	import funfx.model.FunFXRecordedCommand;
	
	import mx.automation.events.AutomationRecordEvent;
	import mx.collections.ArrayCollection;
	import mx.core.UIComponent;
	
	public class FunFXRecording
	{
		public var locatorUtility:FlexObjectLocatorUtility;
		public var records:ArrayCollection;
		
		public function FunFXRecording()
		{
			records = new ArrayCollection();
			locatorUtility = new FlexObjectLocatorUtility();
		}
		
		public function addRecord(event:AutomationRecordEvent):void{
			if(event.automationObject == null || event.name == "") return;
    	var locator:Object = locatorUtility.createLocatorFromRecording(event.automationObject as UIComponent);
    	records.addItem(new FunFXRecordedCommand(locator, event.name, event.args));
    }
	    
		public function printRecords():String{
			var testCase:String = "";
			var counter:int = 0;
			for each(var record:FunFXRecordedCommand in records){
				testCase += "@flex";
				testCase += printLocator(record.locator);
				testCase += "." + changeName(record.eventName);
				testCase += printRecordArguments(record.args);
				if(++counter < records.length)
					testCase += "\n";
			}
			return testCase;
		}
		
		private function printLocator(locator:Object):String{
			if(locator)
				return printLocator(locator["parent"]) + "." + changeName(locator["className"]) + printProperties(locator["id"]) ;
			else return "";
		}
		
		private function printProperties(locator:Object):String{
			var print:String = "";
			print += printProperty(locator, "id", (print == ""));
			print += printProperty(locator, "automationName", (print == ""));
			print += printProperty(locator, "automationIndex", (print == ""));
			print += printProperty(locator, "automationValue", (print == ""));
			return "({" + print + "})";
		}
		
		private function printProperty(locator:Object, locatorName:String, first:Boolean):String{
			var print:String = "";
			if(locator[locatorName] && locator[locatorName] != ""){
				if(!first)
					print += ", ";
				print += ":" + locatorName + " => '" + locator[locatorName] + "'";
			}
			return print;
		}
		
		private function changeName(name:String):String{
			name = name.replace(/([a-z]*)([A-Z])/g, "$1_$2");
			name = name.toLowerCase();
			return name.substr(1, name.length);
		}
		
	  private function printRecordArguments(args:Array):String{
		  if(args == null || args.length == 0) return "";
		  var str:String = "('" + args[0] + "'";
		  for(var i:int=1; i<args.length; i++){
		  	str += ", " + "'" + args[i] + "'";
		  }
		  str += ")";
		  return str;
	  }

	}
}