module FunFX
  module Flex
    module Events
      # Needs real docs
      # Arguments for trees: item_renderer, trigger_event
      # Arguments for other controls: trigger_event
      def open(*args)
        args << ['1'] unless args.last === Array
          
        fire_event('Open', *args)
      end
      
      def select(item_renderer, trigger_event=["1"], key_modifier=["0"])
        fire_event('Select', item_renderer, trigger_event, key_modifier)
      end
      
      def deselect(item_renderer, trigger_event=["1"], key_modifier=["0"])
        fire_event('Deselect', item_renderer, trigger_event, key_modifier)
      end
      
      def click(local_x=0, local_y=0, key_modifier=["0"])
        fire_event('Click', local_x, local_y, key_modifier)
      end
      
      def change(value, thumb_index=0, click_target="thumb", trigger_event=["1"], key_code="")
        fire_event('Change', value, thumb_index, click_target, trigger_event, key_code)
      end
      
      def input(text)
        fire_event('Input', text)
      end
      
      def scroll(position, direction = nil, detail=["null"])
        fire_event('Scroll', position, direction, detail)
      end
      
      def show(item_renderer)
        fire_event('Show', item_renderer)
      end
      
      def select_text(begin_index, end_index)
        fire_event('SelectText', begin_index, end_index)
      end
      
      def drag_start(dragged_item, key_modifier=["0"])
        fire_event('DragStart', dragged_item, key_modifier)
      end
      
      def drag_drop(action, dragged_item="", key_modifier=["0"])
        fire_event('DragDrop', action, dragged_item, key_modifier)
      end
      
      # Needs real docs
      # Arguments for trees: item_renderer, trigger_event
      # Arguments for other controls: trigger_event
      def close(*args)
        args << ['1'] unless args.last === Array
          
        fire_event('Close', *args)
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
      
      def fire_event(event_name, *args)
        flex_args = args.join("_ARG_SEP_");
        flex_invoke do
          @flex_app.fire_event(flex_locator, event_name, flex_args)
        end
        sleep FunFX.fire_pause unless FunFX.fire_pause.nil?
      end

    end
  end
end
