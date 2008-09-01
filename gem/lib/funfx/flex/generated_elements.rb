require 'funfx'
require 'funfx/flex/element'
require 'funfx/flex/tabular_data'

module FunFX
  module Flex

    class FlexDisplayObject < Element
      def mouse_move(local_x=0, local_y=0, key_modifier=[0])
        fire_event("MouseMove", local_x, local_y, key_modifier)
      end

      def click(key_modifier=[0])
        fire_event("Click", key_modifier)
      end

      def tab_children?
        get_property_value("tabChildren", :boolean)
      end

      def tab_enabled?
        get_property_value("tabEnabled", :boolean)
      end

      def tab_index
        get_property_value("tabIndex", :int)
      end

      def mouse_enabled?
        get_property_value("mouseEnabled", :boolean)
      end

      def alpha
        get_property_value("alpha", :number)
      end

      def height
        get_property_value("height", :number)
      end

      def visible?
        get_property_value("visible", :boolean)
      end

      def width
        get_property_value("width", :number)
      end

      def x
        get_property_value("x", :number)
      end

      def y
        get_property_value("y", :number)
      end

    end
    def display_object(*locator_hashes)
      FlexDisplayObject.new(self, *locator_hashes)
    end

    class FlexObject < FlexDisplayObject
      def change_focus(shift_key, key_code="TAB")
        fire_event("ChangeFocus", shift_key, key_code)
      end

      def automation_name
        get_property_value("automationName", :string)
      end

      def automation_class_name
        get_property_value("automationClassName", :string)
      end

      def id
        get_property_value("id", :string)
      end

      def class_name
        get_property_value("className", :string)
      end

      def automation_index
        get_property_value("automationIndex", :string)
      end

      def current_state
        get_property_value("currentState", :string)
      end

      def focus_enabled?
        get_property_value("focusEnabled", :boolean)
      end

      def tool_tip
        get_property_value("toolTip", :string)
      end

      def error_string
        get_property_value("errorString", :string)
      end

      def percent_height
        get_property_value("percentHeight", :number)
      end

      def percent_width
        get_property_value("percentWidth", :number)
      end

      def scale_x
        get_property_value("scaleX", :number)
      end

      def scale_y
        get_property_value("scaleY", :number)
      end

      def error_color
        get_property_value("errorColor", :string)
      end

      def theme_color
        get_property_value("themeColor", :string)
      end

      def enabled?
        get_property_value("enabled", :boolean)
      end

      def use_hand_cursor?
        get_property_value("useHandCursor", :boolean)
      end

      def num_automation_children
        get_property_value("numAutomationChildren", :int)
      end

    end
    def ui_component(*locator_hashes)
      FlexObject.new(self, *locator_hashes)
    end

    class FlexContainer < FlexObject
      include TabularData

      def mouse_scroll(delta=0)
        fire_event("MouseScroll", delta)
      end

      def scroll(position, direction, detail=[0])
        fire_event("Scroll", position, direction, detail)
      end

      def drag_start(dragged_item, key_modifier=[0])
        fire_event("DragStart", dragged_item, key_modifier)
      end

      def drag_drop(action, dragged_item="", key_modifier=[0])
        fire_event("DragDrop", action, dragged_item, key_modifier)
      end

      def drag_cancel(key_modifier=[0])
        fire_event("DragCancel", key_modifier)
      end

      def num_children
        get_property_value("numChildren", :int)
      end

      def label
        get_property_value("label", :string)
      end

      def creation_policy
        get_property_value("creationPolicy", :string)
      end

      def creation_index
        get_property_value("creationIndex", :int)
      end

      def background_alpha
        get_property_value("backgroundAlpha", :number)
      end

      def background_color
        get_property_value("backgroundColor", :string)
      end

      def background_disabled_color
        get_property_value("backgroundDisabledColor", :string)
      end

      def background_image
        get_property_value("backgroundImage", :string)
      end

      def background_size
        get_property_value("backgroundSize", :string)
      end

      def font_family
        get_property_value("fontFamily", :string)
      end

      def font_size
        get_property_value("fontSize", :number)
      end

      def font_style
        get_property_value("fontStyle", :string)
      end

      def font_weight
        get_property_value("fontWeight", :string)
      end

      def fill_alphas
        get_property_value("fillAlphas", :string)
      end

      def fill_colors
        get_property_value("fillColors", :string)
      end

    end
    def container(*locator_hashes)
      FlexContainer.new(self, *locator_hashes)
    end

    class FlexForm < FlexContainer
      include TabularData

    end
    def form(*locator_hashes)
      FlexForm.new(self, *locator_hashes)
    end

    class FlexCanvas < FlexContainer
      include TabularData

    end
    def canvas(*locator_hashes)
      FlexCanvas.new(self, *locator_hashes)
    end

    class FlexBox < FlexContainer
      include TabularData

      def direction
        get_property_value("direction", :string)
      end

      def horizontal_align
        get_property_value("horizontalAlign", :string)
      end

      def vertical_align
        get_property_value("verticalAlign", :string)
      end

    end
    def box(*locator_hashes)
      FlexBox.new(self, *locator_hashes)
    end
    def tile(*locator_hashes)
      FlexBox.new(self, *locator_hashes)
    end

    class FlexProgressBar < FlexObject
      def conversion
        get_property_value("conversion", :number)
      end

      def direction
        get_property_value("direction", :string)
      end

      def indeterminate?
        get_property_value("indeterminate", :boolean)
      end

      def label
        get_property_value("label", :string)
      end

      def label_placement
        get_property_value("labelPlacement", :string)
      end

      def maximum
        get_property_value("maximum", :number)
      end

      def minimum
        get_property_value("minimum", :number)
      end

      def percent_complete
        get_property_value("percentComplete", :number)
      end

      def value
        get_property_value("value", :number)
      end

      def bar_color
        get_property_value("barColor", :string)
      end

      def border_color
        get_property_value("borderColor", :string)
      end

      def color
        get_property_value("color", :string)
      end

      def disabled_color
        get_property_value("disabledColor", :string)
      end

      def fill_colors
        get_property_value("fillColors", :string)
      end

      def font_family
        get_property_value("fontFamily", :string)
      end

      def font_size
        get_property_value("fontSize", :number)
      end

      def font_style
        get_property_value("fontStyle", :string)
      end

      def font_weight
        get_property_value("fontWeight", :string)
      end

      def label_width
        get_property_value("labelWidth", :number)
      end

      def text_align
        get_property_value("textAlign", :string)
      end

      def text_decoration
        get_property_value("textDecoration", :string)
      end

      def text_indent
        get_property_value("textIndent", :number)
      end

      def theme_color
        get_property_value("themeColor", :string)
      end

    end
    def progress_bar(*locator_hashes)
      FlexProgressBar.new(self, *locator_hashes)
    end

    class FlexAccordion < FlexContainer
      include TabularData

      def change(related_object="mouse")
        fire_event("Change", related_object)
      end

      def type(key_code, key_modifier=[0])
        fire_event("Type", key_code, key_modifier)
      end

      def selected_index
        get_property_value("selectedIndex", :int)
      end

      def selected_child
        get_property_value("selectedChild", :string)
      end

      def header_height
        get_property_value("headerHeight", :int)
      end

      def horizontal_gap
        get_property_value("horizontalGap", :number)
      end

      def padding_top
        get_property_value("paddingTop", :number)
      end

      def padding_bottom
        get_property_value("paddingBottom", :number)
      end

      def text_selected_color
        get_property_value("textSelectedColor", :string)
      end

      def vertical_gap
        get_property_value("verticalGap", :number)
      end

    end
    def accordion(*locator_hashes)
      FlexAccordion.new(self, *locator_hashes)
    end

    class FlexButton < FlexObject
      def type(key_code, key_modifier=[0])
        fire_event("Type", key_code, key_modifier)
      end

      def enabled?
        get_property_value("enabled", :boolean)
      end

      def label
        get_property_value("label", :string)
      end

      def label_placement
        get_property_value("labelPlacement", :string)
      end

      def selected?
        get_property_value("selected", :boolean)
      end

      def toggle?
        get_property_value("toggle", :boolean)
      end

      def color
        get_property_value("color", :string)
      end

      def disabled_color
        get_property_value("disabledColor", :string)
      end

      def font_family
        get_property_value("fontFamily", :string)
      end

      def font_size
        get_property_value("fontSize", :number)
      end

      def font_style
        get_property_value("fontStyle", :string)
      end

      def font_weight
        get_property_value("fontWeight", :string)
      end

      def fill_alphas
        get_property_value("fillAlphas", :string)
      end

      def fill_colors
        get_property_value("fillColors", :string)
      end

      def focus_alpha
        get_property_value("focusAlpha", :number)
      end

      def text_align
        get_property_value("textAlign", :string)
      end

      def text_decoration
        get_property_value("textDecoration", :string)
      end

      def text_indent
        get_property_value("textIndent", :number)
      end

      def text_roll_over_color
        get_property_value("textRollOverColor", :string)
      end

      def text_selected_color
        get_property_value("textSelectedColor", :string)
      end

    end
    def button(*locator_hashes)
      FlexButton.new(self, *locator_hashes)
    end

    class FlexPopUpButton < FlexButton
      def open(trigger_event=[1])
        fire_event("Open", trigger_event)
      end

      def close(trigger_event=[1])
        fire_event("Close", trigger_event)
      end

    end
    def pop_up_button(*locator_hashes)
      FlexPopUpButton.new(self, *locator_hashes)
    end

    class FlexCheckBox < FlexButton
    end
    def check_box(*locator_hashes)
      FlexCheckBox.new(self, *locator_hashes)
    end

    class FlexRadioButton < FlexButton
      def group_name
        get_property_value("groupName", :string)
      end

      def label_placement
        get_property_value("labelPlacement", :string)
      end

    end
    def radio_button(*locator_hashes)
      FlexRadioButton.new(self, *locator_hashes)
    end

    class FlexScrollBase < FlexObject
      def mouse_scroll(delta=0)
        fire_event("MouseScroll", delta)
      end

    end
    def scroll_control_base(*locator_hashes)
      FlexScrollBase.new(self, *locator_hashes)
    end

    class FlexListBase < FlexScrollBase
      def mouse_scroll(delta=0)
        fire_event("MouseScroll", delta)
      end

      def drag_start(dragged_item, key_modifier=[0])
        fire_event("DragStart", dragged_item, key_modifier)
      end

      def drag_drop(action, dragged_item="", key_modifier=[0])
        fire_event("DragDrop", action, dragged_item, key_modifier)
      end

      def drag_cancel(key_modifier=[0])
        fire_event("DragCancel", key_modifier)
      end

      def select(item_renderer, trigger_event=[1], key_modifier=[0])
        fire_event("Select", item_renderer, trigger_event, key_modifier)
      end

      def multi_select(item_renderer, trigger_event=[1], key_modifier=[0])
        fire_event("MultiSelect", item_renderer, trigger_event, key_modifier)
      end

      def deselect(item_renderer, trigger_event=[1], key_modifier=[0])
        fire_event("Deselect", item_renderer, trigger_event, key_modifier)
      end

      def scroll(position, direction, detail=[0])
        fire_event("Scroll", position, direction, detail)
      end

      def type(key_code, key_modifier=[0])
        fire_event("Type", key_code, key_modifier)
      end

      def double_click(item_renderer)
        fire_event("DoubleClick", item_renderer)
      end

      def column_count
        get_property_value("columnCount", :int)
      end

      def column_width
        get_property_value("columnWidth", :number)
      end

      def data_tip_field
        get_property_value("dataTipField", :string)
      end

      def icon_field
        get_property_value("iconField", :string)
      end

      def label_field
        get_property_value("labelField", :string)
      end

      def locked_column_count
        get_property_value("lockedColumnCount", :int)
      end

      def locked_row_count
        get_property_value("lockedRowCount", :int)
      end

      def allow_multiple_selection?
        get_property_value("allowMultipleSelection", :boolean)
      end

      def num_automation_children
        get_property_value("numAutomationChildren", :int)
      end

      def row_count
        get_property_value("rowCount", :int)
      end

      def row_height
        get_property_value("rowHeight", :number)
      end

      def selectable?
        get_property_value("selectable", :boolean)
      end

      def selected_index
        get_property_value("selectedIndex", :int)
      end

      def selected_indices
        get_property_value("selectedIndices", :string)
      end

      def selected_item
        get_property_value("selectedItem", :string)
      end

      def selected_items
        get_property_value("selectedItems", :string)
      end

      def show_data_tips?
        get_property_value("showDataTips", :boolean)
      end

      def variable_row_height?
        get_property_value("variableRowHeight", :boolean)
      end

      def word_wrap?
        get_property_value("wordWrap", :boolean)
      end

      def alternating_row_colors
        get_property_value("alternatingRowColors", :string)
      end

      def focus_alpha
        get_property_value("focusAlpha", :number)
      end

      def roll_over_color
        get_property_value("rollOverColor", :string)
      end

      def selection_color
        get_property_value("selectionColor", :string)
      end

      def selection_disabled_color
        get_property_value("selectionDisabledColor", :string)
      end

      def text_roll_over_color
        get_property_value("textRollOverColor", :string)
      end

      def text_selected_color
        get_property_value("textSelectedColor", :string)
      end

      def background_disabled_color
        get_property_value("backgroundDisabledColor", :string)
      end

      def use_roll_over?
        get_property_value("useRollOver", :boolean)
      end

      def vertical_align
        get_property_value("verticalAlign", :string)
      end

    end
    def list_base(*locator_hashes)
      FlexListBase.new(self, *locator_hashes)
    end

    class FlexDataGrid < FlexListBase
      include TabularData

      def header_click(column_index)
        fire_event("HeaderClick", column_index)
      end

      def column_stretch(column_index, local_x)
        fire_event("ColumnStretch", column_index, local_x)
      end

      def header_shift(new_index, old_index, trigger_event=[1])
        fire_event("HeaderShift", new_index, old_index, trigger_event)
      end

      def edit(item_renderer, row_index, column_index)
        fire_event("Edit", item_renderer, row_index, column_index)
      end

      def editable?
        get_property_value("editable", :boolean)
      end

      def column_names
        get_property_value("columnNames", :string)
      end

      def min_column_width
        get_property_value("minColumnWidth", :number)
      end

      def resizable_columns?
        get_property_value("resizableColumns", :boolean)
      end

      def sortable_columns?
        get_property_value("sortableColumns", :boolean)
      end

      def header_colors
        get_property_value("headerColors", :string)
      end

      def header_style
        get_property_value("headerStyle", :string)
      end

      def v_grid_line_color
        get_property_value("vGridLineColor", :string)
      end

      def v_grid_lines?
        get_property_value("vGridLines", :boolean)
      end

    end
    def data_grid(*locator_hashes)
      FlexDataGrid.new(self, *locator_hashes)
    end

    class FlexList < FlexListBase
      include TabularData

      def edit(item_renderer, row_index, column_index)
        fire_event("Edit", item_renderer, row_index, column_index)
      end

    end
    def list(*locator_hashes)
      FlexList.new(self, *locator_hashes)
    end
    def horizontal_list(*locator_hashes)
      FlexList.new(self, *locator_hashes)
    end
    def tile_list(*locator_hashes)
      FlexList.new(self, *locator_hashes)
    end

    class FlexTree < FlexListBase
      include TabularData

      def drag_drop(action, drop_parent="", dragged_item="", key_modifier=[0])
        fire_event("DragDrop", action, drop_parent, dragged_item, key_modifier)
      end

      def open(item_renderer, trigger_event=[1])
        fire_event("Open", item_renderer, trigger_event)
      end

      def close(item_renderer, trigger_event=[1])
        fire_event("Close", item_renderer, trigger_event)
      end

      def editable?
        get_property_value("editable", :boolean)
      end

      def depth_colors
        get_property_value("depthColors", :string)
      end

      def indentation
        get_property_value("indentation", :number)
      end

      def text_disabled_color
        get_property_value("textDisabledColor", :string)
      end

    end
    def tree(*locator_hashes)
      FlexTree.new(self, *locator_hashes)
    end

    class FlexApplication < FlexBox
      include TabularData

      def url
        get_property_value("url", :string)
      end

    end
    def application(*locator_hashes)
      FlexApplication.new(self, *locator_hashes)
    end

    class FlexScrollBar < FlexObject
      def scroll(position, direction, detail=[0])
        fire_event("Scroll", position, direction, detail)
      end

      def line_scroll_size
        get_property_value("lineScrollSize", :number)
      end

      def page_scroll_size
        get_property_value("pageScrollSize", :number)
      end

      def scroll_position
        get_property_value("scrollPosition", :string)
      end

      def track_colors
        get_property_value("trackColors", :string)
      end

      def fill_colors
        get_property_value("fillColors", :string)
      end

    end
    def h_scroll_bar(*locator_hashes)
      FlexScrollBar.new(self, *locator_hashes)
    end
    def v_scroll_bar(*locator_hashes)
      FlexScrollBar.new(self, *locator_hashes)
    end

    class FlexNumericStepper < FlexObject
      def change(value)
        fire_event("Change", value)
      end

      def input(text)
        fire_event("Input", text)
      end

      def select_text(begin_index, end_index)
        fire_event("SelectText", begin_index, end_index)
      end

      def type(key_code, key_modifier=[0])
        fire_event("Type", key_code, key_modifier)
      end

      def value
        get_property_value("value", :number)
      end

      def minimum
        get_property_value("minimum", :number)
      end

      def maximum
        get_property_value("maximum", :number)
      end

      def next_value
        get_property_value("nextValue", :number)
      end

      def previous_value
        get_property_value("previousValue", :number)
      end

      def step_size
        get_property_value("stepSize", :number)
      end

      def color
        get_property_value("color", :int)
      end

      def disabled_color
        get_property_value("disabledColor", :string)
      end

      def fill_colors
        get_property_value("fillColors", :string)
      end

      def font_family
        get_property_value("fontFamily", :string)
      end

      def font_size
        get_property_value("fontSize", :number)
      end

      def font_style
        get_property_value("fontStyle", :string)
      end

      def font_weight
        get_property_value("fontWeight", :string)
      end

      def text_align
        get_property_value("textAlign", :string)
      end

      def text_decoration
        get_property_value("textDecoration", :string)
      end

      def text_indent
        get_property_value("textIndent", :int)
      end

    end
    def numeric_stepper(*locator_hashes)
      FlexNumericStepper.new(self, *locator_hashes)
    end

    class FlexVideoDisplay < FlexObject
      def source
        get_property_value("source", :string)
      end

      def total_time
        get_property_value("totalTime", :number)
      end

      def volume
        get_property_value("volume", :number)
      end

    end
    def video_display(*locator_hashes)
      FlexVideoDisplay.new(self, *locator_hashes)
    end

    class FlexLoader < FlexObject
      def source
        get_property_value("source", :string)
      end

    end
    def swf_loader(*locator_hashes)
      FlexLoader.new(self, *locator_hashes)
    end

    class FlexImage < FlexLoader
    end
    def image(*locator_hashes)
      FlexImage.new(self, *locator_hashes)
    end

    class FlexSlider < FlexObject
      def change(value, thumb_index=0, click_target="thumb", trigger_event=[1], key_code="")
        fire_event("Change", value, thumb_index, click_target, trigger_event, key_code)
      end

      def direction
        get_property_value("direction", :string)
      end

      def value
        get_property_value("value", :number)
      end

      def values
        get_property_value("values", :string)
      end

      def maximum
        get_property_value("maximum", :number)
      end

      def minimum
        get_property_value("minimum", :number)
      end

      def thumb_count
        get_property_value("thumbCount", :int)
      end

      def labels
        get_property_value("labels", :string)
      end

      def live_dragging?
        get_property_value("liveDragging", :boolean)
      end

      def tool_tip_show?
        get_property_value("toolTipShow", :boolean)
      end

      def snap_interval
        get_property_value("snapInterval", :number)
      end

      def fill_colors
        get_property_value("fillColors", :string)
      end

      def label_style_name
        get_property_value("labelStyleName", :string)
      end

      def tick_color
        get_property_value("tickColor", :string)
      end

      def tick_length
        get_property_value("tickLength", :number)
      end

      def tick_thickness
        get_property_value("tickThickness", :number)
      end

      def data_tip_precision
        get_property_value("dataTipPrecision", :number)
      end

      def track_colors
        get_property_value("trackColors", :string)
      end

    end
    def v_slider(*locator_hashes)
      FlexSlider.new(self, *locator_hashes)
    end
    def h_slider(*locator_hashes)
      FlexSlider.new(self, *locator_hashes)
    end

    class FlexComboBase < FlexObject
      def open(trigger_event=[1])
        fire_event("Open", trigger_event)
      end

      def close(trigger_event=[1])
        fire_event("Close", trigger_event)
      end

      def scroll(position, direction, detail=[0])
        fire_event("Scroll", position, direction, detail)
      end

      def input(text)
        fire_event("Input", text)
      end

      def select_text(begin_index, end_index)
        fire_event("SelectText", begin_index, end_index)
      end

      def type(key_code, key_modifier=[0])
        fire_event("Type", key_code, key_modifier)
      end

      def text
        get_property_value("text", :string)
      end

      def restrict
        get_property_value("restrict", :string)
      end

      def editable?
        get_property_value("editable", :boolean)
      end

      def selected_index
        get_property_value("selectedIndex", :int)
      end

      def horizontal_scroll_position
        get_property_value("horizontalScrollPosition", :int)
      end

      def horizontal_scroll_policy
        get_property_value("horizontalScrollPolicy", :string)
      end

      def live_scrolling?
        get_property_value("liveScrolling", :boolean)
      end

      def show_scroll_tips?
        get_property_value("showScrollTips", :boolean)
      end

      def vertical_scroll_position
        get_property_value("verticalScrollPosition", :int)
      end

      def vertical_scroll_policy
        get_property_value("verticalScrollPolicy", :string)
      end

      def background_alpha
        get_property_value("backgroundAlpha", :number)
      end

      def background_color
        get_property_value("backgroundColor", :string)
      end

      def background_image
        get_property_value("backgroundImage", :string)
      end

      def background_size
        get_property_value("backgroundSize", :string)
      end

      def color
        get_property_value("color", :int)
      end

      def disabled_color
        get_property_value("disabledColor", :string)
      end

      def drop_shadow_enabled?
        get_property_value("dropShadowEnabled", :boolean)
      end

      def fill_alphas
        get_property_value("fillAlphas", :string)
      end

      def fill_colors
        get_property_value("fillColors", :string)
      end

      def font_family
        get_property_value("fontFamily", :string)
      end

      def font_size
        get_property_value("fontSize", :number)
      end

      def font_style
        get_property_value("fontStyle", :string)
      end

      def font_weight
        get_property_value("fontWeight", :string)
      end

      def highlight_color
        get_property_value("highlightColor", :string)
      end

      def text_align
        get_property_value("textAlign", :string)
      end

      def text_decoration
        get_property_value("textDecoration", :string)
      end

      def text_indent
        get_property_value("textIndent", :int)
      end

    end
    def combo_base(*locator_hashes)
      FlexComboBase.new(self, *locator_hashes)
    end

    class FlexComboBox < FlexComboBase
      include TabularData

      def select(item_renderer, trigger_event=[1], key_modifier=[0])
        fire_event("Select", item_renderer, trigger_event, key_modifier)
      end

      def type(key_code, key_modifier=[0])
        fire_event("Type", key_code, key_modifier)
      end

      def input(text)
        fire_event("Input", text)
      end

      def text
        get_property_value("text", :string)
      end

      def selected_index
        get_property_value("selectedIndex", :int)
      end

      def editable?
        get_property_value("editable", :boolean)
      end

      def alternating_row_colors
        get_property_value("alternatingRowColors", :string)
      end

      def fill_colors
        get_property_value("fillColors", :string)
      end

      def roll_over_color?
        get_property_value("rollOverColor", :boolean)
      end

      def selection_color?
        get_property_value("selectionColor", :boolean)
      end

    end
    def combo_box(*locator_hashes)
      FlexComboBox.new(self, *locator_hashes)
    end

    class FlexDateField < FlexComboBase
      def change(new_date)
        fire_event("Change", new_date)
      end

      def scroll(detail)
        fire_event("Scroll", detail)
      end

      def type(key_code, key_modifier=[0])
        fire_event("Type", key_code, key_modifier)
      end

      def selected_date
        get_property_value("selectedDate", :date)
      end

      def disabled_days
        get_property_value("disabledDays", :string)
      end

      def disabled_ranges
        get_property_value("disabledRanges", :string)
      end

      def displayed_month
        get_property_value("displayedMonth", :number)
      end

      def displayed_year
        get_property_value("displayedYear", :number)
      end

      def first_day_of_week
        get_property_value("firstDayOfWeek", :number)
      end

      def max_year
        get_property_value("maxYear", :number)
      end

      def min_year
        get_property_value("minYear", :number)
      end

      def show_today?
        get_property_value("showToday", :boolean)
      end

      def year_navigation_enabled?
        get_property_value("yearNavigationEnabled", :boolean)
      end

      def header_colors
        get_property_value("headerColors", :string)
      end

      def roll_over_color
        get_property_value("rollOverColor", :string)
      end

      def today_color
        get_property_value("todayColor", :string)
      end

    end
    def date_field(*locator_hashes)
      FlexDateField.new(self, *locator_hashes)
    end

    class FlexDateChooser < FlexObject
      def change(new_date)
        fire_event("Change", new_date)
      end

      def scroll(detail)
        fire_event("Scroll", detail)
      end

      def type(key_code, key_modifier=[0])
        fire_event("Type", key_code, key_modifier)
      end

      def selected_date
        get_property_value("selectedDate", :date)
      end

      def disabled_days
        get_property_value("disabledDays", :string)
      end

      def disabled_ranges
        get_property_value("disabledRanges", :string)
      end

      def allow_disjoint_selection?
        get_property_value("allowDisjointSelection", :boolean)
      end

      def displayed_month
        get_property_value("displayedMonth", :number)
      end

      def displayed_year
        get_property_value("displayedYear", :number)
      end

      def first_day_of_week
        get_property_value("firstDayOfWeek", :number)
      end

      def max_year
        get_property_value("maxYear", :number)
      end

      def min_year
        get_property_value("minYear", :number)
      end

      def allow_multiple_selection?
        get_property_value("allowMultipleSelection", :boolean)
      end

      def selected_ranges
        get_property_value("selectedRanges", :string)
      end

      def show_today?
        get_property_value("showToday", :boolean)
      end

      def year_navigation_enabled?
        get_property_value("yearNavigationEnabled", :boolean)
      end

      def header_colors
        get_property_value("headerColors", :string)
      end

      def roll_over_color
        get_property_value("rollOverColor", :string)
      end

      def today_color
        get_property_value("todayColor", :string)
      end

      def color
        get_property_value("color", :string)
      end

      def disabled_color
        get_property_value("disabledColor", :string)
      end

      def fill_colors
        get_property_value("fillColors", :string)
      end

      def font_family
        get_property_value("fontFamily", :string)
      end

      def font_size
        get_property_value("fontSize", :number)
      end

      def font_style
        get_property_value("fontStyle", :string)
      end

      def font_weight
        get_property_value("fontWeight", :string)
      end

      def text_align
        get_property_value("textAlign", :string)
      end

      def text_decoration
        get_property_value("textDecoration", :string)
      end

      def text_indent
        get_property_value("textIndent", :int)
      end

      def header_colors
        get_property_value("headerColors", :string)
      end

      def roll_over_color
        get_property_value("rollOverColor", :string)
      end

      def selection_color
        get_property_value("selectionColor", :string)
      end

    end
    def date_chooser(*locator_hashes)
      FlexDateChooser.new(self, *locator_hashes)
    end

    class FlexColorPicker < FlexComboBase
      def open(trigger_event=[1])
        fire_event("Open", trigger_event)
      end

      def close(trigger_event=[1])
        fire_event("Close", trigger_event)
      end

      def change(color)
        fire_event("Change", color)
      end

      def selected_color
        get_property_value("selectedColor", :int)
      end

      def show_text_field?
        get_property_value("showTextField", :boolean)
      end

      def column_count
        get_property_value("columnCount", :int)
      end

    end
    def color_picker(*locator_hashes)
      FlexColorPicker.new(self, *locator_hashes)
    end

    class FlexTextArea < FlexScrollBase
      def input(text)
        fire_event("Input", text)
      end

      def select_text(begin_index, end_index)
        fire_event("SelectText", begin_index, end_index)
      end

      def type(key_code, key_modifier=[0])
        fire_event("Type", key_code, key_modifier)
      end

      def scroll(position, direction, detail=[0])
        fire_event("Scroll", position, direction, detail)
      end

      def editable?
        get_property_value("editable", :boolean)
      end

      def display_as_password?
        get_property_value("displayAsPassword", :boolean)
      end

      def text
        get_property_value("text", :string)
      end

      def color
        get_property_value("color", :int)
      end

      def horizontal_scroll_policy
        get_property_value("horizontalScrollPolicy", :string)
      end

      def html_text
        get_property_value("htmlText", :string)
      end

      def length
        get_property_value("length", :number)
      end

      def max_chars
        get_property_value("maxChars", :number)
      end

      def restrict
        get_property_value("restrict", :string)
      end

      def selection
        get_property_value("selection", :string)
      end

      def word_wrap?
        get_property_value("wordWrap", :boolean)
      end

      def disabled_color
        get_property_value("disabledColor", :string)
      end

      def font_family
        get_property_value("fontFamily", :string)
      end

      def font_size
        get_property_value("fontSize", :number)
      end

      def font_style
        get_property_value("fontStyle", :string)
      end

      def font_weight
        get_property_value("fontWeight", :string)
      end

    end
    def text_area(*locator_hashes)
      FlexTextArea.new(self, *locator_hashes)
    end
    def text_input(*locator_hashes)
      FlexTextArea.new(self, *locator_hashes)
    end

    class FlexPanel < FlexContainer
      include TabularData

      def title
        get_property_value("title", :string)
      end

      def status
        get_property_value("status", :string)
      end

      def drop_shadow_enabled?
        get_property_value("dropShadowEnabled", :boolean)
      end

      def footer_colors
        get_property_value("footerColors", :string)
      end

      def header_colors
        get_property_value("headerColors", :string)
      end

      def header_height
        get_property_value("headerHeight", :int)
      end

    end
    def panel(*locator_hashes)
      FlexPanel.new(self, *locator_hashes)
    end

    class FlexTitleWindow < FlexPanel
      include TabularData

      def show_close_button?
        get_property_value("showCloseButton", :boolean)
      end

    end
    def title_window(*locator_hashes)
      FlexTitleWindow.new(self, *locator_hashes)
    end

    class FlexAlert < FlexPanel
      def type(key_code, key_modifier=[0])
        fire_event("Type", key_code, key_modifier)
      end

      def text
        get_property_value("text", :string)
      end

      def cancel_label
        get_property_value("cancelLabel", :string)
      end

      def default_button_flag
        get_property_value("defaultButtonFlag", :number)
      end

      def no_label
        get_property_value("noLabel", :string)
      end

      def ok_label
        get_property_value("okLabel", :string)
      end

      def yes_label
        get_property_value("yesLabel", :string)
      end

    end
    def alert(*locator_hashes)
      FlexAlert.new(self, *locator_hashes)
    end

    class FlexDividedBox < FlexBox
      include TabularData

      def pressed(divider_index, delta)
        fire_event("Pressed", divider_index, delta)
      end

      def dragged(divider_index, delta)
        fire_event("Dragged", divider_index, delta)
      end

      def released(divider_index, delta)
        fire_event("Released", divider_index, delta)
      end

      def resize_to_content?
        get_property_value("resizeToContent", :boolean)
      end

    end
    def divided_box(*locator_hashes)
      FlexDividedBox.new(self, *locator_hashes)
    end

    class FlexMenu < FlexObject
      include TabularData

      def type(key_code, key_modifier=[0])
        fire_event("Type", key_code, key_modifier)
      end

      def show(item_renderer)
        fire_event("Show", item_renderer)
      end

      def hide
        fire_event("Hide")
      end

      def select(item_renderer)
        fire_event("Select", item_renderer)
      end

      def row_count
        get_property_value("rowCount", :int)
      end

      def selected_index
        get_property_value("selectedIndex", :int)
      end

      def alternating_row_colors
        get_property_value("alternatingRowColors", :string)
      end

      def roll_over_color
        get_property_value("rollOverColor", :string)
      end

      def selection_color
        get_property_value("selectionColor", :string)
      end

      def text_roll_over_color
        get_property_value("textRollOverColor", :string)
      end

      def text_selected_color
        get_property_value("textSelectedColor", :string)
      end

    end
    def menu(*locator_hashes)
      FlexMenu.new(self, *locator_hashes)
    end

    class FlexMenuBar < FlexObject
      include TabularData

      def type(key_code, key_modifier=[0])
        fire_event("Type", key_code, key_modifier)
      end

      def show(item_renderer)
        fire_event("Show", item_renderer)
      end

      def hide
        fire_event("Hide")
      end

      def num_children
        get_property_value("numChildren", :int)
      end

      def selected_index
        get_property_value("selectedIndex", :number)
      end

      def background_color
        get_property_value("backgroundColor", :string)
      end

      def color
        get_property_value("color", :string)
      end

      def disabled_color
        get_property_value("disabledColor", :string)
      end

      def fill_colors
        get_property_value("fillColors", :string)
      end

      def font_family
        get_property_value("fontFamily", :string)
      end

      def font_size
        get_property_value("fontSize", :number)
      end

      def font_style
        get_property_value("fontStyle", :string)
      end

      def font_weight
        get_property_value("fontWeight", :string)
      end

      def text_align
        get_property_value("textAlign", :string)
      end

      def text_decoration
        get_property_value("textDecoration", :string)
      end

      def roll_over_color
        get_property_value("rollOverColor", :string)
      end

      def selection_color
        get_property_value("selectionColor", :string)
      end

      def text_indent
        get_property_value("textIndent", :int)
      end

    end
    def menu_bar(*locator_hashes)
      FlexMenuBar.new(self, *locator_hashes)
    end

    class FlexRepeater < Element
      include TabularData

      def automation_name
        get_property_value("automationName", :string)
      end

      def id
        get_property_value("id", :string)
      end

      def class_name
        get_property_value("className", :string)
      end

      def automation_index
        get_property_value("automationIndex", :string)
      end

      def count
        get_property_value("count", :string)
      end

    end
    def repeater(*locator_hashes)
      FlexRepeater.new(self, *locator_hashes)
    end

    class FlexLabel < FlexObject
      def click(ctrl_key, alt_key, shift_key)
        fire_event("Click", ctrl_key, alt_key, shift_key)
      end

      def text
        get_property_value("text", :string)
      end

      def html_text
        get_property_value("htmlText", :string)
      end

      def color
        get_property_value("color", :string)
      end

      def disabled_color
        get_property_value("disabledColor", :string)
      end

      def font_family
        get_property_value("fontFamily", :string)
      end

      def font_size
        get_property_value("fontSize", :number)
      end

      def font_style
        get_property_value("fontStyle", :string)
      end

      def font_weight
        get_property_value("fontWeight", :string)
      end

      def text_align
        get_property_value("textAlign", :string)
      end

      def text_decoration
        get_property_value("textDecoration", :string)
      end

      def text_indent
        get_property_value("textIndent", :int)
      end

    end
    def label(*locator_hashes)
      FlexLabel.new(self, *locator_hashes)
    end

    class FlexRule < FlexObject
      def color
        get_property_value("color", :string)
      end

      def stroke_width
        get_property_value("strokeWidth", :number)
      end

    end
    def h_rule(*locator_hashes)
      FlexRule.new(self, *locator_hashes)
    end
    def v_rule(*locator_hashes)
      FlexRule.new(self, *locator_hashes)
    end

    class FlexFormItem < FlexContainer
      def horizontal_align
        get_property_value("horizontalAlign", :string)
      end

    end
    def form_item(*locator_hashes)
      FlexFormItem.new(self, *locator_hashes)
    end

    class FlexViewStack < FlexContainer
      include TabularData

      def type(key_code, key_modifier=[0])
        fire_event("Type", key_code, key_modifier)
      end

      def selected_index
        get_property_value("selectedIndex", :int)
      end

      def selected_child
        get_property_value("selectedChild", :string)
      end

    end
    def view_stack(*locator_hashes)
      FlexViewStack.new(self, *locator_hashes)
    end

    class FlexTabNavigator < FlexViewStack
      include TabularData

      def change(related_object)
        fire_event("Change", related_object)
      end

      def horizontal_align
        get_property_value("horizontalAlign", :string)
      end

      def horizontal_gap
        get_property_value("horizontalGap", :number)
      end

      def tab_height
        get_property_value("tabHeight", :number)
      end

      def tab_width
        get_property_value("tabWidth", :number)
      end

    end
    def tab_navigator(*locator_hashes)
      FlexTabNavigator.new(self, *locator_hashes)
    end

    class FlexNavigationBar < FlexBox
      include TabularData

      def change(related_object)
        fire_event("Change", related_object)
      end

      def type(key_code, key_modifier=[0])
        fire_event("Type", key_code, key_modifier)
      end

      def direction
        get_property_value("direction", :string)
      end

      def selected_index
        get_property_value("selectedIndex", :int)
      end

    end
    def nav_bar(*locator_hashes)
      FlexNavigationBar.new(self, *locator_hashes)
    end

    class FlexLinkBar < FlexNavigationBar
      include TabularData

      def selected_index
        get_property_value("selectedIndex", :int)
      end

      def num_children
        get_property_value("numChildren", :int)
      end

    end
    def link_bar(*locator_hashes)
      FlexLinkBar.new(self, *locator_hashes)
    end

    class FlexButtonBar < FlexNavigationBar
      include TabularData

      def selected_index
        get_property_value("selectedIndex", :string)
      end

      def num_children
        get_property_value("numChildren", :string)
      end

    end
    def button_bar(*locator_hashes)
      FlexButtonBar.new(self, *locator_hashes)
    end

    class FlexToggleButtonBar < FlexButtonBar
      include TabularData

      def selected_index
        get_property_value("selectedIndex", :string)
      end

      def num_children
        get_property_value("numChildren", :string)
      end

    end
    def toggle_button_bar(*locator_hashes)
      FlexToggleButtonBar.new(self, *locator_hashes)
    end

    class FlexChart < FlexObject
      include TabularData

      def description
        get_property_value("description", :string)
      end

      def clip_content?
        get_property_value("clipContent", :boolean)
      end

      def data_tip_layer_index
        get_property_value("dataTipLayerIndex", :int)
      end

      def data_tip_mode
        get_property_value("dataTipMode", :string)
      end

      def mouse_sensitivity
        get_property_value("mouseSensitivity", :int)
      end

      def show_data_tips?
        get_property_value("showDataTips", :boolean)
      end

      def font_family
        get_property_value("fontFamily", :string)
      end

      def font_size
        get_property_value("fontSize", :int)
      end

      def maximum_data_tip_count
        get_property_value("maximumDataTipCount", :int)
      end

      def padding_bottom
        get_property_value("paddingBottom", :int)
      end

      def padding_top
        get_property_value("paddingTop", :int)
      end

      def padding_left
        get_property_value("paddingLeft", :int)
      end

      def padding_right
        get_property_value("paddingRight", :int)
      end

      def show_data_tip_targets?
        get_property_value("showDataTipTargets", :boolean)
      end

    end
    def chart_base(*locator_hashes)
      FlexChart.new(self, *locator_hashes)
    end

    class FlexCartesianChart < FlexChart
      include TabularData

      def horizontal_axis_ratio
        get_property_value("horizontalAxisRatio", :number)
      end

      def gutter_left
        get_property_value("gutterLeft", :int)
      end

      def gutter_right
        get_property_value("gutterRight", :int)
      end

      def gutter_bottom
        get_property_value("gutterBottom", :int)
      end

      def gutter_top
        get_property_value("gutterTop", :int)
      end

      def text_align
        get_property_value("textAlign", :string)
      end

    end
    def cartesian_chart(*locator_hashes)
      FlexCartesianChart.new(self, *locator_hashes)
    end

    class FlexAreaChart < FlexCartesianChart
      include TabularData

      def type
        get_property_value("type", :string)
      end

    end
    def area_chart(*locator_hashes)
      FlexAreaChart.new(self, *locator_hashes)
    end

    class FlexBarChart < FlexCartesianChart
      include TabularData

      def bar_width_ratio
        get_property_value("barWidthRatio", :number)
      end

      def max_bar_width
        get_property_value("maxBarWidth", :number)
      end

    end
    def bar_chart(*locator_hashes)
      FlexBarChart.new(self, *locator_hashes)
    end

    class FlexColumnChart < FlexCartesianChart
      include TabularData

      def column_width_ratio
        get_property_value("columnWidthRatio", :number)
      end

      def max_column_width
        get_property_value("maxColumnWidth", :number)
      end

    end
    def column_chart(*locator_hashes)
      FlexColumnChart.new(self, *locator_hashes)
    end

    class FlexHLOCChart < FlexCartesianChart
      include TabularData

      def column_width_ratio
        get_property_value("columnWidthRatio", :number)
      end

      def max_column_width
        get_property_value("maxColumnWidth", :number)
      end

    end
    def hloc_chart(*locator_hashes)
      FlexHLOCChart.new(self, *locator_hashes)
    end

    class FlexLineChart < FlexCartesianChart
      include TabularData

    end
    def line_chart(*locator_hashes)
      FlexLineChart.new(self, *locator_hashes)
    end

    class FlexPieChart < FlexChart
      include TabularData

      def inner_radius
        get_property_value("innerRadius", :number)
      end

      def text_align
        get_property_value("textAlign", :string)
      end

    end
    def pie_chart(*locator_hashes)
      FlexPieChart.new(self, *locator_hashes)
    end

    class FlexChartSeries < FlexObject
      include TabularData

      def click(hit_set)
        fire_event("Click", hit_set)
      end

      def double_click(hit_set)
        fire_event("DoubleClick", hit_set)
      end

      def item_roll_over(hit_set)
        fire_event("ItemRollOver", hit_set)
      end

    end
    def series(*locator_hashes)
      FlexChartSeries.new(self, *locator_hashes)
    end

    class FlexAreaSeries < FlexChartSeries
      include TabularData

      def min_field
        get_property_value("minField", :string)
      end

      def x_field
        get_property_value("xField", :string)
      end

      def y_field
        get_property_value("yField", :string)
      end

      def form
        get_property_value("form", :string)
      end

      def radius
        get_property_value("radius", :number)
      end

    end
    def area_series(*locator_hashes)
      FlexAreaSeries.new(self, *locator_hashes)
    end

    class FlexBarSeries < FlexChartSeries
      include TabularData

      def bar_width_ratio
        get_property_value("barWidthRatio", :number)
      end

      def max_bar_width
        get_property_value("maxBarWidth", :number)
      end

      def min_field
        get_property_value("minField", :string)
      end

      def offset
        get_property_value("offset", :number)
      end

      def x_field
        get_property_value("xField", :string)
      end

      def y_field
        get_property_value("yField", :string)
      end

    end
    def bar_series(*locator_hashes)
      FlexBarSeries.new(self, *locator_hashes)
    end

    class FlexBubbleSeries < FlexChartSeries
      include TabularData

      def max_radius
        get_property_value("maxRadius", :number)
      end

      def radius_field
        get_property_value("radiusField", :string)
      end

      def x_field
        get_property_value("xField", :string)
      end

      def y_field
        get_property_value("yField", :string)
      end

    end
    def bubble_series(*locator_hashes)
      FlexBubbleSeries.new(self, *locator_hashes)
    end

    class FlexColumnSeries < FlexChartSeries
      include TabularData

      def column_width_ratio
        get_property_value("columnWidthRatio", :number)
      end

      def max_column_width
        get_property_value("maxColumnWidth", :number)
      end

      def offset
        get_property_value("offset", :number)
      end

      def sort_on_x_field?
        get_property_value("sortOnXField", :boolean)
      end

      def min_field
        get_property_value("minField", :string)
      end

      def x_field
        get_property_value("xField", :string)
      end

      def y_field
        get_property_value("yField", :string)
      end

    end
    def column_series(*locator_hashes)
      FlexColumnSeries.new(self, *locator_hashes)
    end

    class FlexLineSeries < FlexChartSeries
      include TabularData

      def form
        get_property_value("form", :string)
      end

      def radius
        get_property_value("radius", :number)
      end

      def sort_on_x_field?
        get_property_value("sortOnXField", :boolean)
      end

      def x_field
        get_property_value("xField", :string)
      end

      def y_field
        get_property_value("yField", :string)
      end

    end
    def line_series(*locator_hashes)
      FlexLineSeries.new(self, *locator_hashes)
    end

    class FlexPieSeries < FlexChartSeries
      include TabularData

      def explode_radius
        get_property_value("explodeRadius", :number)
      end

      def field
        get_property_value("field", :string)
      end

      def max_label_radius
        get_property_value("maxLabelRadius", :number)
      end

      def name_field
        get_property_value("nameField", :string)
      end

      def outer_radius
        get_property_value("outerRadius", :number)
      end

      def inside_label_size_limit
        get_property_value("insideLabelSizeLimit", :number)
      end

      def inner_radius
        get_property_value("innerRadius", :number)
      end

      def font_size
        get_property_value("fontSize", :int)
      end

      def callout_gap
        get_property_value("calloutGap", :number)
      end

      def start_angle
        get_property_value("startAngle", :number)
      end

      def label_position
        get_property_value("labelPosition", :string)
      end

    end
    def pie_series(*locator_hashes)
      FlexPieSeries.new(self, *locator_hashes)
    end

    class FlexPlotSeries < FlexChartSeries
      include TabularData

      def radius
        get_property_value("radius", :number)
      end

      def x_field
        get_property_value("xField", :string)
      end

      def y_field
        get_property_value("yField", :string)
      end

    end
    def plot_series(*locator_hashes)
      FlexPlotSeries.new(self, *locator_hashes)
    end

    class FlexAxisRenderer < FlexObject
      include TabularData

      def height_limit
        get_property_value("heightLimit", :number)
      end

      def length
        get_property_value("length", :number)
      end

      def placement
        get_property_value("placement", :string)
      end

      def can_drop_labels?
        get_property_value("canDropLabels", :boolean)
      end

      def can_stagger?
        get_property_value("canStagger", :boolean)
      end

      def label_gap
        get_property_value("labelGap", :number)
      end

      def label_rotation
        get_property_value("labelRotation", :number)
      end

      def minor_tick_length
        get_property_value("minorTickLength", :number)
      end

      def minor_tick_placement
        get_property_value("minorTickPlacement", :string)
      end

      def show_labels?
        get_property_value("showLabels", :boolean)
      end

      def show_line?
        get_property_value("showLine", :boolean)
      end

      def tick_length
        get_property_value("tickLength", :number)
      end

      def tick_placement
        get_property_value("tickPlacement", :string)
      end

      def ticks
        get_property_value("ticks", :string)
      end

      def minor_ticks
        get_property_value("minorTicks", :string)
      end

    end
    def axis_renderer(*locator_hashes)
      FlexAxisRenderer.new(self, *locator_hashes)
    end

    class FlexChartLegend < FlexObject
      include TabularData

      def click(item)
        fire_event("Click", item)
      end

      def label
        get_property_value("label", :string)
      end

      def marker_aspect_ratio
        get_property_value("markerAspectRatio", :number)
      end

      def font_weight
        get_property_value("fontWeight", :string)
      end

      def label_placement
        get_property_value("labelPlacement", :string)
      end

      def marker_height
        get_property_value("markerHeight", :int)
      end

      def marker_width
        get_property_value("markerWidth", :int)
      end

      def padding_left
        get_property_value("paddingLeft", :int)
      end

      def padding_right
        get_property_value("paddingRight", :int)
      end

      def vertical_gap
        get_property_value("verticalGap", :int)
      end

    end
    def legend(*locator_hashes)
      FlexChartLegend.new(self, *locator_hashes)
    end

    class FlexListLabel < FlexDisplayObject
      def automation_value
        get_property_value("automationValue", :string)
      end

      def automation_name
        get_property_value("automationName", :string)
      end

      def class_name
        get_property_value("className", :string)
      end

      def automation_index
        get_property_value("automationIndex", :string)
      end

    end
    def menu_item_renderer(*locator_hashes)
      FlexListLabel.new(self, *locator_hashes)
    end
    def menu_bar_item(*locator_hashes)
      FlexListLabel.new(self, *locator_hashes)
    end
    def tree_item_renderer(*locator_hashes)
      FlexListLabel.new(self, *locator_hashes)
    end
    def list_item_renderer(*locator_hashes)
      FlexListLabel.new(self, *locator_hashes)
    end
    def data_grid_item_renderer(*locator_hashes)
      FlexListLabel.new(self, *locator_hashes)
    end
    def tile_list_item_renderer(*locator_hashes)
      FlexListLabel.new(self, *locator_hashes)
    end
  end
end
