(define (problem belkan-test)

  ;NOMBRE DEL DOMINIO A USAR
  (:domain belkan-domain)
    
  ;DOMINIO DE LOS OBJETOS DEL MUNDO
  (:objects p1 p2 p3 p4 p5 p6 p7 p8 p9 - zona
            jugador1 - jugador
            bruja princesa principe leonardo profesor - personaje
            oscar manzana rosa algoritmo oro bikini zapatilla - objeto
            norte sur este oeste - orientacion
            agua piedra precipicio arena bosque - superficie
  )
  
  ;ESTADO INICIAL
  (:init 
        
        ;definimos las conexiones entre las zonas
        (connected p1 p3)
        (connected p3 p1)
        (connected p9 p1)
        (connected p1 p9)
        (connected p2 p3)
        (connected p3 p2)
        (connected p3 p4)
        (connected p4 p3)
        (connected p3 p6)
        (connected p6 p3)
        (connected p5 p6)
        (connected p6 p5)
        (connected p6 p7)
        (connected p7 p6)
        (connected p1 p8)
        (connected p1 p8)
        (connected p2 p8)
        (connected p8 p2)

        ;al principio puede coger objetos el jugador
        (puedeCogerObjeto)
        
        ;los personajes no tienen nada en las manos
        (not(hasThingPersonaje bruja manzana)) 
        (not(hasThingPersonaje princesa rosa)) 
        (not(hasThingPersonaje principe oro)) 
        (not(hasThingPersonaje profesor algoritmo)) 
        (not(hasThingPersonaje leonardo oscar))
        
        ;definimos las orientaciones entre las zonas
        (orientationZone p1 sur p3)
        (orientationZone p3 norte p1)
        (orientationZone p2 este p3)
        (orientationZone p3 oeste p2)
        (orientationZone p4 oeste p3)
        (orientationZone p3 este p4)
        (orientationZone p6 norte p3)
        (orientationZone p3 sur p6)
        (orientationZone p5 este p6)
        (orientationZone p6 oeste p5)
        (orientationZone p6 este p7)
        (orientationZone p7 oeste p6)
        (orientationZone p8 este p1)
        (orientationZone p1 oeste p8)
        (orientationZone p8 sur p2)
        (orientationZone p2 norte p8)
        
        ;definimos las distancias entre las ciudades
        (= (distancia p1 p3) 1)
        (= (distancia p3 p1) 1)
        (= (distancia p2 p3) 3)
        (= (distancia p3 p2) 3)
        (= (distancia p3 p4) 5)
        (= (distancia p4 p3) 5)
        (= (distancia p5 p6) 2)
        (= (distancia p6 p5) 2)
        (= (distancia p6 p3) 1)
        (= (distancia p3 p6) 1)
        (= (distancia p7 p6) 3)
        (= (distancia p6 p7) 3)
        (= (distancia p1 p8) 2)
        (= (distancia p8 p1) 2)
        (= (distancia p2 p8) 1)
        (= (distancia p8 p2) 1)
        (= (distancia p1 p9) 3)
        (= (distancia p9 p1) 3)
        
        ;definimos la distancia inicial recorrida
        (= (distancia-total) 0)
        
        ;definimos donde se encuentran los objetos
        (atObjeto oro p1)
        (atObjeto algoritmo p5)
        (atObjeto oscar p2)
        (atObjeto manzana p6)
        (atObjeto rosa p4)
        
        ;definimos donde se encuentran los personajes
        (atPersonaje bruja p4)
        (atPersonaje profesor p1)
        (atPersonaje leonardo p5)
        (atPersonaje princesa p3)
        (atPersonaje principe p6)
        
        ;definimos orientación del jugador
        (orientation jugador1 este)
        
        ;definimos donde se encuentra el jugador
        (atJugador jugador1 p1)
  )
  
  ;ESTADO OBJETIVO
  (:goal 
        (AND 
            ;(orientation jugador1 sur)
            ;para probar el dropObject
            ;(not(hasThingJugador jugador1))
            ;(atJugador jugador1 p7)
            
            ;para probar el giveObject
            (hasThingPersonaje bruja manzana)
            (hasThingPersonaje profesor algoritmo)
            (hasThingPersonaje leonardo oscar)
            (hasThingPersonaje principe oro)
            (hasThingPersonaje princesa rosa)
        )
  )
  
  ;le decimos al planificador que minimice la distancia distancia-total
  ;para ir cogiendo sucesivamente los caminos más cortos
  (:metric minimize (distancia-total))
)


