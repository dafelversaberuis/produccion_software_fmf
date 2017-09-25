<%@page import="beans.Certificado"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="net.sf.jasperreports.engine.*"%>
<%@ page import="net.sf.jasperreports.engine.JasperCompileManager.*"%>
<%@ page
	import="net.sf.jasperreports.engine.data.JRBeanCollectionDataSource"%>
<%@ page import="java.lang.*,java.util.*,java.text.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.lowagie.text.Image"%>
<jsp:useBean id="bAdministrarPublicaciones"
	class="beans.AdministrarPublicaciones" scope="page" />
	<%@page import="beans.Asistencia"%>
<%
	try {

		String meses[] = { " ", "Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre" };

		String reporte = new String();
		reporte = "listarEncuesta.jasper";
		
		
	    List<Asistencia> listado = new ArrayList<Asistencia>();
		Asistencia p = null;
		String id = request.getParameter("encuesta");

		Object[] encuesta = bAdministrarPublicaciones.getNombreEncuesta(id);

		List<Object[]> preguntas = bAdministrarPublicaciones
				.getPreguntas(id);
		int j = 0;
		if (preguntas != null && preguntas.size() > 0) {
			for (Object[] pregunta : preguntas) {
				p = new Asistencia();
				p.setValor(pregunta);
				
				
				if(pregunta[3].equals("U") || pregunta[3].equals("M")){
					
					List<Object[]> opciones = bAdministrarPublicaciones.getOpciones("" + pregunta[0]);
					if(opciones!=null && opciones.size()>0){
						p.setHijos(new ArrayList<Asistencia>());
						for(Object[] o: opciones){
							Asistencia hijo = new Asistencia();
							hijo.setValor(o);
							p.getHijos().add(hijo);
						}
						
					}
					
					
				}
				
				listado.add(p);
				
			}
			

		
		


		String ruta_servidor_plantilla = request.getRealPath("/reportes/");
		String logo = request.getRealPath("/home_files/");
		Map pars = new HashMap();
		pars.put("variable", "este es el valor");
		pars.put("logo", logo+"/logo_original.png");
		pars.put("encuesta", encuesta);
		pars.put("SUBREPORT_DIR", ruta_servidor_plantilla + "/");

		//

		//Cuando se quiere usar un listado
		// A la linea de bytes el ultimo parametro se cambia por datasource
		// y se descomentarea la siguiente linea y se le pasa el listado armado un List<>
		JRBeanCollectionDataSource dataSource = new JRBeanCollectionDataSource(listado);

		//Si se quiere usar una conexion se pasa como parmetro un objeto de conexion this.con ó
		//Connection conexion algo asi
		// y el ultimo parametro se de bytes se cambia por la conexion

		//Si solo son parametros, sin conexion ni lista solo como ultimo parametro en la
		//linea de bytes lo siguiente: new JREmptyDataSource()

		byte[] bytes = JasperRunManager.runReportToPdf( ruta_servidor_plantilla+ "/" + reporte, pars, dataSource);

		/*Indicamos que la respuesta va a ser en formato PDF*/

		response.setContentType("application/pdf");
		response.setContentLength(bytes.length);
		ServletOutputStream ouputStream = response.getOutputStream();
		ouputStream.write(bytes, 0, bytes.length);

		/*Limpiamos y cerramos flujos de salida*/

		ouputStream.flush();
		ouputStream.close();

		}else{
			out.println("NO SE PUEDE MOSTRAR REPORTE");
			
		}

	} catch (Exception e) {
		out.println("NO SE PUEDE MOSTRAR REPORTE");
	}
%>