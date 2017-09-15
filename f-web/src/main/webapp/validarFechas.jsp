
<%
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<%@ page contentType="text/html; charset=iso-8859-1" language="java"
	import="java.sql.*,java.util.*,java.text.*" errorPage=""
	session="false"%>
<%@page import="beans.Portafolio"%>
<jsp:useBean
	id="bAdministrarPublicaciones" class="beans.AdministrarPublicaciones"
	scope="page" />



<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%


String fechaI =request.getParameter("fi");
String fechaF = request.getParameter("ff");
String fechaM = request.getParameter("fm");


String mensaje="";
if(fechaI!=null && fechaF!=null && fechaM!=null && !fechaI.equals("") && !fechaF.equals("") && !fechaM.equals("")){
	
	
	if(fechaF.trim().compareTo(fechaI.trim())<0){
		mensaje+="* LA FECHA FIN DEBE SER MAYOR O IGUAL A LA FECHA INICIO\n";
	}
	
	if(fechaM.trim().compareTo(fechaF.trim())<0){
		mensaje+="* LA FECHA MAXIMA DE LA CERTIFCACION DEBE SER MAYOR O IGUAL A LA FECHA FIN DEL CURSO\n";
	}
	

}



%>

<input type="hidden" value="<%=mensaje %>" id="fechas" name="fechas"> 


