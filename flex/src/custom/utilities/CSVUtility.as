package custom.utilities {
  import mx.controls.Alert;
  
	public class CSVUtility {
		private static const FIELD_DELIMITER:String = ',';
		private static const FIELD_ENCLOSURE:String = '"';
		private static const RECORD_DELIMITER:String = '\r';
		
		public static function encode(records:Array):String {
			var encodedRecords:String = '';
			for each (var record:Array in records) {
				var encodedRecord:Array = [];
				for each (var field:* in record) {
				  var encodedField:String = FIELD_ENCLOSURE + field + FIELD_ENCLOSURE;
				  encodedRecord.push(encodedField);
				}
				
				encodedRecords += encodedRecord.join(FIELD_DELIMITER) + RECORD_DELIMITER;
			}
			
			return encodedRecords;
		}

	}
}