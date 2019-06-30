package com.gestionturnos.gestion_turnos.gestionturnos.dao;

import java.util.Optional;
import java.util.Set;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.gestionturnos.gestion_turnos.gestionturnos.model.Medico;
import com.gestionturnos.gestion_turnos.gestionturnos.model.MedicoObraSocial;
import com.gestionturnos.gestion_turnos.gestionturnos.model.Paciente;
import com.gestionturnos.gestion_turnos.gestionturnos.model.Turno;
/**
 * 
 * @author flor
 *
 */
@Repository
public interface TurnoRepository extends JpaRepository<Turno, Integer> {
	
	Optional<Turno> findById(Integer idTurno);
		
	Set<Turno> findByPaciente(Paciente paciente);

	
	//Set<Turno> findByMedico(Medico medico);
	
}
