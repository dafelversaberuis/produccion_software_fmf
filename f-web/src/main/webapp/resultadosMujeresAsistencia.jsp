
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
String fecha=request.getParameter("fecha");
String tema=request.getParameter("tema");
String horas=request.getParameter("horas");

String financiador=request.getParameter("financiador");
String linea=request.getParameter("linea");

//out.println("curso fecha tema "+curso+" * "+fecha+" * "+tema);

List<Object[]> cursos = bAdministrarPublicaciones.getMujeresAsistencia(curso, tema, fecha);

	if (cursos!=null && cursos.size() > 0) {
%>
<table width="100%" border="0" cellspacing="2" cellpadding="2">
	<tr>
		<td bgcolor="#E81D8F">
		<div align="left" style="color:#FFFFFF">ITEM</div>
		</td>
		<td bgcolor="#E81D8F">
		<div align="left" style="color:#FFFFFF">NOMBRE</div>
		</td>
		<td bgcolor="#E81D8F">
		<div align="left" style="color:#FFFFFF">SEXO</div>
		</td>
		<td bgcolor="#E81D8F">
		<div align="left" style="color:#FFFFFF">EDAD</div>
		</td>
		<td bgcolor="#E81D8F">
		<div align="left" style="color:#FFFFFF">ETNIA</div>
		</td>
		<td bgcolor="#E81D8F">
		<div align="left" style="color:#FFFFFF">DOCUMENTO</div>
		</td>
		
		<td bgcolor="#E81D8F">
		<div align="left" style="color:#FFFFFF">BARRIO/COMUNA</div>
		</td>
		
		<td bgcolor="#E81D8F">
		<div align="left" style="color:#FFFFFF">TELEFONO</div>
		</td>
		
		<td bgcolor="#E81D8F">
		<div align="left" style="color:#FFFFFF">INSCRITA</div>
		</td>
		<td bgcolor="#E81D8F">
		<div align="center" style="color:#FFFFFF">ASISTIO ?</div>
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
		<div align="left"><font color="black"><%=i[11] %></font></div>
		</td>
		
		<td align="left" bgcolor="#EEEEEE">
		<div align="left"><font color="black"><%=i[12] %></font></div>
		</td>
		
		<td align="left" bgcolor="#EEEEEE">
		<div align="left"><font color="black"><%=i[6] %></font></div>
		</td>
		
		<td align="left" bgcolor="#EEEEEE">
		<div align="left"><font color="black"><%=i[5] %></font></div>
		</td>
		
		<td align="left" bgcolor="#EEEEEE">
		<div align="left"><font color="black"><%=i[10] %></font></div>
		</td>
		
		
		<td align="left" bgcolor="#EEEEEE">
		<div align="left"><font color="black"><%=i[8] %></font></div>
		</td>
		
		<td align="left" bgcolor="#EEEEEE">
		<div align="left"><font color="black"><% if(i[9].equals("S")){ out.println("Si"); }else{  out.println("No");} %></font></div>
		</td>
		<td align="center" bgcolor="#EEEEEE"><input type="hidden" value="<%=i[0]%>" name="mujer_curso<%=j %>" id="mujer_curso<%=j %>"><input type="checkbox" name="asistio<%=j %>" id="asistio<%=j %>" value="S" ></td>  
		
	</tr>
	<%
		}
	%>
</table>
<br/>
<input type="hidden" value="1" name="exitoso" id="exitoso">
<input type="hidden" value="<%=cursos.size()%>" name="total_asistencia" id="total_asistencia">
<center><font color="black">
<input	type='button' value=' Guardar Asistencia ' onclick='guardarAsistencia();' /> &nbsp;
<input	type='button' value=' Cancelar registro ' onclick='regresarAsistencia();' /> &nbsp;
<a href="imprimirAsistencia.jsp?curso=<%=curso %>&fecha=<%=fecha %>&tema=<%=tema %>&horas=<%=horas %>&linea=<%=linea %>&financiador=<%=financiador %>" target="_blank">(Imprimir formato asistencia)</a>


</font>
</center>


<%
	} else {
%>
No existen mujeres pendientes por tomarles asistencia
<br/>
<input type="hidden" value="0" name="exitoso" id="exitoso">

<%
	}
	
	
%>



