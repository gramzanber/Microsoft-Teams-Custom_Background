# You should ensure you own the rights to the photo
# If you don’t have any suitable landscapes around, check out the royalty-free site Unsplash.com
# Make sure your background is in a suitable size such as 1920×1280.
# Windows location:  %APPDATA%\Microsoft\Teams\Backgrounds\Uploads
# MacOS location: ~/Library/Application Support/Microsoft/Teams/Backgrounds/Uploads

require 'open-uri'

puts "Paste a web link or paste address to a local file"
print "Location: "
link = gets.chomp
if (link != "")
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
							system("cp \"#{link}\" \"#{background_folder}/#{filename}\"")
						elsif os == "WindowsOS"
							system("xcopy /Y \"#{link.gsub('/','\\')}\" \"#{background_folder}\"")
						end
					end
					puts "Background added"
				else
					puts "Wrong file type, must be JPG or PNG"
				end
			else
				puts "Must be on WindowsOS or MacOS, Microsoft Teams only supports custom backgrounds on these platforms"
			end
		else
			puts "Microsoft Teams does not appear to be installed or does not support custom backgrounds"
		end
	rescue StandardError => error
		puts "System closed with error: #{error}"
	end
else
	puts "Location is blank"
end
