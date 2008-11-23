package funfx.recording
{
	import custom.utilities.FlexObjectLocatorUtility;
	
	import funfx.model.FunFXRecordedCommand;
	
	import mx.automation.events.AutomationRecordEvent;
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
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
			var print:String = "({";
			var idBoolean:Boolean = false;
			var automationNameBoolean:Boolean = false;
			if(locator["id"] && locator["id"] != ""){
				idBoolean = true;
				print += ":id => '" + locator["id"] + "'";
			}
			if(locator["automationName"] && locator["automationName"] != ""){
				automationNameBoolean = true;
				if(idBoolean)
					print += ", ";
				print += ":automationName => '" + locator["automationName"] + "'";
			}
			if(locator["index"] && locator["index"] != "" && locator["index"] != "index:-1"){
				if(idBoolean && automationNameBoolean)
					print += ", ";
				print += ":index => '" + locator["index"] + "'";
			}
				
			print += "})";
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