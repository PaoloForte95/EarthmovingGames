(define (problem s1)
	(:domain sokoban)
	(:objects 
	wk1 - worker 
	bx1 bx2 - box 
    l1_1 l1_2 l1_3 l1_4 l2_1 l2_2 l2_3 l2_4 l3_1 l3_2 l3_3 l3_4 l4_1 l4_2 l4_3 l4_4 - location
	)
	
	
	(:init 
	
	(at wk1 l1_1) 
    (at bx1 l2_3)
    (at bx2 l4_3)
    
    


    ;; make sure these are constants or objects:
    ;; l1_1 l1_2 l1_3 l1_4 l l2_1 l2_2 l2_3 l2_4 l3_1 l3_2 l3_3 l3_4 l4_1 l4_2 l4_3 l4_4
    (hor_adj l1_1 l1_2)
    (hor_adj l1_2 l1_1)
    (hor_adj l1_2 l1_3)
    (hor_adj l1_3 l1_2)
    (hor_adj l1_3 l1_4)
    (hor_adj l1_4 l1_3)
    (hor_adj l2_1 l2_2)
    (hor_adj l2_2 l2_1)
    (hor_adj l2_2 l2_3)
    (hor_adj l2_3 l2_2)
    (hor_adj l2_3 l2_4)
    (hor_adj l2_4 l2_3)
    (hor_adj l3_1 l3_2)
    (hor_adj l3_2 l3_1)
    (hor_adj l3_2 l3_3)
    (hor_adj l3_3 l3_2)
    (hor_adj l3_3 l3_4)
    (hor_adj l3_4 l3_3)
    (hor_adj l4_1 l4_2)
    (hor_adj l4_2 l4_1)
    (hor_adj l4_2 l4_3)
    (hor_adj l4_3 l4_2)
    (hor_adj l4_3 l4_4)
    (hor_adj l4_4 l4_3)
    
    
    
    ;; make sure these are constants or objects:
    ;; l1_1 l2_1 l3_1 l4_1 l l1_2 l2_2 l3_2 l4_2 l1_3 l2_3 l3_3 l4_3 l1_4 l2_4 l3_4 l4_4
    (vert_adj l1_1 l2_1)
    (vert_adj l2_1 l1_1)
    (vert_adj l2_1 l3_1)
    (vert_adj l3_1 l2_1)
    (vert_adj l3_1 l4_1)
    (vert_adj l4_1 l3_1)
    (vert_adj l1_2 l2_2)
    (vert_adj l2_2 l1_2)
    (vert_adj l2_2 l3_2)
    (vert_adj l3_2 l2_2)
    (vert_adj l3_2 l4_2)
    (vert_adj l4_2 l3_2)
    (vert_adj l1_3 l2_3)
    (vert_adj l2_3 l1_3)
    (vert_adj l2_3 l3_3)
    (vert_adj l3_3 l2_3)
    (vert_adj l3_3 l4_3)
    (vert_adj l4_3 l3_3)
    (vert_adj l1_4 l2_4)
    (vert_adj l2_4 l1_4)
    (vert_adj l2_4 l3_4)
    (vert_adj l3_4 l2_4)
    (vert_adj l3_4 l4_4)
    (vert_adj l4_4 l3_4)
    
    
    
    
     ;;clear spaces
     (clear l1_2) 
     (clear l1_3)
     (clear l1_4) 
       
     (clear l2_1) 
     (clear l2_2)
     (clear l2_4) 
       
       
     (clear l3_1) 
     (clear l3_2)
     (clear l3_3)
      (clear l3_4)
       
      (clear l4_1) 
      (clear l4_2)
      (clear l4_4)
     )

	(:goal (and 
	
	(at bx1 l4_4)
	(at bx2 l4_1)
	))
)
