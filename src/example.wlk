
object municipio {
	
	var property clubes=#{}
	var property paseEstrella = 50000
	
	method addClub(club) {
		clubes.add(club)
	}
	
	method club(socio) {
		return clubes.find({club => club.pertenece(socio)})
	}
	
}

class Club {
	
	const property socios = #{}
	const property actividades = #{} 
	
	method addSocio(socio) {
		socios.add(socio)
	}
	
	method masAntiguo() {
		return socios.max({socio => socio.antiguedad()})
	}
	
	method sociosDestacados() {
		return actividades.map({actividad => actividad.destacado()})
	}
	
	method pertece(socio) {
		return socios.contains(socio)
	}
	
	method cantidadActividades(jugador) {
		return actividades.count({actividad => actividad.participa(jugador)})
	}
	
	method esEstrella(jugador)
	
} 

class Tradicional inherits Club {
	override method esEstrella(jugador) {
		return  jugador.esCaro() or jugador.participaMucho()
	}
}

class Comunitario inherits Club {
	override method esEstrella(jugador) {
		return jugador.participaMucho()
	}	
}

class Profesional inherits Club {
	override method esEstrella(jugador) {
		return  jugador.esCaro() 
	}
}


class Socio {
	var property antiguedad = 0
	
	method esEstrella() {
		return antiguedad > 20
	}
}

class Jugador inherits Socio {
	var property partidos = 0
	var property pase = 0
	
	override method esEstrella() {
		return partidos >= 50 or self.club().esEstrella(self)
	}
	
	method club() {
		return municipio.club(self)
	}
	
	method cantidadActividades() {
		return self.club().cantidadActividades(self)
	}
	
	method participaMucho() {
		return self.cantidadActividades()>3
	} 
	
	method esCaro() {
		return self.pase() > municipio.paseEstrella()
	}
	
}


class Actividad {
	const property participantes = #{}
	const property destacado
	
	method participa(socio) {
		return participantes.contains(socio)
	}
	
}
//
//class ActividadSocial inherits Actividad {
//}
//
//class ActividadDeportiva inherits Actividad{
//}