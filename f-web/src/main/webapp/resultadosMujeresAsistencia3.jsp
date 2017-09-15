
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

String curso=request.getParameter("curso");
String tema=request.getParameter("tema");
String fecha_desde=request.getParameter("fecha_desde");
String fecha_hasta=request.getParameter("fecha_hasta");
String tipo=request.getParameter("tipo");
String asistio_mujer =request.getParameter("asistio_mujer");
String proyecto =request.getParameter("proyecto");
String linea =request.getParameter("linea");
String financiador =request.getParameter("financiador");
String documento =request.getParameter("documento");



// out.println(proyecto+"*"+linea+"*"+financiador+"*"+documento);
  
List<Object[]> cursos = bAdministrarPublicaciones.getMujeresAsistencia3(curso, tema, fecha_desde, fecha_hasta, tipo, asistio_mujer, proyecto,linea,financiador,documento);

	if (cursos!=null && cursos.size() > 0) {
%>
<table width="100%" border="0" cellspacing="2" cellpadding="2">
	<tr>
		<td bgcolor="#E81D8F" style="font-size:11px">
		<div align="left" style="color:#FFFFFF">FECHA</div>
		</td>
		
		<td bgcolor="#E81D8F" style="font-size:11px">
		<div align="left" style="color:#FFFFFF">CURSO</div>
		</td>
		
		
		<td bgcolor="#E81D8F" style="font-size:11px">
		<div align="left" style="color:#FFFFFF">TEMA</div>
		</td>
		
		<td bgcolor="#E81D8F" style="font-size:11px">
		<div align="left" style="color:#FFFFFF">PROYECTO</div>
		</td>
		
		<td bgcolor="#E81D8F" style="font-size:11px">
		<div align="left" style="color:#FFFFFF">LÍNEA</div>
		</td>
		
		<td bgcolor="#E81D8F" style="font-size:11px">
		<div align="left" style="color:#FFFFFF">FINANCIADOR</div>
		</td>
		
		<td bgcolor="#E81D8F" style="font-size:11px">
		<div align="left" style="color:#FFFFFF">NOMBRE</div>
		</td>
		<td bgcolor="#E81D8F" style="font-size:11px">
		<div align="left" style="color:#FFFFFF">DOCUMENTO</div>
		</td>
		
		
		
		<td bgcolor="#E81D8F" style="font-size:11px">
		<div align="left" style="color:#FFFFFF">INSCRITA</div>
		</td>
	
		
		<td bgcolor="#E81D8F" style="font-size:11px">
		<div align="right" style="color:#FFFFFF">HORAS</div>
		</td>
		
		<td bgcolor="#E81D8F" style="font-size:11px">
		<div align="center" style="color:#FFFFFF">ASISTIO ?</div>
		</td>
		
		
		<td bgcolor="#E81D8F" style="font-size:11px">
		<div align="center" style="color:#FFFFFF"></div>
		</td>
	</tr>
	<%
		int j = 0;
	
	int cuenta_si = 0;
	int cuenta_no = 0;
	int cuenta_todas = 0;
			for (Object[] i : cursos) {
				cuenta_todas++;
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
				
				String color ="#EEEEEE";
				if(j%2==0){
					color ="#FFFFFF";
				}
	%>  
	<tr >
		
		
		<td align="left" bgcolor="<%=color %>" style="font-size:11px">
		<div align="left" ><font color="black"><%=i[14] %></font></div>
		</td>
		
		
		<td align="left" bgcolor="<%=color %>" style="font-size:11px">
		<div align="left"><font color="black"><%=i[13] %></font></div>
		</td>
		
		
		<td align="left" bgcolor="<%=color %>" style="font-size:11px">
		<div align="left"><font color="black"><%=i[12] %></font></div>
		</td>
		
		<td align="left" bgcolor="<%=color %>" style="font-size:11px">
		<div align="left"><font color="black"><%=i[16]  %></font></div>
		</td>
		<td align="left" bgcolor="<%=color %>" style="font-size:11px">
		<div align="left"><font color="black"><%=i[17]  %></font></div>
		</td>
		<td align="left" bgcolor="<%=color %>" style="font-size:11px">
		<div align="left"><font color="black"><%=i[18]  %></font></div>
		</td>
		
		<td align="left" bgcolor="<%=color %>" style="font-size:11px">
		<div align="left"><font color="black"><%=i[1]+" "+i[2]+" "+i[3] + " " + i[4] %></font></div>
		</td>
		<td align="left" bgcolor="<%=color %>" style="font-size:11px">
		<div align="left"><font color="black"><%=i[5] %></font></div>
		</td>
	
		
		
		
		<td align="left" bgcolor="<%=color %>" style="font-size:11px">
		<div align="left"><font color="black"><% if(i[10]!=null && i[10].equals("S")){ out.println("Si"); }else{  out.println("No");} %></font></div>
		</td>
		
		
		
		<td align="right" bgcolor="<%=color %>" style="font-size:11px">
		<div align="right"><font color="black"><%=i[15] %></font></div>
		</td>  
		
		<td align="center" bgcolor="<%=color %>" style="font-size:11px">
		<div align="center"><font color="black"><% if(i[11]!=null && i[11].equals("Si")){ cuenta_si++;; }else{  cuenta_no++;} %>	<%=i[11] %></font></div>
		</td>  
		
		<td align="center" bgcolor="<%=color %>"><a href="#" onclick="cargarEliminarAsistencia(<%=i[0]%>); return false;">Eliminar</a></td>  
		
	</tr>
	<%
		}
	%>
</table>
<br/>
Participantes: <%=cuenta_todas %>
<br/>
Asistentes: <%=cuenta_si %>
<br/>
No asitentes: <%=cuenta_no %>
<br/>
<br/>
<input type="hidden" value="1" name="exitoso" id="exitoso">
<input type="hidden" value="<%=cursos.size()%>" name="total_asistencia" id="total_asistencia">
<center><font color="black">
<input	type='button' value='Limpiar ' onclick='regresarAsistencia3();' />
<a href="imprimirAsistencia3.jsp?curso=<%=curso %>&tema=<%=tema %>&fecha_desde=<%= fecha_desde%>&fecha_hasta=<%=fecha_hasta %>&tipo=<%= tipo %>&asistio_mujer=<%=asistio_mujer %>&proyecto=<%=proyecto %>&linea=<%=linea %>&financiador=<%=financiador %>&documento=<%=documento %>" target="_blank">(Imprimir asistencia registrada)</a>
</font>
</center>


<%
	} else {
%>
No existen registros
<br/>
<input type="hidden" value="0" name="exitoso" id="exitoso">


<%
	}
	
	
%>



