
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


List<Object[]> cursos = bAdministrarPublicaciones.getCapacitaciones(id);

	if (cursos!=null && cursos.size() > 0) {
%>
<table width="100%" border="0" cellspacing="2" cellpadding="2">
	<tr>
		<td bgcolor="#E81D8F">
		<div align="left" style="color:#FFFFFF">ITEM</div>
		</td>
		<td bgcolor="#E81D8F">
		<div align="left" style="color:#FFFFFF">CAPACITACIÓN RECIBIDA</div>
		</td>
		<td bgcolor="#E81D8F">
		<div align="left" style="color:#FFFFFF">INSTITUCIÓN</div>
		</td>
		<td bgcolor="#E81D8F">
		<div align="center" style="color:#FFFFFF">TIEMPO</div>
		</td>
		<td bgcolor="#E81D8F">
		<div align="center" style="color:#FFFFFF">PERCEPCIÓN DE CONOCIMIENTO</div>
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
				
				
				if(i[3]==null){
					i[3]="";
				}else{
					i[3]=": "+i[3];
				}
				
				String capaci = "";
				if(i[8]!=null){
					 capaci = ""+i[8];
				}else{
					
					 capaci = ""+i[9];
				}
				
				
				if((""+i[4]).trim().equals("0")){
					i[4]="De 0 a 2 años";
				}
				if((""+i[4]).trim().equals("3")){
					i[4]="De 3 a 5 años";
				}
				if((""+i[4]).trim().equals("5")){
					i[4]="Más 5 años";
				}
				
				
				if((""+i[7]).equals("P")){
					i[7]="Puso en práctica lo aprendido";
				}
				if((""+i[7]).equals("A")){
					i[7]="Aprendió la teoría";
				}
				if((""+i[7]).equals("S")){
					i[7]="Solo asistió";
				}
				
				
				
	%>  
	<tr >
		<td align="left" bgcolor="<%=color %>"><font color="black"><%=j%></font></td>
		<td align="left" bgcolor="<%=color %>">
		<div align="left"><font color="black"><%=capaci +" "+ i[3]%></font></div>
		</td>
		<td align="left" bgcolor="<%=color %>">
		<div align="left"><font color="black"><%= i[6]%></font></div>
		</td>
		<td align="left" bgcolor="<%=color %>">
		<div align="left"><font color="black"><%= i[4]%></font></div>
		</td>
		<td align="left" bgcolor="<%=color %>">
		<div align="left"><font color="black"><%= i[7]%></font></div>
		</td>
		<td align="center" bgcolor="<%=color %>"><a href="#" onclick="cargarEliminarCapacitacion('<%=i[0]%>','<%=id %>'); return false;">Eliminar</a></td>  
				
	</tr>
	<%
		}
	%>
</table>

<%
	} else {
%>
Aún no existen capacitaciones asignadas a la mujer
<%
	}
%>



