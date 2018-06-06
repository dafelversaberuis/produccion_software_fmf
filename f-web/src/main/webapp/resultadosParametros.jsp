
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

Object[] logos = bAdministrarPublicaciones.getLogosss();

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
				
				if(j==0){
					
					%>
					<tr class="campos">
						<td align="center"  bgcolor="#EEEEEE"><font color="black"><input type="text" style="width: 350px; background-color: #D1D6E2;" value="***Logo del software***"  readonly="true" /></td>
						<td align="center"  bgcolor="#EEEEEE"><font color="black"><%if(logos[2].equals("S")){ %><a href="#" onclick="window.open('/f-web/verLogoLogo.jsp?id=<%=logos[0]%>', 'popup', 'toolbar=no, menubar=no, scrollbars=no, resizable=no, width=650, height=350'); return false;" style="text-decoration:none">Ver logo</a><%  }else{%> <a href="#" onclick="window.open('/f-web/subirLogoLogo.jsp?id=<%=logos[0]%>', 'popup', 'toolbar=no, menubar=no, scrollbars=no, resizable=no, width=650, height=350'); return false;" style="text-decoration:none">Cargar nuevo logo</a><% } %></font></font></td>
						<td align="center"  bgcolor="#EEEEEE"><font color="black"><font color="black"><%if(logos[2].equals("S")){ %> <a href="#" onclick="cargarEliminarLogoLogo('<%=logos[0]%>'); return false;">Eliminar logo</a> <%  } %></font></font></td>
						
						</tr>
					
					<%
					
				}
				
				
				
				j++;
	%>
	<tr class="campos">
		<td align="center"  bgcolor="#EEEEEE"><font color="black">
		<%if((""+i[0]).equals("24") || (""+i[0]).equals("25") || (""+i[0]).equals("26")){ %>
		<input type="text" style="width: 350px; background-color: #D1D6E2;" value="<%=i[1]%>" id="titulo<%=j%>" name="titulo<%=j%>" readonly="true" />
		<%}else{ %>
		<input type="text" style="width: 350px;" value="<%=i[1]%>" id="titulo<%=j%>" name="titulo<%=j%>"/>
		<%} %>
		</font><input type="hidden" value="<%=i[0]%>" id="parametro<%=j%>" name="parametro<%=j%>"/> </font></td>
		<td align="center"  bgcolor="#EEEEEE">
		<div align="center"><font color="black">
		<% if((""+i[0]).equals("24")){%>
			<select id="valor<%=j%>" name="valor<%=j%>" style="width:100px">
		<%if(i[2]!=null && i[2].equals("E")){
			%>
			<option value="E" selected>Español</option>
			<%
		}else{
			%>
			<option value="E">Español</option>
			<%
		}
		%>
		
		<%if(i[2]!=null && i[2].equals("I")){
			%>
			<option value="I" selected>Inglés</option>
			<%
		}else{
			%>
			<option value="I">Inglés</option>
			<%
		}
		%>
			
		
			</select>
		
		<%
		} else if((""+i[0]).equals("25")){
			%>
	<select id="valor<%=j%>" name="valor<%=j%>" style="width:100px" onchange="cambiarAnual()">
		<%if(i[2]!=null && i[2].equals("C")){
			%>
			<option value="C" selected>Colombia</option>
			<%
		}else{
			%>
			<option value="C">Colombia</option>
			<%
		}
		%>
		
		<%if(i[2]!=null && i[2].equals("O")){
			%>
			<option value="O" selected>Otro</option>
			<%
		}else{
			%>
			<option value="O">Otro</option>
			<%
		}
		%>
			
		
			</select>
			
			<%
		}else {
		
				if(j==3){
					%>
					<input type="text" style="width: 100px" value="<%=i[2]%>" id="valor<%=j%>" name="valor<%=j%>" onchange="cambiarAnual()"/>
					<%
					
				}
				else if(j==4){%>
					<input type="text" style="width: 100px" value="<%=i[2]%>" id="valor<%=j%>" name="valor<%=j%>" onchange="cambiarMinimo()"/>
					
				<%} else{
		%>
			<input type="text" style="width: 100px" value="<%=i[2]%>" id="valor<%=j%>" name="valor<%=j%>"/>
		<%}
				
		
		
		}
		%>
		
		
		
		</font></div>
		</td>
		
		<td align="center"  bgcolor="#EEEEEE"><a href="#" onclick="cargarEliminarParametro('<%=i[0] %>'); return false;">
		
		<%if(!(""+i[0]).equals("3") && !(""+i[0]).equals("19") && !(""+i[0]).equals("20") && !(""+i[0]).equals("21") && !(""+i[0]).equals("22") && !(""+i[0]).equals("23") && !(""+i[0]).equals("24")  && !(""+i[0]).equals("25") && !(""+i[0]).equals("26") ){ %>
		
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



