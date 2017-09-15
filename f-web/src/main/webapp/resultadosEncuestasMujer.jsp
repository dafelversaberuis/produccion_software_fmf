
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

List<Object[]> cursos = bAdministrarPublicaciones.getEncuestasVigentesActivas();

	if (cursos!=null && cursos.size() > 0) {
%>
<table width="100%" border="0" cellspacing="2" cellpadding="2">
	<tr>
		<td bgcolor="#E81D8F">
		<div align="left" style="color:#FFFFFF">ENCUESTA</div>
		</td>
		<td bgcolor="#E81D8F">
		<div align="center" style="color:#FFFFFF">VIGENCIA</div>
		</td>
		<td bgcolor="#E81D8F">
		<div align="center" style="color:#FFFFFF"></div>
		</td>
	</tr>
	<%
		int j = 0;
			for (Object[] i : cursos) {
				j++;
				if(i[4].equals("S")){
					i[4]="Si";
				}else{
					
					i[4]="No";
				}
	%>
	<tr >

		<td align="left" bgcolor="#EEEEEE">
		<div align="left"><font color="black"><%=i[1] %></font></div>
		</td>
		
		<td align="left" bgcolor="#EEEEEE">
		<div align="center"><font color="black"><%=i[2] + " a "+ i[3] %></font></div>
		</td>
		<td align="center" bgcolor="#EEEEEE"><font color="red"><a href="#" onclick="contestarEncuesta(<%=i[0]%>); return false;" style="color: blue">Contestar</a></font></td>  
		
	</tr>
	<%
		}
	%>
</table>



<%}else{%>
	No existen encuestas vigentes
	
	<%
	
}
	%>
	<input type="hidden" id="mujer_recuperada" name="mujer_recuperada" value="<%= mujer[0]%>">
	<%
	
	} else {
%>No existe una mujer con el documento digitado

<%
	}
%>



