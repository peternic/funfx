package {
	import flexunit.framework.TestSuite;
	import custom.utilities.CSVUtilityTest;
	
	public class FunFxTestSuite extends TestSuite {
		
		public function FunFxTestSuite(param:Object=null)  {
			addTests();
		}
		
		protected function addTests():void {
 	 		addTestSuite(CSVUtilityTest);
 		}

	}
}