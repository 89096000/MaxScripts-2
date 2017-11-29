
try (destroyDialog BasicTools) catch()

rollout BasicTools "Basic Tools" width:460 height:608
(
	label 'lbl1' "Basic Tools" pos:[212,15] width:57 height:17 align:#left
	
	GroupBox 'grp1' "Import / Export" pos:[49,42] width:361 height:82 align:#left
	button 'button_import' "Import" pos:[66,66] width:92 height:17 align:#left
	button 'button_export' "Export selected" pos:[66,90] width:91 height:17 align:#left
	dropdownList 'dropdown_format' "" pos:[307,90] width:83 height:21 items:#("FBX", "OBJ") align:#left
	checkbox 'check_customize_import' "Customize" pos:[177,65] width:102 height:18 align:#left
	checkbox 'check_customize_export' "Customize" pos:[177,90] width:102 height:18 align:#left
	
	groupBox 'grp2' "Order" pos:[51,148] width:359 height:96 align:#left
	label 'lbl2' "Columns X Axis" pos:[60,167] width:75 height:14 align:#left	
	label 'lbl3' "Columns Y Axis" pos:[60,189] width:75 height:14 align:#left
	spinner 'spn_columnsX' "" pos:[143,167] width:61 height:16 range:[1,100,0] type:#integer align:#left
	spinner 'spn_columnsY' "" pos:[143,188] width:61 height:16 range:[1,100,0] type:#integer align:#left
	label 'lbl4' "Distance" pos:[218,177] width:70 height:14 align:#left
	spinner 'spn_distance' "" pos:[264,177] width:61 height:16 range:[0,100,0] type:#float align:#left
	button 'button_order' "Order Objets" pos:[168,218] width:99 height:17 align:#left
	
	
	on button_import pressed do
	(
		folder_path = getSavePath caption:"Select folder:"
		files = getFiles(folder_path + "\\*")
		i = 0
		for f in files do(
			--comprobar que la extension es obj o fbx
			if check_customize_import.checked == false then(
				print "false"
				importFile f #noPrompt
			)else(
				print "true"
				if i == 0 then(
					importfile f
				)else(
					importfile f #noPrompt
				)
			)
			i = i + 1
		)
	)
	on button_export pressed do
	(
		folder_path = getSavePath caption:"Select folder:"
		selec = Selection as Array
		if dropdown_format.selection == 1 then(
			export_end = "" --fbx is default format, no no need to write it
		)else(
			export_end = ".obj"
		)
		i = 0
		for obj in selec do(
			obj.pos = [0,0,0]
			if check_customize_export.checked == false then(
				exportFile (folder_path + "\\" + obj.name + export_end) #noPrompt selectedOnly:true
			)else(
				if i == 0 then(
					exportFile (folder_path + "\\" + obj.name + export_end) selectedOnly:true
				)else(
					exportFile (folder_path + "\\" + obj.name + export_end) #noPrompt selectedOnly:true
				)
			)
		)
	)
		
	on button_order pressed do (
		
		colX = (int)spn_columnsX.value
		colY = (int)spn_columnsY.value
		dst = (float)spn_distance.value
		
		selec = Selection as Array
		
		accDst = 0;
		
		i = 0
		c_colX = 0
		c_colY = 0
		for obj in selec do(
			obj.pos = [dst*c_colX, dst*c_colY, 0]
			c_colX = c_colX + 1
			if c_colX <= colX then(
				c_colX = 1
				c_colY = c_colY + 1
			)
		)
	)
)

createDialog BasicTools height:600 width:460 pos:[1350, 100]