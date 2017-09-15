
<%
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<%@ page contentType="text/html; charset=iso-8859-1" language="java"
	import="java.sql.*,java.util.*,java.text.SimpleDateFormat" errorPage=""
	session="false"%>
<jsp:useBean id="bAdministrarPublicaciones"
	class="beans.AdministrarPublicaciones" scope="page" />


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<%
		String id = request.getParameter("id");

		Object[] encuesta = bAdministrarPublicaciones.getNombreEncuesta(id);
	%>
<br/>
	<table width="100%" border="0" cellspacing="2" cellpadding="2">
		<tr>
			<td bgcolor="#E81D8F" align="center" style="text-align: center" colspan="2"><font
				color="white"><h2>
						Encuesta:  <input type="hidden" name="encuesta" id="encuesta" value="<%=encuesta[0]%>"/>
						<%=encuesta[1]%></h2>Vigencia: <%=encuesta[2]%> a <%=encuesta[3]%><br />
						<a href="imprimirEncuesta.jsp?encuesta=<%= id %>" target="_blank">(Imprimir formato encuesta)</a>
						</font></td>


		</tr>

		<%
			List<Object[]> preguntas = bAdministrarPublicaciones
					.getPreguntas(id);
			int j = 0;
			if (preguntas != null && preguntas.size() > 0) {
				for (Object[] pregunta : preguntas) {
					j++;
					List<Object[]> opciones = bAdministrarPublicaciones
							.getOpciones("" + pregunta[0]);
					
					int cantidad = 0;
					
					if(pregunta[3].equals("U") || pregunta[3].equals("M")){
					if (opciones != null && opciones.size() > 0) {
						cantidad = opciones.size();
						
					}
					}
					
		%>
		<tr>
			<td align="left" bgcolor="#EEEEEE" valign="middle" width="5%"><input type="hidden" name="cantidad<%=j %>" id="cantidad<%=j %>" value="<%=cantidad%>"/><input type="hidden" name="pregunta<%=j %>" id="pregunta<%=j %>" value="<%=pregunta[0]%>"/><input type="hidden" name="tipo<%=j %>" id="tipo<%=j %>" value="<%=pregunta[3]%>"/><input type="hidden" name="valor<%=j %>" id="valor<%=j %>" value=""/><%=j + ". "%></td>
			<td align="left" bgcolor="#EEEEEE"><%=pregunta[2]%></td>
		</tr>

		<%
		
			if(pregunta[3].equals("U") || pregunta[3].equals("M")){
			//List<Object[]> opciones = bAdministrarPublicaciones
				//			.getOpciones("" + pregunta[0]);
					if (opciones != null && opciones.size() > 0) {
						int k=0;
						for(Object[] opcion: opciones){
							k++;
		if(pregunta[3].equals("U")){  
		%>
		<tr>
			<td align="left" bgcolor="#FFFFFF" valign="middle"  width="5%"><input type="radio" name="radio<%=j %>"  id="radio<%=j %>-<%=k %>"  value="<%=opcion[0]%>"/></td>
			<td align="left" bgcolor="#FFFFFF"><%=opcion[2]%> <%if(opcion[3].equals("S")){ %>Cuál: <input type="text" name="observacion<%=j %>-<%=k %>" id="observacion<%=j %>-<%=k %>" value="" style="background-color: #D1D6E2; width:70%; border-color:red" /><%} else{%><input type="hidden" name="observacion<%=j %>-<%=k %>" id="observacion<%=j %>-<%=k %>" value=""/><%} %></td>
		</tr>
		<%}
		else{
			%>
			<tr>
			<td align="left" bgcolor="#FFFFFF" valign="middle"  width="5%"><input type="checkbox" name="chequeo<%=pregunta[0] %>" value="<%=opcion[0]%>" id="chequeo<%=j %>-<%=k %>"></td>
			<td align="left" bgcolor="#FFFFFF"><%=opcion[2]%> <%if(opcion[3].equals("S")){ %>Cuál: <input type="text" name="observacion<%=j %>-<%=k %>" id="observacion<%=j %>-<%=k %>" value="" style="background-color: #D1D6E2; width:70%; border-color:red"/><%} else{%><input type="hidden" name="observacion<%=j %>-<%=k %>" id="observacion<%=j %>-<%=k %>" value=""/><%} %></td>
		</tr>
			<%
		}
		}  
			}
			}else{
				
				if(pregunta[3].equals("T")){ 
					%>
					<tr>
				<td align="left" bgcolor="#FFFFFF" valign="middle" colspan="2">
				Horas:<select name="horas<%=j %>" id="horas<%=j %>">
				<%
				for(int i=0; i<=200; i++){
					%>
					<option value="<%=i%>"><%=i%></option>
					<%
				}
				%>
				
				</select> Minutos:
				<select name="minutos<%=j %>" id="minutos<%=j %>">
				<%
				for(int i=0; i<=59; i++){
					%>
					<option value="<%=i%>"><%=i%></option>
					<%
				}
				%>
				
				</select>
				
				</td>
				
			</tr>
					<%
					
				}else{
				
				%>
				<tr>
				<td align="left" bgcolor="#FFFFFF" valign="middle" colspan="2"><textarea id="abierta<%=j %>" name="abierta<%=j %>" cols="55" rows="7"></textarea></td>
				
			</tr>
				<% }
			}
					
					
					
				}
			}
		%>

	</table>
<input name="hdnExito" id="hdnExito" type="hidden"
	value="1" />
	
	
	<br/>
<input type="button" style="background-color:red; color: white; width: 150px" value="  Guardar  " class="submitBtn" onclick="validarLleno(1);"/>
	
	<span id="detalle_respuesta"></span>
	
	<input name="total_preguntas" id="total_preguntas" type="hidden"
	value="<%=preguntas.size()%>" />



