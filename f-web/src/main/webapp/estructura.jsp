<jsp:useBean id="bAdministrarPublicaciones"
	class="beans.AdministrarPublicaciones" scope="page" />
<%@ page contentType="text/html; charset=iso-8859-1" language="java"
	import="java.sql.*" import="java.util.*,java.text.SimpleDateFormat"
	session="false"%>
<%
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
<title>FUNDACIÓN MUJER Y FUTURO</title>
<meta name="Description" content="Fundación Mujer y Futuro">


<? header("Cache-Control: no-cache, must-revalidate");?>
<meta http-equiv="cache-control" content="no-cache" />
<meta http-equiv="pragma" content="no-cache" />
<meta name="resource-type" content="document" />

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<meta http-equiv="X-UA-Compatible" content="IE=7">
<script type="text/javascript" src="Scripts/noticias.js"></script>


<style type="text/css">
<!--
body {
	background-image: url();
	background-color: #FBD7EB;
}
-->
</style>
<style type="text/css">
<!--
.Estilo5 {
	font-size: 12px;
	font-weight: bold;
	font-family: Arial, Helvetica, sans-serif;
}

.Estilo6 {
	font-size: 12px;
	font-weight: bold;
}
-->
</style>
</head>
<body>
	<%
		String id = request.getParameter("encuesta");

		Object[] encuesta = bAdministrarPublicaciones.getNombreEncuesta(id);
	%>

	<table width="100%" border="0" cellspacing="2" cellpadding="2">
		<tr>
			<td bgcolor="#E81D8F" align="center" style="text-align: center" colspan="2"><font
				color="white"><h2>
						Encuesta:
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
		%>
		<tr>
			<td align="left" bgcolor="#EEEEEE" valign="middle" width="5%"><%=j + ". "%></td>
			<td align="left" bgcolor="#EEEEEE"><%=pregunta[2]%></td>
		</tr>

		<%
		
			if(pregunta[3].equals("U") || pregunta[3].equals("M")){
			List<Object[]> opciones = bAdministrarPublicaciones
							.getOpciones("" + pregunta[0]);
					if (opciones != null && opciones.size() > 0) {
						for(Object[] opcion: opciones){
		if(pregunta[3].equals("U")){  
		%>
		<tr>
			<td align="left" bgcolor="#FFFFFF" valign="middle"  width="5%"><input type="radio" name="pregunta<%=pregunta[0] %>" value="<%=opcion[2]%>"></td>
			<td align="left" bgcolor="#FFFFFF"><%=opcion[2]%> <%if(opcion[3].equals("S")){ %>Cuál: <input type="text" name="observacion<%=opcion[0] %>" value="" style="width:70%"/><%} %></td>
		</tr>
		<%}
		else{
			%>
			<tr>
			<td align="left" bgcolor="#FFFFFF" valign="middle"  width="5%"><input type="checkbox" name="pregunta<%=pregunta[0] %>" value="<%=opcion[2]%>"></td>
			<td align="left" bgcolor="#FFFFFF"><%=opcion[2]%> <%if(opcion[3].equals("S")){ %>Cuál: <input type="text" name="observacion<%=opcion[0] %>" value="" style="width:70%"/><%} %></td>
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
				Horas:<select name="horas<%=pregunta[0] %>">
				<%
				for(int i=0; i<=200; i++){
					%>
					<option value="<%=i%>"><%=i%></option>
					<%
				}
				%>
				
				</select> Minutos:
				<select name="minutos<%=pregunta[0] %>">
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
				<td align="left" bgcolor="#FFFFFF" valign="middle" colspan="2"><textarea name="pregunta<%=pregunta[0] %>" cols="55" rows="7"></textarea></td>
				
			</tr>
				<% }
			}
					
					
					
				}
			}
		%>

	</table>

</body>
</html>
