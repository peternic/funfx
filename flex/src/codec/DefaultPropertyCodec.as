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
import mx.automation.Automation;
import mx.automation.IAutomationManager;
import mx.automation.IAutomationObject;
import mx.resources.ResourceBundle;
import mx.styles.IStyleClient;
import mx.utils.StringUtil;

/**
 * Base class for codecs, which translate between internal Flex properties 
 * and automation-friendly ones.
 */
public class DefaultPropertyCodec implements IAutomationPropertyCodec
{
		
	//--------------------------------------------------------------------------
	//
	//  Constructor
	//
	//--------------------------------------------------------------------------

	public function DefaultPropertyCodec()
	{
		super();
	}
	
	//--------------------------------------------------------------------------
	//
	//  Methods
	//
	//--------------------------------------------------------------------------

    /**
     *  @private
     */ 
    public function encode(automationManager:IAutomationManager,
                           obj:Object, 
                           pd:IAQPropertyDescriptor,
                           relativeParent:IAutomationObject):Object
    {
        var val:Object = getMemberFromObject(automationManager, obj, pd);

        return getValue(automationManager, obj, val, pd);
    }

    /**
     *  @private
     */ 
    public function decode(automationManager:IAutomationManager,
                           obj:Object, 
                           value:Object,
                           pd:IAQPropertyDescriptor,
                           relativeParent:IAutomationObject):void
    {
        obj[pd.name] = getValue(automationManager, obj, value, pd, true);
    }

    /**
     *  @private
     */ 
    public function getMemberFromObject(automationManager:IAutomationManager,
                                        obj:Object, 
                                        pd:IAQPropertyDescriptor):Object
    {
    	var part:Object;
    	var component:Object;

    	if (obj is IAutomationObject)
	    {
	        part = automationManager.createIDPart(obj as IAutomationObject);
	        component = obj;
	    }   
	    else
	    	component = obj;
	    	
        var result:Object = null;

        if (part != null && pd.name in part)
            result = part[pd.name];
        else if (pd.name in obj)
            result = obj[pd.name];
        else if (component != null)
        {
        	if (pd.name in component)
	            result = component[pd.name];
    	    else if (component is IStyleClient)
        	    result = IStyleClient(component).getStyle(pd.name);
        }
       
        return result;
    }

    /**
     *  @private
     */ 
    private function getValue(automationManager:IAutomationManager,
                                    obj:Object, 
                                    val:Object,
                                    pd:IAQPropertyDescriptor,
                                    useASType:Boolean = false):Object
    {
		if (val == null)
			return null;

		var type:String = useASType && pd.asType ? pd.asType : pd.AQtype;

        switch (type)
        {
			case "Boolean":
            case "boolean":
                if (val is Boolean)
                    return val;
                val = val ? val.toString().toLowerCase() : "false";
                return val == "true";
			case "String":
            case "string":
                if (val is String)
                    return val;
                return val.toString();
			case "int":
			case "uint":
            case "integer":
                if (val is int || val is uint)
                    return val;
                if (val is Date)
                    return val.time;
                if (val is Number)
                    throw new Error(StringUtil.substitute("Precision loss is occuring for ", pd.name));
                return parseInt(val.toString());
			case "Number":
            case "decimal":
                if (val is Number)
                    return val;
                if (val is Date)
                    return val.time;
                return parseFloat(val.toString());
			case "Date":
            case "date":
                if (val is Date)
                    return val;
                var num:Number = Date.parse(val.toString());
                return new Date(num);
            default:
                return val;
        }
    }
}

}
