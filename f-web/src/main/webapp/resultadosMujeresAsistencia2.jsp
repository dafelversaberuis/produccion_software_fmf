
<%@page import="java.awt.font.NumericShaper"%>
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


String numeroAsistentes=request.getParameter("numero_asistentes");
String curso=request.getParameter("curso");
String fecha=request.getParameter("fecha");
String tema=request.getParameter("tema");
String horas=request.getParameter("horas");
//out.println("curso fecha tema "+curso+" * "+fecha+" * "+tema);



	if (numeroAsistentes!=null && Integer.parseInt(numeroAsistentes) > 0) {
%>
<table width="100%" border="0" cellspacing="2" cellpadding="2">
	<tr>
		<td bgcolor="#E81D8F">
		<div align="left" style="color:#FFFFFF">ITEM</div>
		</td>
		<td bgcolor="#E81D8F">
		<div align="center" style="color:#FFFFFF">NOMBRE*</div>
		</td>
		<td bgcolor="#E81D8F">
		<div align="center" style="color:#FFFFFF">DOCUMENTO*</div>
		</td>
		
		<td bgcolor="#E81D8F">
		<div align="center" style="color:#FFFFFF">LUGAR RESIDENCIA*</div>
		</td>
		
		<td bgcolor="#E81D8F">
		<div align="center" style="color:#FFFFFF">TELEFONOS*</div>
		</td>
		
		<td bgcolor="#E81D8F">
		<div align="center" style="color:#FFFFFF">NOMBRE FUNDACION</div>
		</td>
		
	</tr>
	<%
		int j = 0;
			for (int i=0; i<=Integer.parseInt(numeroAsistentes)-1; i++) {
				j++;
				
	%>  
	<tr > 
		<td align="left" bgcolor="#EEEEEE"><font color="black"><%=j%></font></td>
		<td align="center" bgcolor="#EEEEEE">
		<div align="center"><font color="black"><input type="text" name="nombres<%=j %>" id="nombres<%=j %>" value="" /></font></div>
		</td>
		<td align="center" bgcolor="#EEEEEE">
		<div align="center"><font color="black"><input type="text" name="documento<%=j %>" id="documento<%=j %>" value="" /></font></div>
		</td>
		<td align="center" bgcolor="#EEEEEE">
		<div align="center"><font color="black"><input type="text" name="residencia<%=j %>" id="residencia<%=j %>" value="" /></font></div>
		</td>
		
		<td align="center" bgcolor="#EEEEEE">
		<div align="center"><font color="black"><input type="text" name="telefono<%=j %>" id="telefono<%=j %>" value="" /></font></div>
		</td>
		
		<td align="center" bgcolor="#EEEEEE">
		<div align="center"><font color="black"><input type="text" name="fundacion<%=j %>" id="fundacion<%=j %>" value="" /></font></div>
		</td>
		
	</tr>
	<%
		}
	%>
</table>
<br/>
<input type="hidden" value="1" name="exitoso" id="exitoso">
<input type="hidden" value="<%=numeroAsistentes%>" name="total_asistencia" id="total_asistencia">
<center><font color="black">
<input	type='button' value=' Guardar Asistencia ' onclick='guardarAsistencia2();' /> &nbsp;
<input	type='button' value=' Cancelar registro ' onclick='regresarAsistencia2();' />
<a href="imprimirAsistencia2.jsp?curso=<%=curso %>&fecha=<%=fecha %>&tema=<%=tema %>&horas=<%=horas %>&numero_asistentes=<%=numeroAsistentes %>" target="_blank">(Imprimir formato asistencia)</a>

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



