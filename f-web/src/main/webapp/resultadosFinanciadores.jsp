
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


List<Object[]> cursos = bAdministrarPublicaciones.getFinanciadores();

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
		<div align="left" style="color:#FFFFFF"></div>
		</td>
		<td bgcolor="#E81D8F">
		<div align="left" style="color:#FFFFFF"></div>
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
		<div align="left"><font color="black"><%=i[1] %></font></div>
		</td>
		<td align="left" bgcolor="<%=color %>">
		<%if(i[2].equals("S")){ %><a href="#" onclick="window.open('/web/verLogo.jsp?id=<%=i[0]%>', 'popup', 'toolbar=no, menubar=no, scrollbars=no, resizable=no, width=650, height=350'); return false;" style="text-decoration:none">Ver logo</a><%  }else{%> <a href="#" onclick="window.open('/web/subirLogo.jsp?id=<%=i[0]%>', 'popup', 'toolbar=no, menubar=no, scrollbars=no, resizable=no, width=650, height=350'); return false;" style="text-decoration:none">Cargar nuevo logo</a><% } %>
		</td>
		<td align="left" bgcolor="<%=color %>">
		<div align="left"><font color="black"><%if(i[2].equals("S")){ %> <a href="#" onclick="cargarEliminarLogoFinanciador('<%=i[0]%>'); return false;">Eliminar logo</a> <%  } %></font></div>
		</td>
		<td align="center" bgcolor="<%=color %>"><a href="#" onclick="cargarEliminarFinanciador('<%=i[0]%>'); return false;">Eliminar financiador</a></td>  
		
	</tr>
	<%
		}
	%>
</table>

<%
	} else {
%>
Aún no existen financiadores creados en el sistema
<%
	}
%>



