
<%
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<%@ page language="java" contentType="text/html; charset=iso-8859-1" import="java.sql.*,java.util.*,java.text.SimpleDateFormat"
     session="false" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="beans.Administrador"%>
<jsp:useBean
	id="bAdministrarPublicaciones" class="beans.AdministrarPublicaciones"
	scope="page" />



 <font color="black"> 
<%

String id=request.getParameter("id");
if(id==null){
	id="0";
}

if(id!=null && id.trim().equals("")){
	id="0";
}

List<Object[]> cursos = bAdministrarPublicaciones.getTemas(id);
%>

<select name="temas" id="temas" style="width:300px" class="js-example-basic-single2">
	<option value="" selected>Seleccione..</option>
	<%  if (cursos!=null && cursos.size() > 0) {
		for(Object[] c: cursos){
			%>
			<option value="<%=c[0]%>"><%=c[1]%></option>
			<%
			
		}
		
			}
	%>
</select>
</font>


