package custom.utilities
{
	import mx.charts.AreaChart;
	import mx.charts.AxisRenderer;
	import mx.charts.BarChart;
	import mx.charts.ColumnChart;
	import mx.charts.HLOCChart;
	import mx.charts.Legend;
	import mx.charts.LineChart;
	import mx.charts.PieChart;
	import mx.charts.chartClasses.CartesianChart;
	import mx.charts.chartClasses.Series;
	import mx.charts.series.AreaSeries;
	import mx.charts.series.BarSeries;
	import mx.charts.series.BubbleSeries;
	import mx.charts.series.ColumnSeries;
	import mx.charts.series.LineSeries;
	import mx.charts.series.PieSeries;
	import mx.charts.series.PlotSeries;
	import mx.containers.Accordion;
	import mx.containers.Box;
	import mx.containers.Canvas;
	import mx.containers.DividedBox;
	import mx.containers.Form;
	import mx.containers.FormItem;
	import mx.containers.Panel;
	import mx.containers.TabNavigator;
	import mx.containers.Tile;
	import mx.containers.ViewStack;
	import mx.controls.AdvancedDataGrid;
	import mx.controls.Alert;
	import mx.controls.Button;
	import mx.controls.ButtonBar;
	import mx.controls.CheckBox;
	import mx.controls.ColorPicker;
	import mx.controls.ComboBox;
	import mx.controls.DataGrid;
	import mx.controls.DateChooser;
	import mx.controls.DateField;
	import mx.controls.HRule;
	import mx.controls.HScrollBar;
	import mx.controls.HSlider;
	import mx.controls.HorizontalList;
	import mx.controls.Image;
	import mx.controls.Label;
	import mx.controls.LinkBar;
	import mx.controls.List;
	import mx.controls.Menu;
	import mx.controls.MenuBar;
	import mx.controls.NavBar;
	import mx.controls.NumericStepper;
	import mx.controls.PopUpButton;
	import mx.controls.PopUpMenuButton;
	import mx.controls.ProgressBar;
	import mx.controls.RadioButton;
	import mx.controls.SWFLoader;
	import mx.controls.TabBar;
	import mx.controls.Text;
	import mx.controls.TextArea;
	import mx.controls.TextInput;
	import mx.controls.TileList;
	import mx.controls.ToggleButtonBar;
	import mx.controls.Tree;
	import mx.controls.VRule;
	import mx.controls.VScrollBar;
	import mx.controls.VSlider;
	import mx.controls.VideoDisplay;
	import mx.controls.dataGridClasses.DataGridItemRenderer;
	import mx.controls.listClasses.ListItemRenderer;
	import mx.controls.listClasses.TileListItemRenderer;
	import mx.controls.menuClasses.MenuBarItem;
	import mx.controls.menuClasses.MenuItemRenderer;
	import mx.controls.treeClasses.TreeItemRenderer;
	import mx.core.Application;
	import mx.core.Container;
	import mx.core.IChildList;
	import mx.core.Repeater;
	import mx.core.UIComponent;
	
	public class FlexObjectLocatorUtility implements IFlexObjectLocatorUtility{
		
		private var helper:IFlexObjectLocatorUtilityHelper;
		
		public function FlexObjectLocatorUtility(){
		}
		
		public function set flexLocatorhelper(helper:IFlexObjectLocatorUtilityHelper):void{
			this.helper = helper; 
		}
		
		public function getApplicationChildren():IChildList{
			return UIComponent(Application.application).systemManager.rawChildren;
		}
		
		public function createLocatorFromRecording(object:UIComponent):Object{
			if(object && !(object is Application)){
				if(!object.showInAutomationHierarchy) return createLocatorFromRecording(object.parent as UIComponent);
				var id:String = createAutomationID(object);
				return {parent: createLocatorFromRecording(object.parent as UIComponent), className: getClassName(object), id: createIdLocatorForObject(object, id)};
			}
			else
				return null;
		}
		
		public function createAutomationID(object:UIComponent):String{
			return getAutomationIndexForObject(helper.createAutomationID(object));
		}
		
		public function getAutomationIndexForObject(automationString:String):String{
			var automationIndexPattern:RegExp = new RegExp("\.*automationIndex{([A-Za-z0-9-!\"#$%&'()*+,./:;<>=?@[\\\]_|]*) string|object}\.*", "i");
			var resultAutomationIndex:Array = automationIndexPattern.exec(automationString);
			if(resultAutomationIndex == null || resultAutomationIndex.length < 2) return null;
			else if(resultAutomationIndex[1].match("index:-1"))
				return null;
			else return resultAutomationIndex[1];
		}
		
		private function createIdLocatorForObject(object:UIComponent, automationString:String):Object{
			var locator:Object = new Object();
			if(object.automationName && object.automationName != "")
				locator["automationName"] = object.automationName;
			if(object.id && object.id != "")
				locator["id"] = object.id;
			if(automationString)
				locator["automationIndex"] = automationString;
			if(object.automationValue && object.automationValue.length > 0)
				locator["automationValue"] = object.automationValue;
			return locator;
		}
		
		private function getClassName(object:UIComponent):String{
      if(object is Form) return "Form";               
      else if(object is Canvas) return "Canvas";        
      else if(object is DividedBox) return "DividedBox";          
      else if(object is Box) return "Box";
      else if(object is Tile) return "Tile";
      else if(object is ProgressBar) return "ProgressBar";
      else if(object is Accordion) return "Accordion";        
      else if(object is Container) return "Container";        
      else if(object is DataGrid) return "DataGrid";           
      else if(object is AdvancedDataGrid) return "AdvancedDataGrid";
      else if(object is HorizontalList) return "HorizontalList";
      else if(object is TileList) return "TileList";
      else if(object is List) return "List";        
      else if(object is Tree) return "Tree";                
      else if(object is HScrollBar) return "HScrollBar";
      else if(object is VScrollBar) return "VScrollBar";
      else if(object is NumericStepper) return "NumericStepper";     
      else if(object is VideoDisplay) return "VideoDisplay";       
      else if(object is SWFLoader) return "SWFLoader";           
      else if(object is Image) return "Image";              
      else if(object is HSlider) return "HSlider";
      else if(object is VSlider) return "VSlider";          
      else if(object is ComboBox) return "ComboBox";           
      else if(object is DateField) return "DateField";           
      else if(object is DateChooser) return "DateChooser";        
      else if(object is ColorPicker) return "ColorPicker";        
      else if(object is TextArea) return "TextArea";           
      else if(object is TextInput) return "TextInput";
      else if(object is Panel) return "Panel";             
      else if(object is Alert) return "Alert";               
      else if(object is Menu) return "Menu";                
      else if(object is MenuBar) return "MenuBar";             
      else if(object is Repeater) return "Repeater";    
      else if(object is Text) return "Text";              
      else if(object is Label) return "Label";            
      else if(object is HRule) return "HRule";
      else if(object is VRule) return "VRule";
      else if(object is FormItem) return "FormItem";            
      else if(object is ViewStack) return "ViewStack";           
      else if(object is TabNavigator) return "TabNavigator";        
      else if(object is NavBar) return "NavBar";              
      else if(object is LinkBar) return "LinkBar";             
      else if(object is ToggleButtonBar) return "ToggleButtonBar";     
      else if(object is TabBar) return "TabBar";              
      else if(object is ButtonBar) return "ButtonBar";           
      else if(object is CartesianChart) return "CartesianChart";      
      else if(object is AreaChart) return "AreaChart";          
      else if(object is BarChart) return "BarChart";            
      else if(object is ColumnChart) return "ColumnChart";         
      else if(object is HLOCChart) return "HLOCChart";           
      else if(object is LineChart) return "LineChart";           
      else if(object is PieChart) return "PieChart";            
      else if(object is AreaSeries) return "AreaSeries";          
      else if(object is BarSeries) return "BarSeries";           
      else if(object is BubbleSeries) return "BubbleSeries";       
      else if(object is ColumnSeries) return "ColumnSeries";        
      else if(object is LineSeries) return "LineSeries";          
      else if(object is PieSeries) return "PieSeries";           
      else if(object is PlotSeries) return "PlotSeries";          
      else if(object is AxisRenderer) return "AxisRenderer";       
      else if(object is Series) return "Series";             
      else if(object is Legend) return "Legend";             
      else if(object is MenuItemRenderer) return "MenuItemRenderer";
      else if(object is MenuBarItem) return "MenuBarItem";
      else if(object is TreeItemRenderer) return "TreeItemRenderer";
      else if(object is ListItemRenderer) return "ListItemRenderer";
      else if(object is DataGridItemRenderer) return "DataGridItemRenderer";
      else if(object is TileListItemRenderer) return "TileListItemRenderer";
      else if(object is CheckBox) return "CheckBox"; 
      else if(object is RadioButton) return "RadioButton";
      else if(object is PopUpMenuButton) return "PopUpMenuButton";
      else if(object is PopUpButton) return "PopUpButton";         
      else if(object is Button) return "Button";              
      else if(object is Application) return "Application";         
      else 
        return object.className;
		}

	}
}