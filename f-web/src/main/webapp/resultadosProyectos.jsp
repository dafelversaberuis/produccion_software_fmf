
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


List<Object[]> cursos = bAdministrarPublicaciones.getProyectos();

	if (cursos!=null && cursos.size() > 0) {
%>
<table width="100%" border="0" cellspacing="2" cellpadding="2">
	<tr>
		<td bgcolor="#E81D8F">
		<div align="left" style="color:#FFFFFF">ITEM</div>
		</td>
		<td bgcolor="#E81D8F">
		<div align="left" style="color:#FFFFFF">PROYECTO</div>
		</td>
		<td bgcolor="#E81D8F">
		<div align="center" style="color:#FFFFFF"></div>
		</td>
		
	</tr>
	<%
		int j = 0;
			for (Object[] i : cursos) {
				j++;
	%>
	<tr >
		<td align="left" bgcolor="#EEEEEE"><font color="black"><%=j%></font></td>
		<td align="left" bgcolor="#EEEEEE">
		<div align="left"><font color="black"><%=i[1] %></font></div>
		</td>
		<td align="center" bgcolor="#EEEEEE"><a href="#" onclick="cargarEliminarProyecto('<%=i[0]%>'); return false;">Eliminar</a></td>  
		
	</tr>
	<%
		}
	%>
</table>

<%
	} else {
%>
A�n no existen proyectos creados en el sistema
<%
	}
%>



