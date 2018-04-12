(define (domain belkan-domain)	  
  (:requirements :strips :equality :typing)
  (:types  personaje jugador objeto zona orientacion)
 
 ;Lista de predicados
  (:predicates 
	       (hasThingPersonaje ?t - personaje)
	       (hasThingJugador ?j - jugador)
	       (atPersonaje ?p - personaje ?z - zona)
	       (atJugador ?j - jugador ?z - zona)
	       (atObjeto ?o - objeto ?z - zona)
	       (orientation ?j - jugador ?o - orientacion)
	       (connected ?zona1 ?zona2 - zona)
	       (orientationZone ?zonaIni - zona ?o - orientacion ?zonaFin - zona)
  )
  
  ;LISTA DE ACCIONES:
  
  ;moverse a otra zona
  (:action move
        :parameters (?j - jugador ?ozfin - orientacion ?zonaIni ?zonaFin - zona)
	    :precondition (and 
	                    (orientation ?j ?ozfin)
	                    (orientationZone ?zonaIni ?ozfin ?zonaFin)
	                    (atJugador ?j ?zonaIni)
	                    (connected ?zonaIni ?zonaFin)
	                  )
	    :effect 
	    (
	        and
	        (atJugador ?j ?zonaFin)
	        (not(atJugador ?j ?zonaIni))
	    )
  
  )
  
  ;giro a izquierda
  (:action turnLeft
	     :parameters (?j - jugador ?o - orientacion)
	     :precondition (orientation ?j ?o)
	     :effect 
	     (
	        and
	        ;si ocurre algo...
	        (when(and (orientation ?j norte))
	            ;entonces...
	            (and (orientation ?j oeste))
	        )
	        
	        (when(and (orientation ?j sur))
	            (and (orientation ?j este))
	        )
	        
	        (when(and (orientation ?j este))
	            (and (orientation ?j norte))
	        )
	        
	        (when(and (orientation ?j oeste))
	            (and (orientation ?j sur))
	        )
	        
	        ;eliminamos el predicado que había anteriormente
	        (not(orientation ?j ?o))
	     )
  )
  
  
  ;giro derecha
  (:action turnRight
	     :parameters (?j - jugador ?o - orientacion)
	     :precondition (orientation ?j ?o)
	     :effect 
	     (
	        and
	        ;si ocurre algo...
	        (when(and (orientation ?j norte))
	            ;entonces...
	            (and (orientation ?j este))
	        )
	        
	        (when(and (orientation ?j sur))
	            (and (orientation ?j oeste))
	        )
	        
	        (when(and (orientation ?j este))
	            (and (orientation ?j sur))
	        )
	        
	        (when(and (orientation ?j oeste))
	            (and (orientation ?j norte))
	        )
	        
	        ;eliminamos el predicado que había anteriormente
	        (not(orientation ?j ?o))
	     )
  )
  
  ;coger objeto
  (:action takeObject
	     :parameters (?j - jugador ?o - objeto ?z - zona)
	     :precondition 
	     (
	        and
	        (atJugador ?j ?z)
	        (atObjeto ?o ?z)
	        (not(hasThingJugador ?j))
	     )
	     :effect 
	     (
	        and
	        (hasThingJugador ?j)
	        (not(atObjeto ?o ?z))
	     )
  )
  
  ;soltar objeto
  (:action dropObject
	     :parameters (?j - jugador ?o1 ?o2 - objeto ?z - zona)
	     :precondition 
	     (
	        and
	        (atJugador ?j ?z)
	        (hasThingJugador ?j)
	     )
	     :effect 
	     (
	        and
	        (not(hasThingJugador ?j))
	        (atObjeto ?o2 ?z)
	     )
  )
  
  ;entregar objeto
  (:action giveObject
	     :parameters (?j - jugador ?o - objeto ?z - zona ?p - personaje)
	     :precondition 
	     (
	        and
	        (atJugador ?j ?z)
	        (atPersonaje ?p ?z)
	        (not(hasThingPersonaje ?p))
	        (hasThingJugador ?j)
	     )
	     :effect 
	     (
	        and
	        (not(hasThingJugador ?j))
	        (hasThingPersonaje ?p)
	     )
  )
  
)

