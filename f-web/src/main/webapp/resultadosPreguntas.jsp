
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
String preg=request.getParameter("preg");
String encuesta=request.getParameter("encuesta");

List<Object[]> cursos = bAdministrarPublicaciones.getPreguntas(id);

	if (cursos!=null && cursos.size() > 0) {
%>
<table width="100%" border="0" cellspacing="2" cellpadding="2">
	<tr>
		<td bgcolor="#E81D8F" width="4%">
		<div align="left" style="color:#FFFFFF">ITEM</div>
		</td>
		<td bgcolor="#E81D8F" width="70%">  
		<div align="left" style="color:#FFFFFF">PREGUNTA</div>
		</td>
		<td bgcolor="#E81D8F" width="5%">
		<div align="center" style="color:#FFFFFF">TIPO</div>
		</td>
		<td bgcolor="#E81D8F"  width="15%">
		<div align="center" style="color:#FFFFFF"></div>
		</td>
		<td bgcolor="#E81D8F" width="3%">
		<div align="center" style="color:#FFFFFF"></div>
		</td>
		
		<td bgcolor="#E81D8F" width="3%">
		<div align="center" style="color:#FFFFFF"></div>
		</td>
	</tr>
	<%
		int j = 0;
			for (Object[] i : cursos) {
				j++;
			
				/*if(i[3]!=null && i[3].equals("U")){
					i[3]= "UNICA";
				}else if(i[3]!=null && i[3].equals("M")){
					i[3]= "MULTIPLE";
				}
				else if(i[3]!=null && i[3].equals("A")){
					i[3]= "ABIERTA";
				}
				else if(i[3]!=null && i[3].equals("T")){
					i[3]= "TIEMPO";
				}*/
				
				String color ="#EEEEEE";
				if(j%2==0){
					color ="#FFFFFF";
				}
	%>  
	<tr >
		<td align="left" bgcolor="<%=color %>" style="font-size:11px" valign="middle"><font color="black"><%=j%></font></td>
		<td align="left" bgcolor="<%=color %>" valign="top" style="font-size:11px"><%=i[2] %></td>
		<td align="center" bgcolor="<%=color %>" valign="middle" style="font-size:11px"><font color="black"><%=i[3] %></font></td>  
		<td align="center" bgcolor="<%=color %>" valign="middle"  style="font-size:11px"><%if(i[3].equals("U") || i[3].equals("M") ){ %><a href="opcionesRespuestas.jsp?encuesta=<%=encuesta %>&id=<%=i[0]%>&preg=<%=i[0]%>&nc=dfv %>"> Op. respuesta </a><%}else{out.println("- -");} %></td>  
		<td align="center" bgcolor="<%=color %>" valign="middle"  style="font-size:11px"> <a href="#" onclick="cargarEliminarPregunta('<%=i[0]%>','<%=id %>'); return false;"> Eliminar </a> </td>  
		<td align="right" bgcolor="<%=color %>" valign="middle"  style="font-size:11px"> <a href="#" onclick="window.open('/web/editarPregunta.jsp?id=<%=i[1] %>&p=<%=i[0] %>', 'popup', 'toolbar=no, menubar=no, scrollbars=no, resizable=no, width=650, height=450'); return false;" style="text-decoration:none"> Editar </a> </td>
		
	</tr>
	<%
		}
	%>
</table>
*U= ÚNICA RESPUESTA, M=MÚLTIPLE RESPUESTA, A=ABIERTA, T=TIEMPO

<%
	} else {
%>
Aún no existen preguntas creadas para la encuesta
<%
	}
%>



