////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2003-2007 Adobe Systems Incorporated and its licensors.
//  All Rights Reserved. The following is Source Code and is subject to all
//  restrictions on such code as contained in the End User License Agreement
//  accompanying this product.
//
////////////////////////////////////////////////////////////////////////////////

package custom.utilities
{

public class EnvXMLParser
{
	/**
	 *  Constructor
	 */
	public function EnvXMLParser()
	{
		
	}
	
	/**
     *  @private
     */
	private var inputXML:XML;
	
	/**
     *  @private
     */
	private var outputXML:XML
	
	 /**
	 *  @public
	 *  Takes the input XML, parse it i.e., removes the hierarchy
	 *  and returns the output XML.
	 */
	public function parse(inputXML:XML):XML
	{
		this.inputXML = inputXML;
		outputXML = <TypeInformation></TypeInformation>;
		for each(var item:XML in inputXML.ClassInfo)
		{
			// Check if a class extends some other class
			if (item.attribute("Extends") != undefined)
			{
				var result:XML = new XML(item);
				
				var extend:String = item.@Extends;
										
				outputXML.appendChild(recurseAndMake(result,extend));
			}
			else
			{
				outputXML.appendChild(item);
			}
		}
		
		return outputXML;
	}
	
	/**
     *  @private
     */
	private function recurseAndMake(item:XML,extend:String):XML
	{
		if(extend == null || extend == "")
			return item;
		
		var result:XML = new XML(item);							
		
		// Add every method of the base class
		for each(var method:XML in inputXML.ClassInfo.(@Name == extend).Methods.Method)
		{
				if(result.Methods.length() > 0 && !result.Methods.contains(method))
					result.Methods.appendChild(method);
				else
				{
					result.appendChild(inputXML.ClassInfo.(@Name == extend).Methods);
					break;
				}
		}
		
		// Add every event of the base class
		for each(var event:XML in inputXML.ClassInfo.(@Name == extend).Events.Event)
		{
				if(result.Events.length() > 0  && !result.Events.contains(event))
					result.Events.appendChild(event);
				else
				{
					result.appendChild(inputXML.ClassInfo.(@Name == extend).Events);
					break;
				}
		}
		
		// Add every property of the base class
		for each(var property:XML in inputXML.ClassInfo.(@Name == extend).Properties.Property)
		{
				if(result.Properties.length() > 0  && !result.Properties.contains(property))
					result.Properties.appendChild(property);
				else
				{
					result.appendChild(inputXML.ClassInfo.(@Name == extend).Properties);
					break;
				}
		}
		
		// If the base class also extends from any other class,
		// then add methods, events and properties of that class also.
		var str:String = (inputXML.ClassInfo.(@Name == extend).attribute("Extends") != undefined)? 
							inputXML.ClassInfo.(@Name == extend).attribute("Extends") : "";
		
		return recurseAndMake(result,str);
	}
}
}