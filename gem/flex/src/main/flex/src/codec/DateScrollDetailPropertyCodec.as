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
 * Translates between internal Flex description of a scroll event 
 * and automation-friendly version
 */
public class DateScrollDetailPropertyCodec extends DefaultPropertyCodec
{
    /**
     *  Constructor
     */ 
    public function DateScrollDetailPropertyCodec()
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
        
        if (!("detail" in obj))
        	return val;

	    switch (obj["detail"])
	    {
		    case "nextMonth": return 1;
		    case "nextYear": return 2;
		    case "previousMonth": return 3;
		    case "previousYear": return 4;
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
    	var details:Array = 
    	[
	    "nextMonth", "nextYear", "previousMonth", "previousYear"
	    ];
        	
        if ("detail" in obj && value < details.length)
	        obj["detail"] = details[Number(value)-1];
    }
}

}
