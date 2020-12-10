;;Sokoban pddl
(define (domain sokoban)
(:requirements :strips :typing)

;;define the types of element defined into the problem
(:types 
        location locatable - object
        worker box  - locatable
    )
    
;;The properties that are used to describe the state of those things
(:predicates
        ;;(adjacent ?from ?to - location ?dir - direction)
        (hor_adj ?from ?to - location)
        (vert_adj ?from ?to - location)
        (at ?o - locatable ?l - location)
        (clear ?loc - location)
        (pushAction ?wk - locatable)
        (pullAction ?wk - locatable)
        (in ?p - box ?wk - worker)

    )
    
;;WORKER ACTIONS
(:action move_horizontal
		:parameters (?wk -worker ?from ?to - location)
		:precondition (and 	
		
		(hor_adj ?from ?to)
		(at ?wk ?from)
		(clear ?to)
		)

		:effect (and 
				(not (at ?wk ?from)) 
				(not (clear ?to))
				(at ?wk ?to) 
				(clear ?from)
	)
	)
	
(:action move_vertical
		:parameters (?wk -worker ?from ?to - location)
		:precondition (and 	
		
		(vert_adj ?from ?to)
		(at ?wk ?from)
		(clear ?to)
		)

		:effect (and 
				(not (at ?wk ?from)) 
				(not (clear ?to))
				(at ?wk ?to) 
				(clear ?from)
	)
	)
	
	
(:action push_horizontal
		:parameters (?wk -worker ?bx - box ?from ?to - location ?final -location)
		:precondition (and 	
		(hor_adj ?from ?to )
		(hor_adj ?to ?final)
        (at ?wk ?from)
	    (at ?bx ?to)
	    (clear ?final)
	    (pushAction ?wk)
		)

		:effect (and 
				(not (at ?wk ?from)) 
				(not (clear ?final))
				(not (clear ?to))
				(not (at ?bx ?to))
				(at ?wk ?to) (at ?bx ?final) 
				(clear ?from)
				
	)
	)
	
(:action push_vertical
		:parameters (?wk -worker ?bx - box ?from ?to - location ?final -location)
		:precondition (and 	
		(vert_adj ?from ?to )
		(vert_adj ?to ?final)
        (at ?wk ?from)
	    (at ?bx ?to)
	    (clear ?final)
	    (pushAction ?wk)
		)

		:effect (and 
				(not (at ?wk ?from)) 
				(not (clear ?final))
				(not (clear ?to))
				(not (at ?bx ?to))
				(at ?wk ?to) (at ?bx ?final) 
				(clear ?from)
				
	)
	)
	
	;; --MATERIAL ACTION--
	(:action pull_material_horizontal
        :parameters (?wk -worker ?bx - box ?from ?to - location)
        :precondition (and
            (hor_adj ?from ?to)
            (at ?wk ?from)
	        (at ?bx ?to)
            (pullAction ?wk)
        )
        :effect (and
            (not (at ?bx ?to))
            (clear ?to)
            (in ?bx ?wk)
        )
    )
    
    (:action pull_material_vertical
        :parameters (?wk -worker ?bx - box ?from ?to - location)
        :precondition (and
            (vert_adj ?from ?to)
            (at ?wk ?from)
	        (at ?bx ?to)
            (pullAction ?wk)
        )
        :effect (and
            (not (at ?bx ?to))
            (clear ?to)
            (in ?bx ?wk)
        )
    )
    
    
    (:action unload_material_horizontal
        :parameters (?wk -worker ?bx - box ?from ?to - location)
        :precondition (and
            (hor_adj ?from ?to)
            (at ?wk ?from)
	        (in ?bx ?wk)
            (pullAction ?wk)
        )
        :effect (and
            (at ?bx ?to)
            (not (clear ?to))
            (not (in ?bx ?wk))
        )
    )
    
    (:action unload_material_vertical
        :parameters (?wk -worker ?bx - box ?from ?to - location)
        :precondition (and
            (vert_adj ?from ?to)
            (at ?wk ?from)
	        (in ?bx ?wk)
            (pullAction ?wk)
        )
        :effect (and
            (at ?bx ?to)
            (not (clear ?to))
            (not (in ?bx ?wk))
        )
    )
    
	
	
	
	
)
