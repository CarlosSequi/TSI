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
        (connected p1 p9)
        (connected p9 p1)

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

        ;la mochila esta vacia al principio
        (puedoLlenarMochila)

        ;Puntos que otorga la Princesa      
        (= (puntuacionObjeto princesa oscar) 5)      
        (= (puntuacionObjeto princesa rosa) 10)      
        (= (puntuacionObjeto princesa manzana) 1)      
        (= (puntuacionObjeto princesa algoritmo) 3)      
        (= (puntuacionObjeto princesa oro) 4) 
        ;puntuaciones al entregar objetos a personajes
        (= (puntuacionObjeto leonardo oscar) 10)      
        (= (puntuacionObjeto leonardo rosa) 1)      
        (= (puntuacionObjeto leonardo manzana) 3)      
        (= (puntuacionObjeto leonardo algoritmo) 4)      
        (= (puntuacionObjeto leonardo oro) 5)        
        ;Puntos que otorga el Profesor      
        (= (puntuacionObjeto profesor oscar) 3)      
        (= (puntuacionObjeto profesor rosa) 4)      
        (= (puntuacionObjeto profesor manzana) 5)      
        (= (puntuacionObjeto profesor algoritmo) 10)     
        (= (puntuacionObjeto profesor oro) 1)  
        ;Puntos que otorga la Bruja     
        (= (puntuacionObjeto bruja oscar) 4)      
        (= (puntuacionObjeto bruja rosa) 5)      
        (= (puntuacionObjeto bruja manzana) 10)      
        (= (puntuacionObjeto bruja algoritmo) 1)      
        (= (puntuacionObjeto bruja oro) 3)        
        ;Puntos que otorga el Principe      
        (= (puntuacionObjeto principe oscar) 1)      
        (= (puntuacionObjeto principe rosa) 3)      
        (= (puntuacionObjeto principe manzana) 4)      
        (= (puntuacionObjeto principe algoritmo) 5)      
        (= (puntuacionObjeto principe oro) 10)

        ;definimos los tipos de superficies
        (tipoSuperficie p5 agua)
        (tipoSuperficie p2 arena)
        (tipoSuperficie p1 piedra)
        (tipoSuperficie p8 arena)
        (tipoSuperficie p3 bosque)
        (tipoSuperficie p4 arena)
        (tipoSuperficie p7 piedra)
        (tipoSuperficie p6 agua)
        (tipoSuperficie p9 arena)

        ;definimos donde se encuentran los objetos
        (atObjeto oro p3)
        (atObjeto algoritmo p7)
        (atObjeto oscar p1)
        (atObjeto manzana p2)
        (atObjeto rosa p1)
        (atObjeto bikini p3)
        (atObjeto zapatilla p1)
        
        ;definimos donde se encuentran los personajes
        (atPersonaje bruja p8)
        (atPersonaje profesor p7)
        (atPersonaje leonardo p4)
        (atPersonaje princesa p4)
        (atPersonaje principe p2)



        ;puntuacion inicial del jugador
        (= (puntuacion-total) 0)
        
        ;definimos orientación del jugador
        (orientation jugador1 este)
        
        ;definimos donde se encuentra el jugador
        (atJugador jugador1 p1)
  )
  
  ;ESTADO OBJETIVO
  (:goal 
    (>= (puntuacion-total) 50)
  )
  
  ;le decimos al planificador que maximice la puntuación puntuacion-total
  ;al entregar objetos a los diferentes personajes.
  (:metric maximize (puntuacion-total))
)


