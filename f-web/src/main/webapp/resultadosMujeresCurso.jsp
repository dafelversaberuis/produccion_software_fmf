
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


List<Object[]> cursos = bAdministrarPublicaciones.getMujeresCurso(id);

	if (cursos!=null && cursos.size() > 0) {
%>
<table width="100%" border="0" cellspacing="2" cellpadding="2">
	<tr>
		<td bgcolor="#E81D8F">
		<div align="left" style="color:#FFFFFF">ITEM</div>
		</td>
		<td bgcolor="#E81D8F">
		<div align="left" style="color:#FFFFFF">NOMMBRE</div>
		</td>
		<td bgcolor="#E81D8F">
		<div align="left" style="color:#FFFFFF">DOCUMENTO</div>
		</td>
		
		<td bgcolor="#E81D8F">
		<div align="left" style="color:#FFFFFF">TELEFONOS</div>
		</td>
		
		<td bgcolor="#E81D8F">
		<div align="left" style="color:#FFFFFF">INSCRITA</div>
		</td>
		<td bgcolor="#E81D8F">
		<div align="center" style="color:#FFFFFF"></div>
		</td>
	</tr>
	<%
		int j = 0;
			for (Object[] i : cursos) {
				j++;
				if(i[2]==null){
					i[2]= "";
				}
				if(i[4]==null){
					i[4]= "";
				}
				
				if(i[7]==null){
					i[7]= "";
				}
	%>  
	<tr >
		<td align="left" bgcolor="#EEEEEE"><font color="black"><%=j%></font></td>
		<td align="left" bgcolor="#EEEEEE">
		<div align="left"><font color="black"><%=i[1]+" "+i[2]+" "+i[3] + " " + i[4] %></font></div>
		</td>
		<td align="left" bgcolor="#EEEEEE">
		<div align="left"><font color="black"><%=i[5] %></font></div>
		</td>
		
		<td align="left" bgcolor="#EEEEEE">
		<div align="left"><font color="black"><%=i[8] %></font></div>
		</td>
		
		<td align="left" bgcolor="#EEEEEE">
		<div align="left"><font color="black"><% if(i[9].equals("S")){ out.println("Si"); }else{  out.println("No");} %></font></div>
		</td>
		<td align="center" bgcolor="#EEEEEE"><a href="#" onclick="cargarEliminarMC('<%=i[0]%>','<%=id %>'); return false;">Eliminar</a></td>  
		
	</tr>
	<%
		}
	%>
</table>

<%
	} else {
%>
Aún no existen mujeres inscritas en el curso
<%
	}
%>



