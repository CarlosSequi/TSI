(define (domain belkan-domain)	  
  (:requirements :strips :equality :typing :fluents)
  (:types  personaje jugador objeto zona orientacion superficie)
 
 ;Lista de predicados
  (:predicates 
	       (hasThingPersonaje ?t - personaje ?o - objeto)
	       (hasThingJugador ?j - jugador ?o - objeto)
	       (atPersonaje ?p - personaje ?z - zona)
	       (atJugador ?j - jugador ?z - zona)
	       (atObjeto ?o - objeto ?z - zona)
	       (orientation ?j - jugador ?o - orientacion)
	       (connected ?zona1 ?zona2 - zona)
	       (orientationZone ?zonaIni - zona ?o - orientacion ?zonaFin - zona)
	       (puedeCogerObjeto)
	       (objetoEnMochila ?o - objeto)
	       (tipoSuperficie ?z - zona ?s - superficie)
	       (puedoLlenarMochila)
	       
  )
  
  
  ;LISTA DE FUNCIONES
  (:functions
    (distancia ?x ?y - zona)
    (distancia-total)
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
  
  ;LISTA DE ACCIONES:
  ;moverse a otra zona
  (:action move
        :parameters (?j - jugador ?ozfin - orientacion ?zonaIni ?zonaFin - zona)
	    :precondition (and 
	                    (orientation ?j ?ozfin)
	                    (orientationZone ?zonaIni ?ozfin ?zonaFin)
	                    (atJugador ?j ?zonaIni)
	                    (not(tipoSuperficie ?zonaFin bosque))
	                    (not(tipoSuperficie ?zonaFin precipicio))
	                    (not(tipoSuperficie ?zonaFin agua))
	                    (connected ?zonaIni ?zonaFin)
	                  )
	    :effect 
	    (
	        and
	        (atJugador ?j ?zonaFin)
	        (not(atJugador ?j ?zonaIni))
	        (increase (distancia-total) (distancia ?zonaIni ?zonaFin))
	    )
  
  )

  ;moverse a otra zona con agua
  (:action moveWater
        :parameters (?j - jugador ?ozfin - orientacion ?zonaIni ?zonaFin - zona)
	    :precondition (and 
	                    (orientation ?j ?ozfin)
	                    (or
	                    	(hasThingJugador ?j bikini)
	                    	(objetoEnMochila bikini)
	                    )
	                    
	                    (orientationZone ?zonaIni ?ozfin ?zonaFin)
	                    (atJugador ?j ?zonaIni)
	                    (tipoSuperficie ?zonaFin agua)
	                    (connected ?zonaIni ?zonaFin)
	                  )
	    :effect 
	    (
	        and
	        (atJugador ?j ?zonaFin)
	        (not(atJugador ?j ?zonaIni))
	        (increase (distancia-total) (distancia ?zonaIni ?zonaFin))
	    )
  
  )

  ;moverse a otra zona de bosque
  (:action moveForest
        :parameters (?j - jugador ?ozfin - orientacion ?zonaIni ?zonaFin - zona)
	    :precondition (and 
	                    (orientation ?j ?ozfin)
	                    (or
	                    	(hasThingJugador ?j zapatilla)
	                    	(objetoEnMochila zapatilla)
	                    )
	                    (orientationZone ?zonaIni ?ozfin ?zonaFin)
	                    (atJugador ?j ?zonaIni)
	                    (tipoSuperficie ?zonaFin bosque)
	                    (connected ?zonaIni ?zonaFin)
	                  )
	    :effect 
	    (
	        and
	        (atJugador ?j ?zonaFin)
	        (not(atJugador ?j ?zonaIni))
	        (increase (distancia-total) (distancia ?zonaIni ?zonaFin))
	    )
  
  )
  
  ;coger objeto
  (:action takeObject
	     :parameters (?j - jugador ?o - objeto ?z - zona)
	     :precondition 
	     (
	        and
	        (puedeCogerObjeto)
	        (atJugador ?j ?z)
	        (atObjeto ?o ?z)
	        (not(hasThingJugador ?j ?o)) 
	     )
	     :effect 
	     (
	        and
	        (not(puedeCogerObjeto))
	        (hasThingJugador ?j ?o)
	        (not(atObjeto ?o ?z))
	     )
  ) 

  ;metemos objetos en la mochila
  (:action meterObjetoEnMochila
	     :parameters (?j - jugador ?o - objeto)
	     :precondition 
	     (
	        and
	        (not(objetoEnMochila ?o))
	        (hasThingJugador ?j ?o)
	        (puedoLlenarMochila)
	     )
	     :effect 
	     (
	        and
	        (not(puedoLlenarMochila))
	        (puedeCogerObjeto)
	        (not(hasThingJugador ?j ?o))
	        (objetoEnMochila ?o)
	     )
  )

  ;sacamos objetos de la mochila
  (:action sacarObjetoDeMochila
	     :parameters (?j - jugador ?o - objeto)
	     :precondition 
	     (
	        and
	        (objetoEnMochila ?o)
	        (not(hasThingJugador ?j ?o))
	        (puedeCogerObjeto)
	        (not(puedoLlenarMochila))
	     )
	     :effect 
	     (
	        and
	         ;entonces
	         (puedoLlenarMochila)
	         (not(puedeCogerObjeto))
	         (hasThingJugador ?j ?o)
	         (not(objetoEnMochila ?o))
	        
	     )
  )
  

  ;soltar objeto
  (:action dropObject
	     :parameters (?j - jugador ?o - objeto ?z - zona)
	     :precondition 
	     (
	        and
	        (not(puedoLlenarMochila))
	        (not(puedeCogerObjeto))
	        (atJugador ?j ?z)
	        (hasThingJugador ?j ?o)
	     )
	     :effect 
	     (
	        and

	        (when
	         (and 
	         	(not(and(tipoSuperficie ?z bosque) (hasThingJugador ?j zapatilla)))
	         	(not(and(tipoSuperficie ?z agua) (hasThingJugador ?j bikini)))
	         )

			 (and
	          (not(hasThingJugador ?j ?o))
	          (atObjeto ?o ?z)
	          (puedeCogerObjeto)
	         )
			)
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
	        (not(hasThingPersonaje ?p ?o))
	        (hasThingJugador ?j ?o)
	        (not(hasThingJugador ?j bikini))
	        (not(hasThingJugador ?j zapatilla))
	     )
	     :effect 
	     (
	        and
	        (puedeCogerObjeto)
	        (not(hasThingJugador ?j ?o))
	        (hasThingPersonaje ?p ?o)
	     )
  )

  
)

