
<%
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<%@ page language="java" contentType="text/html; charset=iso-8859-1" import="java.sql.*,java.util.*,java.text.SimpleDateFormat"
     session="false" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="beans.Administrador"%>
<jsp:useBean
	id="bAdministrarPublicaciones" class="beans.AdministrarPublicaciones"
	scope="page" />




<%

String id=request.getParameter("id");


List<Object[]> cursos = bAdministrarPublicaciones.getOpciones(id);

	if (cursos!=null && cursos.size() > 0) {
%>
<table width="100%" border="0" cellspacing="2" cellpadding="2">
	<tr>
		<td bgcolor="#E81D8F">
		<div align="left" style="color:#FFFFFF">ITEM</div>
		</td>
		<td bgcolor="#E81D8F">
		<div align="left" style="color:#FFFFFF">OPCION DE RESPUESTA</div>
		</td>
		<td bgcolor="#E81D8F">
		<div align="center" style="color:#FFFFFF">JUSTIFICABLE</div>
		</td>
		<td bgcolor="#E81D8F">
		<div align="center" style="color:#FFFFFF"></div>
		</td>
		
		<td bgcolor="#E81D8F">
		<div align="center" style="color:#FFFFFF"></div>
		</td>
		
		<td bgcolor="#E81D8F">
		<div align="center" style="color:#FFFFFF"></div>
		</td>
	</tr>
	<%
		int j = 0;
			for (Object[] i : cursos) {
				j++;
				
				String color ="#EEEEEE";
				if(j%2==0){
					color ="#FFFFFF";
				}
	%>  
	<tr >
		<td align="left" bgcolor="<%=color %>" style="font-size:11px"><font color="black"><%=j%></font></td>
		<td align="left" bgcolor="<%=color %>" style="font-size:11px">
		<div align="left"><font color="black"><%=i[2] %></font></div>
		</td>
		<td align="left" bgcolor="<%=color %>" style="font-size:11px">
		<div align="center" style="font-size:11px"><font color="black"><%if(i[3].equals("N")){out.println("NO");}else{out.println("SI");} %></font></div>
		</td>
		<td align="center" style="font-size:11px" bgcolor="<%=color %>"><a href="#" onclick="cargarEliminarOpcion('<%=i[0]%>','<%=id %>'); return false;">Eliminar</a></td>
		<td align="center"style="font-size:11px" bgcolor="<%=color %>"><a href="#" onclick="window.open('/web/editarOpcion.jsp?id=<%=i[0]%>', 'popup', 'toolbar=no, menubar=no, scrollbars=no, resizable=no, width=650, height=500'); return false;" style="text-decoration:none">Editar</a></td>    
		
	</tr>
	<%
		}
	%>
</table>

<%
	} else {
%>
Aún no existen opciones de respuesta creadas para la pregunta
<%
	}
%>



