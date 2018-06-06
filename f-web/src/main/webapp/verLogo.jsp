<%@ page contentType="text/html; charset=iso-8859-1" language="java"
	import="java.sql.*" import="java.util.*,java.text.SimpleDateFormat"
	session="false"%>
	
		<jsp:useBean id="bAdministrarPublicaciones"
	class="beans.AdministrarPublicaciones" scope="page" />

<%
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

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
<!--
body {
	background-image: url();
	background-color: #FBD7EB;
}
-->
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


</head>
<body>
<%
//String tu = request.getParameter("tu");
//String us = request.getParameter("us");
String id = request.getParameter("id");

//lo crea x sia ca no está
String directorio_ruta = application.getRealPath("imagenes")+"/logosFinanciadores/";
int sw= 0;
Object[] financiador = bAdministrarPublicaciones.getFinanciador(Integer.parseInt(id));


if(financiador[3]!=null){
sw=1;
bAdministrarPublicaciones.guardarArchivoDisco(directorio_ruta + "logo_financiador_"+id+".jpg", (byte[])financiador[3]);

}



 
%>

<div id="contiene-imagenes" style="width:500px; height: 500px">
<%if(sw==0){ %>
<img src="imagenes/logosFinanciadores/logo_financiador_<%=id %>.jpg" alt="CLIENTE" title="CLIENTE"/>

<%}else{ %>
<img src="/f-web/ver_foto_adjunta.jsp?id=<%=financiador[0] %>" alt="CLIENTE" title="CLIENTE"/>
<% }%>
</div>

</body>
</html>
