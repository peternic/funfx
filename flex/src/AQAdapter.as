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
	
import codec.ArrayPropertyCodec;
import codec.AssetPropertyCodec;
import codec.AutomationObjectPropertyCodec;
import codec.ColorPropertyCodec;
import codec.DatePropertyCodec;
import codec.DateRangePropertyCodec;
import codec.DateScrollDetailPropertyCodec;
import codec.DefaultPropertyCodec;
import codec.IAutomationPropertyCodec;
import codec.KeyCodePropertyCodec;
import codec.KeyModifierPropertyCodec;
import codec.ListDataObjectCodec;
import codec.ScrollDetailPropertyCodec;
import codec.ScrollDirectionPropertyCodec;
import codec.TabObjectCodec;
import codec.TriggerEventPropertyCodec;

import custom.CustomAutomationClass;

import flash.display.DisplayObject;
import flash.events.*;
import flash.net.URLLoader;
import flash.net.URLRequest;
import flash.utils.getDefinitionByName;

import funfx.Proxy;

import mx.automation.Automation;
import mx.automation.AutomationError;
import mx.automation.AutomationID;
import mx.automation.IAutomationClass;
import mx.automation.IAutomationEventDescriptor;
import mx.automation.IAutomationManager;
import mx.automation.IAutomationMethodDescriptor;
import mx.automation.IAutomationObject;
import mx.automation.IAutomationPropertyDescriptor;
import mx.automation.IAutomationTabularData;
import mx.automation.events.AutomationRecordEvent;
import mx.controls.Alert;
import mx.core.Application;
import mx.core.UIComponent;
import mx.core.mx_internal;
import mx.events.FlexEvent;
import mx.managers.PopUpManager;

use namespace mx_internal;

[Mixin]

/**
 *  @private
 */
public class AQAdapter implements IAQCodecHelper
{
	
	//--------------------------------------------------------------------------
	//
	//  Class variables
	//
	//--------------------------------------------------------------------------

    /**
	 *  @private
     */	
    private static var isInitailized:Boolean = false;
    
    /**
	 *  @private
     */	
    private static var AQCodecHelper:IAQCodecHelper;
    

	//--------------------------------------------------------------------------
	//
	//  Class methods
	//
	//--------------------------------------------------------------------------

	private static var _root:DisplayObject;
	
	public static var aqAdapter:AQAdapter;
	
    /**
	 *  @private    
	 */
	public static function init(root:DisplayObject):void
    {
    	if(!aqAdapter)
	    {
	    	_root = root;

			root.addEventListener(FlexEvent.APPLICATION_COMPLETE, applicationCompleteHandler);
    	}
     }
	
    /**
	 *  @private    
	 */
	private static function applicationCompleteHandler(event:FlexEvent):void
	{
		_root.removeEventListener(FlexEvent.APPLICATION_COMPLETE, applicationCompleteHandler);

		aqAdapter = new AQAdapter();
	}
	
	//--------------------------------------------------------------------------
	//
	//  Constructor
	//
	//--------------------------------------------------------------------------

    /**
     *  Constructor
	 */
	public function AQAdapter()
    {
		super();
		
		if (!isInitailized)
		{
		    isInitailized = true;

            AQCodecHelper = this;

            // Add the default serializers.
            addPropertyCodec(
				"object", new DefaultPropertyCodec());

            addPropertyCodec(
				"keyCode", new KeyCodePropertyCodec());

            addPropertyCodec(
				"keyModifier", new KeyModifierPropertyCodec());

            addPropertyCodec(
				"object[]", new ArrayPropertyCodec(new DefaultPropertyCodec()));

            addPropertyCodec(
				"color", new ColorPropertyCodec());

            addPropertyCodec(
				"color[]", new ArrayPropertyCodec(new ColorPropertyCodec()));

            addPropertyCodec(
				"automationObject", new AutomationObjectPropertyCodec());

            addPropertyCodec(
				"automationObject[]",
				new ArrayPropertyCodec(new AutomationObjectPropertyCodec()));

            addPropertyCodec(
				"asset", new AssetPropertyCodec());

            addPropertyCodec(
				"asset[]", new ArrayPropertyCodec(new AssetPropertyCodec()));

            addPropertyCodec(
				"listDataObject", new ListDataObjectCodec());

            addPropertyCodec(
				"listDataObject[]",
				new ArrayPropertyCodec(new ListDataObjectCodec()));

            addPropertyCodec(
				"dateRange", new DateRangePropertyCodec());

			addPropertyCodec(
				"dateObject", new DatePropertyCodec());

            addPropertyCodec(
				"dateRange[]",
				new ArrayPropertyCodec(new DateRangePropertyCodec()));

            addPropertyCodec(
				"event", new TriggerEventPropertyCodec());
			
			addPropertyCodec(
				"tab", new TabObjectCodec());
				
			addPropertyCodec(
				"scrollDetail", new ScrollDetailPropertyCodec());

			addPropertyCodec(
				"dateScrollDetail", new DateScrollDetailPropertyCodec());

			addPropertyCodec(
				"scrollDirection", new ScrollDirectionPropertyCodec());

	    	try
	    	{
	    		// check for availability of chart codec.
	    		// it may not be available if user has not included chart delegates
				var codec:Object = getDefinitionByName("codec.HitDataCodec");
				
				addPropertyCodec(
					"hitDataCodec[]", new ArrayPropertyCodec(new codec()));
	    	}
	    	catch(e:Error)
			{
			}

            /** 
            * If the plugin DLL is ActiveX based this check can be enabled.
            */
            /* if (Capabilities.playerType != "ActiveX")
            {
                trace("No ActiveX support"]);
                return;
            } */

            
/*          If the agent is supporting only Windows platform   
            if (! Capabilities.os.match(/^Windows/))
            {
                trace("Agent supports only Windows");
                return;
            }
 */
            /** 
            *  If the plugin DLL requries ExternalInterface support playerID is a must to 
            *  identfiy the player instance in JavaScript.
            */
            /* if (!playerID || playerID.length == 0)
            {
                trace("No PlayerID is provided");
                return;
            } 

            if (playerID.match(/[\.-]/))
            {
                trace("Invalid PlayerID");
                return;
            }*/

		   // Load environment XML
		   var te:String = "AutoQuickEnv.xml";
	
			var loader:URLLoader = new URLLoader();
			configureListeners(loader);
	
			var request:URLRequest = new URLRequest(te);
			try {
				loader.load(request);
			} catch (error:Error) {
				Alert.show("Unable to load AutoQuickEnv.xml from current directory: " + error.message);
			}
        }
    }
    
 	//--------------------------------------------------------------------------
	//
	//  Variables
	//
	//--------------------------------------------------------------------------

    /**
	 *  @private
	 */
	private var lastError:Error;

    /**
     *  @private
     */
	private var propertyCodecMap:Object = [];
	
  	//--------------------------------------------------------------------------
	//
	//  Properties
	//
	//--------------------------------------------------------------------------

	//----------------------------------
	//  automationManager
	//----------------------------------

    /**
     *  @private
	 */
    public function get automationManager():IAutomationManager
    {
        return Automation.automationManager ;
    }

	//----------------------------------
	//  playerID
	//----------------------------------

    /**
     *  @private
     */
    private function get playerID():String 
    { 
        return Application.application.id;
    }
    
    private var funfxRecords:String = "";
    private var records:XML = <Records></Records>;
    private var lastRecord:String;

  	//--------------------------------------------------------------------------
	//
	//  Methods
	//
	//--------------------------------------------------------------------------

    /**
     *  @private
     *  Registers a custom codec to encoding an decoding of object properties and
     *  event properties to and from a testing tool.  For example, ColorPicker
     *  events can contain the selected color.  A special color codec is provided
     *  to encode and decode colors from their native number format to hex.
     *
     *  Predefined codecs include:
     *      "" - The default codec that supports basic types such as String, Number, int and uint.
     *      "color" - Converts a number to hex.
     *      "keyCode" - Converts a keyCode number to a human readable string
     *      "keyState" - Converts ctrlKey, shiftKey and altKey booleans to a human 
     *                   readable bitfield string.
     *      "skin" - Converts a skin asset class name to closely resemble it's 
     *               original asset name.  Path separators and periods in the orignal
     *               path name will be converted to underscores.  This is only available
     *               on readonly properties.
     *      "automationObject" - Converts an object to it's automationName.
     *
     *  @param codecName the name of the codec.
     * 
     *  @param codec the implementation of the codec.
     */
    private function addPropertyCodec(codecName:String, codec:IAutomationPropertyCodec):void
    {
        propertyCodecMap[codecName] = codec;
    }

    /**
	 *  @private
	 */
    public function setTestingEnvironment(te:String):void
    {
        automationManager.automationEnvironment = new AQEnvironment(new XML(te));
    }

    /**
     *  Encodes a single value to a testing tool value.  Unlike encodeProperties which
     *  takes an object which contains all the properties to encode, this method
     *  takes the actual value to encode.  This is useful for encoding return values.
     *
     *  @param obj the value to be encoded.
     * 
     *  @param propertyDescriptor the property descriptor that describes this value.
     * 
     *  @param relativeParent the IAutomationObject that is related to this value.
     */
    public function encodeValue(value:Object, 
                                testingToolType:String,
                                codecName:String,
                                relativeParent:IAutomationObject):Object
    {
        //setup a fake descriptor and object to send to the codec
        var pd:AQPropertyDescriptor = 
            new AQPropertyDescriptor("value",
                                             false, 
                                             false, 
                                             testingToolType, 
                                             codecName);
        var obj:Object = {value:value};
        return getPropertyValue(obj, pd, relativeParent);
    }
    
    
    public function getPropertyValue(obj:Object, 
                                     pd:AQPropertyDescriptor,
                                     relativeParent:IAutomationObject = null):Object
    {
        var coder:IAutomationPropertyCodec = propertyCodecMap[pd.codecName];
        
        if (coder == null)
            coder = propertyCodecMap["object"];

	    if (relativeParent == null)
		    relativeParent = obj as IAutomationObject;
		    
        return coder.encode(automationManager, obj, pd, relativeParent);
    }
    
    /**
     *  Encodes properties in an AS object to an array of values for a testing tool
     *  using the codecs.  Since the object being passed in may not be an IAutomationObject 
     *  (it could be an event class) and some of the properties require the
     *  IAutomationObject to be transcoded (such as the item renderers in
     *  a list event), relativeParent should always be set to the relevant
     *  IAutomationObject.
     *
     *  @param obj the object that contains the properties to be encoded.
     * 
     *  @param propertyDescriptors the property descriptors that describes the properties for this object.
     * 
     *  @param relativeParent the IAutomationObject that is related to this object.
     *
     *  @return the encoded property value.
     */
    public function encodeProperties(obj:Object,
                                     propertyDescriptors:Array,
                                     interactionReplayer:IAutomationObject):Array
    {
        var result:Array = [];
        var consecutiveDefaultValueCount:Number = 0;
        for (var i:int = 0; i < propertyDescriptors.length; i++)
        {
            var val:Object = getPropertyValue(obj, 
                                              propertyDescriptors[i],
                                              interactionReplayer);

			var isDefaultValueNull:Boolean = propertyDescriptors[i].defaultValue == "null";

            consecutiveDefaultValueCount = (!(val == null && isDefaultValueNull) &&
            								(propertyDescriptors[i].defaultValue == null || 
                                             val == null ||
                                             propertyDescriptors[i].defaultValue != val.toString())
                                            ? 0
                                            : consecutiveDefaultValueCount + 1);

            result.push(val);
        }

        result.splice(result.length - consecutiveDefaultValueCount, 
                      consecutiveDefaultValueCount);

        return result;
    }
    

    /**
	 *  @private
	 */
    private function recordHandler(event:AutomationRecordEvent):void
    {
        automationManager.incrementCacheCounter();

        try
        {
            var obj:IAutomationObject = event.automationObject ;
            var rid:AutomationID = automationManager.createID(obj);

			buildAdobeRecord(event, obj, rid);
			buildFunFXRecord(event, obj, rid);
            
        }
        catch (e:Error)
        {
            lastError = e;
            trace(e.message);
        }

        automationManager.decrementCacheCounter();
    }
    
    private function buildAdobeRecord(event:AutomationRecordEvent, obj:IAutomationObject, rid:AutomationID):void{
    	var rec:XML = (<Step id={rid.toString()} method={event.name} ></Step>);
        XML.prettyPrinting = false;
            
       	rec.appendChild(<Args value={event.args.join("_ARG_SEP_")} />);
			
		records.appendChild(rec);
    }
    
    private function buildFunFXRecord(event:AutomationRecordEvent, obj:IAutomationObject, rid:AutomationID):void{
    	var record:String = "@flex." + changeName(UIComponent(obj).className) + "("
    	var array:Array = rid.toString().split("|");
    	record += "{" + getRecord(array[1]) + "}";
    	for(var i:int=2; i<array.length; i++){
    		record += ", {" + getRecord(array[i]) + "}";
    	}
    	record += ")." + changeName(event.name);
    	
    	if(event.args.length > 0 && !getRecordArguments(event.args).match(/'null'/)){
    		record += "(" + getRecordArguments(event.args) + ")";
    	}
    	
    	funfxRecords += record + "\r";
    }
    
    private function changeName(name:String):String{
    	name = name.replace(/([a-z]*)([A-Z])/g, "$1_$2");
    	name = name.toLowerCase();
    	return name.substr(1, name.length);
    }
    
    private function getRecord(str:String):String{
    	try{
	    	var automationNamePattern:RegExp = new RegExp("\.*automationName{([A-Za-z0-9-!\"#$%&'()*+,./:;<>=?@[\\\]_|]*) string|object}\.*", "i");
	    	var automationIndexPattern:RegExp = new RegExp("\.*automationIndex{([A-Za-z0-9-!\"#$%&'()*+,./:;<>=?@[\\\]_|]*) string|object}\.*", "i");
	    	var idPattern:RegExp = new RegExp("\.*id{([A-Za-z0-9-!\"#$%&'()*+,./:;<>=?@[\\\]_|]*) string|object}\.*", "i");
	    	
	    	var resultAutomationName:Array = automationNamePattern.exec(str);
	    	var resultAutomationIndex:Array = automationIndexPattern.exec(str);
	    	var resultId:Array = idPattern.exec(str);
			
			var result:String = ":id => '" + resultId[1] + "'";
			result += ", :automationName => '" + resultAutomationName[1] + "'";
			result += !resultAutomationIndex[1].match("index:-1") ? (", :automationIndex => '" + resultAutomationIndex[1] + "'") : "";
    	}
    	catch(e:Error){
    		return e.message;
    	}
    	return result;
    }
    
    
  	private function getRecordArguments(args:Array):String{
  		var str:String = "'" + args[0] + "'";
  		for(var i:int=1; i<args.length; i++){
  			str += ", " + "'" + args[i] + "'";
  		}
  		return str;
  	}

    /**
	 *  @private
	 */
    public function beginRecording():Object
    {
        return useErrorHandler(function():Object
        {
            var o:Object = { result:null, error:0 };
            automationManager.addEventListener(AutomationRecordEvent.RECORD,
                                               recordHandler, false, 0, true);
            automationManager.beginRecording();
            
            return o;
        });
    }

    /**
	 *  @private
	 */
    public function endRecording():Object
    {
        return useErrorHandler(function():Object
        {
            var o:Object = { result:null, error:0 };
            automationManager.endRecording();
            automationManager.removeEventListener(AutomationRecordEvent.RECORD,
                                                  recordHandler);
            return o;
        });
    }

    private function replayEvent(target:IAutomationObject, eventName:String, args:Array):Object
    {
        var automationClass:IAutomationClass = 
            automationManager.automationEnvironment.getAutomationClassByInstance(target);
        // try to find the automation class
        if (! automationClass)
            throw new Error(CustomAutomationClass.getClassName(target) + "class not found");
    
        var eventDescriptor:IAutomationEventDescriptor =
            automationClass.getDescriptorForEventByName(eventName);

        if (!eventDescriptor)
            throw new Error(eventName + " event description not found for " + automationClass);
    
		var retValue:Object = eventDescriptor.replay(target, args);
        return {value:retValue, type:null};
    }

    private function replayMethod(target:IAutomationObject, method:String, args:Array):Object
    {
        var automationClass:IAutomationClass = 
            automationManager.automationEnvironment.getAutomationClassByInstance(target);
        // try to find the automation class
        if (! automationClass)
            throw new Error(CustomAutomationClass.getClassName(target) + "class not found");
    
        var methodDescriptor:IAutomationMethodDescriptor =
            automationClass.getDescriptorForMethodByName(method);

        if (!methodDescriptor)
            throw new Error(method + " method not found for "+ automationClass);
    
        var retValue:Object = methodDescriptor.replay(target, args);
        
        if(retValue is IAutomationObject)
	        retValue = automationManager.createID(IAutomationObject(retValue)).toString();
        
        return {value:retValue, type:methodDescriptor.returnType};
    }
    
    /**
     *  @private
     */
    public function replay(target:IAutomationObject, method:String, args:Array):Object
    {   
        automationManager.incrementCacheCounter();
        var o:Object = { result:null, error:0 };
        try
        {
			 o.result = replayMethod(target, method, args);        	
        }
        catch(e:Error)
        {
	        try
	        {
			     o.result = replayEvent(target, method, args);        	
	        }
	        catch(e:Error)
    	    {
		        automationManager.decrementCacheCounter();
    	    	throw e;
    	    }
        }

		//force clear;
        automationManager.decrementCacheCounter(true);
        
        return o;
    }
    

    /**
	 *  @private
	 */
    public function run(objID:String, method:String, args:String):Object
    {
        return useErrorHandler(function():Object
        {
            var rid:AutomationID = AutomationID.parse(objID);
            var target:IAutomationObject = automationManager.resolveIDToSingleObject(rid);
            
            if(!target)
            	return { result:null, error:0 };
            	
            
			return  replay(target, method, convertArrayFromStringToAs(args));
        });
    }
    

    /**
	 *  @private
	 */
    public function getPropertyDescriptors(obj:IAutomationObject, 
                                  names:Array = null, 
                                  forVerification:Boolean = true, 
                                  forDescription:Boolean = true):Array
    {
        if (!obj)
            return null;

        try
        {
            automationManager.incrementCacheCounter();

            var automationClass:IAutomationClass =
                automationManager.automationEnvironment.getAutomationClassByInstance(obj) as IAutomationClass;
            var i:int;
			var propertyNameMap:Object = automationClass.propertyNameMap;

            var result:Array = [];
            if (!names)
            {
	            var propertyDescriptors:Array = 
    		            automationClass.getPropertyDescriptors(obj, 
            	                                        forVerification, 
                	                                    forDescription);
                names = [];
                for (i = 0; i < propertyDescriptors.length; i++)
                {
                    names[i] = propertyDescriptors[i].name;
                }
            }
            for (i = 0; i < names.length; i++)
            {
                var propertyDescriptor:AQPropertyDescriptor = propertyNameMap[ names[i] ];
                result.push(propertyDescriptor);
            }
            
            automationManager.decrementCacheCounter();
        }
        catch(e:Error)
        {
            automationManager.decrementCacheCounter();
            
            throw e;
        }

        return result;
    }

	private function encodeValues(obj:IAutomationObject, values:Array, descriptors:Array):Array
	{
        var result:Array = [];
        for (var i:int = 0; i < values.length; ++i)
        {
        	var descriptor:AQPropertyDescriptor = descriptors[i];
	        var coder:IAutomationPropertyCodec = propertyCodecMap[descriptor.codecName];
	        
	        if (coder == null)
	            coder = propertyCodecMap["object"];
	
		    var relativeParent:IAutomationObject = obj;
	            
	        var retValue:Object = coder.encode(automationManager, obj, descriptor, relativeParent);
            result.push({value:retValue, descriptor:descriptor});
        }
        
        return result;
	}

    /**
	 *  Returns the property values of an AutomationObject.
	 *
	 *  If names are given
	 */
    public function getProperties(objID:String, names:String):Object
    {
        return useErrorHandler(function():Object
        {
            var o:Object = { result:null, error:0 };
            var rid:AutomationID = AutomationID.parse(objID);
            var obj:IAutomationObject = automationManager.resolveIDToSingleObject(rid);
            var asNames:Array = names;
            var descriptors:Array = [];
			if(asNames && asNames.length)
            {
	            var automationClass:IAutomationClass =
            	    automationManager.automationEnvironment.getAutomationClassByInstance(obj) as IAutomationClass;;
				var propertyNameMap:Object = automationClass.propertyNameMap;
	            for (var i:int = 0; i < asNames.length; i++)
	            {
		            var propertyDescriptor:IAutomationPropertyDescriptor = 
	    	            propertyNameMap[ asNames[i] ];
	    	        if(propertyDescriptor)
	                {
						asNames[i] = propertyDescriptor.name;
	                    descriptors.push(propertyDescriptor);
	                }
	                else
	                	// descriptor was not found delete the entry.
	                	asNames.splice(i, 1);

	    	    }
            
            }
            
            var values:Array = automationManager.getProperties(obj, asNames);
			var x:Array = encodeValues(obj, values, descriptors);
            for (var no:int = 0; no < x.length; ++no)
	        {
    	        x[no] = x[no].value;
        	}

            o.result = x;
            return o;
        });
    }

    /**
	 *  @private
	 */
    public function getParent(objID:String):Object
    {
        return useErrorHandler(function():Object
        {
            var o:Object = { result:null, error:0 };
            var rid:AutomationID = AutomationID.parse(objID);
            var obj:IAutomationObject = automationManager.resolveIDToSingleObject(rid);
            obj = automationManager.getParent(obj);
            o.result = (obj 
                        ? automationManager.createID(obj).toString() 
                        : null);
            return o;
        });
    }


    /**
	 *  @private
	 */
    public function getTabularData(objID:String, begin:uint = 0, end:uint = 0):Object
    {
        return useErrorHandler(function():Object
        {
            var o:Object = { result:null, error:0 };
            var rid:AutomationID = AutomationID.parse(objID);
            var obj:IAutomationObject = automationManager.resolveIDToSingleObject(rid);
            var td:IAutomationTabularData = automationManager.getTabularData(obj);
            o.result = {
                columnTitles: td ? td.columnNames : [],
                tableData: (td 
                            ? td.getValues(begin, end) 
                            : [[]])
            };
            return o;
        });
    }

    /**
     *  @private
     */
    private function useErrorHandler(f:Function):Object
    {
        var o:Object = { result:null, error:0 };
        try
        {
        	automationManager.incrementCacheCounter();
            o = f();
        	automationManager.decrementCacheCounter();
        }
        catch (e:Error)
        {
        	automationManager.decrementCacheCounter();
            lastError = e;
            o.error = (e is AutomationError 
                       ? AutomationError(e).code 
                       : AutomationError.ILLEGAL_OPERATION);
            trace(e.message);
        }
        return o;
    }


    /**
     *  @private
     *  Converts AQ specific strings to proper values.
     */
    private function convertArrayFromStringToAs(a:String):Array
    {
        var result:Array = a.split("_ARG_SEP_");
        return result;
    }

    /**
     *  Decodes an array of properties from a testing tool into an AS object.
     *  using the codecs.
     *
     *  @param obj the object that contains the properties to be encoded.
     * 
     *  @param args the property values to transcode.
     * 
     *  @param propertyDescriptors the property descriptors that describes the properties for this object.
     * 
     *  @param relativeParent the IAutomationObject that is related to this object.
     *
     *  @return the decoded property value.
     */
    public function decodeProperties(obj:Object,
                                     args:Array,
                                     propertyDescriptors:Array,
                                     interactionReplayer:IAutomationObject):void
    {	
        for (var i:int = 0; i < propertyDescriptors.length; i++)
        {
            var value:String = null;
            if (args != null && 
                i < args.length && 
                args[i] == "null" && 
                propertyDescriptors[i].defaultValue == "null")
                args[i] = null;
            if (args != null && 
                i < args.length && 
                ((args[i] != null  && args[i] != "")  || propertyDescriptors[i].defaultValue == null))
                setPropertyValue(obj, 
                                 args[i],
                                 propertyDescriptors[i],
                                 interactionReplayer);
            else if (propertyDescriptors[i].defaultValue != null)
                setPropertyValue(obj, 
                                 (propertyDescriptors[i].defaultValue == "null" 
                                      ? null 
                                      : propertyDescriptors[i].defaultValue), 
                                 propertyDescriptors[i], 
                                 interactionReplayer);
            else
                throw new Error("Missing Argument " + propertyDescriptors[i].name);
        }
    }
    

    /**
     *  @private
     */
    public function setPropertyValue(obj:Object, 
                                     value:Object,
                                     pd:AQPropertyDescriptor,
                                     relativeParent:IAutomationObject = null):void
    {
        var coder:IAutomationPropertyCodec = propertyCodecMap[pd.codecName];
        
        if (coder == null)
            coder = propertyCodecMap["object"];
            
	    if (relativeParent == null)
		    relativeParent = obj as IAutomationObject;

        coder.decode(automationManager, obj, value, pd, relativeParent);
	}
	
	/**
	 *  @private
	 */
	public static function getCodecHelper():IAQCodecHelper
	{
		return AQCodecHelper;
	}
	
        private function configureListeners(dispatcher:IEventDispatcher):void 
        {
            dispatcher.addEventListener(Event.COMPLETE, completeHandler);
            dispatcher.addEventListener(Event.OPEN, openHandler);
            dispatcher.addEventListener(ProgressEvent.PROGRESS, progressHandler);
            dispatcher.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
            dispatcher.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
            dispatcher.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
        }

        private function completeHandler(event:Event):void {
            
            var loader:URLLoader = URLLoader(event.target);
            //trace("completeHandler: " + loader.data);
       
            setTestingEnvironment(loader.data);

            // Disable the popup by commenting out the line below
			PopUpManager.createPopUp(DisplayObject(Application.application), AQToolBar);
			//panel.x = Application.application.width - panel.width;
			//panel.y = Application.application.height - panel.height;
			new Proxy();
        }

        private function openHandler(event:Event):void {
            //trace("openHandler: " + event);
        }

        private function progressHandler(event:ProgressEvent):void {
            //trace("progressHandler loaded:" + event.bytesLoaded + " total: " + event.bytesTotal);
        }

        private function securityErrorHandler(event:SecurityErrorEvent):void {
            Alert.show("securityErrorHandler: " + event);
        }

        private function httpStatusHandler(event:HTTPStatusEvent):void {
            //trace("httpStatusHandler: " + event);
        }

        private function ioErrorHandler(event:IOErrorEvent):void {
            Alert.show("ioErrorHandler: " + event);
        }
    
	public function getRecords():String
	{
		return records.toXMLString();
	}
	
	public function getFunFXRecords():String
	{
		return funfxRecords;
	}

}

}
