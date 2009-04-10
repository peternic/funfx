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
 * Translates between internal Flex keyModifiers and automation-friendly ones.
 */
public class KeyModifierPropertyCodec extends DefaultPropertyCodec
{
    /**
     *  Constructor
     */ 
    public function KeyModifierPropertyCodec()
	{
		super();
	}
   
    /**
     *  @private
     */ 
    override public function encode(automationManager:IAutomationManager,
                                    obj:Object, 
                                    pd:IAQPropertyDescriptor,
                                    relativeParent:IAutomationObject):Object
    {
        var val:int = 0;

        if ("ctrlKey" in obj && Boolean(obj["ctrlKey"]))
            val |= (1 << 0);

        if ("shiftKey" in obj && Boolean(obj["shiftKey"]))
            val |= (1 << 1);

        if ("altKey" in obj && Boolean(obj["altKey"]))
            val |= (1 << 2);
            
        return val;
    }

    /**
     *  @private
     */ 
    override public function decode(automationManager:IAutomationManager,
                                    obj:Object, 
                                    value:Object,
                                    pd:IAQPropertyDescriptor,
                                    relativeParent:IAutomationObject):void
    {
        if ("ctrlKey" in obj)
            obj["ctrlKey"] = (uint(value) & (1 << 0)) != 0;

        if ("shiftKey" in obj)
            obj["shiftKey"] = (uint(value) & (1 << 1)) != 0;

        if ("altKey" in obj)
            obj["altKey"] = (uint(value) & (1 << 2)) != 0;
    }
}

}
