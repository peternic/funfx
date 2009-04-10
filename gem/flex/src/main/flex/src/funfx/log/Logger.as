package funfx.log
{
  import flash.display.DisplayObject;
  
  import mx.collections.ArrayCollection;
  
  [Bindable]
  public class Logger
  {
    private static var messages:ArrayCollection = new ArrayCollection();
    
    public static function addInfo(message:String, ... args):void{
        var logMessage:LogMessage = new LogMessage(LogMessage.INFO, message, createArgumentsText(args));
        messages.addItem(logMessage);
    }
    
    public static function addError(message:String, ... args):void{
        var logMessage:LogMessage = new LogMessage(LogMessage.ERROR, message, createArgumentsText(args));
        messages.addItem(logMessage);
    }
    
    public static function printLog():String{
      var result:String = new String();
      for each(var message:LogMessage in messages){
        result += message.type + ": " + message.message + "\n";
      }
      return result;
    }
    
    public static function convertLocator(locator:Object):String{
      
      var result:String = "";
      if(locator.hasOwnProperty("parent")){
        if(locator["parent"] == null)
          result += "{parent: null, id: " + convertLocator(locator["id"]) + "}";
        else
          result += "{parent: " + convertLocator(locator["parent"]) + ", id: " + convertLocator(locator["id"]) + "}";
      } else {
        result += "{";
        for (var property:String in locator) {
          result += property + ": '" + locator[property] + "'";
        }
        result += "}";
      }
      result += "";
      return result;
    }
    
    public static function createComponentText(component:DisplayObject):String{
      if(component == null) return "null";
    var _id:String = createComponentTextHelper(component, "id");
    var _automationName:String = createComponentTextHelper(component, "automationName");
    var _automationValue:String = createComponentTextHelper(component, "automationValue");
    var _className:String = createComponentTextHelper(component, "className");
      
      return "id=" + _id + ", automationName=" + _automationName + ", automationValue=" + _automationValue + ", class=" + _className;
    }
    
    private static function createComponentTextHelper(component:DisplayObject, property:String):String{
      try{
       return component.hasOwnProperty(property) ? component[property] : "null";
      }
      catch(e:Error){
        return "Failed getting property " + property;
      }
      finally{
        return "Failed getting property " + property;
      }
    }
    
    public static function clear():void{
      messages.removeAll();
    }
    
    private static function createArgumentsText(... args):String{
      var str:String = "";
      for (var i:uint=0; i<args[0].length; i++){
          str += "\n\t" + args[0][i].label + ": " + args[0][i].data;
      }
      return str;
    }
    
    
  }
}