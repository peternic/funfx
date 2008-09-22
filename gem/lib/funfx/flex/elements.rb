require 'funfx'
require 'funfx/flex/element'
require 'funfx/flex/tabular_data'

module FunFX
  module Flex
    module Elements
    
      class FlexDisplayObject < Element
      
        def tab_children?
          get_property_value("tabChildren", TrueClass)
        end
      
        def tab_enabled?
          get_property_value("tabEnabled", TrueClass)
        end
      
        def tab_index
          get_property_value("tabIndex", Integer)
        end
      
        def mouse_enabled?
          get_property_value("mouseEnabled", TrueClass)
        end
      
        def alpha
          get_property_value("alpha", Integer)
        end
      
        def height
          get_property_value("height", Integer)
        end
      
        def visible?
          get_property_value("visible", TrueClass)
        end
      
        def width
          get_property_value("width", Integer)
        end
      
        def x
          get_property_value("x", Integer)
        end
      
        def y
          get_property_value("y", Integer)
        end
      
      
        def mouse_move(local_x=0, local_y=0, key_modifier=["0"])
          fire_event(MouseMove, local_x, local_y, key_modifier)
        end
      
        def click(key_modifier=["0"])
          fire_event(Click, key_modifier)
        end
      
      end
    
      class FlexObject < FlexDisplayObject
      
        def automation_name
          get_property_value("automationName", String)
        end
      
        def automation_class_name
          get_property_value("automationClassName", String)
        end
      
        def id
          get_property_value("id", String)
        end
      
        def class_name
          get_property_value("className", String)
        end
      
        def automation_index
          get_property_value("automationIndex", String)
        end
      
        def current_state
          get_property_value("currentState", String)
        end
      
        def focus_enabled?
          get_property_value("focusEnabled", TrueClass)
        end
      
        def tool_tip
          get_property_value("toolTip", String)
        end
      
        def error_string
          get_property_value("errorString", String)
        end
      
        def percent_height
          get_property_value("percentHeight", Integer)
        end
      
        def percent_width
          get_property_value("percentWidth", Integer)
        end
      
        def scale_x
          get_property_value("scaleX", Integer)
        end
      
        def scale_y
          get_property_value("scaleY", Integer)
        end
      
        def error_color
          get_property_value("errorColor", String)
        end
      
        def theme_color
          get_property_value("themeColor", String)
        end
      
        def enabled?
          get_property_value("enabled", TrueClass)
        end
      
        def use_hand_cursor?
          get_property_value("useHandCursor", TrueClass)
        end
      
        def num_automation_children
          get_property_value("numAutomationChildren", Integer)
        end
      
      
        def change_focus(shift_key, key_code="TAB")
          fire_event(ChangeFocus, shift_key, key_code)
        end
      
      end
    
      class FlexContainer < FlexObject
      
        def num_children
          get_property_value("numChildren", Integer)
        end
      
        def label
          get_property_value("label", String)
        end
      
        def creation_policy
          get_property_value("creationPolicy", String)
        end
      
        def creation_index
          get_property_value("creationIndex", Integer)
        end
      
        def background_alpha
          get_property_value("backgroundAlpha", Integer)
        end
      
        def background_color
          get_property_value("backgroundColor", String)
        end
      
        def background_disabled_color
          get_property_value("backgroundDisabledColor", String)
        end
      
        def background_image
          get_property_value("backgroundImage", String)
        end
      
        def background_size
          get_property_value("backgroundSize", String)
        end
      
        def font_family
          get_property_value("fontFamily", String)
        end
      
        def font_size
          get_property_value("fontSize", Integer)
        end
      
        def font_style
          get_property_value("fontStyle", String)
        end
      
        def font_weight
          get_property_value("fontWeight", String)
        end
      
        def fill_alphas
          get_property_value("fillAlphas", String)
        end
      
        def fill_colors
          get_property_value("fillColors", String)
        end
      
      
        def mouse_scroll(delta=0)
          fire_event(MouseScroll, delta)
        end
      
        def scroll(position, direction, detail=["null"])
          fire_event(Scroll, position, direction, detail)
        end
      
        def drag_start(dragged_item, key_modifier=["0"])
          fire_event(DragStart, dragged_item, key_modifier)
        end
      
        def drag_drop(action, dragged_item="", key_modifier=["0"])
          fire_event(DragDrop, action, dragged_item, key_modifier)
        end
      
        def drag_cancel(key_modifier=["0"])
          fire_event(DragCancel, key_modifier)
        end
      
      end
    
      class FlexForm < FlexContainer
      
      
      end
    
      class FlexCanvas < FlexContainer
      
      
      end
    
      class FlexBox < FlexContainer
      
        def direction
          get_property_value("direction", String)
        end
      
        def horizontal_align
          get_property_value("horizontalAlign", String)
        end
      
        def vertical_align
          get_property_value("verticalAlign", String)
        end
      
      
      end
    
      class FlexProgressBar < FlexObject
      
        def conversion
          get_property_value("conversion", Integer)
        end
      
        def direction
          get_property_value("direction", String)
        end
      
        def indeterminate?
          get_property_value("indeterminate", TrueClass)
        end
      
        def label
          get_property_value("label", String)
        end
      
        def label_placement
          get_property_value("labelPlacement", String)
        end
      
        def maximum
          get_property_value("maximum", Integer)
        end
      
        def minimum
          get_property_value("minimum", Integer)
        end
      
        def percent_complete
          get_property_value("percentComplete", Integer)
        end
      
        def value
          get_property_value("value", Integer)
        end
      
        def bar_color
          get_property_value("barColor", String)
        end
      
        def border_color
          get_property_value("borderColor", String)
        end
      
        def color
          get_property_value("color", String)
        end
      
        def disabled_color
          get_property_value("disabledColor", String)
        end
      
        def fill_colors
          get_property_value("fillColors", String)
        end
      
        def font_family
          get_property_value("fontFamily", String)
        end
      
        def font_size
          get_property_value("fontSize", Integer)
        end
      
        def font_style
          get_property_value("fontStyle", String)
        end
      
        def font_weight
          get_property_value("fontWeight", String)
        end
      
        def label_width
          get_property_value("labelWidth", Integer)
        end
      
        def text_align
          get_property_value("textAlign", String)
        end
      
        def text_decoration
          get_property_value("textDecoration", String)
        end
      
        def text_indent
          get_property_value("textIndent", Integer)
        end
      
        def theme_color
          get_property_value("themeColor", String)
        end
      
      
      end
    
      class FlexAccordion < FlexContainer
      
        def selected_index
          get_property_value("selectedIndex", Integer)
        end
      
        def selected_child
          get_property_value("selectedChild", String)
        end
      
        def header_height
          get_property_value("headerHeight", Integer)
        end
      
        def horizontal_gap
          get_property_value("horizontalGap", Integer)
        end
      
        def padding_top
          get_property_value("paddingTop", Integer)
        end
      
        def padding_bottom
          get_property_value("paddingBottom", Integer)
        end
      
        def text_selected_color
          get_property_value("textSelectedColor", String)
        end
      
        def vertical_gap
          get_property_value("verticalGap", Integer)
        end
      
      
        def change(related_object="mouse")
          fire_event(Change, related_object)
        end
      
        def type(key_code, key_modifier=["0"])
          fire_event(Type, key_code, key_modifier)
        end
      
      end
    
      class FlexButton < FlexObject
      
        def enabled?
          get_property_value("enabled", TrueClass)
        end
      
        def label
          get_property_value("label", String)
        end
      
        def label_placement
          get_property_value("labelPlacement", String)
        end
      
        def selected?
          get_property_value("selected", TrueClass)
        end
      
        def toggle?
          get_property_value("toggle", TrueClass)
        end
      
        def color
          get_property_value("color", String)
        end
      
        def disabled_color
          get_property_value("disabledColor", String)
        end
      
        def font_family
          get_property_value("fontFamily", String)
        end
      
        def font_size
          get_property_value("fontSize", Integer)
        end
      
        def font_style
          get_property_value("fontStyle", String)
        end
      
        def font_weight
          get_property_value("fontWeight", String)
        end
      
        def fill_alphas
          get_property_value("fillAlphas", String)
        end
      
        def fill_colors
          get_property_value("fillColors", String)
        end
      
        def focus_alpha
          get_property_value("focusAlpha", Integer)
        end
      
        def text_align
          get_property_value("textAlign", String)
        end
      
        def text_decoration
          get_property_value("textDecoration", String)
        end
      
        def text_indent
          get_property_value("textIndent", Integer)
        end
      
        def text_roll_over_color
          get_property_value("textRollOverColor", String)
        end
      
        def text_selected_color
          get_property_value("textSelectedColor", String)
        end
      
      
        def type(key_code, key_modifier=["0"])
          fire_event(Type, key_code, key_modifier)
        end
      
      end
    
      class FlexPopUpButton < FlexButton
      
      
        def open(trigger_event=["1"])
          fire_event(Open, trigger_event)
        end
      
        def close(trigger_event=["1"])
          fire_event(Close, trigger_event)
        end
      
      end
    
      class FlexCheckBox < FlexButton
      
      
      end
    
      class FlexRadioButton < FlexButton
      
        def group_name
          get_property_value("groupName", String)
        end
      
        def label_placement
          get_property_value("labelPlacement", String)
        end
      
      
      end
    
      class FlexScrollBase < FlexObject
      
      
        def mouse_scroll(delta=0)
          fire_event(MouseScroll, delta)
        end
      
      end
    
      class FlexListBase < FlexScrollBase
      
        def column_count
          get_property_value("columnCount", Integer)
        end
      
        def column_width
          get_property_value("columnWidth", Integer)
        end
      
        def data_tip_field
          get_property_value("dataTipField", String)
        end
      
        def icon_field
          get_property_value("iconField", String)
        end
      
        def label_field
          get_property_value("labelField", String)
        end
      
        def locked_column_count
          get_property_value("lockedColumnCount", Integer)
        end
      
        def locked_row_count
          get_property_value("lockedRowCount", Integer)
        end
      
        def allow_multiple_selection?
          get_property_value("allowMultipleSelection", TrueClass)
        end
      
        def num_automation_children
          get_property_value("numAutomationChildren", Integer)
        end
      
        def row_count
          get_property_value("rowCount", Integer)
        end
      
        def row_height
          get_property_value("rowHeight", Integer)
        end
      
        def selectable?
          get_property_value("selectable", TrueClass)
        end
      
        def selected_index
          get_property_value("selectedIndex", Integer)
        end
      
        def selected_indices
          get_property_value("selectedIndices", String)
        end
      
        def selected_item
          get_property_value("selectedItem", String)
        end
      
        def selected_items
          get_property_value("selectedItems", String)
        end
      
        def show_data_tips?
          get_property_value("showDataTips", TrueClass)
        end
      
        def variable_row_height?
          get_property_value("variableRowHeight", TrueClass)
        end
      
        def word_wrap?
          get_property_value("wordWrap", TrueClass)
        end
      
        def alternating_row_colors
          get_property_value("alternatingRowColors", String)
        end
      
        def focus_alpha
          get_property_value("focusAlpha", Integer)
        end
      
        def roll_over_color
          get_property_value("rollOverColor", String)
        end
      
        def selection_color
          get_property_value("selectionColor", String)
        end
      
        def selection_disabled_color
          get_property_value("selectionDisabledColor", String)
        end
      
        def text_roll_over_color
          get_property_value("textRollOverColor", String)
        end
      
        def text_selected_color
          get_property_value("textSelectedColor", String)
        end
      
        def background_disabled_color
          get_property_value("backgroundDisabledColor", String)
        end
      
        def use_roll_over?
          get_property_value("useRollOver", TrueClass)
        end
      
        def vertical_align
          get_property_value("verticalAlign", String)
        end
      
      
        def mouse_scroll(delta=0)
          fire_event(MouseScroll, delta)
        end
      
        def drag_start(dragged_item, key_modifier=["0"])
          fire_event(DragStart, dragged_item, key_modifier)
        end
      
        def drag_drop(action, dragged_item="", key_modifier=["0"])
          fire_event(DragDrop, action, dragged_item, key_modifier)
        end
      
        def drag_cancel(key_modifier=["0"])
          fire_event(DragCancel, key_modifier)
        end
      
        def select(item_renderer, trigger_event=["1"], key_modifier=["0"])
          fire_event(Select, item_renderer, trigger_event, key_modifier)
        end
      
        def multi_select(item_renderer, trigger_event=["1"], key_modifier=["0"])
          fire_event(MultiSelect, item_renderer, trigger_event, key_modifier)
        end
      
        def deselect(item_renderer, trigger_event=["1"], key_modifier=["0"])
          fire_event(Deselect, item_renderer, trigger_event, key_modifier)
        end
      
        def scroll(position, direction, detail=["null"])
          fire_event(Scroll, position, direction, detail)
        end
      
        def type(key_code, key_modifier=["0"])
          fire_event(Type, key_code, key_modifier)
        end
      
        def double_click(item_renderer)
          fire_event(DoubleClick, item_renderer)
        end
      
      end
    
      class FlexDataGrid < FlexListBase
      
        def editable?
          get_property_value("editable", TrueClass)
        end
      
        def column_names
          get_property_value("columnNames", String)
        end
      
        def min_column_width
          get_property_value("minColumnWidth", Integer)
        end
      
        def resizable_columns?
          get_property_value("resizableColumns", TrueClass)
        end
      
        def sortable_columns?
          get_property_value("sortableColumns", TrueClass)
        end
      
        def header_colors
          get_property_value("headerColors", String)
        end
      
        def header_style
          get_property_value("headerStyle", String)
        end
      
        def v_grid_line_color
          get_property_value("vGridLineColor", String)
        end
      
        def v_grid_lines?
          get_property_value("vGridLines", TrueClass)
        end
      
      
        def header_click(column_index)
          fire_event(HeaderClick, column_index)
        end
      
        def column_stretch(column_index, local_x)
          fire_event(ColumnStretch, column_index, local_x)
        end
      
        def header_shift(new_index, old_index, trigger_event=["1"])
          fire_event(HeaderShift, new_index, old_index, trigger_event)
        end
      
        def edit(item_renderer, row_index, column_index)
          fire_event(Edit, item_renderer, row_index, column_index)
        end
      
      end
    
      class FlexList < FlexListBase
      
      
        def edit(item_renderer, row_index, column_index)
          fire_event(Edit, item_renderer, row_index, column_index)
        end
      
      end
    
      class FlexTree < FlexListBase
      
        def editable?
          get_property_value("editable", TrueClass)
        end
      
        def depth_colors
          get_property_value("depthColors", String)
        end
      
        def indentation
          get_property_value("indentation", Integer)
        end
      
        def text_disabled_color
          get_property_value("textDisabledColor", String)
        end
      
      
        def drag_drop(action, drop_parent="", dragged_item="", key_modifier=["0"])
          fire_event(DragDrop, action, drop_parent, dragged_item, key_modifier)
        end
      
        def open(item_renderer, trigger_event=["1"])
          fire_event(Open, item_renderer, trigger_event)
        end
      
        def close(item_renderer, trigger_event=["1"])
          fire_event(Close, item_renderer, trigger_event)
        end
      
      end
    
      class FlexApplication < FlexBox
      
        def url
          get_property_value("url", String)
        end
      
      
      end
    
      class FlexScrollBar < FlexObject
      
        def line_scroll_size
          get_property_value("lineScrollSize", Integer)
        end
      
        def page_scroll_size
          get_property_value("pageScrollSize", Integer)
        end
      
        def scroll_position
          get_property_value("scrollPosition", String)
        end
      
        def track_colors
          get_property_value("trackColors", String)
        end
      
        def fill_colors
          get_property_value("fillColors", String)
        end
      
      
        def scroll(position, direction, detail=["null"])
          fire_event(Scroll, position, direction, detail)
        end
      
      end
    
      class FlexNumericStepper < FlexObject
      
        def value
          get_property_value("value", Integer)
        end
      
        def minimum
          get_property_value("minimum", Integer)
        end
      
        def maximum
          get_property_value("maximum", Integer)
        end
      
        def next_value
          get_property_value("nextValue", Integer)
        end
      
        def previous_value
          get_property_value("previousValue", Integer)
        end
      
        def step_size
          get_property_value("stepSize", Integer)
        end
      
        def color
          get_property_value("color", Integer)
        end
      
        def disabled_color
          get_property_value("disabledColor", String)
        end
      
        def fill_colors
          get_property_value("fillColors", String)
        end
      
        def font_family
          get_property_value("fontFamily", String)
        end
      
        def font_size
          get_property_value("fontSize", Integer)
        end
      
        def font_style
          get_property_value("fontStyle", String)
        end
      
        def font_weight
          get_property_value("fontWeight", String)
        end
      
        def text_align
          get_property_value("textAlign", String)
        end
      
        def text_decoration
          get_property_value("textDecoration", String)
        end
      
        def text_indent
          get_property_value("textIndent", Integer)
        end
      
      
        def change(value)
          fire_event(Change, value)
        end
      
        def input(text)
          fire_event(Input, text)
        end
      
        def select_text(begin_index, end_index)
          fire_event(SelectText, begin_index, end_index)
        end
      
        def type(key_code, key_modifier=["0"])
          fire_event(Type, key_code, key_modifier)
        end
      
      end
    
      class FlexVideoDisplay < FlexObject
      
        def source
          get_property_value("source", String)
        end
      
        def total_time
          get_property_value("totalTime", Integer)
        end
      
        def volume
          get_property_value("volume", Integer)
        end
      
      
      end
    
      class FlexLoader < FlexObject
      
        def source
          get_property_value("source", String)
        end
      
      
      end
    
      class FlexImage < FlexLoader
      
      
      end
    
      class FlexSlider < FlexObject
      
        def direction
          get_property_value("direction", String)
        end
      
        def value
          get_property_value("value", Integer)
        end
      
        def values
          get_property_value("values", String)
        end
      
        def maximum
          get_property_value("maximum", Integer)
        end
      
        def minimum
          get_property_value("minimum", Integer)
        end
      
        def thumb_count
          get_property_value("thumbCount", Integer)
        end
      
        def labels
          get_property_value("labels", String)
        end
      
        def live_dragging?
          get_property_value("liveDragging", TrueClass)
        end
      
        def tool_tip_show?
          get_property_value("toolTipShow", TrueClass)
        end
      
        def snap_interval
          get_property_value("snapInterval", Integer)
        end
      
        def fill_colors
          get_property_value("fillColors", String)
        end
      
        def label_style_name
          get_property_value("labelStyleName", String)
        end
      
        def tick_color
          get_property_value("tickColor", String)
        end
      
        def tick_length
          get_property_value("tickLength", Integer)
        end
      
        def tick_thickness
          get_property_value("tickThickness", Integer)
        end
      
        def data_tip_precision
          get_property_value("dataTipPrecision", Integer)
        end
      
        def track_colors
          get_property_value("trackColors", String)
        end
      
      
        def change(value, thumb_index=0, click_target="thumb", trigger_event=["1"], key_code="")
          fire_event(Change, value, thumb_index, click_target, trigger_event, key_code)
        end
      
      end
    
      class FlexComboBase < FlexObject
      
        def text
          get_property_value("text", String)
        end
      
        def restrict
          get_property_value("restrict", String)
        end
      
        def editable?
          get_property_value("editable", TrueClass)
        end
      
        def selected_index
          get_property_value("selectedIndex", Integer)
        end
      
        def horizontal_scroll_position
          get_property_value("horizontalScrollPosition", Integer)
        end
      
        def horizontal_scroll_policy
          get_property_value("horizontalScrollPolicy", String)
        end
      
        def live_scrolling?
          get_property_value("liveScrolling", TrueClass)
        end
      
        def show_scroll_tips?
          get_property_value("showScrollTips", TrueClass)
        end
      
        def vertical_scroll_position
          get_property_value("verticalScrollPosition", Integer)
        end
      
        def vertical_scroll_policy
          get_property_value("verticalScrollPolicy", String)
        end
      
        def background_alpha
          get_property_value("backgroundAlpha", Integer)
        end
      
        def background_color
          get_property_value("backgroundColor", String)
        end
      
        def background_image
          get_property_value("backgroundImage", String)
        end
      
        def background_size
          get_property_value("backgroundSize", String)
        end
      
        def color
          get_property_value("color", Integer)
        end
      
        def disabled_color
          get_property_value("disabledColor", String)
        end
      
        def drop_shadow_enabled?
          get_property_value("dropShadowEnabled", TrueClass)
        end
      
        def fill_alphas
          get_property_value("fillAlphas", String)
        end
      
        def fill_colors
          get_property_value("fillColors", String)
        end
      
        def font_family
          get_property_value("fontFamily", String)
        end
      
        def font_size
          get_property_value("fontSize", Integer)
        end
      
        def font_style
          get_property_value("fontStyle", String)
        end
      
        def font_weight
          get_property_value("fontWeight", String)
        end
      
        def highlight_color
          get_property_value("highlightColor", String)
        end
      
        def text_align
          get_property_value("textAlign", String)
        end
      
        def text_decoration
          get_property_value("textDecoration", String)
        end
      
        def text_indent
          get_property_value("textIndent", Integer)
        end
      
      
        def open(trigger_event=["1"])
          fire_event(Open, trigger_event)
        end
      
        def close(trigger_event=["1"])
          fire_event(Close, trigger_event)
        end
      
        def scroll(position, direction, detail=["null"])
          fire_event(Scroll, position, direction, detail)
        end
      
        def input(text)
          fire_event(Input, text)
        end
      
        def select_text(begin_index, end_index)
          fire_event(SelectText, begin_index, end_index)
        end
      
        def type(key_code, key_modifier=["0"])
          fire_event(Type, key_code, key_modifier)
        end
      
      end
    
      class FlexComboBox < FlexComboBase
      
        def text
          get_property_value("text", String)
        end
      
        def selected_index
          get_property_value("selectedIndex", Integer)
        end
      
        def editable?
          get_property_value("editable", TrueClass)
        end
      
        def alternating_row_colors
          get_property_value("alternatingRowColors", String)
        end
      
        def fill_colors
          get_property_value("fillColors", String)
        end
      
        def roll_over_color?
          get_property_value("rollOverColor", TrueClass)
        end
      
        def selection_color?
          get_property_value("selectionColor", TrueClass)
        end
      
      
        def select(item_renderer, trigger_event=["1"], key_modifier=["0"])
          fire_event(Select, item_renderer, trigger_event, key_modifier)
        end
      
        def type(key_code, key_modifier=["0"])
          fire_event(Type, key_code, key_modifier)
        end
      
        def input(text)
          fire_event(Input, text)
        end
      
      end
    
      class FlexDateField < FlexComboBase
      
        def selected_date
          get_property_value("selectedDate", Date)
        end
      
        def disabled_days
          get_property_value("disabledDays", String)
        end
      
        def disabled_ranges
          get_property_value("disabledRanges", String)
        end
      
        def displayed_month
          get_property_value("displayedMonth", Integer)
        end
      
        def displayed_year
          get_property_value("displayedYear", Integer)
        end
      
        def first_day_of_week
          get_property_value("firstDayOfWeek", Integer)
        end
      
        def max_year
          get_property_value("maxYear", Integer)
        end
      
        def min_year
          get_property_value("minYear", Integer)
        end
      
        def show_today?
          get_property_value("showToday", TrueClass)
        end
      
        def year_navigation_enabled?
          get_property_value("yearNavigationEnabled", TrueClass)
        end
      
        def header_colors
          get_property_value("headerColors", String)
        end
      
        def roll_over_color
          get_property_value("rollOverColor", String)
        end
      
        def today_color
          get_property_value("todayColor", String)
        end
      
      
        def change(new_date)
          fire_event(Change, new_date)
        end
      
        def scroll(detail)
          fire_event(Scroll, detail)
        end
      
        def type(key_code, key_modifier=["0"])
          fire_event(Type, key_code, key_modifier)
        end
      
      end
    
      class FlexDateChooser < FlexObject
      
        def selected_date
          get_property_value("selectedDate", Date)
        end
      
        def disabled_days
          get_property_value("disabledDays", String)
        end
      
        def disabled_ranges
          get_property_value("disabledRanges", String)
        end
      
        def allow_disjoint_selection?
          get_property_value("allowDisjointSelection", TrueClass)
        end
      
        def displayed_month
          get_property_value("displayedMonth", Integer)
        end
      
        def displayed_year
          get_property_value("displayedYear", Integer)
        end
      
        def first_day_of_week
          get_property_value("firstDayOfWeek", Integer)
        end
      
        def max_year
          get_property_value("maxYear", Integer)
        end
      
        def min_year
          get_property_value("minYear", Integer)
        end
      
        def allow_multiple_selection?
          get_property_value("allowMultipleSelection", TrueClass)
        end
      
        def selected_ranges
          get_property_value("selectedRanges", String)
        end
      
        def show_today?
          get_property_value("showToday", TrueClass)
        end
      
        def year_navigation_enabled?
          get_property_value("yearNavigationEnabled", TrueClass)
        end
      
        def header_colors
          get_property_value("headerColors", String)
        end
      
        def roll_over_color
          get_property_value("rollOverColor", String)
        end
      
        def today_color
          get_property_value("todayColor", String)
        end
      
        def color
          get_property_value("color", String)
        end
      
        def disabled_color
          get_property_value("disabledColor", String)
        end
      
        def fill_colors
          get_property_value("fillColors", String)
        end
      
        def font_family
          get_property_value("fontFamily", String)
        end
      
        def font_size
          get_property_value("fontSize", Integer)
        end
      
        def font_style
          get_property_value("fontStyle", String)
        end
      
        def font_weight
          get_property_value("fontWeight", String)
        end
      
        def text_align
          get_property_value("textAlign", String)
        end
      
        def text_decoration
          get_property_value("textDecoration", String)
        end
      
        def text_indent
          get_property_value("textIndent", Integer)
        end
      
        def header_colors
          get_property_value("headerColors", String)
        end
      
        def roll_over_color
          get_property_value("rollOverColor", String)
        end
      
        def selection_color
          get_property_value("selectionColor", String)
        end
      
      
        def change(new_date)
          fire_event(Change, new_date)
        end
      
        def scroll(detail)
          fire_event(Scroll, detail)
        end
      
        def type(key_code, key_modifier=["0"])
          fire_event(Type, key_code, key_modifier)
        end
      
      end
    
      class FlexColorPicker < FlexComboBase
      
        def selected_color
          get_property_value("selectedColor", Integer)
        end
      
        def show_text_field?
          get_property_value("showTextField", TrueClass)
        end
      
        def column_count
          get_property_value("columnCount", Integer)
        end
      
      
        def open(trigger_event=["1"])
          fire_event(Open, trigger_event)
        end
      
        def close(trigger_event=["1"])
          fire_event(Close, trigger_event)
        end
      
        def change(color)
          fire_event(Change, color)
        end
      
      end
    
      class FlexTextArea < FlexScrollBase
      
        def editable?
          get_property_value("editable", TrueClass)
        end
      
        def display_as_password?
          get_property_value("displayAsPassword", TrueClass)
        end
      
        def text
          get_property_value("text", String)
        end
      
        def color
          get_property_value("color", Integer)
        end
      
        def horizontal_scroll_policy
          get_property_value("horizontalScrollPolicy", String)
        end
      
        def html_text
          get_property_value("htmlText", String)
        end
      
        def length
          get_property_value("length", Integer)
        end
      
        def max_chars
          get_property_value("maxChars", Integer)
        end
      
        def restrict
          get_property_value("restrict", String)
        end
      
        def selection
          get_property_value("selection", String)
        end
      
        def word_wrap?
          get_property_value("wordWrap", TrueClass)
        end
      
        def disabled_color
          get_property_value("disabledColor", String)
        end
      
        def font_family
          get_property_value("fontFamily", String)
        end
      
        def font_size
          get_property_value("fontSize", Integer)
        end
      
        def font_style
          get_property_value("fontStyle", String)
        end
      
        def font_weight
          get_property_value("fontWeight", String)
        end
      
      
        def input(text)
          fire_event(Input, text)
        end
      
        def select_text(begin_index, end_index)
          fire_event(SelectText, begin_index, end_index)
        end
      
        def type(key_code, key_modifier=["0"])
          fire_event(Type, key_code, key_modifier)
        end
      
        def scroll(position, direction, detail=["null"])
          fire_event(Scroll, position, direction, detail)
        end
      
      end
    
      class FlexPanel < FlexContainer
      
        def title
          get_property_value("title", String)
        end
      
        def status
          get_property_value("status", String)
        end
      
        def drop_shadow_enabled?
          get_property_value("dropShadowEnabled", TrueClass)
        end
      
        def footer_colors
          get_property_value("footerColors", String)
        end
      
        def header_colors
          get_property_value("headerColors", String)
        end
      
        def header_height
          get_property_value("headerHeight", Integer)
        end
      
      
      end
    
      class FlexTitleWindow < FlexPanel
      
        def show_close_button?
          get_property_value("showCloseButton", TrueClass)
        end
      
      
      end
    
      class FlexAlert < FlexPanel
      
        def text
          get_property_value("text", String)
        end
      
        def cancel_label
          get_property_value("cancelLabel", String)
        end
      
        def default_button_flag
          get_property_value("defaultButtonFlag", Integer)
        end
      
        def no_label
          get_property_value("noLabel", String)
        end
      
        def ok_label
          get_property_value("okLabel", String)
        end
      
        def yes_label
          get_property_value("yesLabel", String)
        end
      
      
        def type(key_code, key_modifier=["0"])
          fire_event(Type, key_code, key_modifier)
        end
      
      end
    
      class FlexDividedBox < FlexBox
      
        def resize_to_content?
          get_property_value("resizeToContent", TrueClass)
        end
      
      
        def pressed(divider_index, delta)
          fire_event(Pressed, divider_index, delta)
        end
      
        def dragged(divider_index, delta)
          fire_event(Dragged, divider_index, delta)
        end
      
        def released(divider_index, delta)
          fire_event(Released, divider_index, delta)
        end
      
      end
    
      class FlexMenu < FlexObject
      
        def row_count
          get_property_value("rowCount", Integer)
        end
      
        def selected_index
          get_property_value("selectedIndex", Integer)
        end
      
        def alternating_row_colors
          get_property_value("alternatingRowColors", String)
        end
      
        def roll_over_color
          get_property_value("rollOverColor", String)
        end
      
        def selection_color
          get_property_value("selectionColor", String)
        end
      
        def text_roll_over_color
          get_property_value("textRollOverColor", String)
        end
      
        def text_selected_color
          get_property_value("textSelectedColor", String)
        end
      
      
        def type(key_code, key_modifier=["0"])
          fire_event(Type, key_code, key_modifier)
        end
      
        def show(item_renderer)
          fire_event(Show, item_renderer)
        end
      
        def hide()
          fire_event(Hide)
        end
      
        def select(item_renderer)
          fire_event(Select, item_renderer)
        end
      
      end
    
      class FlexMenuBar < FlexObject
      
        def num_children
          get_property_value("numChildren", Integer)
        end
      
        def selected_index
          get_property_value("selectedIndex", Integer)
        end
      
        def background_color
          get_property_value("backgroundColor", String)
        end
      
        def color
          get_property_value("color", String)
        end
      
        def disabled_color
          get_property_value("disabledColor", String)
        end
      
        def fill_colors
          get_property_value("fillColors", String)
        end
      
        def font_family
          get_property_value("fontFamily", String)
        end
      
        def font_size
          get_property_value("fontSize", Integer)
        end
      
        def font_style
          get_property_value("fontStyle", String)
        end
      
        def font_weight
          get_property_value("fontWeight", String)
        end
      
        def text_align
          get_property_value("textAlign", String)
        end
      
        def text_decoration
          get_property_value("textDecoration", String)
        end
      
        def roll_over_color
          get_property_value("rollOverColor", String)
        end
      
        def selection_color
          get_property_value("selectionColor", String)
        end
      
        def text_indent
          get_property_value("textIndent", Integer)
        end
      
      
        def type(key_code, key_modifier=["0"])
          fire_event(Type, key_code, key_modifier)
        end
      
        def show(item_renderer)
          fire_event(Show, item_renderer)
        end
      
        def hide()
          fire_event(Hide)
        end
      
      end
    
      class FlexRepeater < Element
      
        def automation_name
          get_property_value("automationName", String)
        end
      
        def id
          get_property_value("id", String)
        end
      
        def class_name
          get_property_value("className", String)
        end
      
        def automation_index
          get_property_value("automationIndex", String)
        end
      
        def count
          get_property_value("count", String)
        end
      
      
      end
    
      class FlexLabel < FlexObject
      
        def text
          get_property_value("text", String)
        end
      
        def html_text
          get_property_value("htmlText", String)
        end
      
        def color
          get_property_value("color", String)
        end
      
        def disabled_color
          get_property_value("disabledColor", String)
        end
      
        def font_family
          get_property_value("fontFamily", String)
        end
      
        def font_size
          get_property_value("fontSize", Integer)
        end
      
        def font_style
          get_property_value("fontStyle", String)
        end
      
        def font_weight
          get_property_value("fontWeight", String)
        end
      
        def text_align
          get_property_value("textAlign", String)
        end
      
        def text_decoration
          get_property_value("textDecoration", String)
        end
      
        def text_indent
          get_property_value("textIndent", Integer)
        end
      
      
        def click(ctrl_key, alt_key, shift_key)
          fire_event(Click, ctrl_key, alt_key, shift_key)
        end
      
      end
    
      class FlexRule < FlexObject
      
        def color
          get_property_value("color", String)
        end
      
        def stroke_width
          get_property_value("strokeWidth", Integer)
        end
      
      
      end
    
      class FlexFormItem < FlexContainer
      
        def horizontal_align
          get_property_value("horizontalAlign", String)
        end
      
      
      end
    
      class FlexViewStack < FlexContainer
      
        def selected_index
          get_property_value("selectedIndex", Integer)
        end
      
        def selected_child
          get_property_value("selectedChild", String)
        end
      
      
        def type(key_code, key_modifier=["0"])
          fire_event(Type, key_code, key_modifier)
        end
      
      end
    
      class FlexTabNavigator < FlexViewStack
      
        def horizontal_align
          get_property_value("horizontalAlign", String)
        end
      
        def horizontal_gap
          get_property_value("horizontalGap", Integer)
        end
      
        def tab_height
          get_property_value("tabHeight", Integer)
        end
      
        def tab_width
          get_property_value("tabWidth", Integer)
        end
      
      
        def change(related_object)
          fire_event(Change, related_object)
        end
      
      end
    
      class FlexNavigationBar < FlexBox
      
        def direction
          get_property_value("direction", String)
        end
      
        def selected_index
          get_property_value("selectedIndex", Integer)
        end
      
      
        def change(related_object)
          fire_event(Change, related_object)
        end
      
        def type(key_code, key_modifier=["0"])
          fire_event(Type, key_code, key_modifier)
        end
      
      end
    
      class FlexLinkBar < FlexNavigationBar
      
        def selected_index
          get_property_value("selectedIndex", Integer)
        end
      
        def num_children
          get_property_value("numChildren", Integer)
        end
      
      
      end
    
      class FlexButtonBar < FlexNavigationBar
      
        def selected_index
          get_property_value("selectedIndex", String)
        end
      
        def num_children
          get_property_value("numChildren", String)
        end
      
      
      end
    
      class FlexToggleButtonBar < FlexButtonBar
      
        def selected_index
          get_property_value("selectedIndex", String)
        end
      
        def num_children
          get_property_value("numChildren", String)
        end
      
      
      end
    
      class FlexChart < FlexObject
      
        def description
          get_property_value("description", String)
        end
      
        def clip_content?
          get_property_value("clipContent", TrueClass)
        end
      
        def data_tip_layer_index
          get_property_value("dataTipLayerIndex", Integer)
        end
      
        def data_tip_mode
          get_property_value("dataTipMode", String)
        end
      
        def mouse_sensitivity
          get_property_value("mouseSensitivity", Integer)
        end
      
        def show_data_tips?
          get_property_value("showDataTips", TrueClass)
        end
      
        def font_family
          get_property_value("fontFamily", String)
        end
      
        def font_size
          get_property_value("fontSize", Integer)
        end
      
        def maximum_data_tip_count
          get_property_value("maximumDataTipCount", Integer)
        end
      
        def padding_bottom
          get_property_value("paddingBottom", Integer)
        end
      
        def padding_top
          get_property_value("paddingTop", Integer)
        end
      
        def padding_left
          get_property_value("paddingLeft", Integer)
        end
      
        def padding_right
          get_property_value("paddingRight", Integer)
        end
      
        def show_data_tip_targets?
          get_property_value("showDataTipTargets", TrueClass)
        end
      
      
      end
    
      class FlexCartesianChart < FlexChart
      
        def horizontal_axis_ratio
          get_property_value("horizontalAxisRatio", Integer)
        end
      
        def gutter_left
          get_property_value("gutterLeft", Integer)
        end
      
        def gutter_right
          get_property_value("gutterRight", Integer)
        end
      
        def gutter_bottom
          get_property_value("gutterBottom", Integer)
        end
      
        def gutter_top
          get_property_value("gutterTop", Integer)
        end
      
        def text_align
          get_property_value("textAlign", String)
        end
      
      
      end
    
      class FlexAreaChart < FlexCartesianChart
      
        def type
          get_property_value("type", String)
        end
      
      
      end
    
      class FlexBarChart < FlexCartesianChart
      
        def bar_width_ratio
          get_property_value("barWidthRatio", Integer)
        end
      
        def max_bar_width
          get_property_value("maxBarWidth", Integer)
        end
      
      
      end
    
      class FlexColumnChart < FlexCartesianChart
      
        def column_width_ratio
          get_property_value("columnWidthRatio", Integer)
        end
      
        def max_column_width
          get_property_value("maxColumnWidth", Integer)
        end
      
      
      end
    
      class FlexHLOCChart < FlexCartesianChart
      
        def column_width_ratio
          get_property_value("columnWidthRatio", Integer)
        end
      
        def max_column_width
          get_property_value("maxColumnWidth", Integer)
        end
      
      
      end
    
      class FlexLineChart < FlexCartesianChart
      
      
      end
    
      class FlexPieChart < FlexChart
      
        def inner_radius
          get_property_value("innerRadius", Integer)
        end
      
        def text_align
          get_property_value("textAlign", String)
        end
      
      
      end
    
      class FlexAreaSeries < FlexChartSeries
      
        def min_field
          get_property_value("minField", String)
        end
      
        def x_field
          get_property_value("xField", String)
        end
      
        def y_field
          get_property_value("yField", String)
        end
      
        def form
          get_property_value("form", String)
        end
      
        def radius
          get_property_value("radius", Integer)
        end
      
      
      end
    
      class FlexBarSeries < FlexChartSeries
      
        def bar_width_ratio
          get_property_value("barWidthRatio", Integer)
        end
      
        def max_bar_width
          get_property_value("maxBarWidth", Integer)
        end
      
        def min_field
          get_property_value("minField", String)
        end
      
        def offset
          get_property_value("offset", Integer)
        end
      
        def x_field
          get_property_value("xField", String)
        end
      
        def y_field
          get_property_value("yField", String)
        end
      
      
      end
    
      class FlexBubbleSeries < FlexChartSeries
      
        def max_radius
          get_property_value("maxRadius", Integer)
        end
      
        def radius_field
          get_property_value("radiusField", String)
        end
      
        def x_field
          get_property_value("xField", String)
        end
      
        def y_field
          get_property_value("yField", String)
        end
      
      
      end
    
      class FlexColumnSeries < FlexChartSeries
      
        def column_width_ratio
          get_property_value("columnWidthRatio", Integer)
        end
      
        def max_column_width
          get_property_value("maxColumnWidth", Integer)
        end
      
        def offset
          get_property_value("offset", Integer)
        end
      
        def sort_on_x_field?
          get_property_value("sortOnXField", TrueClass)
        end
      
        def min_field
          get_property_value("minField", String)
        end
      
        def x_field
          get_property_value("xField", String)
        end
      
        def y_field
          get_property_value("yField", String)
        end
      
      
      end
    
      class FlexLineSeries < FlexChartSeries
      
        def form
          get_property_value("form", String)
        end
      
        def radius
          get_property_value("radius", Integer)
        end
      
        def sort_on_x_field?
          get_property_value("sortOnXField", TrueClass)
        end
      
        def x_field
          get_property_value("xField", String)
        end
      
        def y_field
          get_property_value("yField", String)
        end
      
      
      end
    
      class FlexPieSeries < FlexChartSeries
      
        def explode_radius
          get_property_value("explodeRadius", Integer)
        end
      
        def field
          get_property_value("field", String)
        end
      
        def max_label_radius
          get_property_value("maxLabelRadius", Integer)
        end
      
        def name_field
          get_property_value("nameField", String)
        end
      
        def outer_radius
          get_property_value("outerRadius", Integer)
        end
      
        def inside_label_size_limit
          get_property_value("insideLabelSizeLimit", Integer)
        end
      
        def inner_radius
          get_property_value("innerRadius", Integer)
        end
      
        def font_size
          get_property_value("fontSize", Integer)
        end
      
        def callout_gap
          get_property_value("calloutGap", Integer)
        end
      
        def start_angle
          get_property_value("startAngle", Integer)
        end
      
        def label_position
          get_property_value("labelPosition", String)
        end
      
      
      end
    
      class FlexPlotSeries < FlexChartSeries
      
        def radius
          get_property_value("radius", Integer)
        end
      
        def x_field
          get_property_value("xField", String)
        end
      
        def y_field
          get_property_value("yField", String)
        end
      
      
      end
    
      class FlexAxisRenderer < FlexObject
      
        def height_limit
          get_property_value("heightLimit", Integer)
        end
      
        def length
          get_property_value("length", Integer)
        end
      
        def placement
          get_property_value("placement", String)
        end
      
        def can_drop_labels?
          get_property_value("canDropLabels", TrueClass)
        end
      
        def can_stagger?
          get_property_value("canStagger", TrueClass)
        end
      
        def label_gap
          get_property_value("labelGap", Integer)
        end
      
        def label_rotation
          get_property_value("labelRotation", Integer)
        end
      
        def minor_tick_length
          get_property_value("minorTickLength", Integer)
        end
      
        def minor_tick_placement
          get_property_value("minorTickPlacement", String)
        end
      
        def show_labels?
          get_property_value("showLabels", TrueClass)
        end
      
        def show_line?
          get_property_value("showLine", TrueClass)
        end
      
        def tick_length
          get_property_value("tickLength", Integer)
        end
      
        def tick_placement
          get_property_value("tickPlacement", String)
        end
      
        def ticks
          get_property_value("ticks", String)
        end
      
        def minor_ticks
          get_property_value("minorTicks", String)
        end
      
      
      end
    
      class FlexChartSeries < FlexObject
      
      
        def click(hit_set)
          fire_event(Click, hit_set)
        end
      
        def double_click(hit_set)
          fire_event(DoubleClick, hit_set)
        end
      
        def item_roll_over(hit_set)
          fire_event(ItemRollOver, hit_set)
        end
      
      end
    
      class FlexChartLegend < FlexObject
      
        def label
          get_property_value("label", String)
        end
      
        def marker_aspect_ratio
          get_property_value("markerAspectRatio", Integer)
        end
      
        def font_weight
          get_property_value("fontWeight", String)
        end
      
        def label_placement
          get_property_value("labelPlacement", String)
        end
      
        def marker_height
          get_property_value("markerHeight", Integer)
        end
      
        def marker_width
          get_property_value("markerWidth", Integer)
        end
      
        def padding_left
          get_property_value("paddingLeft", Integer)
        end
      
        def padding_right
          get_property_value("paddingRight", Integer)
        end
      
        def vertical_gap
          get_property_value("verticalGap", Integer)
        end
      
      
        def click(item)
          fire_event(Click, item)
        end
      
      end
    
      class FlexListLabel < FlexDisplayObject
      
        def automation_value
          get_property_value("automationValue", String)
        end
      
        def automation_name
          get_property_value("automationName", String)
        end
      
        def class_name
          get_property_value("className", String)
        end
      
        def automation_index
          get_property_value("automationIndex", String)
        end
      
      
      end
    
    end
  end
end