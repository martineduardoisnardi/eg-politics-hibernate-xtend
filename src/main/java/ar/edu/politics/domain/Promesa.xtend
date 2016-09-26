package ar.edu.politics.domain

import java.time.LocalDate
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.UserException
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
@Entity
class Promesa {
	
	@Id
	@GeneratedValue
	private Long id
	
	@Column
	LocalDate fecha

	@Column(length=150)
	String accionPrometida
	
	new() {
		
	}
	
	new(String accionPrometida) {
		fecha = LocalDate.now
		this.accionPrometida = accionPrometida
	}
	
	def void validar() {
		if (fecha == null) {
			throw new UserException("Debe ingresar fecha")
		}
		if (accionPrometida == null) {
			throw new UserException("Debe ingresar una acción en la promesa")
		}
	}
	
}