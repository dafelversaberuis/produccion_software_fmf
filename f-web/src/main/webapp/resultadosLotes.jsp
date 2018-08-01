
<%@page import="beans.Certificado"%>
<%
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<%@ page contentType="text/html; charset=iso-8859-1" language="java"
	import="java.sql.*,java.util.*,java.text.SimpleDateFormat" errorPage=""
	session="false"%>
<%@page import="beans.Administrador"%>
<jsp:useBean
	id="bAdministrarPublicaciones" class="beans.AdministrarPublicaciones"
	scope="page" />



<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
String idiomaSoftware = new beans.AdministrarPublicaciones().getIdioma();
%>
<%

SimpleDateFormat formato = new SimpleDateFormat("yyyy-MM-dd");
String  tipoCertificado = request.getParameter("tc");
String  documento = request.getParameter("d");
String  nombre = request.getParameter("n");
String  fechaI = request.getParameter("fi");
String  fechaF = request.getParameter("ff");


//out.println(tipoCertificado+"*"+ documento+"*"+ nombre+"*"+ fechaI+"*"+ fechaF);
try{
List<Certificado> certificados = bAdministrarPublicaciones.getCertificados(tipoCertificado, documento, nombre, fechaI, fechaF);

	if (certificados!=null && certificados.size() > 0) {
%>
<a href="imprimir_certificados.jsp?i=1&tc=<%=tipoCertificado %>&d=<%=documento %>&n=<%=nombre %>&fi=<%=fechaI %>&ff=<%= fechaF%>" target="_blank">(Imprimir certificados vigentes)</a>
<br/><br/>
<table width="100%" border="0" cellspacing="2" cellpadding="2">
	<tr>  
		<td bgcolor="#0089E1">  
		<div align="center" style="color:#FFFFFF">ITEM</div>
		</td>
		<td bgcolor="#0089E1">
		<div align="center" style="color:#FFFFFF">CURSO</div>
		</td>
		<td bgcolor="#0089E1">
		<div align="center" style="color:#FFFFFF">DOCUMENTO</div>
		</td>
		<td bgcolor="#0089E1">
		<div align="center" style="color:#FFFFFF">NOMBRE</div>
		</td>
		<td bgcolor="#0089E1">
		<div align="center" style="color:#FFFFFF">FECHA CURSO</div>
		</td>
		<td bgcolor="#0089E1">
		<div align="center" style="color:#FFFFFF">H</div>
		</td>
		<td bgcolor="#0089E1">
		<div align="center" style="color:#FFFFFF"></div>
		</td>
		<td bgcolor="#0089E1">
		<div align="center" style="color:#FFFFFF"></div>
		</td>
	</tr>
	<%
		int j = 0;
	if(certificados!=null && certificados.size()>0){
			for (Certificado i : certificados) {
				j++;
	%>
	<tr >
		<td align="center" bgcolor="#EEEEEE"><font color="black"><%=j%></font></td>
		<td align="left" bgcolor="#EEEEEE" ><font color="black"><%=i.getTipoCertificado() %></font></td>
		<td align="left" bgcolor="#EEEEEE" ><font color="black"><%=i.getDocumento() %></font></td>
		<td align="left" bgcolor="#EEEEEE">
		<div align="left"><font color="black"><%=i.getNombre() %></font></div>
		</td>
		<td align="left" bgcolor="#EEEEEE" ><font color="black"><%=i.getFechaInicio()+" a "+i.getFechaFin()%></font></td>
	
		<td align="left" bgcolor="#EEEEEE" ><font color="black"><%=i.getNumeroHoras()%></font></td>
		
		<td align="center" bgcolor="#EEEEEE" ><a href="#" onclick="cargarEliminarCertificado('<%=i.getId() %>'); return false;">Eliminar</a></td>
		<td align="center" bgcolor="#EEEEEE"><%if(i.getFechaDisponibilidad().compareTo(formato.format(new java.util.Date()))>=0 ){   %><a href="imprimir_certificado.jsp?rf=<%=Math.random()%>&i=<%=i.getId() %>&j=<%=Math.random()%>" target="_blank">Certificado</a><%}else{ %><font color="red">(Venció el <%=i.getFechaDisponibilidad() %>)</font><%} %></td>
		
	</tr>
	<%
		}}
	%>
</table>

<%
	} else {
%>
Aún no existen capacitados registrados en el sistema
<%
	}
}catch(Exception e){
	
}
%>



