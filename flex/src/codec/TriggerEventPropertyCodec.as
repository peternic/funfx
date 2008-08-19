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

import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import IAQPropertyDescriptor;
import mx.automation.IAutomationManager;
import mx.automation.IAutomationObject;

/**
 * Translates between internal Flex triggerEvent property and automation-friendly version
 */
public class TriggerEventPropertyCodec extends DefaultPropertyCodec
{
    public function TriggerEventPropertyCodec()
	{
		super();
	}
	
	override public function encode(automationManager:IAutomationManager,
                                    obj:Object, 
                                    propertyDescriptor:IAQPropertyDescriptor,
                                    relativeParent:IAutomationObject):Object
    {
      var val:Object = getMemberFromObject(automationManager, obj, propertyDescriptor);

       return (val is MouseEvent ? 1 :
                val is KeyboardEvent ? 2 : null); 
    }

    override public function decode(automationManager:IAutomationManager,
                                    obj:Object, 
                                    value:Object,
                                    propertyDescriptor:IAQPropertyDescriptor,
                                    relativeParent:IAutomationObject):void
    {
        obj[propertyDescriptor.name] = 
            (value == 1 ? new MouseEvent(MouseEvent.CLICK) :
             value == 2 ? new KeyboardEvent(KeyboardEvent.KEY_UP) : null);
    }
}

}
