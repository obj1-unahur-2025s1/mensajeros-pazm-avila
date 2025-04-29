// primera parte polimorfismo puro. 
object paquete {
    var estaPago = false
    var destino = laMatrix // le puedo poner null también
    method estaPago() = estaPago
    method pagarPaquete() {estaPago = true}
    method puedeEntregarse() {
        destino.dejaPasar(unMensajero) && self.estaPago()
    }
}

object puenteDeBrooklyn {
    method dejaPasar(unMensajero) {
        unMensajero.peso() < 1000
    } 
}

object laMatrix {
    method dejaPasar(unMensajero) {
        unMensajero.puedeLlamar()
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