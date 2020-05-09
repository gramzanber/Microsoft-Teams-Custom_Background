class Frame_Builder
  def add(root)
      @root = root
  end

  def build_frames
    self.build_main
    self.build_status
  end

  def build_main
    frame_main = TkFrame.new(@root) {
      relief 'sunken'
      background $SNOW_WHITE
      pack('fill'=>'both', 'expand'=>'1', 'anchor' => 'n')
    }

    label_instructions = TkLabel.new(frame_main) do
      background $SNOW_WHITE
      text "Paste a web link or browse to a local file"
      pack("pady"=> 20, "anchor"=>"n")
    end

    frame_link = TkFrame.new(frame_main) {
      background $SNOW_WHITE
      pack()
    }

    label_link = TkLabel.new(frame_link) do
      background $SNOW_WHITE
      text "Location"
      pack("side"=>"left")
    end

    # Elements are added to the stack in reverse order, this is the right stack
    button_link = TkButton.new(frame_link) do
      text "Browse"
      command {browse_method}
      pack("side"=>"right")
    end

    $entry_link = TkEntry.new(frame_link) do
      background $SNOW_WHITE
      width 50
      pack("side"=>"right")
    end

    button_link = TkButton.new(frame_main) do
      text "Add background"
      command {add_background}
      pack("pady"=> 15)
    end

    $label_error = TkLabel.new(frame_main) do
      background $SNOW_WHITE
      text ""
      foreground $RED
      pack()
    end
  end

  def build_status
    frame_status_bar = TkFrame.new(@root) {
      background $GUN_METAL
      relief 'sunken'
      borderwidth 2
      highlightbackground "black"
      pack('fill'=>'x', 'anchor' => 's')
    }

    label_version = TkLabel.new(frame_status_bar) do
      background $GUN_METAL
      foreground $WHITE
      text "Version: #{$software_version}"
      pack("side"=>"left")
    end
  end
end
