package {
	import custom.utilities.CSVUtilityTest;
	import custom.utilities.FlexObjectLocatorUtilityTest;
	
	import flexlocator.LocatorTest;
	
	import flexunit.framework.TestSuite;
	
	import recording.FunFXRecordingTest;
	
	
	public class FunFxTestSuite extends TestSuite {
		
		public function FunFxTestSuite(param:Object=null)  {
			addTests();
		}
		
		protected function addTests():void {
 	 		addTestSuite(CSVUtilityTest);
 	 		addTestSuite(LocatorTest);
 	 		addTestSuite(FunFXRecordingTest);
 	 		addTestSuite(FlexObjectLocatorUtilityTest);
 		}

	}
}