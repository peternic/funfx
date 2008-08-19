////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2003-2007 Adobe Systems Incorporated and its licensors.
//  All Rights Reserved. The following is Source Code and is subject to all
//  restrictions on such code as contained in the End User License Agreement
//  accompanying this product.
//
////////////////////////////////////////////////////////////////////////////////

package codec
{

import IAQPropertyDescriptor;
import mx.automation.IAutomationManager;
import mx.automation.IAutomationObject;
import mx.resources.ResourceBundle;

/**
 * Translates between internal Flex date range and automation-friendly version
 */
public class DateRangePropertyCodec extends DefaultPropertyCodec
{
	//--------------------------------------------------------------------------
	//
	//  Constructor
	//
	//--------------------------------------------------------------------------

    /**
     *  Constructor
     */ 
    public function DateRangePropertyCodec()
	{
		super();
	}
   
	//--------------------------------------------------------------------------
	//
	//  Overridden methods
	//
	//--------------------------------------------------------------------------

    /**
     *  @private
     */ 
    override public function encode(automationManager:IAutomationManager,
                                    obj:Object, 
                                    propertyDescriptor:IAQPropertyDescriptor,
                                    relativeParent:IAutomationObject):Object
    {
        var val:Object = getMemberFromObject(automationManager, obj, propertyDescriptor);
		var encodedDate:String = "";

        if (val != null)
        {
        	if (val is Date)
        	{
	            encodedDate = (val as Date).toLocaleDateString();
        	}
        	else if (val is Object)
        	{
	        	if ("rangeStart" in val)
            encodedDate = (val.rangeStart as Date).toLocaleDateString();
            encodedDate += " => "
            	if ("rangeEnd" in val)
            encodedDate += (val.rangeEnd as Date).toLocaleDateString();
        }
        }
        
        return encodedDate;
    }

    /**
     *  @private
     */ 
    override public function decode(automationManager:IAutomationManager,
                                    obj:Object, 
                                    value:Object,
                                    propertyDescriptor:IAQPropertyDescriptor,
                                    relativeParent:IAutomationObject):void
    {
        throw new Error("Resource not Settable");
    }
}

}
