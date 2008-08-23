////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2003-2007 Adobe Systems Incorporated and its licensors.
//  All Rights Reserved. The following is Source Code and is subject to all
//  restrictions on such code as contained in the End User License Agreement
//  accompanying this product.
//
////////////////////////////////////////////////////////////////////////////////

package 
{
import mx.automation.IAutomationClass;
import mx.automation.IAutomationEnvironment;
import mx.automation.IAutomationEventDescriptor;
import mx.automation.IAutomationMethodDescriptor;
import mx.automation.IAutomationObject;

import custom.CustomAutomationClass;
import custom.utilities.EnvXMLParser;

/**
 *  @private
 */
public class AQEnvironment implements IAutomationEnvironment
{
	//--------------------------------------------------------------------------
	//
	//  Constructor
	//
	//--------------------------------------------------------------------------

    /**
     *  @private
	 */
	public function AQEnvironment(source:XML)
    {
		super();

        // Parse the XML, and populate the objects
        var parser:EnvXMLParser = new EnvXMLParser();
		var outputXML:XML = parser.parse(source);
        
        fillObjects(outputXML);
    }

	//--------------------------------------------------------------------------
	//
	//  Variables
	//
	//--------------------------------------------------------------------------

    /**
	 *  @private
	 */
    private var className2automationClass:Object = {};
    
    /**
	 *  @private
	 */
	private var automationClassName2automationClass:Object = {};

	//--------------------------------------------------------------------------
	//
	//  Methods
	//
	//--------------------------------------------------------------------------

    /**
     *  @private
	 */
    private function fillObjects(source:XML):void
    {
        for (var i:Object in source.ClassInfo)
        {
            // populate the class/automationClass map
            var classInfoXML:XML = source.ClassInfo[i];
            var automationClassName:String = classInfoXML.@Name.toString();
            var superClassName:String = 
                classInfoXML.@Extends && classInfoXML.@Extends.length != 0 ?
				classInfoXML.@Extends.toString() :
				null;
            var automationClass:CustomAutomationClass =
				new CustomAutomationClass(automationClassName, superClassName);
            automationClassName2automationClass[automationClassName] =
				automationClass;
            
            for (var j:Object in classInfoXML.Implementation)
            {
                var implementationXML:XML = classInfoXML.Implementation[j];
                var realClassName:String =
					implementationXML.@Class.toString().replace("::", ".");
                className2automationClass[realClassName] = automationClass;
                automationClass.addImplementationClassName(realClassName);
            }

            var pd:AQPropertyDescriptor;

            // for each Method
            for (var k:Object in classInfoXML.Methods.Method)
            {
                var methodXML:XML = classInfoXML.Methods.Method[k];
			
                var automationMethodName:String = methodXML.@Name.toString();
                var methodName:String =
					methodXML.Implementation.@Type.toString();

                if (methodName)
                {
                    var parameters:Array = [];
                    for (var m:Object in methodXML.Parameter)
                    {
                        var parameterXML:XML = methodXML.Parameter[m];
                        var parameterName:String = parameterXML.@Name.toString();
                        var parameterType:String =
							parameterXML.PropertyType.@Type.toString().toLowerCase();
                        pd = new AQPropertyDescriptor(
								parameterName, true, true, parameterType, null);
                        parameters.push(pd);
                    }
                    
                    var returnType:String =
						methodXML.ReturnValueType.PropertyType.@Type.toString();
						
                    var codecName:String =
						methodXML.ReturnValueType.Type.@Codec.toString();
						
					var md:IAutomationMethodDescriptor = new AQMethodDescriptor(
							automationMethodName, methodName, returnType, codecName, parameters);
	                automationClass.addMethod(md);

                }
            }
            

            // for each Event
            for (var q:Object in classInfoXML.Events.Event)
            {
                var eventXML:XML = classInfoXML.Events.Event[q];
			
                var automationEventName:String = eventXML.@Name.toString();
                var eventClassName:String =
					eventXML.Implementation.@Class.toString();
                eventClassName = eventClassName.replace("::", ".");
                var eventType:String =
					eventXML.Implementation.@Type.toString();

                if (eventType)
                {
                    var properties:Array = [];
                    for (var n:Object in eventXML.Property)
                    {
                        var eventPropertyXML:XML = eventXML.Property[n];
                        var eventPropertyName:String = eventPropertyXML.@Name.toString();
                        var eventPropertyType:String =
							eventPropertyXML.PropertyType.@Type.toString().toLowerCase();
                        var eventPropertyCodec:String = eventPropertyXML.PropertyType.@Codec.toString();
                        var defaultValue:String = 
                            eventPropertyXML.@DefaultValue.length() > 0 ?
							eventPropertyXML.@DefaultValue.toString() :
							null;
                        pd = new AQPropertyDescriptor(
								eventPropertyName, true, true, eventPropertyType,
                                (eventPropertyCodec == null || eventPropertyCodec.length == 0 ?
								"object" :
								eventPropertyCodec), defaultValue);
                        properties.push(pd);
                    }
                    
					var ed:IAutomationEventDescriptor = new AQEventDescriptor(
							automationEventName, eventClassName,
                            eventType, properties);
                    automationClass.addEvent(ed);
                }
            }

            // for each Property
            for (var p:Object in classInfoXML.Properties.Property)
            {
                var propertyXML:XML = classInfoXML.Properties.Property[p];
				var propName:String = propertyXML.@Name.toString();
				var propType:String =
					propertyXML.PropertyType.@Type.toString().toLowerCase();
                var propCodec:String = propertyXML.Type.@Codec.toString();
                pd = new AQPropertyDescriptor(
						propName,
                        propertyXML.@ForDescription.toString() == "true",
                        propertyXML.@ForVerification.toString() == "true",
                        propType,
                        (propCodec == null || propCodec.length == 0 ?
						"object" :
						propCodec));
                automationClass.addPropertyDescriptor(pd);
            }
        }
    }
    
    /**
     *  @private
	 */
    public function getAutomationClassByInstance(
						obj:IAutomationObject):IAutomationClass
    {
        var result:IAutomationClass = findClosestAncestor(obj);
        if (! result)
		{
            throw new Error("Automtaion Class Not Found : " + CustomAutomationClass.getClassName(obj));
		}
        return result; 
    }

    /**
     *  @private
	 */
    public function getAutomationClassByName(
						automationClass:String):IAutomationClass
    {
        return CustomAutomationClass(
			automationClassName2automationClass[automationClass]);
    }

    /**
     *  Finds the closest ancestor to this object about which information was 
     *  passed in the environment XML.
     *  @private
     */
    private function findClosestAncestor(obj:Object):IAutomationClass
    {   	
        var className:String = CustomAutomationClass.getClassName(obj);
        if (className in className2automationClass)
            return className2automationClass[className];
		
        var ancestors:Array = findAllAncestors(obj);
        if (ancestors.length != 0)
        {
            className2automationClass[className] = ancestors[0];
            return className2automationClass[className];
        }
        else
		{
            return null;
		}
    }

    /**
	 *  @private
	 */
    private function findAllAncestors(obj:Object):Array
    {
        var result:Array = [];
        
		for (var i:String in className2automationClass)
        {
		    var realClass:Class = 
                          CustomAutomationClass.getDefinitionFromObjectDomain(obj,i);
            if (realClass && obj is realClass)
                result.push(className2automationClass[i]);
        }
        
		result.sort(sortAncestors);
        
		return result;
    }
    
    /**
	 *  @private
	 */
    private function sortAncestors(a:IAutomationClass, b:IAutomationClass):int
    {
        var superClass:IAutomationClass;
        var x:String = a.superClassName;
        while (x)
        {
            if (x == b.name)
                return -1;
            superClass = getAutomationClassByName(x);
            x = superClass.superClassName;
        }
        
		x = b.superClassName;
        while (x)
        {
            if (x == a.name)
                return 1;
            superClass = getAutomationClassByName(x);
            x = superClass.superClassName;
        }
        
        return 0;
    }
}

}
