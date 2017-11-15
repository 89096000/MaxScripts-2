-- MS 	REFERENCE

-- Convert to editable poly
convertTo mesh_obj Editable_Poly

-- Verts
	-- Vertex set selection
	subobjectlevel = 1
	polyop.setvertselection obj_Poly #{1}

	-- Vertex get selection
	polyop.getvertselection  obj_Poly

	-- Get num verts
	polyop.getnumverts obj_Poly

	-- Get vertex cooordinate
	polyop.getvert obj_Poly 1

	-- Set vertex cooordinate
	polyop.setvert obj_Poly 1 [0,0,0]

-- Edges
	-- Edge set selection
	subobjectlevel = 2
	polyop.setedgeselection obj_Poly #{1}

	-- Edge get selection
	polyop.getedgeselection obj_Poly

	-- Get num edges
	polyop.getnumedges obj_Poly

-- Faces
	-- Face set selection
	subobjectlevel = 4
	polyop.setfaceselection  obj_Poly #{1}
	
	-- Face get selection
	polyop.getfaceselection  obj_Poly

	-- Get num faces
	polyop.getnumfaces obj_Poly

	-- Get face center
	polyop.getfacecenter obj_Poly 1

	-- Get face normal
	polyop.getfacenormal obj_Poly 1

	-- Get face area
	polyop.getfacearea obj_Poly 1


-- Get B using A
polyop.getEdgesUsingVert obj_Poly <vertlist>
polyop.getVertsUsingEdge obj_Poly <edgelist>
polyop.getFacesUsingVert obj_Poly <vertlist>
polyop.getFacesUsingEdge obj_Poly <edgelist>
polyop.getVertsUsingFace obj_Poly <facelist>
polyop.getEdgesUsingFace obj_Poly <facelist>
polyop.getElementsUsingFace obj_Poly <facelist> fence:<fence_facelist>


-- Editable Poly operations
	-- Attach
	polyop.attach obj_Poly obj_Poly_2

	-- Delete vertices
	polyop.deleteverts obj_Poly #{1..4}

	-- Delete faces
	polyop.deletefaces obj_Poly #{1..4}

	-- Delete edges
	polyop.deleteedges obj_Poly #{1..4}

	-- Weld
	obj_Poly.weldThreshold = 100 
	polyop.weldVertsByThreshold obj_Poly #{1,2,3}

	--Extrude
	polyop.extrudeFaces <Poly poly> <facelist> <float amount>




	https://help.autodesk.com/view/3DSMAX/2018/ENU/?guid=__files_GUID_B40F84EA_5F19_45B6_AA7C_0ADC77708BBE_htm#WS3ED54CBA79FF2E3D-417FC02312B7835BF26-6E6C







