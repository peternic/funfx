package funfx.flexlocator {
  import custom.utilities.IFlexObjectLocatorUtility;

  import flash.display.DisplayObject;

  import mx.logging.ILogger;
  import mx.logging.Log;

  import funfx.Logging;

  import mx.core.IChildList;
  import mx.core.UIComponent;

  public class FlexObjectLocator {
    private var log:ILogger = Log.getLogger("funfx.FlexObjectLocator");
    public var flexObjectLocatorUtility:IFlexObjectLocatorUtility;

    public function FlexObjectLocator() {}

    public function findAutomationObject(locator:Object) : * {
      log.debug(Logging.toString("Starting locating element", "Locator", Logging.convertLocator(locator)));

      return findComponentWith(locator["id"], findAutomationParent(locator["parent"]) as UIComponent);
    }

    public function findAutomationParent(locator:Object):UIComponent{
      try {
        if (locator)
          return findComponentWith(locator["id"], findAutomationParent(locator["parent"]) as UIComponent);
        else
          return null;
      } catch (e:Error) {
        log.error(Logging.toString("FunFX failed", "Error", e.message, "Stacktrace", e.getStackTrace()));
        throw e;
      } 
      return null;
    }

    /**
     * From FlexMonkey source
     *
     * Find the first component with the specified property/value pair. If a container is specified, then
     * only its children and descendents are searched. The search order is (currently) indeterminate. If no container is specified,
     * then all components will be searched.
     */
    public function findComponentWith(locator:Object, container:UIComponent):UIComponent {
      var childContainer:IChildList = (container == null) ?
        flexObjectLocatorUtility.getApplicationChildren() :
        container;

      var numChildren:int = getNumberOfChildren(childContainer);

      log.debug(Logging.toString("Locating element", 
                                "Locator", Logging.convertLocator(locator), 
                                "Container", Logging.createComponentText(container), 
                                "Children", numChildren));

      if (numChildren == 0) {
        return null;
      }
      for (var i:int=0; i < numChildren; i++) {
        var child:DisplayObject = getChild(childContainer, i);

        if (!(child is UIComponent)) {
          continue;
        }

        if (childMatch(DisplayObject(child), locator)) {
          return UIComponent(child);
        }

        var grandChild:UIComponent = findComponentWith(locator, UIComponent(child));
        if (grandChild != null) {
          return grandChild;
        }
      }
      return null;
    }

    public function getNumberOfChildren(container:IChildList):int{
      if (container is UIComponent)
        return UIComponent(container).numAutomationChildren != 0 ? UIComponent(container).numAutomationChildren : UIComponent(container).numChildren;
      else
        return container.numChildren;
    }

    public function getChild(container:IChildList, position:int):DisplayObject{
      if (container is UIComponent)
        return UIComponent(container).numAutomationChildren != 0 ? (UIComponent(container).getAutomationChildAt(position) as DisplayObject) : container.getChildAt(position);
      else
        return container.getChildAt(position);
    }


    public function childMatch(child:DisplayObject, locator:Object):Boolean {
      log.debug(Logging.toString("Child match", "Locator", Logging.convertLocator(locator), "Child", Logging.createComponentText(child)));

      var indexValue:String = "";
      for (var property:String in locator) {
        var value:String = decodeURIComponent(locator[property]);

        if (property == "automationIndex"){
          indexValue = value;
        } else {
          if (!child.hasOwnProperty(property) || trim(child[property]) != trim(value)){
            log.debug(Logging.toString("NO MATCH", "Locator", Logging.convertLocator(locator), "Child", Logging.createComponentText(child)));
            log.debug(Logging.toString("NO MATCH II", "Property", property, "HasOwnProperty", child.hasOwnProperty(property)));
            if (child.hasOwnProperty(property)){
              log.debug(Logging.toString("NO MATCH III", 
                                        "Child[property]", trim(child[property]), 
                                        "Value", value, 
                                        "Comparison", (child[property] == value)));
              log.debug(Logging.toString("NO MATCH IV", 
                                        "Child[property].length", trim(child[property]) != null ? trim(child[property]).length : "null", 
                                        "Value.length", value.length));
            } else {
              log.debug(Logging.toString("NO MATCH V", "Value", value));
            }
              
            return false;
          }
        }
      }
      if (indexValue != ""){
        return checkIndex(child, indexValue);
      }
      else {
        log.debug(Logging.toString("MATCH", "Locator", Logging.convertLocator(locator), "Child", Logging.createComponentText(child)));
        
        return true;
      }
    }

    public function toString(locator:Object):String {
      var result:String = "{";
      for (var property:String in locator) {
        var value:String = decodeURIComponent(locator[property]);
        if (result != "{") result += ", ";
        result += ":" + property + " => '" + value + "'"; 
      }
      result += "}";
      return result;
    }

    private function checkIndex(child:DisplayObject, value:String):Boolean {
      var index:String = flexObjectLocatorUtility.createAutomationID(child as UIComponent);
      log.debug(Logging.toString("Check index", "Actual index", index, "Provided index", value, "Child", Logging.createComponentText(child)));
      return index == value;
    }

    private function trim(str:String):String {
      if (str == null) return str;
      for(var i:uint = 0; str.charCodeAt(i) < 33; i++);
      for(var j:uint = str.length-1; str.charCodeAt(j) < 33; j--);
      return str.substring(i, j+1);
    }
  }
}
