
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


List<Object[]> cursos = bAdministrarPublicaciones.getActividades(id);

	if (cursos!=null && cursos.size() > 0) {
%>
<table width="100%" border="0" cellspacing="2" cellpadding="2">
	<tr>
		<td bgcolor="#E81D8F">
		<div align="left" style="color:#FFFFFF">ITEM</div>
		</td>
		<td bgcolor="#E81D8F">
		<div align="left" style="color:#FFFFFF">ACTIVIDAD ECONÓMICA</div>
		</td>
		<td bgcolor="#E81D8F">
		<div align="left" style="color:#FFFFFF">NÚMERO DE SALARIOS APROX.</div>
		</td>
		<td bgcolor="#E81D8F">
		<div align="right" style="color:#FFFFFF">INGRESO PROMEDIO SEMANAL</div>
		</td>
		<td bgcolor="#E81D8F">
		<div align="right" style="color:#FFFFFF"></div>
		</td>
		
		
	</tr>
	<%
		int j = 0;
	double suma = 0;
			for (Object[] i : cursos) {
				j++;
				
				String color ="#EEEEEE";
				if(j%2==0){
					color ="#FFFFFF";
				}
				if(i[5]==null){
					i[5]="";
				}else{
					i[5]=": "+i[5];
				}
				
				if(i[4]!=null && ((""+i[4]).trim().equals("1"))){
					i[4]="Entre 0 y 1 salario mínimo";
				}
				if(i[4]!=null && ((""+i[4]).trim().equals("2"))){
					i[4]="Entre 1 y 2 salarios mínimos";
				}
				if(i[4]!=null && ((""+i[4]).trim().equals("3"))){
					i[4]="Entre 2 y 3 salarios mínmos";
				}
				if(i[4]!=null && ((""+i[4]).trim().equals("4"))){
					i[4]="Entre 3 y 4 salarios mínimos";
				}
				if(i[4]!=null && ((""+i[4]).trim().equals("5"))){
					i[4]="Entre 4 y 5 salarios mínmos";
				}
				if(i[4]!=null && ((""+i[4]).trim().equals("6"))){
					i[4]="5 ó más salarios mínmos";
				}
				
	%>  
	<tr >
		<td align="left" bgcolor="<%=color %>"><font color="black"><%=j%></font></td>
		<td align="left" bgcolor="<%=color %>">
		<div align="left"><font color="black"><%=i[6] +" "+ i[5]%></font></div>
		</td>
		<td align="left" bgcolor="<%=color %>">
		<div align="left"><font color="black"><%=i[4]%></font></div>
		</td>
		<td align="right" bgcolor="<%=color %>">
		<div align="right"><font color="black">$ <%=i[3]%></font></div>
		</td>
		<td align="right" bgcolor="<%=color %>"><a href="#" onclick="cargarEliminarActividad('<%=i[0]%>','<%=id %>'); return false;">Eliminar</a></td>  
				
	</tr>
	<%
			suma+=Double.parseDouble(""+i[3]);
		}
			if(j>0){
				j++;
				String color ="#EEEEEE";
				if(j%2==0){
					color ="#FFFFFF";
				}
				%>
				
				<tr >
				<td align="left" bgcolor="<%=color %>" colspan="2"><font color="black"></font></td>
		<td align="left" bgcolor="<%=color %>" ><font color="black"><b>TOTAL INGRESO PROMEDIO SEMANAL =</b></font></td>
		<td align="right" bgcolor="<%=color %>" ><font color="black"><b>$ <%=bAdministrarPublicaciones.getRedondeado(""+suma) %></b></font></td>
		<td align="right" bgcolor="<%=color %>" ></td>
				
	</tr>
				<%
				
			}
	%>
</table>

<%
	} else {
%>
Aún no existen actividades económicas asignadas a la mujer
<%
	}
%>



