function createSofa largo_respaldo grosor_respaldo ancho_brazo \
					alto_brazo ancho_asiento alto_asiento \
					alto_respaldo largo_brazo largo_asiento = (

	dummy_obj = Dummy()
	dummy_obj.boxsize=[largo_asiento, ancho_asiento, alto_asiento + alto_respaldo]
	dummy_obj.pivot = dummy_obj.min
	dummy_obj.pos = [0,0,0]

	seat = Box widthsegs:3 lengthsegs:5 length:ancho_asiento width:largo_asiento height:alto_asiento
	seat.pivot = seat.min
	seat.pos = [0,0,0]
	seat.parent = dummy_obj

	convertTo seat Editable_Poly
	
	loop1 = #{2, 5, 8, 41, 45, 48, 81, 92}
	loop2 = #{12, 14, 16, 50, 53, 55, 82, 91}
	loop3 = #{26, 28, 30, 64, 67, 69, 84, 89}
	loop4 = #{19, 21, 23, 57, 60, 62, 83, 90}
	loopB = #{6, 15, 22, 29, 36, 44, 52, 59, 66, 73, 79, 86}

	if largo_respaldo > (ancho_asiento-ancho_brazo*2) then(
	
		select seat
		subobjectlevel = 2
		polyop.setedgeselection seat loop1
		move seat.selectedEdges [0, -ancho_asiento/5 + (ancho_asiento - largo_respaldo)/2,0]
		polyop.setedgeselection seat loop2
		move seat.selectedEdges [0, -2*ancho_asiento/5 + ancho_brazo,0]

		polyop.setedgeselection seat loop3
		move seat.selectedEdges [0, ancho_asiento/5 - (ancho_asiento - largo_respaldo)/2,0]
		polyop.setedgeselection seat loop4
		move seat.selectedEdges [0, 2*ancho_asiento/5 - ancho_brazo,0]

		polyop.setedgeselection seat loopB
		move seat.selectedEdges [largo_asiento/3 - grosor_respaldo, 0, 0]

		subobjectlevel = 4
		polyop.extrudeFaces seat #{16..17, 19..20, 25..26, 28..29} alto_brazo
		polyop.extrudeFaces seat #{21, 24, 27} alto_respaldo
		
		subobjectlevel = 2;
		polyop.setedgeselection seat #{133..140}
		seat.EditablePoly.ConnectEdges ()
		move seat.selectedEdges[0, 0, -alto_respaldo/2 + alto_brazo]
		
		polyop.deletefaces seat #{50, 57, 68, 70}
		
		seat.weldThreshold = 0.1 
		polyop.weldVertsByThreshold seat #{52..53, 59..60, 73, 78..80}
		
	) else (

		select seat
		subobjectlevel = 2

		polyop.setedgeselection seat loop1
		move seat.selectedEdges [0, -ancho_asiento/5 + ancho_brazo,0]
		polyop.setedgeselection seat loop2
		move seat.selectedEdges [0, -2*ancho_asiento/5 + (ancho_asiento - largo_respaldo)/2,0]

		polyop.setedgeselection seat loop3
		move seat.selectedEdges [0, ancho_asiento/5 - ancho_brazo,0]
		polyop.setedgeselection seat loop4
		move seat.selectedEdges [0, 2*ancho_asiento/5 - (ancho_asiento - largo_respaldo)/2,0]

		polyop.setedgeselection seat loopB
		move seat.selectedEdges [largo_asiento/3 - grosor_respaldo, 0, 0]

		subobjectlevel = 4
		polyop.extrudeFaces seat #{16..17, 28..29} alto_brazo
		polyop.extrudeFaces seat #{24} alto_respaldo

	)
	
)

try(destroyDialog sofa_creator)catch()

rollout sofa_creator "Creador de Sofás" width:169 height:246
(
	
	label 'lbl10' "Creador de sofas" pos:[41,8] width:89 height:26 align:#left
	
	label 'lbl1' "Largo respaldo" pos:[14,34] width:122 height:19 align:#left
	label 'lbl2' "Grosor respaldo" pos:[15,188] width:122 height:19 align:#left
	label 'lbl3' "Ancho posabrazos" pos:[14,50] width:122 height:19 align:#left
	label 'lbl4' "Alto posabrazos" pos:[15,110] width:122 height:19 align:#left
	label 'lbl5' "Largo asiento" pos:[15,155] width:122 height:19 align:#left
	label 'lbl6' "Ancho asiento" pos:[15,67] width:122 height:19 align:#left
	label 'lbl7' "Alto respaldo" pos:[15,127] width:122 height:19 align:#left
	label 'lbl8' "Largo posabrazos" pos:[15,171] width:122 height:19 align:#left
	label 'lbl9' "Alto asiento" pos:[15,94] width:122 height:19 align:#left
	
	spinner 'largo_respaldo' "" pos:[112,35] width:60 height:16 range:[0,500,160] align:#left
	spinner 'ancho_brazo' "" pos:[112,52] width:60 height:16 range:[0,500,20] align:#left
	spinner 'ancho_asiento' "" pos:[112,68] width:60 height:16 range:[0,500,200] align:#left
	
	spinner 'alto_asiento' "" pos:[112,95] width:60 height:16 range:[0,500,30] align:#left
	spinner 'alto_brazo' "" pos:[112,111] width:60 height:16 range:[0,500,20] align:#left
	spinner 'alto_respaldo' "" pos:[112,127] width:60 height:16 range:[0,500,40] align:#left
	
	spinner 'largo_asiento' "" pos:[111,155] width:60 height:16 range:[0,500,100] align:#left
	spinner 'largo_brazo' "" pos:[111,172] width:60 height:16 range:[0,500,60] align:#left
	spinner 'grosor_respaldo' "" pos:[111,189] width:60 height:16 range:[0,500,20] align:#left
	
	
	button 'create' "Create" pos:[35,217] width:90 height:18 align:#left
	
	on create pressed  do (
		delete $*
		createSofa largo_respaldo.value grosor_respaldo.value ancho_brazo.value \
							alto_brazo.value ancho_asiento.value alto_asiento.value \
							alto_respaldo.value largo_brazo.value largo_asiento.value
	)
		
)

createDialog sofa_creator height:245 width:175 pos:[1024, 512]