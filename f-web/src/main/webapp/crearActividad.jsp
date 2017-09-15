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
List<Object[]> cursos = bAdministrarPublicaciones.getActividades();

long salario = 0; 
%>
<form method="post" name="form1" id="form1">  
<table border="0" width="100%" cellpadding="2">
	<tr>   
		<td width="34%"><span class="Estilo3"><span
			class="Estilo4 Estilo8">*</span>Actividad económica:</span></td>
		<td width="66%">
		<select name="niveles" id="niveles" style="width:300px" onchange="cambiarNivel();">
	<option value="" selected>Seleccione..</option>
	<%  if (cursos!=null && cursos.size() > 0) {
		for(Object[] c: cursos){
			
			salario = Long.parseLong(""+c[4]);
			
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
		<td width="34%"><span class="Estilo3" ><span
			class="Estilo4 Estilo8">*</span>Rango de salario:</span></td>
		<td width="66%">
		<select name="rango" id="rango" style="width:300px" onchange="cambiarRango()">
				<option value="">Seleccione...</option>
				<option value="1">Entre 0 y 1 salario  mínimo  (Máximo $ <%= salario %> pesos mensuales)</option>
				<option value="2">Entre 1 y 2 salarios mínimos (Máximo $ <%= salario*2 %> pesos mensuales)</option>
				<option value="3">Entre 2 y 3 salarios mínimos (Máximo $ <%= salario*3 %> pesos mensuales)</option>
				<option value="4">Entre 3 y 4 salarios mínimos (Máximo $ <%= salario*4 %> pesos mensuales)</option>
				<option value="5">Entre 4 y 5 salarios mínimos (Máximo $ <%= salario*5 %> pesos mensuales)</option>
				<option value="6">5 ó más salarios mínmos      ($ <%= salario*5 %> pesos mensuales o más)</option>
		</select>
		
		<input type="hidden" name="salario1" id="salario1" value="<%= bAdministrarPublicaciones.getValorSemanal(""+salario) %>"> 
		<input type="hidden" name="salario2" id="salario2" value="<%= bAdministrarPublicaciones.getValorSemanal(""+(salario*2)) %>">
		<input type="hidden" name="salario3" id="salario3" value="<%= bAdministrarPublicaciones.getValorSemanal(""+(salario*2)) %>">
		<input type="hidden" name="salario4" id="salario4" value="<%= bAdministrarPublicaciones.getValorSemanal(""+(salario*4)) %>">
		<input type="hidden" name="salario5" id="salario5" value="<%= bAdministrarPublicaciones.getValorSemanal(""+(salario*5)) %>">
		<input type="hidden" name="salario6" id="salario6" value="<%= bAdministrarPublicaciones.getValorSemanal(""+(salario*5)) %>">
		</td>
		</tr>
		<tr>
		<td width="34%"><span class="Estilo3" ><span
			class="Estilo4 Estilo8">*</span>Ingreso promedio semanal:</span></td>
		<td width="66%">
				
				<input name="minimo" type="text" id="minimo" value="">
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
			onClick="nuevaActividad('<%=id%>'); return false;" /> 
	    </span></div></td>
	</tr>
</table>
<span id="detalle"></span>
</form>
</div>
</body>
</html>
