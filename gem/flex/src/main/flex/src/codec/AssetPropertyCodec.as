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
 * translates between internal Flex asset and automation-friendly version
 */
public class AssetPropertyCodec extends DefaultPropertyCodec
{

	//--------------------------------------------------------------------------
	//
	//  Constructor
	//
	//--------------------------------------------------------------------------

    public function AssetPropertyCodec()
	{
		super();
	}
   
	//--------------------------------------------------------------------------
	//
	//  Overridden methods
	//
	//--------------------------------------------------------------------------

    override public function encode(automationManager:IAutomationManager,
                                    obj:Object, 
                                    pd:IAQPropertyDescriptor,
                                    relativeParent:IAutomationObject):Object
    {
        var val:Object = getMemberFromObject(automationManager, obj, pd);

		if (val != null)
		{
	        val = val.toString();
	            
	        val = stripNoiseFromString("css_", String(val));
	        val = stripNoiseFromString("embed_mxml_", String(val));
	        val = stripNoiseFromString("embed_as_", String(val));
		}
        
        return val;
    }

    protected function stripNoiseFromString(beginPart:String, asset:String):String
    {
	    var pos:int = asset.indexOf(beginPart);

	    if (pos != -1)
	    {
	        asset = asset.substr(pos + beginPart.length);
	        
	        var lastUnderscorePos:int = asset.lastIndexOf("_");
	        
	        if (lastUnderscorePos != -1)
	        {
	            asset = asset.substr(0, lastUnderscorePos);
	        }
	    }
	    
	    return asset;
    }

    override public function decode(automationManager:IAutomationManager,
                                    obj:Object, 
                                    value:Object,
                                    pd:IAQPropertyDescriptor,
                                    relativeParent:IAutomationObject):void
    {
        throw new Error("Resource is not Settable");
    }
}

}
