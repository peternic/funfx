package custom.utilities {
  import mx.core.ByteArrayAsset;

  public class XMLUtility {

    public static function buildFromByteStream(xmlStream:Class):XML {
      var ba:ByteArrayAsset = ByteArrayAsset(new xmlStream());
      return new XML(ba.readUTFBytes(ba.length));
    }

  }
}