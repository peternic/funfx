////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2003-2007 Adobe Systems Incorporated and its licensors.
//  All Rights Reserved. The following is Source Code and is subject to all
//  restrictions on such code as contained in the End User License Agreement
//  accompanying this product.
//
////////////////////////////////////////////////////////////////////////////////

package 
{

import flash.events.Event;
import flash.system.ApplicationDomain;
import flash.utils.describeType;

import custom.CustomAutomationMethodDescriptor;

import mx.automation.Automation;
import mx.automation.IAutomationManager;
import mx.automation.IAutomationMethodDescriptor;
import mx.automation.IAutomationObject;

import mx.core.mx_internal;
import IAQCodecHelper;

use namespace mx_internal;

/**
 * Basic method descriptor class. Generates descriptor from event parameters, if necessary
 */
public class AQMethodDescriptor extends CustomAutomationMethodDescriptor
	   implements IAQMethodDescriptor
{
	//--------------------------------------------------------------------------
	//
	//  Constructor
	//
	//--------------------------------------------------------------------------

    /**
     * 
     */
    public function AQMethodDescriptor(name:String,
                                                      asMethodName:String,
                                                      returnType:String,
                                                      codecName:String,
                                                      args:Array)
    {
        super(name, asMethodName, returnType, args);
        _codecName = codecName;
    }

	//--------------------------------------------------------------------------
	//
	//  Variables
	//
	//--------------------------------------------------------------------------

	//--------------------------------------------------------------------------
	//
	//  Properties
	//
	//--------------------------------------------------------------------------

	//----------------------------------
	//  codecName
	//----------------------------------

    /**
     *  @private
     */
    private var _codecName:String;

    /**
     *  @private
     */
    public function get codecName():String
    {
        return _codecName;
    }

	//--------------------------------------------------------------------------
	//
	//  Methods
	//
	//--------------------------------------------------------------------------

    /**
     *
     */
    override public function record(target:IAutomationObject, event:Event):Array
    {
        // Unsupported to record a method.
        throw new Error();
        return null;
    }

    /**
     *
     */
    override public function replay(target:IAutomationObject, args:Array):Object
    {
    	var delegate:IAutomationObject = target;
        var argDescriptors:Array = getArgDescriptors(delegate);
        var asArgs:Object = {};

		var helper:IAQCodecHelper = AQAdapter.getCodecHelper();
        helper.decodeProperties(asArgs, args, argDescriptors, delegate);

		// Convert args into an ordered array.
		var asArgsOrdered:Array = [];
		for (var argNo:int = 0; argNo < argDescriptors.length; ++argNo)
			asArgsOrdered.push(asArgs[argDescriptors[argNo].name]);
			
		var retVal:Object = super.replay(target, asArgsOrdered);

        return helper.encodeValue(retVal, returnType, _codecName, delegate);
    }

}

}
