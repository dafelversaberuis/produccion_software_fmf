
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


//List<Object[]> mujeres = bAdministrarPublicaciones.getMujeres();


String pn = request.getParameter("pn");
String sn = request.getParameter("sn");
String pa = request.getParameter("pa");
String sa  = request.getParameter("sa");
String doc  = request.getParameter("doc");

String c14  = request.getParameter("c14");
String c15  = request.getParameter("c15");
String c16  = request.getParameter("c16");


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

if(c14!=null && c14.equals("null")){
	
	c14 = null;	
}
if(c15!=null && c15.equals("null")){
	
	c15 = null;	
}
if(c16!=null && c16.equals("null")){
	
	c16 = null;	
}







List<Object[]> mujeres = bAdministrarPublicaciones.getMujeresS(pn, sn, pa, sa, doc,c14,c15,c16);
	if (mujeres.size() > 0) {
		
		
		
		
		List<Object[]> comunas = bAdministrarPublicaciones.getTipoDirecciones("C");
		List<Object[]> corregimientos = bAdministrarPublicaciones.getTipoDirecciones("CO");
		
		List<Object[]> barrios = bAdministrarPublicaciones.getBarriosVeredasTodos("C");
		List<Object[]> veredas = bAdministrarPublicaciones.getBarriosVeredasTodos("CO");
		
		
		Map<String,String> comunasH = new HashMap<String,String>();
		for (Object[] p: comunas) {
			comunasH.put(""+p[0],""+p[1]);
		}
		Map<String,String> corregimientosH = new HashMap<String,String>();
		for (Object[] p: corregimientos) {
			corregimientosH.put(""+p[0],""+p[1]);
		}
		
	
		
		Map<String,String> barriosH = new HashMap<String,String>();
		for (Object[] p: barrios) {
			barriosH.put(""+p[0],""+p[1]);
		}
		
		
		Map<String,String> veredasH = new HashMap<String,String>();
		for (Object[] p: veredas) {
			veredasH.put(""+p[0],""+p[1]);
		}
		

		
		
		
%>
<center>
	<form action="imprimirExcel.jsp" method="post" target="_blank"
		id="FormularioExportacion" name="FormularioExportacion">
		<font color="black"> 
			&nbsp;&nbsp; <input type="hidden" id="datos_a_enviar"
			name="datos_a_enviar" /> <input type="button"
			value="Exportar resultados de pantalla a excel" onclick="genrarTabla()" />

		</font>

	</form>
</center>
<div id="Exportar_a_Excel">



<table width="100%" border="0" cellspacing="2" cellpadding="2">
	<tr>
		<td bgcolor="#E81D8F">
		<div align="center" style="color:#FFFFFF; font-size:9px" >ITEM</div>
		</td>
		<td bgcolor="#E81D8F">
		<div align="center" style="color:#FFFFFF; font-size:9px">NOMBRE</div>
		</td>
		<td bgcolor="#E81D8F">
		<div align="left" style="color:#FFFFFF; font-size:9px">DOC</div>
		</td>
		
	
		<td bgcolor="#E81D8F">
		<div align="left" style="color:#FFFFFF; font-size:9px">COMUNA/CORREGIMIENTO</div>
		</td>
		<td bgcolor="#E81D8F">
		<div align="left" style="color:#FFFFFF; font-size:9px">BARRIO/VEREDA</div>
		</td>
		
		
		<td bgcolor="#E81D8F">
		<div align="center" style="color:#FFFFFF; font-size:9px">ASPECTOS DEMOGRÁFICOS</div>
		</td>
		
		<td bgcolor="#E81D8F" colspan="2">
		<div align="center" style="color:#FFFFFF; font-size:9px">ASPECTOS SOCIOECONÓMICOS</div>
		</td>
		
		<td bgcolor="#E81D8F" colspan="2">
		<div align="center" style="color:#FFFFFF; font-size:9px">ASPECTOS PARTICIPATIVOS</div>
		</td>
		<td bgcolor="#E81D8F">
		<div align="center" style="color:#FFFFFF; font-size:9px"></div>
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
		<td align="center" bgcolor="<%=color %>"><font color="black" style="font-size:9px"><%=j%></font></td>
		<td align="center" bgcolor="<%=color %>">
		<div align="left"><font color="black" style="font-size:9px"><%=i[2-1] + " " + i[3-1] + " " + i[4-1] + " "+ i[5-1] %></font></div>
		</td>
		<td align="left" bgcolor="<%=color %>" ><font color="black" style="font-size:9px"><%=i[6-1] %></font></td>
		

		<td align="left" bgcolor="<%=color %>" ><font color="black" style="font-size:9px"><%=(i[38]!=null) ? comunasH.get(""+i[38]): (   (i[39]!=null)?corregimientosH.get(""+i[39]):""     ) %></font></td>
				<td align="left" bgcolor="<%=color %>" ><font color="black" style="font-size:9px"><%=(i[38]!=null && i[40]!=null) ? barriosH.get(""+i[40]): (   (i[39]!=null && i[41]!=null)?veredasH.get(""+i[41]):""     ) %></font></td>
		
		  
		<td align="center" class="ignorar" bgcolor="<%=color %>" style="font-size:9px"><a href="#" onclick="window.open('/f-web/verMujer.jsp?id=<%=i[1-1]%>', 'popup', 'toolbar=no, menubar=no, scrollbars=no, resizable=no, width=850, height=400'); return false;" style="text-decoration:none">Ver / Editar</a></td>
			
			<td align="center" bgcolor="<%=color %>" style="font-size:9px"><a target="_blank" href="participaciones.jsp?id=<%=i[1-1]%>&nc=<%=i[2-1] + " " + i[3-1] + " " + i[4-1] + " "+ i[5-1] %>">Participación organizaciones</a></td>	
<td align="center" bgcolor="<%=color %>" style="font-size:9px"><a target="_blank" href="capacitaciones.jsp?id=<%=i[1-1]%>&nc=<%=i[2-1] + " " + i[3-1] + " " + i[4-1] + " "+ i[5-1] %>">Capacitaciones recibidas</a></td>

				<td align="center" bgcolor="<%=color %>" style="font-size:9px"><a target="_blank" href="nivelesEducativos.jsp?id=<%=i[1-1]%>&nc=<%=i[2-1] + " " + i[3-1] + " " + i[4-1] + " "+ i[5-1] %>">Niveles educativos</a></td>
				<td align="center" bgcolor="<%=color %>" style="font-size:9px"><a target="_blank" href="actividadesEconomicas.jsp?id=<%=i[1-1]%>&nc=<%=i[2-1] + " " + i[3-1] + " " + i[4-1] + " "+ i[5-1] %>">Actividades económicas</a></td>

		<td align="center" bgcolor="<%=color %>" style="font-size:9px"><a href="#" onclick="cargarEliminarMujer('<%=i[1-1] %>'); return false;">Eliminar.</a></td>
		  
	</tr>
	<%
		}
	%>
</table>

</div>

<%
	} else {
%>
Aún no existen mujeres de la fundación creadas en el sistema
<%
	}
%>



