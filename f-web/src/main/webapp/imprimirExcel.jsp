
<%
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<%@ page contentType="text/html; charset=iso-8859-1" language="java"
	import="java.sql.*,java.util.*,java.text.SimpleDateFormat, java.math.BigDecimal" errorPage=""
	session="false"%>
	<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
	
<style>
.ignorar {
	display: none;
}
</style>

<%

response.setHeader("Content-Type","application/vnd.ms-excel; name='excel' charset=utf-8");


response.setHeader("Cache-Control", "no-store");
response.setHeader("Pragma", "no-cache"); 
response.setDateHeader("Expires", 0);
response.setHeader("Content-Disposition","attachment; filename=\"resultados.xls\""); 
String datos = request.getParameter("datos_a_enviar");

out.println(datos);
%>



