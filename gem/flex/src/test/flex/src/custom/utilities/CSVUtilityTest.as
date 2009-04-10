package custom.utilities {
	import com.blchq.unit.TestCaseExt;
	
	public class CSVUtilityTest extends TestCaseExt {
		public override function defineTests():void {
			describe('encode', function():void {
				it('should return empty if there are no records to encode', function():void {
					assertEquals('', CSVUtility.encode([]));
				});

				it('should encode records', function():void {
					var field1:String = "field1";
					var field2:String = "field2";
					
					var fields:Array = [field1, field2];
					var records:Array = [fields];
					
					var expected:String = '"' + field1 + '","' + field2 + '"\r';
					assertEquals(expected, CSVUtility.encode(records));
				});

				it('should encode records with fields containing commas', function():void {
					var field1:String = "field1";
					var field2:String = "field,2";
					
					var fields:Array = [field1, field2];
					var records:Array = [fields];
					
					var expected:String = '"' + field1 + '","' + field2 + '"\r';
					assertEquals(expected, CSVUtility.encode(records));
				});
			});
		}
	}
}