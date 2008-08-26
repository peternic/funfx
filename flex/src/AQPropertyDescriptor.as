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

import custom.CustomAutomationPropertyDescriptor;

/**
 * Describes a property of a test object.
 */
public class AQPropertyDescriptor extends CustomAutomationPropertyDescriptor implements IAQPropertyDescriptor
{
	/**
	 * @private
	 */
    private var _type:String;

	/**
	 * @private
	 */
    private var _codecName:String;

    /**
     *  Constructor
     */
    public function AQPropertyDescriptor(name:String,
                                                 forDescription:Boolean,
                                                 forVerification:Boolean,
                                                 type:String,
                                                 codecName:String,
                                                 defaultValue:String = null)
    {
        super(name, forDescription, forVerification, defaultValue);
        _type = type;
        _codecName = codecName;
    }

	/**
	 * @private
	 */
    public function get AQtype():String
    {
        return _type;
    }

	/**
	 * @private
	 */
    public function get codecName():String
    {
        return _codecName;
    }

}

}
