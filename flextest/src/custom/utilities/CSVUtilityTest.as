package custom.utilities {
	import flexunit.framework.Assert;
	import flexunit.framework.TestCase;
	
	public class CSVUtilityTest extends TestCase {
		
		public function testShouldReturnEmptyIfThereAreNoRecordsToEncode():void {
			Assert.assertEquals('', CSVUtility.encode([]));
		}
		
		public function testShouldEncodeRecords():void {
			var field1:String = "field1";
			var field2:String = "field2";
			
			var fields:Array = [field1, field2];
			var records:Array = [fields];
			
			var expected:String = '"' + field1 + '","' + field2 + '"\r';
			Assert.assertEquals(expected, CSVUtility.encode(records));
		}
		
		public function testShouldEncodeRecordsWithFieldsContainingCommas():void {
			var field1:String = "field1";
			var field2:String = "field,2";
			
			var fields:Array = [field1, field2];
			var records:Array = [fields];
			
			var expected:String = '"' + field1 + '","' + field2 + '"\r';
			Assert.assertEquals(expected, CSVUtility.encode(records));
		}

	}
}