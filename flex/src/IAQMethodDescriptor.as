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

import mx.automation.IAutomationMethodDescriptor;

/**
 *  Defines the interface for a method descriptor.
 */
public interface IAQMethodDescriptor extends IAutomationMethodDescriptor
{
    /**
     *  Returns the codec name for the return value of this method
     */
    function get codecName():String;

}

}
