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
import flash.system.ApplicationDomain;
import flash.utils.describeType;
import mx.automation.IAutomationManager;
import mx.automation.IAutomationMethodDescriptor;
import mx.automation.IAutomationObject;
import mx.core.mx_internal;

use namespace mx_internal;

/**
 * Method descriptor class.
 */
public class CustomAutomationMethodDescriptor implements IAutomationMethodDescriptor
{
	//--------------------------------------------------------------------------
	//
	//  Constructor
	//
	//--------------------------------------------------------------------------

    /**
     * 
     */
    public function CustomAutomationMethodDescriptor(name:String,
                                                      asMethodName:String,
                                                      returnType:String,
                                                      args:Array)
    {
        super();

        _name = name;
        _asMethodName = asMethodName;
        _returnType = returnType;
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
     *
     */
    public function get name():String
    {
        return _name;
    }

	//----------------------------------
	//  returnType
	//----------------------------------

    /**
     *  @private
     */
    private var _returnType:String;

    /**
     *
     */
    public function get returnType():String
    {
        return _returnType;
    }
    
    //----------------------------------
	//  asMethodName
	//----------------------------------
	
    /**
     *  @private
     */
    private var _asMethodName:String;
    
    //----------------------------------
	//  args
	//----------------------------------
	
    /**
     *  @private
     */
	private var _args:Array;

	//--------------------------------------------------------------------------
	//
	//  Methods
	//
	//--------------------------------------------------------------------------

    /**
     *
     */
    public function record(target:IAutomationObject, event:Event):Array
    {
        // No support to record a method.
        throw new Error();
    }

    /**
     *
     */
    public function replay(target:IAutomationObject, args:Array):Object
    {
        var f:Function = Object(target)[_asMethodName];
        var retVal:Object = f.apply(target, args);
		return retVal;
    }

    /**
     *
     */
    public function getArgDescriptors(obj:IAutomationObject):Array
    {
       return _args;
    }
}

}
