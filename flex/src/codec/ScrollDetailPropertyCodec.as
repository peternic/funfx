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
 * Translates between internal Flex ScrollEvent detail and automation-friendly version
 */
public class ScrollDetailPropertyCodec extends DefaultPropertyCodec
{
    /**
     *  Constructor
     */ 
    public function ScrollDetailPropertyCodec()
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
	    	//ScrollEvent.detail 
		    case "atBottom" : return 1;
		    case "atLeft" : return 2;
		    case "atRight" : return 3;
		    case "atTop" : return 4;
		    case "lineDown" : return 5;
		    case "lineLeft" : return 6;
		    case "lineRight" : return 7;
		    case "lineUp" : return 8;
		    case "pageDown" : return 9;
		    case "pageLeft" : return 10;
		    case "pageRight" : return 11;
		    case "pageUp" : return 12;
		    case "thumbPosition" : return 13;
		    case "thumbTrack" : return 14;
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
	    "atBottom", "atLeft", "atRight", "atTop", "lineDown",
	    "lineLeft", "lineRight", "lineUp", "pageDown",
	    "pageLeft", "pageRight", "pageUp", "thumbPosition",
	    "thumbTrack",
	    ];
        	
        if ("detail" in obj && value > 0 && value <= details.length)
	        obj["detail"] = details[uint(value)-1];
    }
}

}
