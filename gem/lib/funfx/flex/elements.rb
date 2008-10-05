require 'funfx'
require 'funfx/flex/element'
require 'funfx/flex/tabular_data'

module FunFX
  module Flex
    module Elements
    
      class FlexDisplayObject < Element
      
      
        def tab_children?
          get_property_value('tabChildren', TrueClass)
        end
      
        def tab_enabled?
          get_property_value('tabEnabled', TrueClass)
        end
      
        def tab_index
          get_property_value('tabIndex', Integer)
        end
      
        def mouse_enabled?
          get_property_value('mouseEnabled', TrueClass)
        end
      
        def alpha
          get_property_value('alpha', Integer)
        end
      
        def height
          get_property_value('height', Integer)
        end
      
        def visible?
          get_property_value('visible', TrueClass)
        end
      
        def width
          get_property_value('width', Integer)
        end
      
        def x
          get_property_value('x', Integer)
        end
      
        def y
          get_property_value('y', Integer)
        end
      
      
        def mouse_move(local_x=0, local_y=0, key_modifier=["0"])
          fire_event('MouseMove', local_x, local_y, key_modifier)
        end
      
        def click(key_modifier=["0"])
          fire_event('Click', key_modifier)
        end
      
      end
      
      def display_object(*locator_hash)
        FlexDisplayObject.new(self, *locator_hash)
      end
    
      class FlexListLabel < FlexDisplayObject
      
      
        def automation_value
          get_property_value('automationValue', String)
        end
      
        def automation_name
          get_property_value('automationName', String)
        end
      
        def class_name
          get_property_value('className', String)
        end
      
        def automation_index
          get_property_value('automationIndex', String)
        end
      
      
      end
      
      def list_label(*locator_hash)
        FlexListLabel.new(self, *locator_hash)
      end
    
      class FlexObject < FlexDisplayObject
      
      
        def automation_name
          get_property_value('automationName', String)
        end
      
        def automation_class_name
          get_property_value('automationClassName', String)
        end
      
        def id
          get_property_value('id', String)
        end
      
        def class_name
          get_property_value('className', String)
        end
      
        def automation_index
          get_property_value('automationIndex', String)
        end
      
        def current_state
          get_property_value('currentState', String)
        end
      
        def focus_enabled?
          get_property_value('focusEnabled', TrueClass)
        end
      
        def tool_tip
          get_property_value('toolTip', String)
        end
      
        def error_string
          get_property_value('errorString', String)
        end
      
        def percent_height
          get_property_value('percentHeight', Integer)
        end
      
        def percent_width
          get_property_value('percentWidth', Integer)
        end
      
        def scale_x
          get_property_value('scaleX', Integer)
        end
      
        def scale_y
          get_property_value('scaleY', Integer)
        end
      
        def error_color
          get_property_value('errorColor', String)
        end
      
        def theme_color
          get_property_value('themeColor', String)
        end
      
        def enabled?
          get_property_value('enabled', TrueClass)
        end
      
        def use_hand_cursor?
          get_property_value('useHandCursor', TrueClass)
        end
      
        def num_automation_children
          get_property_value('numAutomationChildren', Integer)
        end
      
      
        def change_focus(shift_key, key_code="TAB")
          fire_event('ChangeFocus', shift_key, key_code)
        end
      
      end
      
      def object(*locator_hash)
        FlexObject.new(self, *locator_hash)
      end
    
      class FlexScrollBar < FlexObject
      
      
        def line_scroll_size
          get_property_value('lineScrollSize', Integer)
        end
      
        def page_scroll_size
          get_property_value('pageScrollSize', Integer)
        end
      
        def scroll_position
          get_property_value('scrollPosition', String)
        end
      
        def track_colors
          get_property_value('trackColors', String)
        end
      
        def fill_colors
          get_property_value('fillColors', String)
        end
      
      
        def scroll(position, direction, detail=["null"])
          fire_event('Scroll', position, direction, detail)
        end
      
      end
      
      def scroll_bar(*locator_hash)
        FlexScrollBar.new(self, *locator_hash)
      end
    
      class FlexMenu < FlexObject
      
        include TabularData
      
      
        def row_count
          get_property_value('rowCount', Integer)
        end
      
        def selected_index
          get_property_value('selectedIndex', Integer)
        end
      
        def alternating_row_colors
          get_property_value('alternatingRowColors', String)
        end
      
        def roll_over_color
          get_property_value('rollOverColor', String)
        end
      
        def selection_color
          get_property_value('selectionColor', String)
        end
      
        def text_roll_over_color
          get_property_value('textRollOverColor', String)
        end
      
        def text_selected_color
          get_property_value('textSelectedColor', String)
        end
      
      
        def type(key_code, key_modifier=["0"])
          fire_event('Type', key_code, key_modifier)
        end
      
        def show(item_renderer)
          fire_event('Show', item_renderer)
        end
      
        def hide()
          fire_event('Hide')
        end
      
        def select(item_renderer)
          fire_event('Select', item_renderer)
        end
      
      end
      
      def menu(*locator_hash)
        FlexMenu.new(self, *locator_hash)
      end
    
      class FlexLabel < FlexObject
      
      
        def text
          get_property_value('text', String)
        end
      
        def html_text
          get_property_value('htmlText', String)
        end
      
        def color
          get_property_value('color', String)
        end
      
        def disabled_color
          get_property_value('disabledColor', String)
        end
      
        def font_family
          get_property_value('fontFamily', String)
        end
      
        def font_size
          get_property_value('fontSize', Integer)
        end
      
        def font_style
          get_property_value('fontStyle', String)
        end
      
        def font_weight
          get_property_value('fontWeight', String)
        end
      
        def text_align
          get_property_value('textAlign', String)
        end
      
        def text_decoration
          get_property_value('textDecoration', String)
        end
      
        def text_indent
          get_property_value('textIndent', Integer)
        end
      
      
        def click(ctrl_key, alt_key, shift_key)
          fire_event('Click', ctrl_key, alt_key, shift_key)
        end
      
      end
      
      def label(*locator_hash)
        FlexLabel.new(self, *locator_hash)
      end
    
      class FlexDateChooser < FlexObject
      
      
        def selected_date
          get_property_value('selectedDate', Date)
        end
      
        def disabled_days
          get_property_value('disabledDays', String)
        end
      
        def disabled_ranges
          get_property_value('disabledRanges', String)
        end
      
        def allow_disjoint_selection?
          get_property_value('allowDisjointSelection', TrueClass)
        end
      
        def displayed_month
          get_property_value('displayedMonth', Integer)
        end
      
        def displayed_year
          get_property_value('displayedYear', Integer)
        end
      
        def first_day_of_week
          get_property_value('firstDayOfWeek', Integer)
        end
      
        def max_year
          get_property_value('maxYear', Integer)
        end
      
        def min_year
          get_property_value('minYear', Integer)
        end
      
        def allow_multiple_selection?
          get_property_value('allowMultipleSelection', TrueClass)
        end
      
        def selected_ranges
          get_property_value('selectedRanges', String)
        end
      
        def show_today?
          get_property_value('showToday', TrueClass)
        end
      
        def year_navigation_enabled?
          get_property_value('yearNavigationEnabled', TrueClass)
        end
      
        def header_colors
          get_property_value('headerColors', String)
        end
      
        def roll_over_color
          get_property_value('rollOverColor', String)
        end
      
        def today_color
          get_property_value('todayColor', String)
        end
      
        def color
          get_property_value('color', String)
        end
      
        def disabled_color
          get_property_value('disabledColor', String)
        end
      
        def fill_colors
          get_property_value('fillColors', String)
        end
      
        def font_family
          get_property_value('fontFamily', String)
        end
      
        def font_size
          get_property_value('fontSize', Integer)
        end
      
        def font_style
          get_property_value('fontStyle', String)
        end
      
        def font_weight
          get_property_value('fontWeight', String)
        end
      
        def text_align
          get_property_value('textAlign', String)
        end
      
        def text_decoration
          get_property_value('textDecoration', String)
        end
      
        def text_indent
          get_property_value('textIndent', Integer)
        end
      
        def header_colors
          get_property_value('headerColors', String)
        end
      
        def roll_over_color
          get_property_value('rollOverColor', String)
        end
      
        def selection_color
          get_property_value('selectionColor', String)
        end
      
      
        def change(new_date)
          fire_event('Change', new_date)
        end
      
        def scroll(detail)
          fire_event('Scroll', detail)
        end
      
        def type(key_code, key_modifier=["0"])
          fire_event('Type', key_code, key_modifier)
        end
      
      end
      
      def date_chooser(*locator_hash)
        FlexDateChooser.new(self, *locator_hash)
      end
    
      class FlexChartSeries < FlexObject
      
        include TabularData
      
      
      
        def click(hit_set)
          fire_event('Click', hit_set)
        end
      
        def double_click(hit_set)
          fire_event('DoubleClick', hit_set)
        end
      
        def item_roll_over(hit_set)
          fire_event('ItemRollOver', hit_set)
        end
      
      end
      
      def chart_series(*locator_hash)
        FlexChartSeries.new(self, *locator_hash)
      end
    
      class FlexLineSeries < FlexChartSeries
      
        include TabularData
      
      
        def form
          get_property_value('form', String)
        end
      
        def radius
          get_property_value('radius', Integer)
        end
      
        def sort_on_x_field?
          get_property_value('sortOnXField', TrueClass)
        end
      
        def x_field
          get_property_value('xField', String)
        end
      
        def y_field
          get_property_value('yField', String)
        end
      
      
      end
      
      def line_series(*locator_hash)
        FlexLineSeries.new(self, *locator_hash)
      end
    
      class FlexPieSeries < FlexChartSeries
      
        include TabularData
      
      
        def explode_radius
          get_property_value('explodeRadius', Integer)
        end
      
        def field
          get_property_value('field', String)
        end
      
        def max_label_radius
          get_property_value('maxLabelRadius', Integer)
        end
      
        def name_field
          get_property_value('nameField', String)
        end
      
        def outer_radius
          get_property_value('outerRadius', Integer)
        end
      
        def inside_label_size_limit
          get_property_value('insideLabelSizeLimit', Integer)
        end
      
        def inner_radius
          get_property_value('innerRadius', Integer)
        end
      
        def font_size
          get_property_value('fontSize', Integer)
        end
      
        def callout_gap
          get_property_value('calloutGap', Integer)
        end
      
        def start_angle
          get_property_value('startAngle', Integer)
        end
      
        def label_position
          get_property_value('labelPosition', String)
        end
      
      
      end
      
      def pie_series(*locator_hash)
        FlexPieSeries.new(self, *locator_hash)
      end
    
      class FlexBubbleSeries < FlexChartSeries
      
        include TabularData
      
      
        def max_radius
          get_property_value('maxRadius', Integer)
        end
      
        def radius_field
          get_property_value('radiusField', String)
        end
      
        def x_field
          get_property_value('xField', String)
        end
      
        def y_field
          get_property_value('yField', String)
        end
      
      
      end
      
      def bubble_series(*locator_hash)
        FlexBubbleSeries.new(self, *locator_hash)
      end
    
      class FlexPlotSeries < FlexChartSeries
      
        include TabularData
      
      
        def radius
          get_property_value('radius', Integer)
        end
      
        def x_field
          get_property_value('xField', String)
        end
      
        def y_field
          get_property_value('yField', String)
        end
      
      
      end
      
      def plot_series(*locator_hash)
        FlexPlotSeries.new(self, *locator_hash)
      end
    
      class FlexAreaSeries < FlexChartSeries
      
        include TabularData
      
      
        def min_field
          get_property_value('minField', String)
        end
      
        def x_field
          get_property_value('xField', String)
        end
      
        def y_field
          get_property_value('yField', String)
        end
      
        def form
          get_property_value('form', String)
        end
      
        def radius
          get_property_value('radius', Integer)
        end
      
      
      end
      
      def area_series(*locator_hash)
        FlexAreaSeries.new(self, *locator_hash)
      end
    
      class FlexColumnSeries < FlexChartSeries
      
        include TabularData
      
      
        def column_width_ratio
          get_property_value('columnWidthRatio', Integer)
        end
      
        def max_column_width
          get_property_value('maxColumnWidth', Integer)
        end
      
        def offset
          get_property_value('offset', Integer)
        end
      
        def sort_on_x_field?
          get_property_value('sortOnXField', TrueClass)
        end
      
        def min_field
          get_property_value('minField', String)
        end
      
        def x_field
          get_property_value('xField', String)
        end
      
        def y_field
          get_property_value('yField', String)
        end
      
      
      end
      
      def column_series(*locator_hash)
        FlexColumnSeries.new(self, *locator_hash)
      end
    
      class FlexBarSeries < FlexChartSeries
      
        include TabularData
      
      
        def bar_width_ratio
          get_property_value('barWidthRatio', Integer)
        end
      
        def max_bar_width
          get_property_value('maxBarWidth', Integer)
        end
      
        def min_field
          get_property_value('minField', String)
        end
      
        def offset
          get_property_value('offset', Integer)
        end
      
        def x_field
          get_property_value('xField', String)
        end
      
        def y_field
          get_property_value('yField', String)
        end
      
      
      end
      
      def bar_series(*locator_hash)
        FlexBarSeries.new(self, *locator_hash)
      end
    
      class FlexAxisRenderer < FlexObject
      
        include TabularData
      
      
        def height_limit
          get_property_value('heightLimit', Integer)
        end
      
        def length
          get_property_value('length', Integer)
        end
      
        def placement
          get_property_value('placement', String)
        end
      
        def can_drop_labels?
          get_property_value('canDropLabels', TrueClass)
        end
      
        def can_stagger?
          get_property_value('canStagger', TrueClass)
        end
      
        def label_gap
          get_property_value('labelGap', Integer)
        end
      
        def label_rotation
          get_property_value('labelRotation', Integer)
        end
      
        def minor_tick_length
          get_property_value('minorTickLength', Integer)
        end
      
        def minor_tick_placement
          get_property_value('minorTickPlacement', String)
        end
      
        def show_labels?
          get_property_value('showLabels', TrueClass)
        end
      
        def show_line?
          get_property_value('showLine', TrueClass)
        end
      
        def tick_length
          get_property_value('tickLength', Integer)
        end
      
        def tick_placement
          get_property_value('tickPlacement', String)
        end
      
        def ticks
          get_property_value('ticks', String)
        end
      
        def minor_ticks
          get_property_value('minorTicks', String)
        end
      
      
      end
      
      def axis_renderer(*locator_hash)
        FlexAxisRenderer.new(self, *locator_hash)
      end
    
      class FlexChart < FlexObject
      
        include TabularData
      
      
        def description
          get_property_value('description', String)
        end
      
        def clip_content?
          get_property_value('clipContent', TrueClass)
        end
      
        def data_tip_layer_index
          get_property_value('dataTipLayerIndex', Integer)
        end
      
        def data_tip_mode
          get_property_value('dataTipMode', String)
        end
      
        def mouse_sensitivity
          get_property_value('mouseSensitivity', Integer)
        end
      
        def show_data_tips?
          get_property_value('showDataTips', TrueClass)
        end
      
        def font_family
          get_property_value('fontFamily', String)
        end
      
        def font_size
          get_property_value('fontSize', Integer)
        end
      
        def maximum_data_tip_count
          get_property_value('maximumDataTipCount', Integer)
        end
      
        def padding_bottom
          get_property_value('paddingBottom', Integer)
        end
      
        def padding_top
          get_property_value('paddingTop', Integer)
        end
      
        def padding_left
          get_property_value('paddingLeft', Integer)
        end
      
        def padding_right
          get_property_value('paddingRight', Integer)
        end
      
        def show_data_tip_targets?
          get_property_value('showDataTipTargets', TrueClass)
        end
      
      
      end
      
      def chart(*locator_hash)
        FlexChart.new(self, *locator_hash)
      end
    
      class FlexCartesianChart < FlexChart
      
        include TabularData
      
      
        def horizontal_axis_ratio
          get_property_value('horizontalAxisRatio', Integer)
        end
      
        def gutter_left
          get_property_value('gutterLeft', Integer)
        end
      
        def gutter_right
          get_property_value('gutterRight', Integer)
        end
      
        def gutter_bottom
          get_property_value('gutterBottom', Integer)
        end
      
        def gutter_top
          get_property_value('gutterTop', Integer)
        end
      
        def text_align
          get_property_value('textAlign', String)
        end
      
      
      end
      
      def cartesian_chart(*locator_hash)
        FlexCartesianChart.new(self, *locator_hash)
      end
    
      class FlexAreaChart < FlexCartesianChart
      
        include TabularData
      
      
        def type
          get_property_value('type', String)
        end
      
      
      end
      
      def area_chart(*locator_hash)
        FlexAreaChart.new(self, *locator_hash)
      end
    
      class FlexColumnChart < FlexCartesianChart
      
        include TabularData
      
      
        def column_width_ratio
          get_property_value('columnWidthRatio', Integer)
        end
      
        def max_column_width
          get_property_value('maxColumnWidth', Integer)
        end
      
      
      end
      
      def column_chart(*locator_hash)
        FlexColumnChart.new(self, *locator_hash)
      end
    
      class FlexLineChart < FlexCartesianChart
      
        include TabularData
      
      
      
      end
      
      def line_chart(*locator_hash)
        FlexLineChart.new(self, *locator_hash)
      end
    
      class FlexBarChart < FlexCartesianChart
      
        include TabularData
      
      
        def bar_width_ratio
          get_property_value('barWidthRatio', Integer)
        end
      
        def max_bar_width
          get_property_value('maxBarWidth', Integer)
        end
      
      
      end
      
      def bar_chart(*locator_hash)
        FlexBarChart.new(self, *locator_hash)
      end
    
      class FlexHLOCChart < FlexCartesianChart
      
        include TabularData
      
      
        def column_width_ratio
          get_property_value('columnWidthRatio', Integer)
        end
      
        def max_column_width
          get_property_value('maxColumnWidth', Integer)
        end
      
      
      end
      
      def hloc_chart(*locator_hash)
        FlexHLOCChart.new(self, *locator_hash)
      end
    
      class FlexPieChart < FlexChart
      
        include TabularData
      
      
        def inner_radius
          get_property_value('innerRadius', Integer)
        end
      
        def text_align
          get_property_value('textAlign', String)
        end
      
      
      end
      
      def pie_chart(*locator_hash)
        FlexPieChart.new(self, *locator_hash)
      end
    
      class FlexProgressBar < FlexObject
      
      
        def conversion
          get_property_value('conversion', Integer)
        end
      
        def direction
          get_property_value('direction', String)
        end
      
        def indeterminate?
          get_property_value('indeterminate', TrueClass)
        end
      
        def label
          get_property_value('label', String)
        end
      
        def label_placement
          get_property_value('labelPlacement', String)
        end
      
        def maximum
          get_property_value('maximum', Integer)
        end
      
        def minimum
          get_property_value('minimum', Integer)
        end
      
        def percent_complete
          get_property_value('percentComplete', Integer)
        end
      
        def value
          get_property_value('value', Integer)
        end
      
        def bar_color
          get_property_value('barColor', String)
        end
      
        def border_color
          get_property_value('borderColor', String)
        end
      
        def color
          get_property_value('color', String)
        end
      
        def disabled_color
          get_property_value('disabledColor', String)
        end
      
        def fill_colors
          get_property_value('fillColors', String)
        end
      
        def font_family
          get_property_value('fontFamily', String)
        end
      
        def font_size
          get_property_value('fontSize', Integer)
        end
      
        def font_style
          get_property_value('fontStyle', String)
        end
      
        def font_weight
          get_property_value('fontWeight', String)
        end
      
        def label_width
          get_property_value('labelWidth', Integer)
        end
      
        def text_align
          get_property_value('textAlign', String)
        end
      
        def text_decoration
          get_property_value('textDecoration', String)
        end
      
        def text_indent
          get_property_value('textIndent', Integer)
        end
      
        def theme_color
          get_property_value('themeColor', String)
        end
      
      
      end
      
      def progress_bar(*locator_hash)
        FlexProgressBar.new(self, *locator_hash)
      end
    
      class FlexScrollBase < FlexObject
      
      
      
        def mouse_scroll(delta=0)
          fire_event('MouseScroll', delta)
        end
      
      end
      
      def scroll_base(*locator_hash)
        FlexScrollBase.new(self, *locator_hash)
      end
    
      class FlexTextArea < FlexScrollBase
      
      
        def editable?
          get_property_value('editable', TrueClass)
        end
      
        def display_as_password?
          get_property_value('displayAsPassword', TrueClass)
        end
      
        def text
          get_property_value('text', String)
        end
      
        def color
          get_property_value('color', Integer)
        end
      
        def horizontal_scroll_policy
          get_property_value('horizontalScrollPolicy', String)
        end
      
        def html_text
          get_property_value('htmlText', String)
        end
      
        def length
          get_property_value('length', Integer)
        end
      
        def max_chars
          get_property_value('maxChars', Integer)
        end
      
        def restrict
          get_property_value('restrict', String)
        end
      
        def selection
          get_property_value('selection', String)
        end
      
        def word_wrap?
          get_property_value('wordWrap', TrueClass)
        end
      
        def disabled_color
          get_property_value('disabledColor', String)
        end
      
        def font_family
          get_property_value('fontFamily', String)
        end
      
        def font_size
          get_property_value('fontSize', Integer)
        end
      
        def font_style
          get_property_value('fontStyle', String)
        end
      
        def font_weight
          get_property_value('fontWeight', String)
        end
      
      
        def input(text)
          fire_event('Input', text)
        end
      
        def select_text(begin_index, end_index)
          fire_event('SelectText', begin_index, end_index)
        end
      
        def type(key_code, key_modifier=["0"])
          fire_event('Type', key_code, key_modifier)
        end
      
        def scroll(position, direction, detail=["null"])
          fire_event('Scroll', position, direction, detail)
        end
      
      end
      
      def text_area(*locator_hash)
        FlexTextArea.new(self, *locator_hash)
      end
    
      class FlexAdvancedListBase < FlexScrollBase
      
        include TabularData
      
      
      
        def select(item_renderer, trigger_event=["1"], key_modifier=["0"])
          fire_event('Select', item_renderer, trigger_event, key_modifier)
        end
      
      end
      
      def advanced_list_base(*locator_hash)
        FlexAdvancedListBase.new(self, *locator_hash)
      end
    
      class FlexAdvancedDataGridBase < FlexAdvancedListBase
      
        include TabularData
      
      
      
      end
      
      def advanced_data_grid_base(*locator_hash)
        FlexAdvancedDataGridBase.new(self, *locator_hash)
      end
    
      class FlexAdvancedDataGridBaseEx < FlexAdvancedDataGridBase
      
        include TabularData
      
      
      
      end
      
      def advanced_data_grid_base_ex(*locator_hash)
        FlexAdvancedDataGridBaseEx.new(self, *locator_hash)
      end
    
      class FlexAdvancedDataGrid < FlexAdvancedDataGridBaseEx
      
        include TabularData
      
      
      
        def select(item_renderer, trigger_event=["1"], key_modifier=["0"])
          fire_event('Select', item_renderer, trigger_event, key_modifier)
        end
      
        def item_open(item_renderer, trigger_event=["1"], key_modifier=["0"])
          fire_event('ItemOpen', item_renderer, trigger_event, key_modifier)
        end
      
        def item_close(item_renderer, trigger_event=["1"], key_modifier=["0"])
          fire_event('ItemClose', item_renderer, trigger_event, key_modifier)
        end
      
        def select_index(item_index, trigger_event=["1"])
          fire_event('SelectIndex', item_index, trigger_event)
        end
      
      end
      
      def advanced_data_grid(*locator_hash)
        FlexAdvancedDataGrid.new(self, *locator_hash)
      end
    
      class FlexListBase < FlexScrollBase
      
      
        def column_count
          get_property_value('columnCount', Integer)
        end
      
        def column_width
          get_property_value('columnWidth', Integer)
        end
      
        def data_tip_field
          get_property_value('dataTipField', String)
        end
      
        def icon_field
          get_property_value('iconField', String)
        end
      
        def label_field
          get_property_value('labelField', String)
        end
      
        def locked_column_count
          get_property_value('lockedColumnCount', Integer)
        end
      
        def locked_row_count
          get_property_value('lockedRowCount', Integer)
        end
      
        def allow_multiple_selection?
          get_property_value('allowMultipleSelection', TrueClass)
        end
      
        def num_automation_children
          get_property_value('numAutomationChildren', Integer)
        end
      
        def row_count
          get_property_value('rowCount', Integer)
        end
      
        def row_height
          get_property_value('rowHeight', Integer)
        end
      
        def selectable?
          get_property_value('selectable', TrueClass)
        end
      
        def selected_index
          get_property_value('selectedIndex', Integer)
        end
      
        def selected_indices
          get_property_value('selectedIndices', String)
        end
      
        def selected_item
          get_property_value('selectedItem', String)
        end
      
        def selected_items
          get_property_value('selectedItems', String)
        end
      
        def show_data_tips?
          get_property_value('showDataTips', TrueClass)
        end
      
        def variable_row_height?
          get_property_value('variableRowHeight', TrueClass)
        end
      
        def word_wrap?
          get_property_value('wordWrap', TrueClass)
        end
      
        def alternating_row_colors
          get_property_value('alternatingRowColors', String)
        end
      
        def focus_alpha
          get_property_value('focusAlpha', Integer)
        end
      
        def roll_over_color
          get_property_value('rollOverColor', String)
        end
      
        def selection_color
          get_property_value('selectionColor', String)
        end
      
        def selection_disabled_color
          get_property_value('selectionDisabledColor', String)
        end
      
        def text_roll_over_color
          get_property_value('textRollOverColor', String)
        end
      
        def text_selected_color
          get_property_value('textSelectedColor', String)
        end
      
        def background_disabled_color
          get_property_value('backgroundDisabledColor', String)
        end
      
        def use_roll_over?
          get_property_value('useRollOver', TrueClass)
        end
      
        def vertical_align
          get_property_value('verticalAlign', String)
        end
      
      
        def mouse_scroll(delta=0)
          fire_event('MouseScroll', delta)
        end
      
        def drag_start(dragged_item, key_modifier=["0"])
          fire_event('DragStart', dragged_item, key_modifier)
        end
      
        def drag_drop(action, dragged_item="", key_modifier=["0"])
          fire_event('DragDrop', action, dragged_item, key_modifier)
        end
      
        def drag_cancel(key_modifier=["0"])
          fire_event('DragCancel', key_modifier)
        end
      
        def select(item_renderer, trigger_event=["1"], key_modifier=["0"])
          fire_event('Select', item_renderer, trigger_event, key_modifier)
        end
      
        def multi_select(item_renderer, trigger_event=["1"], key_modifier=["0"])
          fire_event('MultiSelect', item_renderer, trigger_event, key_modifier)
        end
      
        def deselect(item_renderer, trigger_event=["1"], key_modifier=["0"])
          fire_event('Deselect', item_renderer, trigger_event, key_modifier)
        end
      
        def scroll(position, direction, detail=["null"])
          fire_event('Scroll', position, direction, detail)
        end
      
        def type(key_code, key_modifier=["0"])
          fire_event('Type', key_code, key_modifier)
        end
      
        def double_click(item_renderer)
          fire_event('DoubleClick', item_renderer)
        end
      
      end
      
      def list_base(*locator_hash)
        FlexListBase.new(self, *locator_hash)
      end
    
      class FlexDataGrid < FlexListBase
      
        include TabularData
      
      
        def editable?
          get_property_value('editable', TrueClass)
        end
      
        def min_column_width
          get_property_value('minColumnWidth', Integer)
        end
      
        def resizable_columns?
          get_property_value('resizableColumns', TrueClass)
        end
      
        def sortable_columns?
          get_property_value('sortableColumns', TrueClass)
        end
      
        def header_colors
          get_property_value('headerColors', String)
        end
      
        def header_style
          get_property_value('headerStyle', String)
        end
      
        def v_grid_line_color
          get_property_value('vGridLineColor', String)
        end
      
        def v_grid_lines?
          get_property_value('vGridLines', TrueClass)
        end
      
      
        def header_click(column_index)
          fire_event('HeaderClick', column_index)
        end
      
        def column_stretch(column_index, local_x)
          fire_event('ColumnStretch', column_index, local_x)
        end
      
        def header_shift(new_index, old_index, trigger_event=["1"])
          fire_event('HeaderShift', new_index, old_index, trigger_event)
        end
      
        def edit(item_renderer, row_index, column_index)
          fire_event('Edit', item_renderer, row_index, column_index)
        end
      
      end
      
      def data_grid(*locator_hash)
        FlexDataGrid.new(self, *locator_hash)
      end
    
      class FlexList < FlexListBase
      
        include TabularData
      
      
      
        def edit(item_renderer, row_index, column_index)
          fire_event('Edit', item_renderer, row_index, column_index)
        end
      
      end
      
      def list(*locator_hash)
        FlexList.new(self, *locator_hash)
      end
    
      class FlexTree < FlexListBase
      
        include TabularData
      
      
        def editable?
          get_property_value('editable', TrueClass)
        end
      
        def depth_colors
          get_property_value('depthColors', String)
        end
      
        def indentation
          get_property_value('indentation', Integer)
        end
      
        def text_disabled_color
          get_property_value('textDisabledColor', String)
        end
      
      
        def drag_drop(action, drop_parent="", dragged_item="", key_modifier=["0"])
          fire_event('DragDrop', action, drop_parent, dragged_item, key_modifier)
        end
      
        def open(item_renderer, trigger_event=["1"])
          fire_event('Open', item_renderer, trigger_event)
        end
      
        def close(item_renderer, trigger_event=["1"])
          fire_event('Close', item_renderer, trigger_event)
        end
      
      end
      
      def tree(*locator_hash)
        FlexTree.new(self, *locator_hash)
      end
    
      class FlexVideoDisplay < FlexObject
      
      
        def source
          get_property_value('source', String)
        end
      
        def total_time
          get_property_value('totalTime', Integer)
        end
      
        def volume
          get_property_value('volume', Integer)
        end
      
      
      end
      
      def video_display(*locator_hash)
        FlexVideoDisplay.new(self, *locator_hash)
      end
    
      class FlexMenuBar < FlexObject
      
        include TabularData
      
      
        def num_children
          get_property_value('numChildren', Integer)
        end
      
        def selected_index
          get_property_value('selectedIndex', Integer)
        end
      
        def background_color
          get_property_value('backgroundColor', String)
        end
      
        def color
          get_property_value('color', String)
        end
      
        def disabled_color
          get_property_value('disabledColor', String)
        end
      
        def fill_colors
          get_property_value('fillColors', String)
        end
      
        def font_family
          get_property_value('fontFamily', String)
        end
      
        def font_size
          get_property_value('fontSize', Integer)
        end
      
        def font_style
          get_property_value('fontStyle', String)
        end
      
        def font_weight
          get_property_value('fontWeight', String)
        end
      
        def text_align
          get_property_value('textAlign', String)
        end
      
        def text_decoration
          get_property_value('textDecoration', String)
        end
      
        def roll_over_color
          get_property_value('rollOverColor', String)
        end
      
        def selection_color
          get_property_value('selectionColor', String)
        end
      
        def text_indent
          get_property_value('textIndent', Integer)
        end
      
      
        def type(key_code, key_modifier=["0"])
          fire_event('Type', key_code, key_modifier)
        end
      
        def show(item_renderer)
          fire_event('Show', item_renderer)
        end
      
        def hide()
          fire_event('Hide')
        end
      
      end
      
      def menu_bar(*locator_hash)
        FlexMenuBar.new(self, *locator_hash)
      end
    
      class FlexRule < FlexObject
      
      
        def color
          get_property_value('color', String)
        end
      
        def stroke_width
          get_property_value('strokeWidth', Integer)
        end
      
      
      end
      
      def rule(*locator_hash)
        FlexRule.new(self, *locator_hash)
      end
    
      class FlexComboBase < FlexObject
      
      
        def text
          get_property_value('text', String)
        end
      
        def restrict
          get_property_value('restrict', String)
        end
      
        def editable?
          get_property_value('editable', TrueClass)
        end
      
        def selected_index
          get_property_value('selectedIndex', Integer)
        end
      
        def horizontal_scroll_position
          get_property_value('horizontalScrollPosition', Integer)
        end
      
        def horizontal_scroll_policy
          get_property_value('horizontalScrollPolicy', String)
        end
      
        def live_scrolling?
          get_property_value('liveScrolling', TrueClass)
        end
      
        def show_scroll_tips?
          get_property_value('showScrollTips', TrueClass)
        end
      
        def vertical_scroll_position
          get_property_value('verticalScrollPosition', Integer)
        end
      
        def vertical_scroll_policy
          get_property_value('verticalScrollPolicy', String)
        end
      
        def background_alpha
          get_property_value('backgroundAlpha', Integer)
        end
      
        def background_color
          get_property_value('backgroundColor', String)
        end
      
        def background_image
          get_property_value('backgroundImage', String)
        end
      
        def background_size
          get_property_value('backgroundSize', String)
        end
      
        def color
          get_property_value('color', Integer)
        end
      
        def disabled_color
          get_property_value('disabledColor', String)
        end
      
        def drop_shadow_enabled?
          get_property_value('dropShadowEnabled', TrueClass)
        end
      
        def fill_alphas
          get_property_value('fillAlphas', String)
        end
      
        def fill_colors
          get_property_value('fillColors', String)
        end
      
        def font_family
          get_property_value('fontFamily', String)
        end
      
        def font_size
          get_property_value('fontSize', Integer)
        end
      
        def font_style
          get_property_value('fontStyle', String)
        end
      
        def font_weight
          get_property_value('fontWeight', String)
        end
      
        def highlight_color
          get_property_value('highlightColor', String)
        end
      
        def text_align
          get_property_value('textAlign', String)
        end
      
        def text_decoration
          get_property_value('textDecoration', String)
        end
      
        def text_indent
          get_property_value('textIndent', Integer)
        end
      
      
        def open(trigger_event=["1"])
          fire_event('Open', trigger_event)
        end
      
        def close(trigger_event=["1"])
          fire_event('Close', trigger_event)
        end
      
        def scroll(position, direction, detail=["null"])
          fire_event('Scroll', position, direction, detail)
        end
      
        def input(text)
          fire_event('Input', text)
        end
      
        def select_text(begin_index, end_index)
          fire_event('SelectText', begin_index, end_index)
        end
      
        def type(key_code, key_modifier=["0"])
          fire_event('Type', key_code, key_modifier)
        end
      
      end
      
      def combo_base(*locator_hash)
        FlexComboBase.new(self, *locator_hash)
      end
    
      class FlexComboBox < FlexComboBase
      
        include TabularData
      
      
        def text
          get_property_value('text', String)
        end
      
        def selected_index
          get_property_value('selectedIndex', Integer)
        end
      
        def editable?
          get_property_value('editable', TrueClass)
        end
      
        def alternating_row_colors
          get_property_value('alternatingRowColors', String)
        end
      
        def fill_colors
          get_property_value('fillColors', String)
        end
      
        def roll_over_color?
          get_property_value('rollOverColor', TrueClass)
        end
      
        def selection_color?
          get_property_value('selectionColor', TrueClass)
        end
      
      
        def select(item_renderer, trigger_event=["1"], key_modifier=["0"])
          fire_event('Select', item_renderer, trigger_event, key_modifier)
        end
      
        def type(key_code, key_modifier=["0"])
          fire_event('Type', key_code, key_modifier)
        end
      
        def input(text)
          fire_event('Input', text)
        end
      
      end
      
      def combo_box(*locator_hash)
        FlexComboBox.new(self, *locator_hash)
      end
    
      class FlexColorPicker < FlexComboBase
      
      
        def selected_color
          get_property_value('selectedColor', Integer)
        end
      
        def show_text_field?
          get_property_value('showTextField', TrueClass)
        end
      
        def column_count
          get_property_value('columnCount', Integer)
        end
      
      
        def open(trigger_event=["1"])
          fire_event('Open', trigger_event)
        end
      
        def close(trigger_event=["1"])
          fire_event('Close', trigger_event)
        end
      
        def change(color)
          fire_event('Change', color)
        end
      
      end
      
      def color_picker(*locator_hash)
        FlexColorPicker.new(self, *locator_hash)
      end
    
      class FlexDateField < FlexComboBase
      
      
        def selected_date
          get_property_value('selectedDate', Date)
        end
      
        def disabled_days
          get_property_value('disabledDays', String)
        end
      
        def disabled_ranges
          get_property_value('disabledRanges', String)
        end
      
        def displayed_month
          get_property_value('displayedMonth', Integer)
        end
      
        def displayed_year
          get_property_value('displayedYear', Integer)
        end
      
        def first_day_of_week
          get_property_value('firstDayOfWeek', Integer)
        end
      
        def max_year
          get_property_value('maxYear', Integer)
        end
      
        def min_year
          get_property_value('minYear', Integer)
        end
      
        def show_today?
          get_property_value('showToday', TrueClass)
        end
      
        def year_navigation_enabled?
          get_property_value('yearNavigationEnabled', TrueClass)
        end
      
        def header_colors
          get_property_value('headerColors', String)
        end
      
        def roll_over_color
          get_property_value('rollOverColor', String)
        end
      
        def today_color
          get_property_value('todayColor', String)
        end
      
      
        def change(new_date)
          fire_event('Change', new_date)
        end
      
        def scroll(detail)
          fire_event('Scroll', detail)
        end
      
        def type(key_code, key_modifier=["0"])
          fire_event('Type', key_code, key_modifier)
        end
      
      end
      
      def date_field(*locator_hash)
        FlexDateField.new(self, *locator_hash)
      end
    
      class FlexContainer < FlexObject
      
        include TabularData
      
      
        def num_children
          get_property_value('numChildren', Integer)
        end
      
        def label
          get_property_value('label', String)
        end
      
        def creation_policy
          get_property_value('creationPolicy', String)
        end
      
        def creation_index
          get_property_value('creationIndex', Integer)
        end
      
        def background_alpha
          get_property_value('backgroundAlpha', Integer)
        end
      
        def background_color
          get_property_value('backgroundColor', String)
        end
      
        def background_disabled_color
          get_property_value('backgroundDisabledColor', String)
        end
      
        def background_image
          get_property_value('backgroundImage', String)
        end
      
        def background_size
          get_property_value('backgroundSize', String)
        end
      
        def font_family
          get_property_value('fontFamily', String)
        end
      
        def font_size
          get_property_value('fontSize', Integer)
        end
      
        def font_style
          get_property_value('fontStyle', String)
        end
      
        def font_weight
          get_property_value('fontWeight', String)
        end
      
        def fill_alphas
          get_property_value('fillAlphas', String)
        end
      
        def fill_colors
          get_property_value('fillColors', String)
        end
      
      
        def mouse_scroll(delta=0)
          fire_event('MouseScroll', delta)
        end
      
        def scroll(position, direction, detail=["null"])
          fire_event('Scroll', position, direction, detail)
        end
      
        def drag_start(dragged_item, key_modifier=["0"])
          fire_event('DragStart', dragged_item, key_modifier)
        end
      
        def drag_drop(action, dragged_item="", key_modifier=["0"])
          fire_event('DragDrop', action, dragged_item, key_modifier)
        end
      
        def drag_cancel(key_modifier=["0"])
          fire_event('DragCancel', key_modifier)
        end
      
      end
      
      def container(*locator_hash)
        FlexContainer.new(self, *locator_hash)
      end
    
      class FlexForm < FlexContainer
      
        include TabularData
      
      
      
      end
      
      def form(*locator_hash)
        FlexForm.new(self, *locator_hash)
      end
    
      class FlexBox < FlexContainer
      
        include TabularData
      
      
        def direction
          get_property_value('direction', String)
        end
      
        def horizontal_align
          get_property_value('horizontalAlign', String)
        end
      
        def vertical_align
          get_property_value('verticalAlign', String)
        end
      
      
      end
      
      def box(*locator_hash)
        FlexBox.new(self, *locator_hash)
      end
    
      class FlexDividedBox < FlexBox
      
        include TabularData
      
      
        def resize_to_content?
          get_property_value('resizeToContent', TrueClass)
        end
      
      
        def pressed(divider_index, delta)
          fire_event('Pressed', divider_index, delta)
        end
      
        def dragged(divider_index, delta)
          fire_event('Dragged', divider_index, delta)
        end
      
        def released(divider_index, delta)
          fire_event('Released', divider_index, delta)
        end
      
      end
      
      def divided_box(*locator_hash)
        FlexDividedBox.new(self, *locator_hash)
      end
    
      class FlexNavigationBar < FlexBox
      
        include TabularData
      
      
        def direction
          get_property_value('direction', String)
        end
      
        def selected_index
          get_property_value('selectedIndex', Integer)
        end
      
      
        def change(related_object)
          fire_event('Change', related_object)
        end
      
        def type(key_code, key_modifier=["0"])
          fire_event('Type', key_code, key_modifier)
        end
      
      end
      
      def navigation_bar(*locator_hash)
        FlexNavigationBar.new(self, *locator_hash)
      end
    
      class FlexLinkBar < FlexNavigationBar
      
        include TabularData
      
      
        def selected_index
          get_property_value('selectedIndex', Integer)
        end
      
        def num_children
          get_property_value('numChildren', Integer)
        end
      
      
      end
      
      def link_bar(*locator_hash)
        FlexLinkBar.new(self, *locator_hash)
      end
    
      class FlexButtonBar < FlexNavigationBar
      
        include TabularData
      
      
        def selected_index
          get_property_value('selectedIndex', String)
        end
      
        def num_children
          get_property_value('numChildren', String)
        end
      
      
      end
      
      def button_bar(*locator_hash)
        FlexButtonBar.new(self, *locator_hash)
      end
    
      class FlexToggleButtonBar < FlexButtonBar
      
        include TabularData
      
      
        def selected_index
          get_property_value('selectedIndex', String)
        end
      
        def num_children
          get_property_value('numChildren', String)
        end
      
      
      end
      
      def toggle_button_bar(*locator_hash)
        FlexToggleButtonBar.new(self, *locator_hash)
      end
    
      class FlexApplication < FlexBox
      
        include TabularData
      
      
        def url
          get_property_value('url', String)
        end
      
      
      end
      
      def application(*locator_hash)
        FlexApplication.new(self, *locator_hash)
      end
    
      class FlexPanel < FlexContainer
      
        include TabularData
      
      
        def title
          get_property_value('title', String)
        end
      
        def status
          get_property_value('status', String)
        end
      
        def drop_shadow_enabled?
          get_property_value('dropShadowEnabled', TrueClass)
        end
      
        def footer_colors
          get_property_value('footerColors', String)
        end
      
        def header_colors
          get_property_value('headerColors', String)
        end
      
        def header_height
          get_property_value('headerHeight', Integer)
        end
      
      
      end
      
      def panel(*locator_hash)
        FlexPanel.new(self, *locator_hash)
      end
    
      class FlexTitleWindow < FlexPanel
      
        include TabularData
      
      
        def show_close_button?
          get_property_value('showCloseButton', TrueClass)
        end
      
      
      end
      
      def title_window(*locator_hash)
        FlexTitleWindow.new(self, *locator_hash)
      end
    
      class FlexAlert < FlexPanel
      
      
        def text
          get_property_value('text', String)
        end
      
        def cancel_label
          get_property_value('cancelLabel', String)
        end
      
        def default_button_flag
          get_property_value('defaultButtonFlag', Integer)
        end
      
        def no_label
          get_property_value('noLabel', String)
        end
      
        def ok_label
          get_property_value('okLabel', String)
        end
      
        def yes_label
          get_property_value('yesLabel', String)
        end
      
      
        def type(key_code, key_modifier=["0"])
          fire_event('Type', key_code, key_modifier)
        end
      
      end
      
      def alert(*locator_hash)
        FlexAlert.new(self, *locator_hash)
      end
    
      class FlexViewStack < FlexContainer
      
        include TabularData
      
      
        def selected_index
          get_property_value('selectedIndex', Integer)
        end
      
        def selected_child
          get_property_value('selectedChild', String)
        end
      
      
        def type(key_code, key_modifier=["0"])
          fire_event('Type', key_code, key_modifier)
        end
      
      end
      
      def view_stack(*locator_hash)
        FlexViewStack.new(self, *locator_hash)
      end
    
      class FlexTabNavigator < FlexViewStack
      
        include TabularData
      
      
        def horizontal_align
          get_property_value('horizontalAlign', String)
        end
      
        def horizontal_gap
          get_property_value('horizontalGap', Integer)
        end
      
        def tab_height
          get_property_value('tabHeight', Integer)
        end
      
        def tab_width
          get_property_value('tabWidth', Integer)
        end
      
      
        def change(related_object)
          fire_event('Change', related_object)
        end
      
      end
      
      def tab_navigator(*locator_hash)
        FlexTabNavigator.new(self, *locator_hash)
      end
    
      class FlexAccordion < FlexContainer
      
        include TabularData
      
      
        def selected_index
          get_property_value('selectedIndex', Integer)
        end
      
        def selected_child
          get_property_value('selectedChild', String)
        end
      
        def header_height
          get_property_value('headerHeight', Integer)
        end
      
        def horizontal_gap
          get_property_value('horizontalGap', Integer)
        end
      
        def padding_top
          get_property_value('paddingTop', Integer)
        end
      
        def padding_bottom
          get_property_value('paddingBottom', Integer)
        end
      
        def text_selected_color
          get_property_value('textSelectedColor', String)
        end
      
        def vertical_gap
          get_property_value('verticalGap', Integer)
        end
      
      
        def change(related_object="mouse")
          fire_event('Change', related_object)
        end
      
        def type(key_code, key_modifier=["0"])
          fire_event('Type', key_code, key_modifier)
        end
      
      end
      
      def accordion(*locator_hash)
        FlexAccordion.new(self, *locator_hash)
      end
    
      class FlexFormItem < FlexContainer
      
      
        def horizontal_align
          get_property_value('horizontalAlign', String)
        end
      
      
      end
      
      def form_item(*locator_hash)
        FlexFormItem.new(self, *locator_hash)
      end
    
      class FlexCanvas < FlexContainer
      
        include TabularData
      
      
      
      end
      
      def canvas(*locator_hash)
        FlexCanvas.new(self, *locator_hash)
      end
    
      class FlexLoader < FlexObject
      
      
        def source
          get_property_value('source', String)
        end
      
      
      end
      
      def loader(*locator_hash)
        FlexLoader.new(self, *locator_hash)
      end
    
      class FlexImage < FlexLoader
      
      
      
      end
      
      def image(*locator_hash)
        FlexImage.new(self, *locator_hash)
      end
    
      class FlexNumericStepper < FlexObject
      
      
        def value
          get_property_value('value', Integer)
        end
      
        def minimum
          get_property_value('minimum', Integer)
        end
      
        def maximum
          get_property_value('maximum', Integer)
        end
      
        def next_value
          get_property_value('nextValue', Integer)
        end
      
        def previous_value
          get_property_value('previousValue', Integer)
        end
      
        def step_size
          get_property_value('stepSize', Integer)
        end
      
        def color
          get_property_value('color', Integer)
        end
      
        def disabled_color
          get_property_value('disabledColor', String)
        end
      
        def fill_colors
          get_property_value('fillColors', String)
        end
      
        def font_family
          get_property_value('fontFamily', String)
        end
      
        def font_size
          get_property_value('fontSize', Integer)
        end
      
        def font_style
          get_property_value('fontStyle', String)
        end
      
        def font_weight
          get_property_value('fontWeight', String)
        end
      
        def text_align
          get_property_value('textAlign', String)
        end
      
        def text_decoration
          get_property_value('textDecoration', String)
        end
      
        def text_indent
          get_property_value('textIndent', Integer)
        end
      
      
        def change(value)
          fire_event('Change', value)
        end
      
        def input(text)
          fire_event('Input', text)
        end
      
        def select_text(begin_index, end_index)
          fire_event('SelectText', begin_index, end_index)
        end
      
        def type(key_code, key_modifier=["0"])
          fire_event('Type', key_code, key_modifier)
        end
      
      end
      
      def numeric_stepper(*locator_hash)
        FlexNumericStepper.new(self, *locator_hash)
      end
    
      class FlexChartLegend < FlexObject
      
        include TabularData
      
      
        def label
          get_property_value('label', String)
        end
      
        def marker_aspect_ratio
          get_property_value('markerAspectRatio', Integer)
        end
      
        def font_weight
          get_property_value('fontWeight', String)
        end
      
        def label_placement
          get_property_value('labelPlacement', String)
        end
      
        def marker_height
          get_property_value('markerHeight', Integer)
        end
      
        def marker_width
          get_property_value('markerWidth', Integer)
        end
      
        def padding_left
          get_property_value('paddingLeft', Integer)
        end
      
        def padding_right
          get_property_value('paddingRight', Integer)
        end
      
        def vertical_gap
          get_property_value('verticalGap', Integer)
        end
      
      
        def click(item)
          fire_event('Click', item)
        end
      
      end
      
      def chart_legend(*locator_hash)
        FlexChartLegend.new(self, *locator_hash)
      end
    
      class FlexButton < FlexObject
      
      
        def enabled?
          get_property_value('enabled', TrueClass)
        end
      
        def label
          get_property_value('label', String)
        end
      
        def label_placement
          get_property_value('labelPlacement', String)
        end
      
        def selected?
          get_property_value('selected', TrueClass)
        end
      
        def toggle?
          get_property_value('toggle', TrueClass)
        end
      
        def color
          get_property_value('color', String)
        end
      
        def disabled_color
          get_property_value('disabledColor', String)
        end
      
        def font_family
          get_property_value('fontFamily', String)
        end
      
        def font_size
          get_property_value('fontSize', Integer)
        end
      
        def font_style
          get_property_value('fontStyle', String)
        end
      
        def font_weight
          get_property_value('fontWeight', String)
        end
      
        def fill_alphas
          get_property_value('fillAlphas', String)
        end
      
        def fill_colors
          get_property_value('fillColors', String)
        end
      
        def focus_alpha
          get_property_value('focusAlpha', Integer)
        end
      
        def text_align
          get_property_value('textAlign', String)
        end
      
        def text_decoration
          get_property_value('textDecoration', String)
        end
      
        def text_indent
          get_property_value('textIndent', Integer)
        end
      
        def text_roll_over_color
          get_property_value('textRollOverColor', String)
        end
      
        def text_selected_color
          get_property_value('textSelectedColor', String)
        end
      
      
        def type(key_code, key_modifier=["0"])
          fire_event('Type', key_code, key_modifier)
        end
      
      end
      
      def button(*locator_hash)
        FlexButton.new(self, *locator_hash)
      end
    
      class FlexRadioButton < FlexButton
      
      
        def group_name
          get_property_value('groupName', String)
        end
      
        def label_placement
          get_property_value('labelPlacement', String)
        end
      
      
      end
      
      def radio_button(*locator_hash)
        FlexRadioButton.new(self, *locator_hash)
      end
    
      class FlexPopUpButton < FlexButton
      
      
      
        def open(trigger_event=["1"])
          fire_event('Open', trigger_event)
        end
      
        def close(trigger_event=["1"])
          fire_event('Close', trigger_event)
        end
      
      end
      
      def pop_up_button(*locator_hash)
        FlexPopUpButton.new(self, *locator_hash)
      end
    
      class FlexCheckBox < FlexButton
      
      
      
      end
      
      def check_box(*locator_hash)
        FlexCheckBox.new(self, *locator_hash)
      end
    
      class FlexSlider < FlexObject
      
      
        def direction
          get_property_value('direction', String)
        end
      
        def value
          get_property_value('value', Integer)
        end
      
        def values
          get_property_value('values', String)
        end
      
        def maximum
          get_property_value('maximum', Integer)
        end
      
        def minimum
          get_property_value('minimum', Integer)
        end
      
        def thumb_count
          get_property_value('thumbCount', Integer)
        end
      
        def labels
          get_property_value('labels', String)
        end
      
        def live_dragging?
          get_property_value('liveDragging', TrueClass)
        end
      
        def tool_tip_show?
          get_property_value('toolTipShow', TrueClass)
        end
      
        def snap_interval
          get_property_value('snapInterval', Integer)
        end
      
        def fill_colors
          get_property_value('fillColors', String)
        end
      
        def label_style_name
          get_property_value('labelStyleName', String)
        end
      
        def tick_color
          get_property_value('tickColor', String)
        end
      
        def tick_length
          get_property_value('tickLength', Integer)
        end
      
        def tick_thickness
          get_property_value('tickThickness', Integer)
        end
      
        def data_tip_precision
          get_property_value('dataTipPrecision', Integer)
        end
      
        def track_colors
          get_property_value('trackColors', String)
        end
      
      
        def change(value, thumb_index=0, click_target="thumb", trigger_event=["1"], key_code="")
          fire_event('Change', value, thumb_index, click_target, trigger_event, key_code)
        end
      
      end
      
      def slider(*locator_hash)
        FlexSlider.new(self, *locator_hash)
      end
    
      class FlexRepeater < Element
      
        include TabularData
      
      
        def automation_name
          get_property_value('automationName', String)
        end
      
        def id
          get_property_value('id', String)
        end
      
        def class_name
          get_property_value('className', String)
        end
      
        def automation_index
          get_property_value('automationIndex', String)
        end
      
        def count
          get_property_value('count', String)
        end
      
      
      end
      
      def repeater(*locator_hash)
        FlexRepeater.new(self, *locator_hash)
      end
    
    end
  end
end