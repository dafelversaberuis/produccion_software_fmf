
<%
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<%@ page contentType="text/html; charset=iso-8859-1" language="java"
	import="java.sql.*,java.util.*,java.text.SimpleDateFormat" errorPage=""
	session="false"%>
<%@page import="beans.Administrador"%>
<jsp:useBean
	id="bAdministrarPublicaciones" class="beans.AdministrarPublicaciones"
	scope="page" />



<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
String idiomaSoftware = new beans.AdministrarPublicaciones().getIdioma();
%>
<%

String documento_mujer = request.getParameter("documento_mujer");

Object[] mujer = bAdministrarPublicaciones.getMujerDoc(documento_mujer);
if(mujer!=null){
	
	if(mujer[2]==null){
		mujer[2]= "";
	}
	if(mujer[4]==null){
		mujer[4]= "";
	}

	out.println("<br/>Hola "+ mujer[1] + " " + mujer[2] + " " + mujer[3] + " "+ mujer[4] +" ! ");
	
	List<Object[]> encuestas = bAdministrarPublicaciones.getEncuestas();
	%>
	<br/>
	<br/>
	Elija la encuesta a la que aplicó y presione mostrar aporte:
		<br/>
	
	<select name="encuesta" id="encuesta"
									style="width: 400px">
									<option value="">Seleccione</option>
									<%
										if (encuestas != null && encuestas.size() > 0) {
											for (Object[] o : encuestas) {
									%>
									<option value="<%=o[0]%>"><%=o[1] + " (" + o[2] + " a " + o[3] + ")"%></option>

									<%
										}
										}
									%>


								</select>
	<br/>
<input type="button" onclick="cargarResultadosOJO2()"
										value=" MOSTRAR APORTE ">
	
	<%


	
	} else {
%>No existe una mujer con el documento digitado

<%
	}
%>



