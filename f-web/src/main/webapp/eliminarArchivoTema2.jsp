
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
	String id = request.getParameter("id");

	Object[] tema = bAdministrarPublicaciones.getTema(id);
	
	String ruta = application.getRealPath("imagenes")+"/archivosTemas2/"+tema[6];

	int actualizo = bAdministrarPublicaciones.eliminarArchivoTema2(id,ruta); 
%>

<input name="hdnElimino2" id="hdnElimino2" type="hidden"
	value="<%=actualizo%>" />


