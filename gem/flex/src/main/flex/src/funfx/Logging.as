package funfx
{
  import flash.display.DisplayObject;

  public class Logging
  {
    public static function convertLocator(locator:Object):String {
      
      var result:String = "";
      if (locator.hasOwnProperty("parent")){
        if (locator["parent"] == null)
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
    
    public static function toString(title:String, ... args):String {
      var str:String = title;
      
      for (var i:int = 0; i < args.length; i += 2) {
        str += ("\n\t" + args[i] + ": " + args[i + 1]);
      }
      
      return str;
    }
    
    public static function createComponentText(component:DisplayObject):String {
      if (component == null) return "null";
      var _id:String = createComponentTextHelper(component, "id");
      var _automationName:String = createComponentTextHelper(component, "automationName");
      var _automationValue:String = createComponentTextHelper(component, "automationValue");
      var _className:String = createComponentTextHelper(component, "className");
      
      return "id=" + _id + ", automationName=" + _automationName + ", automationValue=" + _automationValue + ", class=" + _className;
    }
    
    private static function createComponentTextHelper(component:DisplayObject, property:String):String{
      var str:String;

      try{
        str = component.hasOwnProperty(property) ? component[property] : "null";
      }
      catch(e:Error){
        str = "Failed getting property " + property + ": " + e.message;
      }
      
      return str;
    }
    
    private static function createArgumentsText(... args):String {
      var str:String = "";
      for (var i:uint=0; i<args[0].length; i++){
        str += "\n\t" + args[0][i].label + ": " + args[0][i].data;
      }
      return str;
    }
  }
}
