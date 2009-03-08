package funfx.log
{
  [Bindable]
  public class LogMessage
  {
    public static var ERROR:String = "ERROR";
    public static var INFO:String = "INFO";
    
    public var type:String;
    public var message:String;
    
    public function LogMessage(type:String, message:String, argMessage:String)
    {
      this.type = type;
      this.message = message;
      this.message += argMessage;
    }

  }
}