////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2003-2007 Adobe Systems Incorporated and its licensors.
//  All Rights Reserved. The following is Source Code and is subject to all
//  restrictions on such code as contained in the End User License Agreement
//  accompanying this product.
//
////////////////////////////////////////////////////////////////////////////////

package custom
{
import flash.display.DisplayObject;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.system.ApplicationDomain;
import flash.utils.describeType;
import flash.utils.getQualifiedClassName;
import mx.utils.ObjectUtil;
import mx.automation.IAutomationClass;
import mx.automation.IAutomationMethodDescriptor;
import mx.automation.IAutomationEventDescriptor;
import mx.automation.IAutomationPropertyDescriptor;

/**
 * Provides serializable class information for external automation tools.
 * Some classes are represented as the same AutomationClass (HSlider and VSlider, forinstance).
 */

public class CustomAutomationClass implements IAutomationClass
{
	//--------------------------------------------------------------------------
	//
	//  Constructor
	//
	//--------------------------------------------------------------------------

    public function CustomAutomationClass(name:String, superClassName:String = null)
    {
		super();

        _name = name;
        _superClassName = superClassName;
    }

	//--------------------------------------------------------------------------
	//
	//  Variables
	//
	//--------------------------------------------------------------------------

    /**
	 *  @private
	 */
    private var _implementationClassNames:Array = [];
    
    /**
	 *  @private
	 */
	private var _properties:Array = [];
	
    /**
	 *  @private
	 */
	private var _verificationProperties:Array = [];
	
    /**
	 *  @private
	 */
	private var _descriptionProperties:Array = [];
	
    /**
	 *  @private
	 */
	private var _event2descriptor:Object = {};
    
    /**
	 *  @private
	 */
	private var _method2descriptor:Object = {};
    
    /**
	 *  @private
	 */
	private var _propertyASTypesInitialized:Boolean = false;

	//--------------------------------------------------------------------------
	//
	//  Properties
	//
	//--------------------------------------------------------------------------

	//----------------------------------
	//  name
	//----------------------------------

    /**
	 *  @private
	 */
    private var _name:String;

    /**
	 * the class name
	 */
    public function get name():String
    {
        return _name;
    }

	//----------------------------------
	//  superClassName
	//----------------------------------

    /**
	 *  @private
	 */
    private var _superClassName:String;

    /**
	 * The name of the class's superclass.
	 */
    public function get superClassName():String
    {
        return _superClassName;
    }
    
    /**
	 *  @private
	 *  A map of property name to property descriptor.
	 *  Useful in getting the descriptor based on property names.
	 */
	private var _propertyNameMap:Object = {};
 
	//--------------------------------------------------------------------------
	//
	//  Methods
	//
	//--------------------------------------------------------------------------

    /**
	 * The list of the Flex classes that implement this automation class
	 *
	 * @param className the name of the Flex class
	 */
    public function addImplementationClassName(className:String):void
    {
        _implementationClassNames.push(className);
    }

    /**
	 * Indicates that this class has the specified property
	 */
    public function addPropertyDescriptor(p:IAutomationPropertyDescriptor):void
    {
        _properties.push(p);
        if (p.forVerification)
	        _verificationProperties.push(p);
	    
	    if (p.forDescription)
	      	_descriptionProperties.push(p);
	            	
	    _propertyNameMap[p.name] = p;
    }

    /**
	 *  Returns the list of properties this class supports
	 * 
	 *  @param objForInitialization Object which can be used to find ActionScript type of 
	 *  the properties.
	 * 
	 *  @param forVerification Indicates whether properties used for verfication
	 *  should be included or not. Default value is <code>true<code>
	 * 
	 *  @param forDescription Indicates whether properties used for object identitication
	 *  should be included or not. Default value is <code>true<code>
	 * 
	 *  @return Array containing property descriptions.
	 */
    public function getPropertyDescriptors(objForInitialization:Object = null,
                                           forVerification:Boolean = true,
                                           forDescription:Boolean = true):Array
    {
		var result:Array = [];
        if (forVerification && forDescription)
        	result = _properties;
        else if (forVerification)
        	result = _verificationProperties;
        else if (forDescription)
        	result = _descriptionProperties;
        	
       	return result;
    }
    
    /**
	 * @private
	 */
	public function addMethod(m:IAutomationMethodDescriptor):void
    {
        var hash:String = m.name;
                            
        _method2descriptor[hash] = m;
    }

    /**
	 * @private
	 */
	public function addEvent(m:IAutomationEventDescriptor):void
    {
        var hash:String = hash(m.eventClassName, m.eventType);
                            
        _event2descriptor[hash] = m;
    }

    /**
     *  Translates between component event and Automation method descriptor
     *
     *  @param event The event object for which a method descrptor is required.
	 *
     *  @return The method descriptor for the event passed if one is available. 
     *          Otherwise null.
     */
    public function getDescriptorForEvent(
						event:Event):IAutomationEventDescriptor
    {
        var eventType:String = event.type;
        if (event is KeyboardEvent)
            eventType = "keyPress";
        var eventClassName:String = getClassName(event);
        var hash:String = hash(eventClassName, eventType);
        return hash in _event2descriptor ? _event2descriptor[hash] : null;
    }

     /**
      * Returns a full methodDescriptor from its name
      *
      *  @param methodName The method name for which the descriptor is required.
      *
      *  @return The method descriptor for the name passed if one is available. 
      *          Otherwise null.
      */
    public function getDescriptorForMethodByName(
						methodName:String):IAutomationMethodDescriptor
    {
        for (var i:Object in _method2descriptor)
        {
            if (_method2descriptor[i].name == methodName)
                return _method2descriptor[i];
        }

        return null;
    }

    public function getDescriptorForEventByName(
						eventName:String):IAutomationEventDescriptor
    {
        for (var i:Object in _event2descriptor)
        {
            if (_event2descriptor[i].name == eventName)
                return _event2descriptor[i];
        }

        return null;
    }
    
    /**
	 * Returns the fully qualified name of the class to which the object belongs.
	 *  
	 * @param obj The object whose class name is desired
	 * 
	 * @return Fully qualified name of the class
	 * 
	 */
    public static function getClassName(obj:Object):String
    {
        return getQualifiedClassName(obj).replace("::", ".");
    }

    /**
     *  Utility function that returns the class definition from the domain of a
     *  object instance
     */
    public static function getDefinitionFromObjectDomain(obj:Object, className:String):Class
    {
		var eventClass:Class ;
		try
		{
			eventClass = Class(ApplicationDomain.currentDomain.getDefinition(className));
		}
		catch(e:Error)
		{
			// we can get a reference or security exception
			// in which case we try to access the objects own domain
			try
			{
				var dispObj:DisplayObject = obj as DisplayObject;
				eventClass = Class(dispObj.root.loaderInfo.applicationDomain.getDefinition(className));
			}
			catch(e:Error)
			{
				// we can get a reference or security exception

				// In this case we assume that the class definition is not available
				// as the class has not been referenced in the app and it has 
				// not been linked in.
			}
		}

		return eventClass;		
    }

    /**
     *  Puts an event in string form for hashing
     */
    private static function hash(eventClassName:String, eventType:String):String
    {
        return eventClassName.replace("::", ".") + "|" + eventType;
    }
    
    /**
     * private
     */
    public function get propertyNameMap():Object
    {
    	return _propertyNameMap;
    }

    /**
     *  @return name, superClassName, and event/method mappings.
     */
    public function toString():String
    {
        return "name: " + _name + "\n" +
               "superClassName: " + _superClassName + "\n" +
               "event2descriptor: " + ObjectUtil.toString(_event2descriptor);
    }
}

}
