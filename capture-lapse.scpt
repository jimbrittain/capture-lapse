set shot_number to 100
set delay_time to (60 * 60 * 1000) -- delay one hour, integer in secs
set the_desktop to (path to home folder as text) & "Desktop"
set save_location to choose folder with prompt "Choose where to save screenshots:" default location alias the_desktop

repeat
	set dialogResult to (display dialog "Enter number of shots:" default answer "100")
	try
		set shot_number to (text returned of dialogResult) as integer
		if class of shot_number is integer then exit repeat
	on error m number n from o partial result r to t
		set unableToConvertToInteger to n is -1700 and o is text returned of dialogResult and t is integer
		set numericResultTooLarge to n is -2702 and t is integer
		if not (unableToConvertToInteger or numericResultTooLarge) then error m number n from o partial result r to t
	end try
	display dialog "The number of shots needs to be a valid integer" buttons {"Enter number of shots again", "Cancel"} default button 1
end repeat

repeat
	set dialogResult to (display dialog "Enter delay time in milliseconds:" default answer "1000")
	try
		set delay_time to (text returned of dialogResult) as integer
		if class of delay_time is integer then exit repeat
	on error m number n from o partial result r to t
		set unableToConvertToInteger to n is -1700 and o is text returned of dialogResult and t is integer
		set numericResultTooLarge to n is -2702 and t is integer
		if not (unableToConvertToInteger or numericResultTooLarge) then error m number n from o partial result r to t
	end try
	display dialog "The delay time needs to be a valid integer" buttons {"Enter delay time in seconds again", "Cancel"} default button 1
end repeat

repeat with shotcount from 1 to shot_number
	--display dialog "Cancel Screen Capture" buttons {Cancel} cancel button 1
	do shell script "screencapture -T 0 -x -t png " & quoted form of POSIX path of save_location & "screen" & (shotcount as string) & ".png"
	delay (delay_time / 1000) -- delay one hour, interger in milliseconds
end repeat
