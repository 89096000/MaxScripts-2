function replaceString str1 str2 = (
	
	sel = $selection as Array
	
	for obj in sel do
	(
		obj.name = substitutestring obj.name str1 str2
	)
)

-- replaceString "Box" "Caja"

try (destroyDialog RenameTool) catch()

rollout RenameTool "Rename Tool" width:162 height:114
(
	label 'lbl19' "Rename Objects" pos:[37,13] width:82 height:17 align:#left
	label 'lbl20' "Find:" pos:[11,42] width:40 height:17 align:#left
	label 'lbl21' "Replace:" pos:[11,59] width:40 height:17 align:#left
	editText 'edt1' "" pos:[71,39] width:68 height:17 align:#left
	editText 'edt2' "" pos:[71,58] width:68 height:17 align:#left
	button 'btn' "Find and Replace" pos:[31,85] width:101 height:18 align:#left
	
	on btn pressed do
	(
		replaceString edt1.text edt2.text
	)
)

createDialog RenameTool height:114 width:162 pos:[1350, 100]