<%@ page contentType="text/html; charset=iso-8859-1" language="java"
	import="java.sql.*" import="java.util.*,java.text.SimpleDateFormat"
	session="false"%>
	<jsp:useBean
	id="bAdministrarPublicaciones" class="beans.AdministrarPublicaciones"
	scope="page" />
<%
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%
String idiomaSoftware = new beans.AdministrarPublicaciones().getIdioma();
%>
<html>
<head>
   <title>SOFTWARE SIMYF</title>
    <meta name="Description" content="SOFTWARE SIMYF">
  

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
<body><div id="contenedor">
<%
List<Object[]> proyectos = bAdministrarPublicaciones.getProyectos();
List<Object[]> lineas = bAdministrarPublicaciones.getLineas();
List<Object[]> financiadores = bAdministrarPublicaciones.getFinanciadores();
%>

<form method="post" name="form1" id="form1">  
<table border="0" width="100%" cellpadding="2">
	<tr>   
		<td width="34%"><span class="Estilo3"><span
			class="Estilo4 Estilo8">*</span>Proyecto:</span></td>
		<td width="66%">
		<select name="proyecto" id="proyecto" style="width:300px">
					<option value="" selected>Seleccione...</option>
					<%
						if(proyectos!=null && proyectos.size()>0){
							for(Object[] l: proyectos){
								%>
								<option value="<%=l[0] %>"><%=l[1] %></option>
								<%
							}
							
						}
					
					%>
					
		</select></td>
	</tr><tr>	
		
		<td width="34%"><span class="Estilo3"><span
			class="Estilo4 Estilo8">*</span>L�nea:</span></td>
		<td width="66%">
		<select name="linea" id="linea" style="width:300px">
					<option value="" selected>Seleccione...</option>
					<%
						if(lineas!=null && lineas.size()>0){
							for(Object[] l: lineas){
								%>
								<option value="<%=l[0] %>"><%=l[1] %></option>
								<%
							}
							
						}
					
					%>
					
		</select></td>
		
		</tr><tr>
		
		<td width="34%"><span class="Estilo3"><span
			class="Estilo4 Estilo8">*</span>Financiador:</span></td>
		<td width="66%">
		<select name="financiador" id="financiador" style="width:300px">
					<option value="" selected>Seleccione...</option>
					<%
						if(financiadores!=null && financiadores.size()>0){
							for(Object[] l: financiadores){
								%>
								<option value="<%=l[0] %>"><%=l[1] %></option>
								<%
							}
							
						}
					
					%>
					
		</select></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td colspan="2"><div align="center"><span id="detalleActualizarDatos">
		  <input class="searchbutton"
			name="btnActualizarDatos" id="btnActualizarDatos" type="button"
			style="cursor: hand" value=" Crear "
			onClick="nuevoProyectoLinea(); return false;" /> 
	    </span></div></td>
	</tr>
</table>
<span id="detalle"></span>
</form>
</div>
</body>
</html>
