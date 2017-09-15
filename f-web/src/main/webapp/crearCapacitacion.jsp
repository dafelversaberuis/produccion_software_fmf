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
<body><div id="contenedor">
<%
String id = request.getParameter("id");
List<Object[]> cursos = bAdministrarPublicaciones.getCapacitaciones();
%>
<form method="post" name="form1" id="form1">  
<table border="0" width="100%" cellpadding="2">
	<tr>   
		<td width="34%"><span class="Estilo3"><span
			class="Estilo4 Estilo8">*</span>Capacitación recibida:</span></td>
		<td width="66%">
		<select name="niveles" id="niveles" style="width:300px" onchange="cambiarNivel();">
	<option value="" selected>Seleccione..</option>
	<%  if (cursos!=null && cursos.size() > 0) {
		for(Object[] c: cursos){
			%>
			<option value="<%=c[0]+"-"+c[2]+"-"+c[3]%>"><%=c[1]%></option>
			<%
			
		}
		
			}
	%>
</select>
		
		</td>
		</tr>
			<tr>
		<td width="34%"><span class="Estilo3" id="label" style="display: none;"><span
			class="Estilo4 Estilo8">*</span>Cual:</span></td>
		<td width="66%">
		<input name="cual" type="text" id="cual" style="display: none;">
		</td>
		
		</tr>
		
		<tr>
		<td width="34%"><span
			class="Estilo4 Estilo8">*</span>Institución que la ofreció:</td>
		<td width="66%">
		<input name="institucion" type="text" id="institucion" >
		</td>
		
		</tr>
		
		
	<tr>   
		<td width="34%"><span class="Estilo3"><span
			class="Estilo4 Estilo8">*</span>Percepción de conocimiento:</span></td>
		<td width="66%">
		<select name="percepcion" id="percepcion" style="width:300px" >
	<option value="" selected>Seleccione..</option>
	<option value="P" >Puso en práctica lo aprendido</option>
	<option value="A" >Aprendió la teoría</option>
	<option value="S" >Solo asistió</option>
	
</select>
		
		</td>
		</tr>
		
		<tr>   
		<td width="34%"><span class="Estilo3"><span
			class="Estilo4 Estilo8">*</span>Tiempo:</span></td>
		<td width="66%">
		<select name="tiempo" id="tiempo" style="width:300px" >
	<option value="" selected>Seleccione..</option>
	<option value="0" >De 0 a 2 años</option>
	<option value="3" >De 3 a 5 años</option>
	<option value="5" >Más 5 años</option>
	
</select>
		
		</td>
		</tr>
	<tr>
		<td colspan="2"><div align="center"><span id="detalleActualizarDatos">
		  <input class="searchbutton"
			name="btnActualizarDatos" id="btnActualizarDatos" type="button"
			style="cursor: hand" value=" Crear "
			onClick="nuevaCapacitacion('<%=id%>'); return false;" /> 
	    </span></div></td>
	</tr>
</table>
<span id="detalle"></span>
</form>
</div>
</body>
</html>
