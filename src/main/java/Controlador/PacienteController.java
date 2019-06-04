package Controlador;

import java.util.Optional;
import java.util.Set;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import DAO.PacienteRepository;
import DAO.ObraSocialRepository;
import DAO.TurnoRepository;
import Modelos.Medico;
import Modelos.ObraSocial;
import Modelos.Paciente;
import Modelos.Turno;
/**
 * 
 * @author flor
 *
 */
@RestController
@RequestMapping("/paciente")
public class PacienteController {
	
	@Autowired
	private PacienteRepository repository;
	
	@Autowired
	private TurnoRepository turnoRepository;
	
	@Autowired
	private ObraSocialRepository obraSocialRepository;
	
	@GetMapping()
	public Page<Paciente> getPage(Pageable pageable) {
		return repository.findAll(pageable);
	}
		
	@GetMapping("/{idPaciente}")
	public ResponseEntity<Paciente> findById(@PathVariable Integer idPaciente) {
		
		Optional<Paciente> opt = repository.findById(idPaciente);
		if (opt.isPresent())
			return ResponseEntity.ok(opt.get());
		return ResponseEntity.notFound().build();
	}
	
	@GetMapping("/obraSocial/{idObraSocial}")
	public ResponseEntity<Set<Paciente>> findByObraSocial(@PathVariable Integer idObraSocial) {
		ObraSocial obraSocial = obraSocialRepository.getOne(idObraSocial);
		Set<Paciente> ret = repository.findByObraSocial(obraSocial);
		return ResponseEntity.ok(ret);
	}
	
	/*@GetMapping("/turno/{idTurno}")
	public ResponseEntity<Set<Paciente>> findByTurno(@PathVariable Integer idTurno) {
		Turno turno = turnoRepository.getOne(idTurno);
		Set<Paciente> ret = repository.findByTurno(turno);
		return ResponseEntity.ok(ret);
	}*/
	
	@PostMapping()
	public ResponseEntity<Paciente> create(@Valid @RequestBody Paciente createRequest) {
		return ResponseEntity.ok(repository.save(createRequest));
	}
	
	@PutMapping()
	public ResponseEntity<Paciente> update(@Valid @RequestBody Paciente updateRequest) {
		boolean exists = repository.existsById(updateRequest.getIdPaciente());
		if (exists) {
			return ResponseEntity.ok(repository.save(updateRequest));
		}
		return ResponseEntity.notFound().build();		
	}
	
	@DeleteMapping("/{idPaciente}")
	public ResponseEntity<Paciente> delete(@PathVariable Integer idPaciente) {
		Optional<Paciente> opt = repository.findById(idPaciente);
		if (opt.isPresent()) {
			repository.delete(opt.get());
			return ResponseEntity.ok().build();			
		}
		return ResponseEntity.notFound().build();
	}
}
