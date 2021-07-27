;;FUN18673753_Benjamin Fung
;;Domain for cleaning floor tiles
;; A domain file for CMP2020M assignment 2018/2019

(define (domain floor-tile)
	;; We only require some typing to make this plan faster. We can do without!
	(:requirements :typing)
	;; We have two types: robots and the tiles, both are objects
	(:types robot tile - object)
	;; define all the predicates as they are used in the probem files
	(:predicates  
    ;; described what tile a robot is at
    (robot-at ?r - robot ?x - tile)
    ;; indicates that tile ?x is above tile ?y
    (up ?x - tile ?y - tile)
    ;; indicates that tile ?x is below tile ?y
    (down ?x - tile ?y - tile)
    ;; indicates that tile ?x is right of tile ?y
    (right ?x - tile ?y - tile)
    ;; indicates that tile ?x is left of tile ?y
    (left ?x - tile ?y - tile)    
    ;; indicates that a tile is clear (robot can move there)
    (clear ?x - tile)
    ;; indicates that a tile is cleaned
    (cleaned ?x - tile)
 	)
  ;action defintions
 (:action clean-up ;cleaning the tile above the robot
  :parameters (?r - robot ?y - tile ?x - tile) ;objects that will be used
  :precondition (and (robot-at ?r ?y) ;the location of the robot
                     (up ?x ?y) ;the tile that is above the robot
                     (not (cleaned ?y))) ;the tile above the robot needs to not be cleaned already
  :effect (and 
           (cleaned ?x) 
           (not (clear ?x))) 
 )

 (:action clean-down ; cleaning the tile below the robot
  :parameters (?r - robot ?y - tile ?x - tile)
  :precondition (and (robot-at ?r ?y)
                     (down ?x ?y); the tile that is below the robot
                     (not (cleaned ?y))); the tile below the robot is needs to not be cleaned already
  :effect (and (cleaned ?x) ;the tile is now cleaned
           (not (clear ?x))) ; the tile is not available for robots to move there
 )

 (:action up ;robot moving to the tile above
  :parameters (?r - robot ?y - tile ?x - tile) 
  :precondition (and (up ?x ?y) ;tile ?x is above ?y whilst the robot is at tile ?y
                 (robot-at ?r ?y) 
                 (clear ?x)); the tile above must be available for the robot to move there
  :effect (and  (robot-at ?r ?x);afterwards, the robot is now at tile ?x
                (not (up ?y ?x)); the tile above is no longer above
                (not (robot-at ?r ?y)));afterwards the robot has moved.
 )

 (:action down ;robot moving to the tile below
  :parameters (?r - robot ?y - tile ?x - tile)
  :precondition (and (down ?x ?y) (robot-at ?r ?y) (clear ?x))
  :effect (and (not (robot-at ?r ?y))
               (not (down ?y ?x))
                (robot-at ?r ?x))
 )

 (:action right ;robot moving to the tile on the right
  :parameters (?r - robot ?y - tile ?x - tile)
  :precondition (and (right ?x ?y) (robot-at ?r ?y) (clear ?x))
  :effect (and (not (robot-at ?r ?y))
               (not (right ?y ?x))
               (robot-at ?r ?x))
 )

 (:action left ;robot moving to the tile on the left
  :parameters (?r - robot ?y - tile ?x - tile)
  :precondition (and (left ?x ?y) (robot-at ?r ?y) (clear ?x))
  :effect (and (not (robot-at ?r ?y))
               (not (left ?y ?x))
               (robot-at ?r ?x))
 )
)
;References
;Yu, M. (2020) Week 10: Planning II [speech]. University of Lincoln.
;Helmert, M. (2006) The Fast Downward Planning System. Journal of Artificial Intelligence Research, 26,.
