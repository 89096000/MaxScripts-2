function convertToEditPoly obj = (
	select obj
	macros.run "Modifier Stack" "Convert_to_Poly"
	deselect obj
)

function createStairs s_length s_width s_height = (
	
	-- Create Dummy
	
	dummy_obj = Dummy()
	dummy_obj.boxsize=[s_length, s_width, s_height]
	dummy_obj.pivot = dummy_obj.min
	dummy_obj.pos = [0,0,0]
	
	-- Create box
	
	step_max_length = 30
	step_max_height = 20
	
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

createStairs 400 200 300
