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

/**
 * Translates between internal Flex color and automation-friendly version
 */
public class ColorPropertyCodec extends DefaultPropertyCodec
{
    /**
     * Constructor
     */
    public function ColorPropertyCodec()
	{
		super();
	}
   
    /**
     * @private
     */
    override public function encode(automationManager:IAutomationManager,
                                    obj:Object, 
                                    propertyDescriptor:IAQPropertyDescriptor,
                                    relativeParent:IAutomationObject):Object
    {
        var val:Object = getMemberFromObject(automationManager, obj, propertyDescriptor);

        if (val != null)
        {
            val = Number(val).toString(16);
            while (val.length != 6)
            {
                val = "0" + val;
            }
            val = "#" + val;
        }
        
        return val;
    }

    /**
     * @private
     */
    override public function decode(automationManager:IAutomationManager,
                                    obj:Object, 
                                    value:Object,
                                    propertyDescriptor:IAQPropertyDescriptor,
                                    relativeParent:IAutomationObject):void
    {
        obj[propertyDescriptor.name] = parseInt(String(value).substring(1), 16).toString();
    }
}

}
