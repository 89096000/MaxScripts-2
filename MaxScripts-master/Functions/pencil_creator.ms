function create_mesh mesh_width:mesh_width mesh_height:mesh_height mesh_top_height:mesh_top_height sides:sides vertical_divisions:vertical_divisions horizontal_divisions:horizontal_divisions = (
	radius = mesh_width / 2
	mesh_obj = Cylinder radius:radius height:mesh_height sides:sides
	convertTo mesh_obj Editable_Poly
	
	num_edges = polyop.getNumEdges mesh_obj
	edges_aux = polyop.getEdgesUsingVert mesh_obj #{1..sides}
	
	edges_medium = edges_aux - #{1..sides}
	edges_base = #{1..sides}
	edges_top = (#{1..num_edges} - edges_base) - edges_medium
	
	select mesh_obj
	subObjectLevel = 2
	polyop.setEdgeSelection mesh_obj edges_top
	
	num_faces = polyop.getNumFaces mesh_obj 
	polyop.deleteFaces mesh_obj #{1, num_faces}
	
	polyop.setEdgeSelection mesh_obj (edges_top + edges_base)
	
	mesh_obj.connectEdgeSegments = vertical_divisions
	mesh_obj.EditablePoly.ConnectEdges ()
	
	edges_medium2 = polyop.getedgeselection mesh_obj
	edges_medium = edges_medium + edges_medium2
	polyop.setEdgeSelection mesh_obj edges_medium
	
	mesh_obj.connectEdgeSegments = horizontal_divisions
	mesh_obj.EditablePoly.ConnectEdges ()
	
	mesh_obj.EditablePoly.setSelection #Edge((polyop.getOpenEdges mesh_obj))
	
	subobjectLevel = 3
	mesh_obj.EditablePoly.capHoles #Edge
	face = polyop.getNumFaces mesh_obj
	
	mesh_obj.edgeChamfer = 1
	mesh_obj.EditablePoly.buttonOp #Chamfer
	
	subobjectLevel = 4
	polyop.setFaceSelection mesh_obj face
	
	mesh_obj.insetAmount = 0;
	mesh_obj.EditablePoly.buttonOp #inset
	
	mesh_obj.EditablePoly.collapse #face
	
	last_vertex = polyop.getNumVerts mesh_obj
	polyop.setVertSelection mesh_obj last_vertex
	move mesh_obj.selectedVerts[0,0,mesh_top_height]
	
	subobjectLevel = 0
	deselect mesh_obj
	
)

delete $*
create_mesh mesh_width:5 mesh_height:20 mesh_top_height:5 sides:5 vertical_divisions:5 horizontal_divisions:5