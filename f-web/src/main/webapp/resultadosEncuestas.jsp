
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


List<Object[]> cursos = bAdministrarPublicaciones.getEncuestas();

	if (cursos!=null && cursos.size() > 0) {
%>
<table width="100%" border="0" cellspacing="2" cellpadding="2">
	<tr>
		<td bgcolor="#E81D8F">
		<div align="left" style="color:#FFFFFF">ITEM</div>
		</td>
		<td bgcolor="#E81D8F">
		<div align="left" style="color:#FFFFFF">ENCUESTA</div>
		</td>
		<td bgcolor="#E81D8F">
		<div align="center" style="color:#FFFFFF">VIGENCIA</div>
		</td>
		<td bgcolor="#E81D8F">
		<div align="center" style="color:#FFFFFF">ACTIVA ?</div>
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
				if(i[4].equals("S")){
					i[4]="Si";
				}else{
					
					i[4]="No";
				}
				
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
		<div align="center"><font color="black"><%=i[2] + " a "+ i[3] %></font></div>
		</td>
		
		<td align="left" bgcolor="<%=color %>">
		<div align="center"><font color="black"><%=i[4] %> <%if(i[4].equals("No")){ %><a href="#" onclick="activarEncuesta(<%=i[0]%>); return false;">(Activar)</a><% } %></font></div>
		</td>
		<td align="center" bgcolor="<%=color %>" ><%if(i[4].equals("No")){ %><a href="preguntas.jsp?encuesta=<%=i[0] %>&id=<%=i[0]%>&nc=<%=i[1] %>">Preguntas</a><%} %></td>
		
		<td align="center" bgcolor="<%=color %>" ><a href="#" onclick="window.open('/web/estructura.jsp?encuesta=<%=i[0] %>', 'popup', 'toolbar=no, menubar=no, scrollbars=no, resizable=no, width=600, height=400'); return false;" style="text-decoration:none">Ver Diseño</a></td>
		<td align="center" bgcolor="<%=color %>" ><%if(!i[4].equals("No")){ %><a href="#" onclick="window.open('/web/resultado.jsp?encuesta=<%=i[0] %>', 'popup2', 'toolbar=no, menubar=no, scrollbars=no, resizable=no, width=700, height=500'); return false;" style="text-decoration:none">Resultados</a><%} %></td>
		<td align="center" bgcolor="<%=color %>"><%if(i[4].equals("No")){ %><a href="#" onclick="cargarEliminarEncuesta(<%=i[0]%>); return false;">Eliminar</a><%} %></td> 
		
		<td align="center" bgcolor="<%=color %>"><%if(i[4].equals("No")){ %><a href="#" onclick="window.open('/web/editarEncuesta.jsp?id=<%=i[0]%>', 'popup', 'toolbar=no, menubar=no, scrollbars=no, resizable=no, width=650, height=350'); return false;" style="text-decoration:none">Editar</a><%} %></td>
		 
		
	</tr>
	<%
		}
	%>
</table>

<%
	} else {
%>
Aún no existen encuestas creadas en el sistema
<%
	}
%>



