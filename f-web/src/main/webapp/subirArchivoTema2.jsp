<%@ page contentType="text/html; charset=iso-8859-1" language="java"
	import="java.sql.*" import="java.util.*,java.text.SimpleDateFormat"
	session="false"%>

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
    <meta name="Description" content="SOFTWARE SIMYF ">


<? header("Cache-Control: no-cache, must-revalidate");?>
<meta http-equiv="cache-control" content="no-cache" />
<meta http-equiv="pragma" content="no-cache" />
<meta name="resource-type" content="document" />

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<link href="estilos/estilos.css" rel="stylesheet" type="text/css">
<style type="text/css">

body {
	background-image: url();
	background-color: #FBD7EB;
}

</style>
<style type="text/css">
<!--
.Estilo4 {
	font-size: 12px;
	font-weight: bold;
	font-family: Arial, Helvetica, sans-serif;
}
-->
</style>

<script>
	function cargarImagen()
	{
		if(document.frm_cargar.fil_imagen.value)
		{
			document.frm_cargar.submit();
		}
		else
		{
			alert("Debe seleccionar un archivo. Clic en el bot�n examinar; seleccione la imagen y luego clic en Aceptar");			
		}
	
	}

</script>
</head>
<body>
<%
//String tu = request.getParameter("tu");
//String us = request.getParameter("us");
String id = request.getParameter("id");


%>

<p class="Estilo4">&nbsp;</p>
<p class="Estilo4">&nbsp;</p>
<p class="Estilo4">Seleccione el archivo que desea cargar. Formatos aceptados: pdf, word (doc, docx), excel (xls, xlsx), power point (ppt,pptx,pps,ppsx), im�genes (jpg,jpeg,gif,png), comprimidos(zip, rar, 7z)</p>
<form action="recibirArchivoTema2.jsp?id=<%=id%>" method="post" enctype="multipart/form-data" name="frm_cargar">
        <p>
          <input name="fil_imagen" type="file" size="40">
 </p>
        <p align="center">         
          <input type="button" name="btn_cargar" value="Aceptar" onClick="cargarImagen();" class="searchbutton" style="cursor: hand">        
                </p>
</form>
</body>
</html>
