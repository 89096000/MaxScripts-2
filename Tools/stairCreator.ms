function convertToEditPoly obj = (
	select obj
	macros.run "Modifier Stack" "Convert_to_Poly"
	deselect obj
)

function createStairs s_length s_width s_height step_max_length step_max_height = (
	
	-- Create Dummy
	
	dummy_obj = Dummy()
	dummy_obj.boxsize=[s_length, s_width, s_height]
	dummy_obj.pivot = dummy_obj.min
	dummy_obj.pos = [0,0,0]
	
	-- Create box
	
	/*step_max_length = 30
	step_max_height = 20*/
	
	num_steps = int(s_height / step_max_height)
	step_height = float(s_height) / float(num_steps)
	step_length = float(s_length) / float(num_steps)
	
	box_first_step = Box length:step_length width:s_width height:step_height
	rotate box_first_step (angleaxis 90 [0, 0, 1])
	box_first_step.pivot = box_first_step.min
	box_first_step.pos = [0,0,0]
	convertToEditPoly box_first_step
	polyop.deleteFaces box_first_step #{3}
		
	box_step = copy box_first_step
	move box_step [step_length*2, s_width, 0]
	rotate box_step (angleaxis 180 [0, 0, 1])
	polyop.setFaceSelection box_step #{2}
	box_step.extrudeFaces step_height
	polyop.deleteFaces box_step #{8}
	polyop.setEdgeSelection box_step #{2}
	box_step.chamferEdges 50
		
	steps = #(box_first_step, box_step)
		
	for i=3 to num_steps do(
		steps[i] = copy steps[i-1]
		move steps[i] [step_length, 0, step_height]
	)
	steps[num_steps].EditablePoly.SetSelection #Edge #{7, 15, 19, 20}
	steps[num_steps].EditablePoly.capHoles #Edge
	
	for i=1 to num_steps-1 do(
		polyop.attach steps[i+1] steps[i]
	)
	stair = steps[num_steps]
	weldThreshold = 0.1 
	polyop.weldVertsByThreshold stair #{1..176}
)

try(destroyDialog stair_creator)catch()

rollout stair_creator "Stair Creator" width:201 height:219
(
	label 'lbl1' "Stair Creator" pos:[68,15] width:63 height:18 align:#left
	label 'lbl2' "Length" pos:[12,52] width:67 height:16 align:#left
	label 'lbl3' "Width" pos:[12,72] width:67 height:16 align:#left
	label 'lbl4' "Height" pos:[12,92] width:67 height:16 align:#left
	spinner 'spn_length' "" pos:[122,51] width:70 height:16 range:[0,1000,400] align:#left
	spinner 'spn_width' "" pos:[122,71] width:70 height:16 range:[0,1000,200] align:#left
	spinner 'spn_height' "" pos:[122,91] width:70 height:16 range:[0,1000,300] align:#left
	button 'create' "Create" pos:[64,173] width:76 height:21 align:#left
	label 'lbl5' "Max step length" pos:[11,120] width:78 height:16 align:#left
	label 'lbl6' "Max step height" pos:[10,138] width:78 height:16 align:#left
	spinner 'spn_ms_length' "" pos:[122,118] width:70 height:16 range:[0,100,30] align:#left
	spinner 'spn_ms_height' "" pos:[122,138] width:70 height:16 range:[0,100,20] align:#left
	
	on create pressed do(
		
		if $ != undefined then
			delete $
		createStairs 	spn_length.value spn_width.value spn_height.value \
							spn_ms_length.value spn_ms_height.value
		
	)
	
)

createDialog stair_creator height:220 width:200 pos:[1024, 512]
