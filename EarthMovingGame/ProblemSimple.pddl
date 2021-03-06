(define (problem s1)
	(:domain sokoban)
	(:objects 
	wk1 wk2 - worker 
	bx1 bx2 bx3 - box 
    wp1 wp2 wp3 wp8 wp11 wp10 wp9 wp4 wp5 wp6 wp7 - location
	)
	(:init 
	
    ;; make sure these are constants or objects:
    ;; wp1 wp2 wp3 wp8 wp11 wp10 wp9 wp4 wp5 wp6 wp7
    (connected wp1 wp2)
    (connected wp2 wp1)
    (connected wp2 wp3)
    (connected wp3 wp2)
    (connected wp3 wp8)
    (connected wp8 wp3)
    (connected wp8 wp11)
    (connected wp11 wp8)
    (connected wp11 wp10)
    (connected wp10 wp11)
    (connected wp10 wp9)
    (connected wp9 wp10)
    (connected wp9 wp4)
    (connected wp4 wp9)
    (connected wp4 wp1)
    (connected wp1 wp4)
    (connected wp1 wp5)
    (connected wp5 wp1)
    (connected wp5 wp6)
    (connected wp6 wp5)
    (connected wp6 wp7)
    (connected wp7 wp6)
    (connected wp7 wp11)
    (connected wp11 wp7)
    (connected wp2 wp6)
    (connected wp6 wp2)
    (connected wp6 wp10)
    (connected wp10 wp6)
    
    
    (pushAction wk1)
    (pullAction wk2)
     
     
    (isfree wk1)
    (isfree wk2)
    
    
    (at wk1 wp1) 
	(at wk2 wp1)
	
    (at bx1 wp9)
    (at bx2 wp6)
    (at bx3 wp3)
    
    
    (isopen bx1)
    (isopen bx2)
    (isopen bx3)
    ;;(on bx3 bx1)
    
(= (machine_capacity wk1) 10)
   (= (machine_capacity wk2) 20)
   
   (= (machine_velocity wk1) 20)
   (= (machine_velocity wk2) 10)
   
   (= (pushActionCost wk1) 5)
   (= (pullActionCost wk2) 10)

   
   (= (material_at_location_fn bx1 wp10) 30)
   (= (material_at_location_st bx1 wp10) 0)
   
   (= (material_at_location_fn bx1 wp4) 20)
   (= (material_at_location_st bx1 wp4) 0)
   
   
   (box_start_position bx1 wp9)
   (box_start_position bx2 wp6)
   (box_start_position bx3 wp3)
   
   (= (material_amount2 bx1 wp9) 50)
   (= (material_amount2 bx2 wp6) 50)
   (= (material_amount2 bx3 wp3) 50)
     
    
     ;;clear spaces
     (clear wp1) 
     (clear wp2)
     ;;(clear wp3) 
     (clear wp4) 
     (clear wp5)
     ;;(clear wp6) 
     (clear wp7) 
     (clear wp8)
     ;;(clear wp9) 
     (clear wp10) 
     (clear wp11)

     )

	(:goal (and 
	
	;;(at bx1 wp10)
	(final_configuration bx1 wp10)

	(final_configuration bx1 wp4)
    ;;(all_material_moved bx1 wp9)

	;;(= (material-amount bx1 wp10) 50)
    ;;(orderingStackFinal bx2 bx1 wp10)
	(at bx3 wp11)
	))
)