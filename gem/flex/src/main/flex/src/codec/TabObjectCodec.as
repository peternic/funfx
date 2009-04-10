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

import mx.automation.AutomationIDPart;
import mx.automation.Automation;
import IAQPropertyDescriptor;
import mx.automation.IAutomationManager;
import mx.automation.IAutomationObject;
import codec.AutomationObjectPropertyCodec;
import mx.containers.TabNavigator;
import mx.core.mx_internal;
import mx.resources.ResourceBundle;
import mx.utils.StringUtil;

use namespace mx_internal;

/**
 * Translates between internal Flex TabNavigator object and automation-friendly version
 */
public class TabObjectCodec extends AutomationObjectPropertyCodec
{

	//--------------------------------------------------------------------------
	//
	//  Constructor
	//
	//--------------------------------------------------------------------------

    public function TabObjectCodec()
	{
		super();
	}
   
	//--------------------------------------------------------------------------
	//
	//  Overridden methods
	//
	//--------------------------------------------------------------------------

  
    /**
	 *  This is only used for TabNavigators.  
     */	
    override public function decode(automationManager:IAutomationManager,
                                    obj:Object, 
                                    value:Object,
                                    pd:IAQPropertyDescriptor,
                                    relativeParent:IAutomationObject):void
    {
		
		if (value == null || value.length == 0)
		{
	        obj[pd.name] = null;
		}
		else
		{
			var aoc:IAutomationObject;
	        if (relativeParent != null)
	        {
	        	var tabBar:Object = Object(relativeParent).getTabBar();
		        aoc = tabBar as IAutomationObject;
	        }
	        else
	        {
	        	aoc = obj as IAutomationObject;
	 		}
		
			for (var i:uint = 0; i < aoc.numAutomationChildren; i++)
			{
				var delegate:IAutomationObject = aoc.getAutomationChildAt(i);
				if (delegate.automationName == value)
				{
					obj[pd.name] = delegate;
					break;
				}
			}
		}
    }
}

}
