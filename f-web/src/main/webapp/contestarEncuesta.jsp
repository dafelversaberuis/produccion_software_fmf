
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
		String id_mujer = request.getParameter("id_mujer");

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
			
			Object[] rta = bAdministrarPublicaciones.getHorasMujerEncuestaActualizar(""+encuesta[0], ""+id_mujer, ""+pregunta[0], ""+opcion[0]);
		%>
		<tr>
			<td align="left" bgcolor="#FFFFFF" valign="middle"  width="5%">
			
			<%if(rta!=null){ %>
			<input type="radio" name="radio<%=j %>"  id="radio<%=j %>-<%=k %>"  value="<%=opcion[0]%>" checked/>
			<%}else{ %>
			<input type="radio" name="radio<%=j %>"  id="radio<%=j %>-<%=k %>"  value="<%=opcion[0]%>"/>
			<%} %>
			
			
			
			</td>
			<td align="left" bgcolor="#FFFFFF"><%=opcion[2]%> <%if(opcion[3].equals("S")){ %>Cuál: 
			<% if(rta!=null && rta[7]!=null){ %>
			<input type="text" name="observacion<%=j %>-<%=k %>" id="observacion<%=j %>-<%=k %>" value="<%=rta[7] %>" style="background-color: #D1D6E2; width:70%; border-color:red" />
			<%}else{ %>
			<input type="text" name="observacion<%=j %>-<%=k %>" id="observacion<%=j %>-<%=k %>" value="" style="background-color: #D1D6E2; width:70%; border-color:red" />
			<%} %>
			
			
			<%} else{%><input type="hidden" name="observacion<%=j %>-<%=k %>" id="observacion<%=j %>-<%=k %>" value=""/><%} %></td>
		</tr>
		<%}
		else{
			
			Object[] rta = bAdministrarPublicaciones.getHorasMujerEncuestaActualizar(""+encuesta[0], ""+id_mujer, ""+pregunta[0], ""+opcion[0]);
			
			%>
			<tr>
			<td align="left" bgcolor="#FFFFFF" valign="middle"  width="5%">
				<%if(rta!=null){ %>
			<input type="checkbox" name="chequeo<%=pregunta[0] %>" value="<%=opcion[0]%>" id="chequeo<%=j %>-<%=k %>" checked>
			<%}else{ %>
			<input type="checkbox" name="chequeo<%=pregunta[0] %>" value="<%=opcion[0]%>" id="chequeo<%=j %>-<%=k %>">
			<%} %>
			
			</td>
			<td align="left" bgcolor="#FFFFFF"><%=opcion[2]%> <%if(opcion[3].equals("S")){ %>Cuál:
			
			<% if(rta!=null && rta[7]!=null){ %>
			 <input type="text" name="observacion<%=j %>-<%=k %>" id="observacion<%=j %>-<%=k %>" value="<%=rta[7]%>" style="background-color: #D1D6E2; width:70%; border-color:red"/>
			 	<%}else{ %>
			 	<input type="text" name="observacion<%=j %>-<%=k %>" id="observacion<%=j %>-<%=k %>" value="" style="background-color: #D1D6E2; width:70%; border-color:red"/>
			 	<%} %>
			 
			 <%} else{%><input type="hidden" name="observacion<%=j %>-<%=k %>" id="observacion<%=j %>-<%=k %>" value=""/><%} %></td>
		</tr>
			<%
		}
		}  
			}
			}else{
				
				if(pregunta[3].equals("T")){ 
					
					Object[] rta = bAdministrarPublicaciones.getHorasMujerEncuestaActualizar(""+encuesta[0], ""+id_mujer, ""+pregunta[0], null);
					%>
					<tr>
				<td align="left" bgcolor="#FFFFFF" valign="middle" colspan="2">
				Horas:<select name="horas<%=j %>" id="horas<%=j %>">
				<%
				for(int i=0; i<=200; i++){
					
					%>
					<% if(rta!=null && rta[5]!=null && (""+rta[5]).equals(""+i)){ %>
					<option value="<%=i%>" selected><%=i%></option>
					<%}else{ %>
					<option value="<%=i%>"><%=i%></option>
					<% }%>
					
					
					<%
				}
				%>
				
				</select> Minutos:
				<select name="minutos<%=j %>" id="minutos<%=j %>">
				<%
				for(int i=0; i<=59; i++){
					%>
					<% if(rta!=null && rta[6]!=null && (""+rta[6]).equals(""+i)){ %>
					<option value="<%=i%>" selected><%=i%></option>
					<%}else{ %>
					<option value="<%=i%>"><%=i%></option>
					<% }%>
					
					<%
				}
				%>
				
				</select>
				
				</td>
				
			</tr>
					<%
					
				}else{
					Object[] rta = bAdministrarPublicaciones.getHorasMujerEncuestaActualizar(""+encuesta[0], ""+id_mujer, ""+pregunta[0], null);
				%>
				<tr>
				<td align="left" bgcolor="#FFFFFF" valign="middle" colspan="2">
				<% if(rta!=null && rta[7]!=null){ %>
				<textarea id="abierta<%=j %>" name="abierta<%=j %>" cols="55" rows="7"><%=rta[7]%></textarea>
				<%}else{ %>
				<textarea id="abierta<%=j %>" name="abierta<%=j %>" cols="55" rows="7"></textarea>
				<% }%>
				
				</td>
				
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



