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

import mx.automation.Automation;
import AQPropertyDescriptor;
import IAQPropertyDescriptor;
import mx.automation.IAutomationManager;
import mx.automation.IAutomationObject;

/**
 * translates between internal Flex array and automation-friendly version
 */
public class ArrayPropertyCodec extends DefaultPropertyCodec
{
    private var arrayTypeCodec:IAutomationPropertyCodec;
    
    /**
     * Constructor
     */ 
    
    public function ArrayPropertyCodec(arrayTypeCodec:IAutomationPropertyCodec)
    {
		super();

        this.arrayTypeCodec = arrayTypeCodec;
    }

    override public function encode(automationManager:IAutomationManager,
                                    obj:Object, 
                                    pd:IAQPropertyDescriptor,
                                    relativeParent:IAutomationObject):Object
    {
        var result:Array = [];
        var value:Object = getMemberFromObject(automationManager, obj, pd);
        
        if (value != null && value is Array)
        {
            var arrayObj:Array = value as Array;
            
            for (var i:int = 0; i < arrayObj.length; ++i)
            {
                var arrayPropertyDescriptor:AQPropertyDescriptor= 
                    new AQPropertyDescriptor(String(i),
                                                     pd.forDescription,
                                                     pd.forVerification,
                                                     "string",
                                                     pd.codecName);
                var arrayItem:String = String(arrayTypeCodec.encode(automationManager, 
                                                                    arrayObj,
                                                                    arrayPropertyDescriptor,
                                                                    relativeParent));
            
                arrayItem = arrayItem.replace(/;/g, "&#x3B;");
            
                result.push(arrayItem);
            }
        }
        
        //Arrays are always returned as strings
        return result.join(";");
    }

    override public function decode(automationManager:IAutomationManager,
                                    obj:Object, 
                                    value:Object,
                                    pd:IAQPropertyDescriptor,
                                    relativeParent:IAutomationObject):void
    {
        if (value != null && value.length != 0)
        {
            //since we override obj when calling the sub-codec
            //make sure relativeParent is set
            var delegate:IAutomationObject = obj as IAutomationObject;
            if (relativeParent == null)
                relativeParent = delegate;

            var arrayObj:Array = [];
            var arrayString:Array = String(value).split(";");

            //note if the array members have extra spaces this code
            //won't work, we would need to trim the members, but that could
            //be a bad thing if the spaces are significant, so if we need to
            //do this, then we should also entity encode spaces (which would be ugly)
            
            for (var i:int = 0; i < arrayString.length; ++i)
            {
                arrayString[i] = arrayString[i].replace(/&#x3B;/g, ";");
                var arrayPropertyDescriptor:AQPropertyDescriptor= 
                    new AQPropertyDescriptor(String(i),
                                                     pd.forDescription,
                                                     pd.forVerification,
                                                     "string",
                                                     pd.codecName);

                arrayTypeCodec.decode(automationManager, 
                                      arrayString,
                                      arrayString[i],
                                      arrayPropertyDescriptor,
                                      relativeParent);
            
                arrayObj.push(arrayString[i]);
            }
            
            obj[pd.name] = arrayObj;
        }
    }
}

}
