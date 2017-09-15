
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


//List<Object[]> mujeres = bAdministrarPublicaciones.getMujeres();


String pn = request.getParameter("pn");
String sn = request.getParameter("sn");
String pa = request.getParameter("pa");
String sa  = request.getParameter("sa");
String doc  = request.getParameter("doc");


if(pn!=null && pn.equals("null")){
	pn = null;
	
}

if(sn!=null && sn.equals("null")){
	sn = null;	
	
}

if(pa!=null && pa.equals("null")){
	pa = null;	
	
}

if(sa!=null && sa.equals("null")){
	sa = null;	
	
}
if(doc!=null && doc.equals("null")){
	
	doc = null;	
}






List<Object[]> mujeres = bAdministrarPublicaciones.getMujeresS(pn, sn, pa, sa, doc);
	if (mujeres.size() > 0) {
%>
<table width="100%" border="0" cellspacing="2" cellpadding="2">
	<tr>
		<td bgcolor="#E81D8F">
		<div align="center" style="color:#FFFFFF">ITEM</div>
		</td>
		<td bgcolor="#E81D8F">
		<div align="center" style="color:#FFFFFF">NOMBRE</div>
		</td>
		<td bgcolor="#E81D8F">
		<div align="left" style="color:#FFFFFF">DOCUMENTO</div>
		</td>
		
		<td bgcolor="#E81D8F">
		<div align="center" style="color:#FFFFFF">ASPECTOS DEMOGRÁFICOS</div>
		</td>
		
		<td bgcolor="#E81D8F" colspan="2">
		<div align="center" style="color:#FFFFFF">ASPECTOS SOCIOECONÓMICOS</div>
		</td>
		
		<td bgcolor="#E81D8F" colspan="2">
		<div align="center" style="color:#FFFFFF">ASPECTOS PARTICIPATIVOS</div>
		</td>
		<td bgcolor="#E81D8F">
		<div align="center" style="color:#FFFFFF"></div>
		</td>
	</tr>
	<%
		int j = 0;
			for (Object[] i : mujeres) {
				j++;
				if(i[3-1]==null){
					i[3-1]= "";
				}
				if(i[5-1]==null){
					i[5-1]= "";
				}
				
				String color ="#EEEEEE";
				if(j%2==0){
					color ="#FFFFFF";
				}
	%>
	<tr >
		<td align="center" bgcolor="<%=color %>"><font color="black" style="font-size:11px"><%=j%></font></td>
		<td align="center" bgcolor="<%=color %>">
		<div align="left"><font color="black" style="font-size:11px"><%=i[2-1] + " " + i[3-1] + " " + i[4-1] + " "+ i[5-1] %></font></div>
		</td>
		<td align="left" bgcolor="<%=color %>" ><font color="black" style="font-size:11px"><%=i[6-1] %></font></td>
		  
		<td align="center" bgcolor="<%=color %>" style="font-size:11px"><a href="#" onclick="window.open('/web/verMujer.jsp?id=<%=i[1-1]%>', 'popup', 'toolbar=no, menubar=no, scrollbars=no, resizable=no, width=850, height=400'); return false;" style="text-decoration:none">Ver / Editar</a></td>
			
			<td align="center" bgcolor="<%=color %>" style="font-size:11px"><a href="participaciones.jsp?id=<%=i[1-1]%>&nc=<%=i[2-1] + " " + i[3-1] + " " + i[4-1] + " "+ i[5-1] %>">Participación organizaciones</a></td>	
<td align="center" bgcolor="<%=color %>" style="font-size:11px"><a href="capacitaciones.jsp?id=<%=i[1-1]%>&nc=<%=i[2-1] + " " + i[3-1] + " " + i[4-1] + " "+ i[5-1] %>">Capacitaciones recibidas</a></td>

				<td align="center" bgcolor="<%=color %>" style="font-size:11px"><a href="nivelesEducativos.jsp?id=<%=i[1-1]%>&nc=<%=i[2-1] + " " + i[3-1] + " " + i[4-1] + " "+ i[5-1] %>">Niveles educativos</a></td>
				<td align="center" bgcolor="<%=color %>" style="font-size:11px"><a href="actividadesEconomicas.jsp?id=<%=i[1-1]%>&nc=<%=i[2-1] + " " + i[3-1] + " " + i[4-1] + " "+ i[5-1] %>">Actividades económicas</a></td>

		<td align="center" bgcolor="<%=color %>" style="font-size:11px"><a href="#" onclick="cargarEliminarMujer('<%=i[1-1] %>'); return false;">Eliminar</a></td>
		
	</tr>
	<%
		}
	%>
</table>

<%
	} else {
%>
Aún no existen mujeres de la fundación creadas en el sistema
<%
	}
%>



