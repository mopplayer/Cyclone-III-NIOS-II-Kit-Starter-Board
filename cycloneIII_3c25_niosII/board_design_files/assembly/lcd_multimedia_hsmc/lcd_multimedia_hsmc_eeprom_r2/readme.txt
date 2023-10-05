=============================================================================================
Function:
	Read/write EEPROM in HMB through the host pc.

=============================================================================================
Requirement:
	- Quartus 7.1 or 7.2 installed
	- Nios II IDE installed
	- Cyclone III starter board 
	- HMB board
	- USB-Blaster Cable

=============================================================================================
Hardware Configuration:
	- Connect HMB board to Cyclone III starter board.
	- Connect Cyclone III starter board to the host pc by an USB-Blaster Cable.
	
=============================================================================================
Utility Operation:	
	- Launch the utility by executing "CIII_HMB_EEPROM.exe"
	- Click "Download Code" to download .sof and .elf to Cyclone III start board.
	- Select EEPROM Size: 16 byte
	- Click "Read" to Upload EEPROM to UI-EEPROM-Setting.
	- Click "Write" to Download UI-EEPROM-Setting to EEPROM.
	- Click "Save to File" to save the UI-EEPROM-Setting to a specified file. 
	- click "Load from File" to load a specified file content to UI-EEPROM-Setting.
	- click "Default" to restore UI-EEPROM-Setting. 
	        (note. the data is not written to EEPROM until users click "Write").
	- click "Exit" to terminate the utility.
	
	Note. If USB-Blaster is used by Quartus II or Nios II IDE, please release 
	the connection before using this utility.
	

=============================================================================================
End	
	