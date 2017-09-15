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
List<Object[]> cursos = bAdministrarPublicaciones.getOrganizaciones();
List<Object[]> cursos2 = bAdministrarPublicaciones.getCargos();
%>
<form method="post" name="form1" id="form1">  
<table border="0" width="100%" cellpadding="2">
<tr>   
		<td width="34%"><span class="Estilo3"><span
			class="Estilo4 Estilo8">*</span>Tipo participación:</span></td>
		<td width="66%">
		<select name="tipo" id="tipo" style="width:300px">
			<option value="" selected>Seleccione..</option>
			<option value="MU" >Sólo Mujeres</option>
			<option value="MI" >Mixta (Hombres, Mujeres, LGBTI)</option>
	
		</select>
		
		</td>
		</tr>
	<tr>   
		<td width="34%"><span class="Estilo3"><span
			class="Estilo4 Estilo8">*</span>Tipo organización:</span></td>
		<td width="66%">
		<select name="niveles" id="niveles" style="width:300px" onchange="cambiarNivel();">
	<option value="" selected>Seleccione..</option>
	<%  if (cursos!=null && cursos.size() > 0) {
		for(Object[] c: cursos){
			%>
			<option value="<%=c[0]+"-"+c[2]%>"><%=c[1]%></option>
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
		<td width="34%"><span class="Estilo3"><span
			class="Estilo4 Estilo8">*</span>Cargo:</span></td>
		<td width="66%">
		<select name="cargos" id="cargos" style="width:300px" >
	<option value="" selected>Seleccione..</option>
	<%  if (cursos2!=null && cursos2.size() > 0) {
		for(Object[] c: cursos2){
			%>
			<option value="<%=c[0]%>"><%=c[1]%></option>
			<%
			
		}
		
			}
	%>
</select>
		
		</td>
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
			onClick="nuevaParticipacion('<%=id%>'); return false;" /> 
	    </span></div></td>
	</tr>
</table>
<span id="detalle"></span>
</form>
</div>
</body>
</html>
