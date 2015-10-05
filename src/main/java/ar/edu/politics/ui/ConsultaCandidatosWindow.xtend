package ar.edu.politics.ui

import ar.edu.politics.appModel.ConsultaCandidatos
import ar.edu.politics.appModel.VerCandidato
import ar.edu.politics.domain.Candidato
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Selector
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner

class ConsultaCandidatosWindow extends SimpleWindow<ConsultaCandidatos> {
	
	new(WindowOwner parent) {
		super(parent, new ConsultaCandidatos)
	}
	
	override protected addActions(Panel actionsPanel) {
		new Button(actionsPanel) => [
			caption = "Ver ficha"
			bindEnabledToProperty("puedeVerFicha")
			onClick [ | 
				val candidatoSeleccionado = this.modelObject.candidatoSeleccionado
				new VerCandidatoDialog(this, new VerCandidato(candidatoSeleccionado)).open ]
		]
	}
	
	override protected createFormPanel(Panel mainPanel) {
		title = "Consulta de candidatos"
		
		new Label(mainPanel).text = "Zona de votación"
		new Selector(mainPanel) => [
			allowNull = false
			bindItemsToProperty("zonasDeVotacion")
			bindValueToProperty("zonaSeleccionada")
		]
		
		new Label(mainPanel).text = "Candidatos"
		val gridCandidatos = new Table(mainPanel, typeof(Candidato)) => [
			bindItemsToProperty("zonaSeleccionada.candidatos")
			bindValueToProperty("candidatoSeleccionado")
		]
		new Column<Candidato>(gridCandidatos) => [
			title = "Candidato"
			bindContentsToProperty("nombre")
			fixedSize = 200
		]
		new Column<Candidato>(gridCandidatos) => [
			title = "Partido"
			bindContentsToProperty("partido")
			fixedSize = 300
		]
	}
	
}