
public class SimpleClassWithGetMethod extends SimpleClass {
  private var testProperty : Boolean;
  
  [Bindable] public var publicProperty  : String = "Test";
  
  public function get testProperty():Boolean {
    return true;
  }
}