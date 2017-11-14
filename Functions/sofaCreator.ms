function createSofa largo_respaldo:largo_respaldo grosor_respaldo:grosor_respaldo ancho_brazo:ancho_brazo \
					alto_brazo:alto_brazo ancho_asiento:ancho_asiento alto_asiento:alto_asiento \
					alto_respaldo:alto_respaldo largo_brazo:largo_brazo largo_asiento:largo_asiento = (

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

	if largo_respaldo < (ancho_brazo*2) then(
	
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
		polyop.extrudeFaces seat #{21, 24, 27} alto_asiento

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

delete $*
createSofa 	largo_respaldo:40 grosor_respaldo:5 ancho_brazo:3 \
			alto_brazo:7 ancho_asiento:50 alto_asiento:7 \
			alto_respaldo:15 largo_brazo:25 largo_asiento:30