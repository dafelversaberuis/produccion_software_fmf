
<%
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<%@ page language="java" contentType="text/html; charset=iso-8859-1" import="java.sql.*,java.util.*,java.text.SimpleDateFormat"
     session="false" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
String idiomaSoftware = new beans.AdministrarPublicaciones().getIdioma();
%>
<%@page import="beans.Administrador"%>
<jsp:useBean
	id="bAdministrarPublicaciones" class="beans.AdministrarPublicaciones"
	scope="page" />




<%

String id=request.getParameter("id");


List<Object[]> cursos = bAdministrarPublicaciones.getTemas(id);

	if (cursos!=null && cursos.size() > 0) {
%>
<table width="100%" border="0" cellspacing="2" cellpadding="2">
	<tr>
		<td bgcolor="#E81D8F" style="font-size:11px">
		<div align="left" style="color:#FFFFFF">ITEM</div>
		</td>
		<td bgcolor="#E81D8F" style="font-size:11px">
		<div align="left" style="color:#FFFFFF">TEMA DEL CURSO</div>
		</td>
		<td bgcolor="#E81D8F" style="font-size:11px">
		<div align="center" style="color:#FFFFFF"></div>
		</td>
		<td bgcolor="#E81D8F" style="font-size:11px">
		<div align="center" style="color:#FFFFFF"></div>
		</td>
		<td bgcolor="#E81D8F" style="font-size:11px">
		<div align="center" style="color:#FFFFFF"></div>
		</td>
		<td bgcolor="#E81D8F" style="font-size:11px">
		<div align="center" style="color:#FFFFFF"></div>
		</td>
		<td bgcolor="#E81D8F" style="font-size:11px">
		<div align="center" style="color:#FFFFFF"></div>
		</td>
		<td bgcolor="#E81D8F" style="font-size:11px">
		<div align="center" style="color:#FFFFFF"></div>
		
		<td bgcolor="#E81D8F" style="font-size:11px">
		<div align="center" style="color:#FFFFFF"></div>
		</td>
		<td bgcolor="#E81D8F" style="font-size:11px">
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
		<div align="left"><font color="black"><%=i[1] %></font></div>
		</td>
		<td align="left" bgcolor="<%=color %>" style="font-size:11px"> 
		<%
	
		//el viejo
		//imagenes/archivosTemas/<%=i[3]
				
				//cambio por www.spicol.com/fmf/<%=i[3]
				
				
		
		
		
		if(i[3]!=null && !i[3].equals("")){ if(i[4]!=null){%><a href="/f-web/ver_archivo_adjunto.jsp?id=<%=i[0] %>" target="_blank" style="text-decoration:none">Ver archivo 1</a><%}else{ %><a href="http://www.spicol.com/fmf/<%=i[3] %>" target="_blank" style="text-decoration:none">Ver archivo 1</a><%}  }else{%> <a href="#" onclick="window.open('/f-web/subirArchivoTema.jsp?id=<%=i[0]%>', 'popup', 'toolbar=no, menubar=no, scrollbars=no, resizable=no, width=650, height=350'); return false;" style="text-decoration:none">Cargar archivo 1</a><% } %>
		</td>  
		
		
		
		<td align="center" bgcolor="<%=color %>" style="font-size:11px"><%if(i[3]!=null && !i[3].equals("")){ %><a href="#" onclick="cargarEliminarArchivoTema('<%=i[0]%>','<%=id %>'); return false;">Eliminar archivo 1</a><% } %></td>
		
		
		<td align="left" bgcolor="<%=color %>" style="font-size:11px"> 
		<%
		
		if(i[6]!=null && !i[6].equals("")){
			if(i[7]!=null){
			%>
			<a href="/f-web/ver_archivo_adjunto2.jsp?id=<%=i[0] %>" target="_blank" style="text-decoration:none">Ver archivo 2</a>
			<%}else{ %>
		-
			<%}  }else{%>
			 <a href="#" onclick="window.open('/f-web/subirArchivoTema2.jsp?id=<%=i[0]%>', 'popup', 'toolbar=no, menubar=no, scrollbars=no, resizable=no, width=650, height=350'); return false;" style="text-decoration:none">Cargar archivo 2</a>
			 <% } %>
		</td> 
		
		<td align="center" bgcolor="<%=color %>" style="font-size:11px"><%if(i[6]!=null && !i[6].equals("")){ %><a href="#" onclick="cargarEliminarArchivoTema2('<%=i[0]%>','<%=id %>'); return false;">Eliminar archivo 2</a><% } %></td>
		
		<td align="left" bgcolor="<%=color %>" style="font-size:11px"> 
		<%
		
		if(i[9]!=null && !i[9].equals("")){
			if(i[10]!=null){
			%>
			<a href="/f-web/ver_archivo_adjunto3.jsp?id=<%=i[0] %>" target="_blank" style="text-decoration:none">Ver archivo 3</a>
			<%}else{ %>
		-
			<%}  }else{%>
			 <a href="#" onclick="window.open('/f-web/subirArchivoTema3.jsp?id=<%=i[0]%>', 'popup', 'toolbar=no, menubar=no, scrollbars=no, resizable=no, width=650, height=350'); return false;" style="text-decoration:none">Cargar archivo 3</a>
			 <% } %>
		</td> 
		<td align="center" bgcolor="<%=color %>" style="font-size:11px"><%if(i[9]!=null && !i[9].equals("")){ %><a href="#" onclick="cargarEliminarArchivoTema3('<%=i[0]%>','<%=id %>'); return false;">Eliminar archivo 3</a><% } %></td>
		
		<td align="center" bgcolor="<%=color %>" style="font-size:11px"><a href="#" onclick="cargarEliminarTema('<%=i[0]%>','<%=id %>'); return false;">Eliminar tema</a></td>  
		<td align="center" bgcolor="<%=color %>" style="font-size:11px"><a href="#" onclick="window.open('/f-web/editarTema.jsp?id=<%=i[0]%>', 'popup', 'toolbar=no, menubar=no, scrollbars=no, resizable=no, width=500, height=350'); return false;" style="text-decoration:none">Editar tema</a></td>		
	</tr>
	<%
		}
	%>
</table>

<%
	} else {
%>
Aún no existen temas creados para el curso
<%
	}
%>



