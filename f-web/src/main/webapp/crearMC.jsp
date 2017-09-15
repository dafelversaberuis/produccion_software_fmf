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
	<div id="contenedor">
		<%
			String id = request.getParameter("id");
		%>
		<form method="post" name="form1" id="form1">
			<table border="0" width="100%" cellpadding="2">
				<tr>

					<td>Primer Nombre :</td>
					<td><input id="control1" name="control1" type="text" value="" /></td>
					<td>Segundo Nombre:</td>
					<td><input id="control2" name="control2" type="text" value="" /></td>


				</tr>
				<tr>
					<td>Primer Apellido :</td>
					<td><input id="control3" name="control3" type="text" value="" /></td>
					<td>Segundo Apellido:</td>
					<td><input id="control4" name="control4" type="text" value="" /></td>
				</tr>
				<tr>
					<td>Número de Cédula :</td>
					<td><input id="control5" name="control5" type="text" value="" /></td>
					<td></td>
					<td></td>
				</tr>
			</table>
			<center>
			
			<br /> <input
									type="button" value=" Consultar " onclick="consultarMujer(<%=id%>);" /> <br />
			
			</center>
			
			<span id="detalle"></span>
		</form>
	</div>
</body>
</html>
