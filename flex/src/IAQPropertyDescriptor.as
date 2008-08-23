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

import mx.automation.IAutomationPropertyDescriptor

/**
 * Describes a property of a test object.
 */
public interface IAQPropertyDescriptor extends IAutomationPropertyDescriptor
{
	/**
	 * Property type as string.
	 */
    function get AQtype():String;

	/**
	 * The codec that should be used for this property.
	 */
    function get codecName():String;

}

}
