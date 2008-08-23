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

import flash.events.Event;
import flash.events.FocusEvent;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.system.ApplicationDomain;
import flash.utils.describeType;

import mx.automation.Automation;
import mx.automation.events.AutomationReplayEvent;
import mx.automation.IAutomationObject;
import mx.automation.IAutomationEventDescriptor;
import mx.core.mx_internal;

use namespace mx_internal;

/**
 * Event descriptor class.
 */
public class CustomAutomationEventDescriptor implements IAutomationEventDescriptor
{
	//--------------------------------------------------------------------------
	//
	//  Constructor
	//
	//--------------------------------------------------------------------------

    /**
     *  Constructor
     */
    public function CustomAutomationEventDescriptor(name:String,
                                               eventClassName:String,
                                               eventType:String,
                                               args:Array)
    {
        super();

        _name = name;
        _eventClassName = eventClassName;
        _eventType = eventType;
        _args = args;
    }

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
	 * @private
	 */
    public function get name():String
    {
        return _name;
    }

	//----------------------------------
	//  eventClassName
	//----------------------------------

    /**
     *  @private
     */
    private var _eventClassName:String;

	/**
	 * @private
	 */
    public function get eventClassName():String
    {
        return _eventClassName;
    }
    
	//----------------------------------
	//  eventType
	//----------------------------------

    /**
     *  @private
     */
    private var _eventType:String;

	/**
	 * @private
	 */
    public function get eventType():String
    {
        return _eventType;
    }
    
    //----------------------------------
	//  args
	//----------------------------------
	
     /**
     *  @private
     */
    private var _args:Array;
    
    /**
	 * @private
	 */
    public function get args():Array
    {
        return _args;
    }
    
	//--------------------------------------------------------------------------
	//
	//  Methods
	//
	//--------------------------------------------------------------------------

	/**
	 * @private
	 */
    public function record(target:IAutomationObject, event:Event):Array
    {
		var propertyDescriptors:Array = getArgDescriptors(target);
        
        var result:Array = [];
        var consecutiveDefaultValueCount:Number = 0;
        for (var i:int = 0; i < propertyDescriptors.length; i++)
        {
            var val:Object = event[propertyDescriptors[i].name];
            
            if(val is IAutomationObject)
            	val = IAutomationObject(val).automationValue;
            	
            // Check for the event type
            if(val is KeyboardEvent)
            	val = "KeyBoard";
            
            if(val is MouseEvent)
            	val = "Mouse";

            var isDefaultValueNull:Boolean = propertyDescriptors[i].defaultValue == "null";

            consecutiveDefaultValueCount = (!(val == null && isDefaultValueNull) && 
            								(propertyDescriptors[i].defaultValue == null || 
                                             val == null ||
                                             propertyDescriptors[i].defaultValue != val.toString())
                                            ? 0
                                            : consecutiveDefaultValueCount + 1);

            result.push(val);
        }

        result.splice(result.length - consecutiveDefaultValueCount, 
                      consecutiveDefaultValueCount);

        return result;
    }

    /**
	 * 
     */
    public function replay(target:IAutomationObject, args:Array):Object
    {
        var event:Event = createEvent(target);
        
        var argDescriptors:Array = getArgDescriptors(target);
		
		// set event properties
		for (var argNo:int = 0; argNo < args.length; ++argNo)
			event[argDescriptors[argNo].name] = args[argNo];
        
        var riEvent:AutomationReplayEvent = new AutomationReplayEvent();
		riEvent.automationObject = target;
		riEvent.replayableEvent = event;
        Automation.automationManager.replayAutomatableEvent(riEvent);

        return null;
    }

	/**
	 * @private
	 */
    public function getArgDescriptors(obj:IAutomationObject):Array
    {
       return _args;
    }

    /**
     *  Creates an event based on the class and type described in this
     *  descriptor.
     *  
     *  @param Object An object in whose applicationDomain the required event class
     *                exists. 
     */
    public function createEvent(obj:Object):Event
    {
		var eventClass:Class = 
			CustomAutomationClass.getDefinitionFromObjectDomain(obj, _eventClassName);
		
		return (eventClass == KeyboardEvent 
                ? new KeyboardEvent(KeyboardEvent.KEY_DOWN) 
                : (eventClass == FocusEvent && 
                   _eventType == FocusEvent.KEY_FOCUS_CHANGE
                   // this event is not like the other children.  it needs
                   // to be cancelable.  this should be generalized at some point
                   // because other children may need this attention too.
                   ? new eventClass(_eventType, true, true)
                   : new eventClass(_eventType)));
    }
}

}
