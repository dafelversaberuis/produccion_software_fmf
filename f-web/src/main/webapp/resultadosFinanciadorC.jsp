
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

//out.println("***"+id);
List<Object[]> cursos = bAdministrarPublicaciones.getFinanciadoresCurso(id);

	if (cursos!=null && cursos.size() > 0) {
%>
<table width="100%" border="0" cellspacing="2" cellpadding="2">
	<tr>
		<td bgcolor="#E81D8F">
		<div align="left" style="color:#FFFFFF">ITEM</div>
		</td>
		<td bgcolor="#E81D8F">
		<div align="left" style="color:#FFFFFF">FINANCIADOR</div>
		</td>
		<td bgcolor="#E81D8F">
		<div align="right" style="color:#FFFFFF">% PARTICIPACIÓN</div>
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
		<td align="left" bgcolor="<%=color %>"><font color="black"><%=j%></font></td>
		<td align="left" bgcolor="<%=color %>">
		<div align="left"><font color="black"><%=i[4] %></font></div>
		</td>
		<td align="right" bgcolor="<%=color %>">
		<div align="right"><font color="black"><input type="hidden" value="<%=i[0] %>" name="parametro<%=j%>"  name="parametro<%=j%>"/><input type="text" value="<%=i[3] %>" style="width:70px; text-align: right;" id="valor<%=j%>" name="valor<%=j%>"/></font></div>
		</td>
		<td align="center" bgcolor="<%=color %>"><a href="#" onclick="cargarEliminarFinanciadorC('<%=i[0]%>','<%=id %>'); return false;">Eliminar</a></td>  
				
	</tr>
	<%
		}
	%>
</table>

<input type="hidden" value="<%= cursos.size()%>" name="total" id="total">

<center>
<br/>
<% if(cursos!=null && cursos.size()>0){ %>
<font color="black"><a href="#"
														onclick="document.getElementById('hdnGuardarPublicacion').value='1'; fparametrosupdateCurso();" id="btnGuardar"
														name="btnGuardar" >(ACTUALIZAR PORCENTAJES)</a></font>
</center>

<%}
	} else {
%>
Aún no existen financiadores agregadas a el curso
<%
	}
%>



