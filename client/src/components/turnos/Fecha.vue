<template>
      <v-flex xs12 sm6 md6 xl6 >
       <v-menu>
         <v-text-field :value="fecha" slot="activator" label="Fecha" prepend-icon="date_range"></v-text-field>
         <v-date-picker 
         :show-current="false"
         locale="es-ar"
         :min="minimo"
         v-model="fecha" @input="enviarFecha(fecha)"
         ></v-date-picker>
       </v-menu>
      </v-flex>
</template>

<script lang="ts">
  import Turnos, { Turno} from '../../rest/turno';

  export default {
    props: ['idm'],
    data () {
      return {
       fecha:null,
       minimo: new Date().toISOString().substr(0, 10),
       horarios: ["8:00:00","8:30:00","9:00:00","9:30:00","10:00:00","10:30:00","11:00:00","11:30:00","12:00:00"],
       turnos:[],
       hor_nodispo:[],
       fh:{fecha:null,hor_dis :[]},
      }
    },
    

    methods:{
      enviarFecha(fecha){
      this.$data.fecha = fecha;
      this.$data.fh.fecha =fecha;
      this.buscarTurnos();
      
    },
      buscarHorarios(){
     
        var disponible = [];
         this.$data.hor_nodispo=this.$data.hor_nodispo.toString();
        
        for (var i = 0; i < this.$data.horarios.length; i++) {
    
                if (this.$data.hor_nodispo.includes(''+this.$data.horarios[i] )== 0 ) {
                  disponible.push(this.$data.horarios[i]);

                }
         }
        this.$data.fh.hor_dis=disponible;
        console.log("disponibles ",disponible);
         console.log("estoy mandando una fecha y horario", this.$data.fh.hor_dis );
         this.$emit('enviarFecha',  this.$data.fh )
        },

      buscarTurnos: async function(){
      try {
        var hor_nodispo =[];
        //busco para obtener los horarios de turnos registrados en esa fecha
        const response = await Turnos.getRestApi().getAllTurnos();
        console.log("response: ",response );
        this.$data.turnos = response.data ;
        for (var i = 0; i < this.$data.turnos.content.length; i++) {
              //filtro por id medico y fecha
              if((this.$data.fecha==this.$data.turnos.content[i].fecha)&&
              (this.idm==this.$data.turnos.content[i].medico.idMedico)){
              var algo = this.$data.turnos.content[i].hora.toString();
              hor_nodispo.push(algo);
              }
              }
        console.log("hora turnos", typeof hor_nodispo );
        this.$data.hor_nodispo = hor_nodispo;
        this.buscarHorarios();
     
      } catch (error) {
        this.emitError(error);
        
      }
    },

    }
  }
</script>