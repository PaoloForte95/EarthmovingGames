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
    (distance ?from - location ?to - location)
    (material-amount ?bx - box)
    (material_amount2 ?bx - box ?loc - location)
    (material_at_location_fn ?box - box ?loc - location)
    (material_at_location_st ?box - box ?loc - location)
)


;;MACHINE ACTIONS


(:durative-action all_material_moved_from_start_position
      :parameters (?bx - box ?loc - location)
      :duration (= ?duration 1)
      :condition (and
        (at start  (at ?bx ?loc) )
        (at start  (<= (material_amount2 ?bx ?loc) 0))
      )
      :effect (and
        (at end (not (at ?bx ?loc)))
        (at end(all_material_moved ?bx ?loc))
      )
    )


(:durative-action all_material_moved_to_final_position
      :parameters (?bx - box ?loc - location)
      :duration (= ?duration 1)
      :condition (and
        (at start  (at ?bx ?loc) )
        (at start  (>= (material_at_location_st ?bx ?loc ) (material_at_location_fn ?bx ?loc)))
      )
      :effect (and
        (at end (final_configuration ?bx ?loc))
        (at end (box_start_position ?bx ?loc))
        (at end (can_stack ?bx ?loc))
      )
    )
    
 
(:durative-action move
      :parameters (?wk - worker ?from ?to - location)
      :duration (= ?duration (/ (distance ?from ?to) (machine_velocity ?wk)))
      :condition (and
        (at start  (at ?wk ?from) )
        (at start  (clear ?to) )
        (at start  (isfree ?wk) )
        (over all (connected ?from ?to))
      )
      :effect (and
        (at start(not (at ?wk ?from)))
        (at end (at ?wk ?to))
      )
    )
    
    
(:durative-action move_with_material
      :parameters (?wk - worker ?from ?to - location ?bx - box)
      :duration (= ?duration (/ (distance ?from ?to) (machine_velocity ?wk)))
      :condition (and
        (at start  (at ?wk ?from) )
        (at start  (clear ?to) )
        (at start  (in ?bx ?wk))
        (over all (connected ?from ?to))
      )
      :effect (and
        (at start(not (at ?wk ?from)))
        (at end (at ?wk ?to))
      )
    )

(:durative-action move_to_take_material
      :parameters (?wk - worker ?from ?to - location ?bx - box)
      :duration (= ?duration (/ (distance ?from ?to) (machine_velocity ?wk)))
      :condition (and
        (at start  (at ?wk ?from) )
        (at start  (at ?bx ?to))
        (at start  (isfree ?wk))
        (at start  (box_start_position ?bx ?to))
        (over all (connected ?from ?to))
      )
      :effect (and
        (at start(not (at ?wk ?from)))
        (at end (at ?wk ?to))
      )
)



(:durative-action move_to_stack_material
      :parameters (?wk - worker ?from ?to - location ?bx - box)
      :duration (= ?duration (/ (distance ?from ?to) (machine_velocity ?wk)))
      :condition (and
        (at start  (at ?wk ?from) )
        (at start  (at ?bx ?to))
        (at start  (in ?bx ?wk))
        (over all (connected ?from ?to))
      )
      :effect (and
        (at start(not (at ?wk ?from)))
        (at end (at ?wk ?to))
      )
)



(:durative-action start_push_material
      :parameters (?wk - worker ?bx - box ?loc - location)
      :duration (= ?duration (pushActionCost ?wk))
      :condition (and
        (at start  (at ?wk ?loc) )
        (at start  (at ?bx ?loc))
        (at start  (pushAction ?wk))
        (at start  (isfree ?wk))
        (at start  (box_start_position ?bx ?loc))
      )
      :effect (and
        (at start (not (isfree ?wk)))
        (at end (in ?bx ?wk))
        (at end (decrease (material_amount2  ?bx ?loc) (machine_capacity ?wk)))
      )
)
	


(:durative-action stop_push_material
      :parameters (?wk - worker ?bx - box ?loc - location)
      :duration (= ?duration (pushActionCost ?wk))
      :condition (and
        (at start  (at ?wk ?loc) )
        (at start  (in ?bx ?wk))
        (at start  (pushAction ?wk))
        (at start  (clear ?loc))
      )
      :effect (and
        (at end (at ?bx ?loc))
        (at end (not (clear ?loc)))
        (at end (not (in ?bx ?wk)))
        (at end (isfree ?wk))
        (at end (increase (material_at_location_st ?bx  ?loc ) (machine_capacity ?wk)))
      )
)	


(:durative-action stack_same_material
      :parameters (?wk - worker ?bx - box ?loc - location)
      :duration (= ?duration 1)
      :condition (and
        (at start  (at ?wk ?loc))
        (at start  (in ?bx ?wk))
        (at start  (at ?bx ?loc))

      )
      :effect (and
        (at end (not (in ?bx ?wk)))
        (at end (isfree ?wk))
        (at end (increase (material_at_location_st ?bx  ?loc ) (machine_capacity ?wk)))
      )
)


(:durative-action load_material
      :parameters (?wk - worker ?bx - box ?loc - location)
      :duration (= ?duration (pullActionCost ?wk))
      :condition (and
        (at start  (at ?wk ?loc))
        (at start  (at ?bx ?loc))
        (at start  (pullAction ?wk))
        (at start  (isfree ?wk))
        (at start  (box_start_position ?bx ?loc))

      )
      :effect (and
        (at end (in ?bx ?wk))
        (at start (not (isfree ?wk)))
        (at end (decrease (material_amount2  ?bx ?loc) (machine_capacity ?wk)))
      )
)


(:durative-action unload_material
      :parameters (?wk - worker ?bx - box ?loc - location)
      :duration (= ?duration (pullActionCost ?wk))
      :condition (and
        (at start  (at ?wk ?loc))
        (at start  (in ?bx ?wk))
        (at start  (pullAction ?wk))
        (at start  (clear ?loc))
      )
      :effect (and
        (at end (at ?bx ?loc))
        (at end (not (clear ?loc)))
        (at end (not (in ?bx ?wk)))
        (at end (isfree ?wk))
        (at end (increase (material_at_location_st ?bx  ?loc ) (machine_capacity ?wk)))
      )
)

(:durative-action stack_material
      :parameters (?wk - worker ?bx ?underox - box ?loc - location)
      :duration (= ?duration 1)
      :condition (and
        (at start  (at ?wk ?loc))
        (at start  (in ?bx ?wk))
        (at start  (isopen ?underox))
        (at start  (at ?underox ?loc))
        (at start  (can_stack ?underox ?loc))
      )
      :effect (and
        (at end (on ?bx ?underox))
        (at end (at ?bx ?loc))
        (at end (not (in ?bx ?wk)))
        (at end (isfree ?wk))
        (at end (not (isopen ?underox)))
        (at end (orderingStackFinal ?bx ?underox ?loc))
      )
)


(:durative-action unstack_material
      :parameters (?wk - worker ?bx ?underox - box ?loc - location)
      :duration (= ?duration 1)
      :condition (and
        (at start  (at ?wk ?loc))
        (at start  (isfree ?wk))
        (at start  (at ?bx ?loc))
        (at start  (on ?bx ?underox))
      )
      :effect (and
        (at end (not(on ?bx ?underox)))
        (at end (at ?underox ?loc))
        (at end (isopen ?underox))
        (at end (box_start_position ?bx ?loc))

      )
)


)