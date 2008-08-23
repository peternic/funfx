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
 * Translates between internal Flex ScrollEvent direction and automation-friendly version
 */
public class ScrollDirectionPropertyCodec extends DefaultPropertyCodec
{
    /**
     *  Constructor
     */
    public function ScrollDirectionPropertyCodec()
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
		
		if (!("direction" in obj))
			return val;

	    switch (obj["direction"])
	    {
		    case "horizontal" : return 1;
		    case "vertical" : return 2;
	    }
	    
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
    	var directions:Array = 
    	[ "horizontal", "vertical" ];
        	
        if ("direction" in obj && value > 0 && value <= directions.length)
	        obj["direction"] = directions[uint(value)-1];
    }
}

}
