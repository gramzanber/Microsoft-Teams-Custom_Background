def program_information_method
  Tk::messageBox :type => 'ok', :message => $program_information, :icon => 'info', :title => 'Program Information'
end

def program_license_method
  Tk::messageBox :type => 'ok', :message => $license, :icon => 'info', :title => 'Program License'
end

def browse_method
  image = Tk.getOpenFile
  $entry_link.delete("0", "end")
  $entry_link.insert 'end', image
end

# You should ensure you own the rights to the photo
# If you don’t have any suitable landscapes around, check out the royalty-free site Unsplash.com
# Make sure your background is in a suitable size such as 1920×1280.
# Windows location:  %APPDATA%\Microsoft\Teams\Backgrounds\Uploads
# MacOS location: ~/Library/Application Support/Microsoft/Teams/Backgrounds/Uploads
def add_background
  require 'open-uri'

  if $entry_link.get != ""
    # Checks the Operating System(os) becuase Microsoft only supports custom backgrounds on MacOS and WindowsOS
    # Also sets OS specific variables
    if(RUBY_PLATFORM.include?("darwin"))
    	os = "MacOS"
    	background_folder = "~/Library/Application\\ Support/Microsoft/Teams/Backgrounds/Uploads"
    elsif(RUBY_PLATFORM.include?("mswin") || RUBY_PLATFORM.include?("mingw") || RUBY_PLATFORM.include?("cygwin"))
    	os = "WindowsOS"
      background_folder = "#{ENV['appdata']}\\Microsoft Teams\\Backgrounds\\Uploads"
    else
    	os = "Not supported"
    	background_folder = "Not supported"
    end

    begin
    	# Check if Microsoft Teams is installed
    	if Dir.exist?(background_folder)
    		# Integrity check to ensure we are on the right platform
    		if os == "MacOS" || os == "WindowsOS"
    			# Getting picture information
    			link = $entry_link.get
    			# Determine if link is a web link or a local file
    			if link.include?("http")
    				link_type = "web";
    				filename = link.split("/")[link.split("/").count - 1]
    			else
    				link_type = "local";
    				if os == "MacOS"
    					filename = link.split("/")[link.split("/").count - 1]
    				elsif os == "WindowsOS"
    					filename = link.split("\\")[link.split("\\").count - 1]
    				end
    			end
    			filetype = filename.split(".")[1]
    			# Must be a PNG or JPG, Microsoft teams only supports PNG or JPG for custom backgrounds
    			if (filetype.downcase == "png" || filetype.downcase == "jpg")
    				# Get file
    				if link_type == "web"
    					File.open("#{background_folder}/#{filename}", "wb") do |file|
    						file.write open(link).read
    					end
    				elsif link_type == "local"
    					if os == "MacOS"
                # reverify
    						system("cp \"#{link}\" \"#{background_folder}/#{filename}\"")
    					elsif os == "WindowsOS"
                system("xcopy /Y \"#{link.gsub('/','\\')}\" \"#{background_folder}\"")
    					end
    				end
            $label_error.text = "Background added"
    			else
            $label_error.text = "Wrong file type, must be JPG or PNG"
    			end
    		else
          $label_error.text = "Must be on WindowsOS or MacOS, Microsoft Teams only supports custom backgrounds on these platforms"
    		end
    	else
        $label_error.text = "Microsoft Teams does not appear to be installed or does not support custom backgrounds"
    	end
    rescue StandardError => error
    	$label_error.text = "System closed with error: #{error}"
    end
  else
    $label_error.text = "Location is blank"
  end
end
