
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
	
String id = request.getParameter("id");
String c = request.getParameter("c");
String fecha_desde = request.getParameter("fecha_desde");
String fecha_hasta = request.getParameter("fecha_hasta");


	int exito = bAdministrarPublicaciones.editarEncuesta(id,c, fecha_desde, fecha_hasta);
%>

<input name="hdnExito" type="hidden" value="<%=exito%>"
	id="hdnExito" />







