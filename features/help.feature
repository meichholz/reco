Feature: Programs shows help

	In order to fight details
	As a user
	I want to get help for the program

	Scenario: Shows Version
		Given the Application
		When I start with --help
		Then I want to see a version number

	Scenario: Shows Modes
		Given the Application
		When I start with --help
		Then I want to see modes and options

