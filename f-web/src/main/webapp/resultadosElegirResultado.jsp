
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
	
	
	%>
	<br/>
	<br/>
	<table cellpadding="20" cellspacing="20">
 
  <tr>
    <td><font color="red"><a href="#"  onclick="cargarOpcionesMujer2();"  style="color: blue; font-size:19px">Conocer aporte</a></font> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
    <td><font color="red"><a href="#" onclick="cargarEncuestasMujer();" style="color: blue; font-size:19px">Contestar/actualizar encuesta</a></font></td>
  </tr>
</table>

	

	
	<%


	
	} else {
%>No existe una mujer con el documento digitado

<%
	}
%>



