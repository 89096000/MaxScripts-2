-- Crear una habitacion con pared de un grosor determinado

function convertToEditPoly obj = (
	select obj
	macros.run "Modifier Stack" "Convert_to_Poly"
	deselect obj
)

function moveVertex obj vertexList amount = (
	select obj
	subobjectLevel = 1
	obj.EditablePoly.SetSelection #Vertex(vertexList as Bitarray)
	move obj.selectedVerts amount
	subobjectLevel = 0
	deselect obj
)

function createRoom roomLength roomWidth roomHeight = (
	
	wallThick = 10
	
	-- Create Dummy
	
	dummy_obj = Dummy()
	dummy_obj.boxsize=[roomLength, roomWidth, roomHeight]
	dummy_obj.pivot = dummy_obj.min
	dummy_obj.pos = [0,0,0]
	
	-- Create Length walls
	
	wall1 = Box lengthsegs:1 widthsegs:1 heightsegs:1 length:wallThick width:roomLength height:roomHeight mapcoords:on pos:[0,0,0] isSelected:on
	wall1.pivot = wall1.min
	wall1.pos = [0,0,0]
	wall1.parent = dummy_obj
	
	convertToEditPoly wall1
	moveVertex wall1 #{3, 7} [wallThick, 0, 0]
	moveVertex wall1 #{4, 8} [-wallThick, 0, 0]
	
	wall2 = copy wall1
	
	move wall2 [roomLength, roomWidth, 0]
	rotate wall2 (angleaxis 180[0, 0, 1])
	
	-- Create Width walls
	
	wall3 = Box lengthsegs:1 widthsegs:1 heightsegs:1 length:roomWidth width:wallThick height:roomHeight mapcoords:on pos:[0,0,0] isSelected:on
	wall3.pivot = wall3.min
	wall3.pos = [0,0,0]
	wall3.parent = dummy_obj
	
	convertToEditPoly wall3
	moveVertex wall3 #{2, 6} [0, wallThick, 0]
	moveVertex wall3 #{4, 8} [0, -wallThick, 0]
	
	wall4 = copy wall3
	
	move wall4 [roomLength, roomWidth, 0]
	rotate wall4 (angleaxis 180[0, 0, 1])
	
)

createRoom 800 600 200




































