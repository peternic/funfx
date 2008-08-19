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

import mx.automation.IAutomationObject;	
	
public interface IAQCodecHelper
{
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
    function encodeProperties(obj:Object, 
                              propertyDescriptors:Array, 
                              relativeParent:IAutomationObject):Array;

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
     
    function encodeValue(value:Object, 
                         testingToolType:String,
                         codecName:String,
                         relativeParent:IAutomationObject):Object;

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
    function decodeProperties(obj:Object, 
                              args:Array,
                              propertyDescriptors:Array,
                              relativeParent:IAutomationObject):void;

}		
}
