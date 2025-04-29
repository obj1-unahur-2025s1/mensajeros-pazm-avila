// Hacer DELEGACIÓN aka division de subtareas para que quede más prolijo el codigo. Osea, usar metodos auxiliares para que no me quede un choclo la resolución.

// primera parte polimorfismo puro. 
object paquete {
    var estaPago = false
    var destino = laMatrix // le puedo poner null también
    method estaPago() = estaPago
    method pagarPaquete() {estaPago = true}
    method puedeEntregarse(unMensajero) {
        return destino.dejaPasar(unMensajero) && self.estaPago()
    }
    //Tercera parte
    method precioTotal() = 50 // polimorfismo. 
}

object puenteDeBrooklyn {
    method dejaPasar(unMensajero) {
        return unMensajero.peso() < 1000
    } 
}

object laMatrix {
    method dejaPasar(unMensajero) {
        return unMensajero.puedeLlamar() // el test fallaba porque no estaba el return
    } 
}

object roberto {
    var transporte = bicicleta
    method peso() = 90 + transporte.peso()
    method puedeLlamar() = false
    method cambiarTransporte(nuevoTransporte) {transporte=nuevoTransporte}
}

object chuckNorris {
   method peso() = 80
    method puedeLlamar() = true
}

object neo {
    var tieneCreadito = true
    method peso() = 0
    method puedeLlamar() = tieneCreadito
    method cargarCredito() {tieneCreadito = true}
    method agotarCredito() {tieneCreadito = false}
}

object bicicleta {
    method peso() = 5
}

object camion {
    var acoplados = 1
    method cantidadAcoplados(unaCantidad) {acoplados=unaCantidad}
    method peso() = acoplados * 500
}

// Segunda parte. Colecciones. 
object empresaMensajeria {
    // conjunto: const mensajeros = #{}
    const mensajeros = []
    const paquetesPendientes = []
    const paquetesEnviados = []
    method mensajeros() = mensajeros
    method contratar(unMensajero) {mensajeros.add(unMensajero)}
    method despedir(unMensajero) {mensajeros.remove(unMensajero)}
    method esGrande() = mensajeros.size() > 2
    method puedeEntregarsePaquete() {
        return paquete.puedeEntregarse(mensajeros.first())
    }
    method pesoUltimoMensajero() = mensajeros.last().peso()

    //Tercera parte
    method puedeEntregarse(unPaquete) {
        return mensajeros.any({m => unPaquete.puedeEntregarse(m)})
    }
    method losQuePuedenEntregar(unPaquete) {
        // hay que hacer una sublista con una condición (uso filter q me retorna otra lista)
        return mensajeros.filter({m => unPaquete.puedeEntregarse(m)})
    }
    method tieneSobrepeso() {
        return self.pesoDeLosMensajeros() / mensajeros.size() > 500 // promedio > 500
    }
    method pesoDeLosMensajeros() = mensajeros.sum({m => m.peso()}) // con esto obtengo un número, que es la suma total de todos los pesos de los mensajeros.
    
    method enviar(unPaquete) {
        if(self.puedeEntregarse(unPaquete)) {
            paquetesEnviados.add(unPaquete)
        }
        else {
            paquetesPendientes.add(unPaquete)
        }
    }

    method facturacion() = paquetesEnviados.sum({p=>p.precioTotal()})

    method enviarPaquetes(listaDePaquetes) {
        listaDePaquetes.forEach({p=>self.enviar(p)})
    }

    method enviarPendienteMasCaro() {
       //no hago esto xq me duplica el mismo paquete en la lista self.enviar(self.paquetePendienteMasCaro())
        if(self.puedeEntregarse(self.paquetePendienteMasCaro())) {
            self.enviar(self.paquetePendienteMasCaro())
            paquetesPendientes.remove(self.paquetePendienteMasCaro())
        }

    }

    method paquetePendienteMasCaro() {
        return paquetesPendientes.max({p=>p.precioTotal()})
    }
}

// RESOLVER PUNTO 8 Y 9 DE LA TERCERA PARTE

// Tercera parte. 
object paquetito {
    method estaPago() = true
    method puedeEntregarse(unMensajero) = true // por mas que no necesite un mensajero, le paso el parametro igual x polimorfismo.
    method precioTotal() = 0
}

object paquetonViajero {
    const destinos = []
    var importePagado = 0
    method agregarDestino(unDestino) {destinos.add(unDestino)}
    method estaPago() {return importePagado >= self.precioTotal()} // todavia no vimos excepciones pero podria arrojar una excepción si se paga de más. Sigue siendo polimórfico xq sigue retornando un booleano.
    method puedeEntregarse(unMensajero) {return self.estaPago() && self.puedePasarPorDestinos(unMensajero)}
    method puedePasarPorDestinos(unMensajero) {return destinos.all({d => d.dejaPasar(unMensajero)})}    // metodo auxiliar para el puedeEntregarse
    method precioTotal() = 100 * destinos.size() // destinos.size() es la cantidad de destinos
    method pagar(unImporte) {importePagado = importePagado + unImporte}
}