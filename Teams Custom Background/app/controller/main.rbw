# Designed by Tyrel Tachibana
# Designed on 05/08/2020

# Variables
$company = "Tyrel Tachibana"
$company_link = "https://github.com/gramzanber"
$program_information = "Custom backgrounds were a fun way to invite fun and whimsy to the Corona Virus based meeting, " +
                      "so I built this program to easily allow adding custom backgrounds.\n\nDesigned by Tyrel Tachibana\n#{$company_link}"
$license = "This code is free to use, and is BSD 4-clause Licensed.\n" + "Code was designed by #{$company}.\n" + "This application is in no way endorsed my Microsoft.\n"
$software_version = "1.0.0"
$application_name = "Microsoft Teams Custom Backgrounds"
$detected_operating_system = ""
$root_directory = "../.."

# Required ruby code
require "#{$root_directory}/lib/colors.rb"
require "../view/application_builder.rb"

# Start Main application
$program = Application_Builder.new
$program.start
