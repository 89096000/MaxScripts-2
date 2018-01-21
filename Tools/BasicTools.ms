
try (destroyDialog BasicTools) catch()

rollout BasicTools "Basic Tools" width:460 height:608
(
	label 'lbl1' "Basic Tools" pos:[212,15] width:57 height:17 align:#left
	
	GroupBox 'grp1' "Import / Export" pos:[50,42] width:361 height:82 align:#left
	button 'button_import' "Import" pos:[66,66] width:92 height:17 align:#left
	button 'button_export' "Export selected" pos:[66,90] width:91 height:17 align:#left
	dropdownList 'dropdown_format' "" pos:[307,90] width:83 height:21 items:#("FBX", "OBJ") align:#left
	checkbox 'check_customize_import' "Customize" pos:[177,65] width:102 height:18 align:#left
	checkbox 'check_customize_export' "Customize" pos:[177,90] width:102 height:18 align:#left
	
	GroupBox 'grp2' "Order" pos:[50,148] width:359 height:96 align:#left
	label 'lbl2' "Columns X Axis" pos:[60,167] width:75 height:14 align:#left	
	
	
	label 'lbl3' "Columns Y Axis" pos:[60,189] width:75 height:14 align:#left
	spinner 'spn_columnsX' "" pos:[143,167] width:61 height:16 range:[1,100,0] type:#integer align:#left
	spinner 'spn_columnsY' "" pos:[143,188] width:61 height:16 range:[1,100,0] type:#integer align:#left
	label 'lbl4' "Distance" pos:[218,177] width:70 height:14 align:#left
	spinner 'spn_distance' "" pos:[264,177] width:61 height:16 range:[0,100,0] type:#float align:#left
	button 'button_order' "Order Objets" pos:[184,218] width:99 height:17 align:#left
	
	GroupBox 'grp6' "Resize" pos:[50,431] width:359 height:80 align:#left
	label 'lbl9' "X Size" pos:[71,456] width:33 height:15 align:#left
	label 'lbl10' "Y Size" pos:[184,456] width:33 height:15 align:#left
	label 'lbl11' "Z Size" pos:[300,456] width:33 height:15 align:#left
	spinner 'spnXS' "" pos:[104,455] width:62 height:16 range:[0,1000,0] align:#left
	spinner 'spnYS' "" pos:[219,455] width:62 height:16 range:[0,1000,0] align:#left
	spinner 'spnZS' "" pos:[336,455] width:62 height:16 range:[0,1000,0] align:#left
	button 'btnRes' "Resize Selection" pos:[189,479] width:87 height:18 align:#left
	
	
	GroupBox 'grp4' "Geometry" pos:[50,257] width:359 height:99 align:#left
	button 'btnResX' "Reset X Form" pos:[288,289] width:94 height:19 align:#left
	label 'lbl16' "Angle" pos:[100,276] width:47 height:16 align:#left
	label 'lbl17' "Angle" pos:[204,276] width:47 height:16 align:#left
	spinner 'angle_smoothing' "" pos:[88,295] width:53 height:16 range:[0,359, 45] align:#left
	spinner 'angle_flatten' "" pos:[192,295] width:53 height:16 range:[0,359, 45] align:#left
	button 'btnSmoothing' "Smoothing Groups" pos:[63,320] width:97 height:20 align:#left
	button 'btnFlatten' "Flatten Mapping" pos:[171,320] width:97 height:20 align:#left
	
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
		folder_path += "\export"
		makeDir folder_path
		selec = Selection as Array
		if dropdown_format.selection == 1 then( -- selection -> number / selected -> value string
			export_end = "" --fbx is default format, no no need to write it
		)else(
			export_end = ".obj"
		)
		i = 0
		for obj in selec do(
			Select obj
			obj.pivot = obj.min
			prev_pos = obj.pos
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
			i += 1;
			obj.pos = prev_pos
		)
	)
	on button_order pressed do
	(
			
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
	on btnRes pressed do
	(
		selec = $selection as array
		
		for obj in selec do (
			
			select obj
		
			size = obj.max - obj.min
			
			xscale = spnXS.value / size.x
			yscale = spnYS.value / size.y
			zscale = spnZS.value / size.z
			
			scale obj [xscale, yscale, zscale]		
			
		)	
	)
	
	on btnResX pressed do
	(
		sel = $selection as array
		
		for obj in sel do (
			
			select obj
			modPanel.addModToSelection(XForm()) ui:on
			ResetXform obj
			ResetTransform obj
			maxOps.CollapseNode obj off
			
		)
	)
	
	on btnFlatten pressed do
	(
		sel = $selection as array
		
		for obj in sel do
		(
			select obj
			modPanel.addModToSelection(Unwrap_UVW()) ui:on
			obj.modifiers["unwrap_uvw"].flattenMap(angle_flatten.value as float) #() 0.01 true 0 true true
			maxOps.CollapseNode obj off
		)
	)
	
	on btnSmoothing pressed do
	(
		sel = $selection as array
		
		for obj in sel do
		(
			select obj
			convertTo obj Editable_Poly
			polyOp.setFaceSelection obj #{1..polyOp.getNumFaces obj}
			obj.autoSmoothThreshold = angle_smoothing.value as float
			obj.EditablePoly.autosmooth()
			polyop.setFaceSelection obj #{}
		)
	)
)

createDialog BasicTools height:600 width:460 pos:[1350, 100]



