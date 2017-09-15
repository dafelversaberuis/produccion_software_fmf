
<%@page import="beans.Seccion"%>
<%
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<%@ page language="java" contentType="text/html; charset=iso-8859-1" import="java.sql.*,java.util.*,java.text.SimpleDateFormat"
     session="false" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<jsp:useBean
	id="bAdministrarPublicaciones" class="beans.AdministrarPublicaciones"
	scope="page" />



<%


List<Object[]> parametrosGlobales = bAdministrarPublicaciones.getParametrosGlobales();

	if (parametrosGlobales!=null && parametrosGlobales.size() > 0) {
%>
<table width="100%" border="0" cellspacing="2" cellpadding="2">
	<tr>
		<td bgcolor="#E81D8F">
		<div align="center" style="color:#FFFFFF">NOMBRE PARAMETRO</div>
		</td>
		<td bgcolor="#E81D8F">
		<div align="center" style="color:#FFFFFF">VALOR</div>
		</td>
		
		<td bgcolor="#E81D8F">
		<div align="center" style="color:#FFFFFF"></div>
		</td>
	</tr>   
	<%
		int j = 0;
			for (Object[] i : parametrosGlobales) {
				j++;
	%>
	<tr class="campos">
		<td align="center"  bgcolor="#EEEEEE"><font color="black"><input type="text" style="width: 350px;" value="<%=i[1]%>" id="titulo<%=j%>" name="titulo<%=j%>"/></font><input type="hidden" value="<%=i[0]%>" id="parametro<%=j%>" name="parametro<%=j%>"/> </font></td>
		<td align="center"  bgcolor="#EEEEEE">
		<div align="center"><font color="black"><input type="text" style="width: 100px" value="<%=i[2]%>" id="valor<%=j%>" name="valor<%=j%>"/></font></div>
		</td>
		
		<td align="center"  bgcolor="#EEEEEE"><a href="#" onclick="cargarEliminarParametro('<%=i[0] %>'); return false;">
		
		<%if(!(""+i[0]).equals("3") && !(""+i[0]).equals("19") && !(""+i[0]).equals("20") && !(""+i[0]).equals("21") && !(""+i[0]).equals("22") ){ %>
		
		Eliminar
		
		<%} %>
		</a></td>
		
	</tr>
	<%
		}
	%>
</table>
<input type="hidden" value="<%= parametrosGlobales.size()%>" name="total" id="total">
<br><br>
<center>
<% if(parametrosGlobales!=null && parametrosGlobales.size()>0){ %>
<font color="black"><input type="button" value=" ACTUALIZAR INFORMACION "
														onclick="document.getElementById('hdnGuardarPublicacion').value='1'; fparametrosupdate();" id="btnGuardar"
														name="btnGuardar" /></font>
</center>


<%}
	} else {
%>
Aún no existen parámetros creados
<%
	}
%>



