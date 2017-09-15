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

<link rel="stylesheet" type="text/css" href="css/epoch_styles.css" />
<script type="text/javascript" src="Scripts/epoch_classes.js"></script>
<script language="JavaScript">
	//Este script debe ponerse antes del Formulario
	//Empieza Calendario
	var dp_cal;
	var dp_cal2;
	window.onload = function() {
		dp_cal = new Epoch('dp_cal', 'popup', document.getElementById('fecha_desde'));
		dp_cal2 = new Epoch('dp_cal2', 'popup', document.getElementById('fecha_hasta'));

	};
	//Termina Calendario
	//Esta funcion asigna el calendario al campo5  del formulario
</script>
</head>
<body><div id="contenedor">
<%

String id=request.getParameter("id");

Object[] encuesta = bAdministrarPublicaciones.getNombreEncuesta(id);

%>
<form method="post" name="form1" id="form1">  
<table border="0" width="100%" cellpadding="2">
	<tr>   
		<td >*Nombre de la encuesta:</td>
		<td><input name="encuesta" type="text" id="encuesta" value="<%=encuesta[1] %>"
			  /></td><td></td><td>
	</tr>
	<tr>
											<td>* Fecha desde :</td>
											<td><input name="fecha_desde" id="fecha_desde" class="texto"
												type="text"
												style="background-color: #D1D6E2; text-align: center; vertical-align: middle"
												readonly="true"  size="14"
												value="<%=encuesta[2] %>" /> <img id="cal" name="cal"
												style="vertical-align: middle"
												src="images/iconocalendario.gif" title="Calendario"
												width="25" height="25" onClick="dp_cal.toggle();" /></td>


											<td>* Fecha hasta:</td>
											<td><input name="fecha_hasta" id="fecha_hasta" class="texto"
												type="text"
												style="background-color: #D1D6E2; text-align: center; vertical-align: middle"
												readonly="true"  size="14"
												value="<%=encuesta[3] %>" /> <img id="cal2" name="cal2"
												style="vertical-align: middle"
												src="images/iconocalendario.gif" title="Calendario"
												width="25" height="25" onClick="dp_cal2.toggle();" /></td>
										</tr>
	<tr>
		<td colspan="4"><br/><div align="center"><span id="detalleActualizarDatos">
		  <input class="searchbutton"
			name="btnActualizarDatos" id="btnActualizarDatos" type="button"
			style="cursor: hand" value=" Editar "
			onClick="editarEncuesta('<%=id %>'); return false;" /> 
	    </span></div></td>
	</tr>
</table>
<span id="detalle"></span>
</form>
</div>
</body>
</html>
