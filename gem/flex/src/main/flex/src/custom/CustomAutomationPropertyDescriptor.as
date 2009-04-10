////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2003-2007 Adobe Systems Incorporated and its licensors.
//  All Rights Reserved. The following is Source Code and is subject to all
//  restrictions on such code as contained in the End User License Agreement
//  accompanying this product.
//
////////////////////////////////////////////////////////////////////////////////

package custom
{
	
import mx.automation.IAutomationPropertyDescriptor;

/**
 * Describes a property of a test object.
 */
public class CustomAutomationPropertyDescriptor implements IAutomationPropertyDescriptor
{
    /**
     *  Constructor
     */
    public function CustomAutomationPropertyDescriptor(name:String,
                                                 forDescription:Boolean,
                                                 forVerification:Boolean,
                                                 asType:String = null,
                                                 defaultValue:String = null)
    {
        super();
        _name = name;
        _forDescription = forDescription;
        _forVerification = forVerification;
        _defaultValue = defaultValue;
        _asType = asType;
    }
    
    //--------------------------------------------------------------------------
	//
	//  Properties
	//
	//--------------------------------------------------------------------------

	//----------------------------------
	//  name
	//----------------------------------
	
	/**
	 * @private
	 */
	 private var _name:String;
	
	/**
	 * @private
	 */
    public function get name():String
    {
        return _name;
    }
    
    //----------------------------------
	//  forDescription
	//----------------------------------
	
	/**
	 * @private
	 */
	 private var _forDescription:Boolean;
	 
	/**
	 * @private
	 */
    public function get forDescription():Boolean
    {
        return _forDescription;
    }
    
    //----------------------------------
	//  forVerfication
	//----------------------------------
	
	/**
	 * @private
	 */
	 private var _forVerification:Boolean;
	 
	/**
	 * @private
	 */
    public function get forVerification():Boolean
    {
        return _forVerification;
    }
    
    //----------------------------------
	//  defaultValue
	//----------------------------------
	
	/**
	 * @private
	 */
	 private var _defaultValue:String;
	
	/**
	 * @private
	 */
    public function get defaultValue():String
    {
        return _defaultValue;
    }
    
    //----------------------------------
	//  asType
	//----------------------------------
	
	/**
	 * @private
	 */
	private var _asType:String;
    
	/**
	 * @private
	 */
    public function get asType():String
    {
    	return _asType ;
    }
}

}
