<%@ page language="java" contentType="text/html; charset=iso-8859-1"
	import="java.sql.*,java.util.*,java.text.SimpleDateFormat"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@page import="beans.Seccion"%>
<jsp:useBean id="bAdministrarPublicaciones"
	class="beans.AdministrarPublicaciones" scope="page" />
	<%@page import="beans.Seccion"%>
<%@page import="beans.Publicacion"%>
<%@page import="beans.Parametro"%>

<html lang="es">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
</head>
<body>

<%

String texto = request.getParameter("texto");

%>

<script type="text/javascript">
    var height = $("body").outerHeight();
    parent.SetIFrameHeight(height);
</script>
</body>
</html>