;;Sokoban pddl
(define (domain sokoban)
(:requirements :strips :typing :fluents)

;;define the types of element defined into the problem
(:types 
        location locatable  - object
        worker box  quantity - locatable
    )
    
;;The properties that are used to describe the state of those things
(:predicates
        ;;(adjacent ?from ?to - location ?dir - direction)
        (connected ?from ?to - location)
        (at ?o - locatable ?l - location)
        (clear ?loc - location)
        
        (pushAction ?wk - locatable)
        (pullAction ?wk - locatable)
        (in ?p - box ?wk - worker)
        (isfree ?wk - worker)
        
        
        ;;Stack material
        (isopen ?b - box)
        (can_stack ?b - box ?loc - location)
        (can_take ?b - box ?loc - location)
        
        
        (on ?b1 ?b2 - box)
        (orderingStackFinal ?b1 ?b2 - box ?final - location)
        (final_configuration ?bx - box ?loc - location)

        (box_start_position ?bx - box ?loc - location)
        (all_material_moved ?bx - box ?loc - location)
        


    )
    
(:functions
    (pushActionCost ?wk - worker )
    (pullActionCost ?wk - worker )
    (machine_velocity ?wk - worker )
    (machine_capacity ?wk - worker )
    (distance ?bx - box ?wk - worker )
    (material-amount ?bx - box)
    (material_amount2 ?bx - box ?loc - location)
    (material_at_location_fn ?box - box ?loc - location)
    (material_at_location_st ?box - box ?loc - location)
)


;;MACHINE ACTIONS
(:action all_material_moved_from_start_position
		:parameters (?bx - box ?loc - location)
		:precondition (and
		(at ?bx ?loc)
		(<= (material_amount2 ?bx ?loc) 0)
		)
		:effect (and 
                (not (at ?bx ?loc))
				(all_material_moved ?bx ?loc)
	)
	)


;;MACHINE ACTIONS
(:action all_material_moved_to_final_position
		:parameters (?bx - box ?loc - location)
		:precondition (and
		(at ?bx ?loc)

		(>= (material_at_location_st ?bx ?loc ) (material_at_location_fn ?bx ?loc))
		)
		:effect (and 
				(final_configuration ?bx ?loc)

				(box_start_position ?bx ?loc)
				(can_stack ?bx ?loc)
	)
	)
    
;;MACHINE ACTIONS
(:action move
		:parameters (?wk - worker ?from ?to - location)
		:precondition (and 	
		(connected ?from ?to)
		(at ?wk ?from)
		(clear ?to)
		(isfree ?wk)
		
		)

		:effect (and 
				(not (at ?wk ?from)) 
				(at ?wk ?to) 
				;;(not (clear ?to))
				;;(clear ?from)
	)
	)


(:action move_with_material
		:parameters (?wk - worker ?from ?to - location ?bx - box)
		:precondition (and 	
		(connected ?from ?to)
		(at ?wk ?from)
		(in ?bx ?wk)
		(clear ?to)
		)

		:effect (and 
				(not (at ?wk ?from)) 
				(at ?wk ?to) 
				;;(not (clear ?to))
				;;(clear ?from)
	)
	)


	
(:action move_to_take_material
		:parameters (?wk - worker ?from ?to - location ?bx - box)
		:precondition (and 	
		(connected ?from ?to)
		(at ?wk ?from)
		(at ?bx ?to)
		(isfree ?wk)
        (box_start_position ?bx ?to)
		)

		:effect (and 
				(not (at ?wk ?from)) 
				(at ?wk ?to) 
				;;(not (clear ?to))
				;;(clear ?from)
	)
	)	


(:action move_to_stack_material
		:parameters (?wk - worker ?from ?to - location ?bx - box)
		:precondition (and 	
		(connected ?from ?to)
		(at ?wk ?from)
		(at ?bx ?to)
		(in ?bx ?wk)

		)

		:effect (and 
				(not (at ?wk ?from)) 
				(at ?wk ?to) 
				;;(not (clear ?to))
				;;(clear ?from)
	)
	)	
		
	
	
(:action start_push_material
		:parameters (?wk - worker ?bx - box ?loc - location)
		:precondition (and 	
        (at ?wk ?loc)
	    (at ?bx ?loc)
	    (pushAction ?wk)
	    (isfree ?wk)
	    ;;(isopen ?bx)
	    (box_start_position ?bx ?loc)
		)
		:effect (and 
				;;(not (at ?bx ?loc))
				;;(clear ?loc)
				(not (isfree ?wk))
				(in ?bx ?wk)
				(decrease (material_amount2  ?bx ?loc) (machine_capacity ?wk))
	)
	)
	
(:action stop_push_material
		:parameters (?wk - worker ?bx - box ?loc - location)
        :precondition (and
            (at ?wk ?loc)
	        (in ?bx ?wk)
            (pushAction ?wk)
            (clear ?loc)
        )
        :effect (and
            (at ?bx ?loc)
            (not (clear ?loc))
            (not (in ?bx ?wk))
            (isfree ?wk)
            ;;(isopen ?bx)
            (increase (material_at_location_st ?bx  ?loc ) (machine_capacity ?wk))

           
        )
    )	
	
   
  (:action stack_same_material
        :parameters (?wk - worker ?bx - box ?loc - location)
        :precondition (and
            (at ?wk ?loc)
	        (in ?bx ?wk)
       
            (at ?bx ?loc)
        )
        :effect (and
            ;;(at ?bx ?loc)
            (not (in ?bx ?wk))
            (isfree ?wk)
            ;;(isopen ?bx)
            (increase (material_at_location_st ?bx  ?loc ) (machine_capacity ?wk))

            
        )
    )   
		
	
	
	
	
(:action load_material
        :parameters (?wk - worker ?bx - box ?loc - location)
        :precondition (and
            (at ?wk ?loc)
	        (at ?bx ?loc)
            (pullAction ?wk)
            (isfree ?wk)
            ;;(isopen ?bx)
            (box_start_position ?bx ?loc)
        )
        :effect (and
            ;;(not (at ?bx ?loc))
            ;;(clear ?loc)
            (in ?bx ?wk)
            (not (isfree ?wk))
            (decrease (material_amount2  ?bx ?loc) (machine_capacity ?wk))
        )
    )
    
    
    
    	
	
  
 (:action unload_material
        :parameters (?wk - worker ?bx - box ?loc - location)
        :precondition (and
            (at ?wk ?loc)
	        (in ?bx ?wk)
            (pullAction ?wk)
            (clear ?loc)
        )
        :effect (and
            (at ?bx ?loc)
            (not (clear ?loc))
            (not (in ?bx ?wk))
            (isfree ?wk)
            ;;(isopen ?bx)
            (increase (material_at_location_st ?bx  ?loc ) (machine_capacity ?wk))
           
        )
    )	
    
    
 (:action stack_material
        :parameters (?wk - worker ?bx ?underox - box ?loc - location)
        :precondition (and
            (at ?wk ?loc)
	        (in ?bx ?wk)
            (isopen ?underox)
            (at ?underox ?loc)
            (can_stack ?underox ?loc)
            ;;(finalTarget ?bx)
            
            
            
        )
        :effect (and
            (on ?bx ?underox)
            (at ?bx ?loc)
            (not (in ?bx ?wk))
            (isfree ?wk)
            (not (isopen ?underox))
            (orderingStackFinal ?bx ?underox ?loc)
            
        )
    )
    
    

    (:action unstack_material
        :parameters (?wk - worker ?bx ?underox - box ?loc - location)
        :precondition (and
            (at ?wk ?loc)
	        (isfree ?wk)
	        (at ?bx ?loc)
            ;;(isopen ?bx)
            (on ?bx ?underox)
            
        )
        :effect (and
            (not(on ?bx ?underox))
            ;;(not (at ?bx ?to))
            (at ?underox ?loc)
            ;;(in ?bx ?wk)
            ;;(not (isfree ?wk))
            (isopen ?underox)
            (box_start_position ?bx ?loc)
            
        )
    )
	
)	
