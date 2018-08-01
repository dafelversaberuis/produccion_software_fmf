
<%
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<%@ page contentType="text/html; charset=iso-8859-1" language="java"
	import="java.sql.*,java.util.*,java.text.SimpleDateFormat" errorPage=""
	session="false"%>

<jsp:useBean id="bAdministrarPublicaciones"
	class="beans.AdministrarPublicaciones" scope="page" />


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%
String idiomaSoftware = new beans.AdministrarPublicaciones().getIdioma();
%>
<%
	
int exito = 0; 


/*String registros = request.getParameter("registros");
	


	String encuesta = "";
	String pregunta = "";
	String opcion = "";
	
	
	if(registros!=null){
		
		for(int i=1; i<=Integer.parseInt(registros); i++){
			
			 encuesta = request.getParameter("encuesta"+i);
			 pregunta = request.getParameter("pregunta"+i);
			 opcion = request.getParameter("opcion"+i);
			
			 bAdministrarPublicaciones.crearRespuesta(encuesta, pregunta, opcion);
		}
		
		exito = 1; 
		
		
	}

*/

String encuesta = request.getParameter("encuesta");
String mujer = request.getParameter("mujer");
String totalPreguntas = request.getParameter("totalPreguntas");

//elimina la anterior para guardar una nueva
bAdministrarPublicaciones.eliminarAntesEncuesta(encuesta, mujer);

for(int i=1; i<=Integer.parseInt(totalPreguntas); i++){
	
	 String tipoPregunta = request.getParameter("tipoPregunta"+i);

	 
	 //tiempo
	 if(tipoPregunta!=null && tipoPregunta.equals("T")){
		
		 String pregunta = request.getParameter("pregunta"+i); 
		 String horas = request.getParameter("horas"+i);
		 String minutos = request.getParameter("minutos"+i);
		 bAdministrarPublicaciones.crearRespuestaTiempo(encuesta, pregunta, mujer,horas,minutos);
	
		 
	 }
	 
	
	 //única respuesta
	 if(tipoPregunta!=null && tipoPregunta.equals("U")){
		String pregunta = request.getParameter("pregunta"+i);
		String opcionSeleccionada =  request.getParameter("opcion"+i);

		String ampliacion =  request.getParameter("observacion"+i);
		if(ampliacion!=null && ampliacion.trim().equals("") && ampliacion.trim().equals("null")){
			ampliacion = null;
		}
		
		if(opcionSeleccionada!=null && !opcionSeleccionada.trim().equals("") && !opcionSeleccionada.trim().equals("null")){
			
	
			bAdministrarPublicaciones.crearRespuestaUnica(encuesta, pregunta, opcionSeleccionada,mujer,ampliacion);
		}
	 }
	 
	 //abierta
	 if(tipoPregunta!=null && tipoPregunta.equals("A")){
			String pregunta = request.getParameter("pregunta"+i);
			String abierta =  request.getParameter("abierta"+i);

			if(abierta!=null && !abierta.trim().equals("") && !abierta.trim().equals("null")){
				
				bAdministrarPublicaciones.crearRespuestaAbierta(encuesta, pregunta, mujer, abierta);
				
			}
	}
	
	 
	 //multiple
	 if(tipoPregunta!=null && tipoPregunta.equals("M")){
			String pregunta = request.getParameter("pregunta"+i);
			String chequeados =  request.getParameter("chequeados"+i);
			String observaciones =  request.getParameter("observaciones"+i);

			
			
			
			
			if(chequeados!=null && !chequeados.trim().equals("") && !chequeados.trim().equals("null")){
				
				
				String [] opcion = chequeados.split("-dfvp-");
				String [] observacion = observaciones.split("-dfvp-");
				for(int q=0; q<=opcion.length-1; q++){
					String op = opcion[q];
					String obp = observacion[q];
					if(obp.equals("null")){
						obp=null;
					}
					
					//la única sirve para multiple xq guardamos uno a uno
					bAdministrarPublicaciones.crearRespuestaUnica(encuesta, pregunta, op,mujer,obp);
					
				}
				
		
				
			}
		 }
	 
	
}




%>

<input name="hdnExito" type="hidden" value="<%=exito%>"
	id="hdnExito" />







