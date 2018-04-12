(define (problem belkan-test)

  ;NOMBRE DEL DOMINIO A USAR
  (:domain belkan-domain)
    
  ;DOMINIO DE LOS OBJETOS DEL MUNDO
  (:objects p1 p2 p3 p4 p5 p6 p7 - zona
            jugador1 - jugador
            bruja princesa principe leonardo profesor - personaje
            oscar manzana rosa algoritmo oro - objeto
            norte sur este oeste - orientacion
  )
  
  ;ESTADO INICIAL
  (:init 
        
        ;definimos las conexiones entre las zonas
        (connected p1 p3)
        (connected p3 p1)
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

        ;los personajes no tienen nada en las manos
        (not(hasThingPersonaje bruja)) 
        (not(hasThingPersonaje princesa)) 
        (not(hasThingPersonaje principe)) 
        (not(hasThingPersonaje profesor)) 
        (not(hasThingPersonaje leonardo))
        
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
        (atPersonaje principe p7)
        
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
            (hasThingPersonaje bruja)
            (hasThingPersonaje profesor)
            (hasThingPersonaje leonardo)
            (hasThingPersonaje principe)
            (hasThingPersonaje princesa)
        )
  )
  
  
  
)