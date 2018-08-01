
<%
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<%@ page language="java" contentType="text/html; charset=iso-8859-1"
	import="java.sql.*,java.util.*,java.text.SimpleDateFormat, java.math.BigDecimal"
	session="false" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
String idiomaSoftware = new beans.AdministrarPublicaciones().getIdioma();
%>
<%@page import="beans.Administrador"%>
<jsp:useBean id="bAdministrarPublicaciones"
	class="beans.AdministrarPublicaciones" scope="page" />




<%

try{
	String curso = request.getParameter("curso");
	String tema = request.getParameter("tema");
	String fecha_desde = request.getParameter("fecha_desde");
	String fecha_hasta = request.getParameter("fecha_hasta");
	String tipo = request.getParameter("tipo");
	String asistio_mujer = request.getParameter("asistio_mujer");
	String proyecto = request.getParameter("proyecto");
	String linea = request.getParameter("linea");
	String financiador = request.getParameter("financiador");
	String documento = request.getParameter("documento");
	String encuesta = request.getParameter("encuesta");
	
	String c14  = request.getParameter("c14");
	String c15  = request.getParameter("c15");
	String c16  = request.getParameter("c16");
	if(c14!=null && c14.equals("null")){
		
		c14 = null;	
	}
	if(c15!=null && c15.equals("null")){
		
		c15 = null;	
	}
	if(c16!=null && c16.equals("null")){
		
		c16 = null;	
	}
	
	

	int mujeresConCurso = 0;

	Object[] mujer = null;

	if (documento != null && !documento.trim().equals("")) {

		mujer = bAdministrarPublicaciones.getMujerDoc(documento);

	}

	List<Object[]> actividadesEncuesta = bAdministrarPublicaciones
			.getPreguntasResultados(encuesta);
	List<Object[]> mujeresEncuestaRespondida = null;

	mujeresEncuestaRespondida = bAdministrarPublicaciones
			.getMujeresEncuestav2(encuesta, curso, tema, proyecto,
					linea, financiador, documento, fecha_desde,
					fecha_hasta,c14,c15,c16);

	//if(mujer!=null){
	//mujeresEncuestaRespondida = bAdministrarPublicaciones.getMujeresEncuesta(encuesta,""+mujer[0]);

	//}else{
	//mujeresEncuestaRespondida = bAdministrarPublicaciones.getMujeresEncuesta(encuesta);	
	//}

	List<Object[]> parametrosGlobales = bAdministrarPublicaciones
			.getParametrosGlobales();
	Map<String, String> parametros = new HashMap<String, String>();
	//el primer id es id mujer y el segundo hora minuto
	Map<Integer, Integer[]> sumasVerticales = new HashMap<Integer, Integer[]>();

	if (actividadesEncuesta != null && actividadesEncuesta.size() > 0
			&& mujeresEncuestaRespondida != null
			&& mujeresEncuestaRespondida.size() > 0
			&& parametrosGlobales != null
			&& parametrosGlobales.size() > 0) {
		BigDecimal totalCostoMesBase = new BigDecimal(0);
		BigDecimal totalCostoHoraBase = new BigDecimal(0);
		int totalHorasBase = 0;

		for (Object[] j : parametrosGlobales) {
			if (("" + j[0]).equals("3")) {
				parametros.put("salarioMinimo", "" + j[2]);
			}

			if (("" + j[0]).equals("19")) {
				parametros.put("semanaMes", "" + j[2]);
			}

			if (("" + j[0]).equals("20")) {
				parametros.put("costoHoras", "" + j[2]);
			}

			if (("" + j[0]).equals("21")) {
				parametros.put("diaMes", "" + j[2]);
			}

			if (("" + j[0]).equals("22")) {
				parametros.put("horaDia", "" + j[2]);
			}
		}

		for (Object[] m : mujeresEncuestaRespondida) {

			Integer[] suma = new Integer[2];
			suma[0] = 0;
			suma[1] = 0;
			sumasVerticales.put(Integer.parseInt("" + m[0]), suma);
		}
%>
<font color="black"> * Recuerde que estos resultados hacen
	alusión a los criterios seleccionados (SOLO CONTEMPLA MUJERES
	PARTICIPES DE LAS ACTIVIDADES) </font>
<br>
<center>
	<form action="imprimirExcel.jsp" method="post" target="_blank"
		id="FormularioExportacion2" name="FormularioExportacion2">
		<font color="black"> <input type="button"
			value=" CALCULAR RESULTADOS DE NUEVO " onclick="validarPlanilla4();" />
			&nbsp;&nbsp;  <input type="button"
			value="Exportar a excel" onclick="genrarTabla()" />

		</font>

	</form>
</center>
<div id="Exportar_a_Excel">
	<table border="1" cellspacing="2" cellpadding="2" style="width: 100%">


		<%
			BigDecimal totalValorCursoMujer = new BigDecimal(0);
				int totalHorasCursoMujer = 0;

				for (Object[] m : mujeresEncuestaRespondida) {
					if (m[2] == null) {
						m[2] = "";
					}

					if (m[4] == null) {
						m[4] = "";
					}
		%>

		<tr>
			<td colspan="3" bgcolor="#E81D8F" colspan="2" style="color: #FFFFFF"
				align="left"><font><%=m[1] + " " + m[2] + " " + m[3] + " " + m[4]%></font></td>

		</tr>

		<tr>
			<td colspan="3" style="color: #FFFFFF" align="left">
				<%
					BigDecimal sumador = new BigDecimal(0);
							for (Object[] p : actividadesEncuesta) {

								Object[] tiempoMujer = bAdministrarPublicaciones
										.getHorasMujerEncuesta(encuesta, "" + m[0], ""
												+ p[4]);

								Integer[] llevoVertical = sumasVerticales.get(Integer
										.parseInt("" + m[0]));
								Integer[] suma2 = new Integer[2];
								suma2[0] = Integer.parseInt("" + tiempoMujer[5])
										+ llevoVertical[0];
								suma2[1] = Integer.parseInt("" + tiempoMujer[6])
										+ llevoVertical[1];

								sumasVerticales.put(Integer.parseInt("" + m[0]), suma2);

							}

							Integer[] radicado = sumasVerticales.get(Integer
									.parseInt("" + m[0]));
							int minutosMujer = radicado[0] * 60 + radicado[1];
							int tiempoEnUnMes = minutosMujer
									* Integer.parseInt(parametros.get("semanaMes"));

							totalHorasBase += minutosMujer;
				%>
			
		<tr>
			<th colspan="3" bgcolor="#D1D6E2"><font color="black">Análisis
					de aportes(Línea base)</font></th>
		</tr>
		<tr>
			<td colspan="3" align="left"><font color="black"> Tiempo
					semanal según encuesta (min) = <%=minutosMujer%>
			</font></td>

		</tr>
		<!-- 
			<tr>
			<td colspan="3"><font color="black"> 
			Tiempo en un mes (min)  = tiempoEnUnMes%>
			</font>
			</td>
			
			</tr>
			-->

		<tr>
			<td colspan="3" align="left"><font color="black"> <%
 	double costoMesMinuto = 1.0 * minutosMujer
 					* Integer.parseInt(parametros.get("semanaMes"))
 					* Integer.parseInt(parametros.get("costoHoras"))
 					/ 60.0;
 			BigDecimal costosMes = bAdministrarPublicaciones
 					.getValorRedondeado(new BigDecimal(costoMesMinuto),
 							2);

 			double operacion = costosMes.doubleValue()
 					/ Integer.parseInt(parametros.get("diaMes"));
 			BigDecimal costoDia = bAdministrarPublicaciones
 					.getValorRedondeado(new BigDecimal(operacion), 2);

 			double operacion2 = costoDia.doubleValue()
 					/ Integer.parseInt(parametros.get("horaDia"));
 			BigDecimal costoHora = bAdministrarPublicaciones
 					.getValorRedondeado(new BigDecimal(operacion2), 2);

 			totalCostoMesBase = totalCostoMesBase.add(costosMes);
 			totalCostoHoraBase = totalCostoHoraBase.add(costoHora);
 %> Costo en un mes según encuesta = $ <%=costosMes%> ; Costo en una
					hora según encuesta = $ <%=costoHora%>
			</font></td>

		</tr>


		<tr>
			<th colspan="3" bgcolor="#D1D6E2"><font color="black">Aporte
					por concepto de cursos</font></th>
		</tr>

		<%
			List<Object[]> cursos = bAdministrarPublicaciones
							.getMujeresAsistenciaResultado(curso, tema,
									fecha_desde, fecha_hasta, tipo,
									asistio_mujer, proyecto, linea,
									financiador, "" + m[0],c14,c15,c16);
					if (cursos != null && cursos.size() > 0) {
						mujeresConCurso++;
		%>
		<tr>
			<th><font color="black"> Curso</font></th>
			<th align="right"><font color="black"> Tiempo
					capacitación (min)</font></th>
			<th align="right"><font color="black"> Valor</font></th>
		</tr>
		<%
			BigDecimal sumadorValorCursoMujer = new BigDecimal(0);
						int sumadorHorasCursoMujer = 0;
						for (Object[] tc : cursos) {

							double operacion3 = costoHora.doubleValue()
									* (Integer.parseInt("" + tc[0]));
							BigDecimal costoCurso = bAdministrarPublicaciones
									.getValorRedondeado(new BigDecimal(
											operacion3), 2);

							sumadorHorasCursoMujer += Integer.parseInt(""
									+ tc[0]) * 60;
							sumadorValorCursoMujer = sumadorValorCursoMujer
									.add(costoCurso);

							totalHorasCursoMujer += sumadorHorasCursoMujer;
							totalValorCursoMujer = totalValorCursoMujer
									.add(sumadorValorCursoMujer);
		%>
		<tr>
			<td align="left"><font color="black"> <%="" + tc[2]%></font></td>
			<td align="right"><font color="black"><%="" + (Integer.parseInt("" + tc[0]) * 60)%></font></td>
			<td align="right"><font color="black"><%="$ " + costoCurso%></font></td>
		</tr>

		<%
			}
		%>
		<tr>
			<td align="right"><font color="black"> <%="Total "%></font></td>
			<td align="right"><font color="black"><%="" + sumadorHorasCursoMujer%></font></td>
			<td align="right"><font color="black"><%="$ "
								+ bAdministrarPublicaciones.getValorRedondeado(
										sumadorValorCursoMujer, 2)%></font></td>
		</tr>

		<%
			} else {
		%>
		<tr>
			<td colspan="3"><font color="black"> No existe aportes
					por concepto de capacitación </font></td>

		</tr>
		<%
			}
		%>





		<%
			}
		%>

		<tr>
			<th colspan="3" bgcolor="yellow"><font color="black">RESUMEN</font></th>
		</tr>
		<tr>
			<td colspan="3" align="left"><font color="black"> <%=" TOTAL MUJERES= " + mujeresEncuestaRespondida.size()%></font></td>
		</tr>
		<!-- 
			<tr>
			<td colspan="3" align="left"><font color="black"> TOTAL MUJERES PARTICPANTES EN CURSOS= "+mujeresConCurso </font></td>
			</tr>
			-->
		<tr>
			<td colspan="3" align="left"><font color="black"> <%=" TOTAL TIEMPO SEGÚN ENCUESTA[LÍNEA BASE] (MIN)= "
						+ totalHorasBase%></font></td>
		</tr>
		<tr>
			<td colspan="3" align="left"><font color="black"> <%=" TOTAL COSTO MENSUAL SEGÚN ENCUESTA[LÍNEA BASE] = "
						+ "$ "
						+ bAdministrarPublicaciones.getValorRedondeado(
								totalCostoMesBase, 2)%>;
					<%=" TOTAL COSTO HORA SEGÚN ENCUESTA[LÍNEA BASE] = "
						+ "$ "
						+ bAdministrarPublicaciones.getValorRedondeado(
								totalCostoHoraBase, 2)%></font></td>
		</tr>
		<tr>
			<td colspan="3" align="left"><font color="black"> <%=" TOTAL TIEMPO DE CAPACITACIONES (MIN)= "
						+ totalHorasCursoMujer%></font></td>
		</tr>
		<tr>
			<td colspan="3" align="left"><font color="black"> <%=" TOTAL APORTE CAPACITACIONES= "
						+ "$ "
						+ bAdministrarPublicaciones.getValorRedondeado(
								totalValorCursoMujer, 2)%></font></td>
		</tr>


	</table>
</div>
<br>
<br>
<center>
	<form action="imprimirExcel.jsp" method="post" target="_blank"
		id="FormularioExportacion" name="FormularioExportacion">
		<font color="black"> <input type="button"
			value=" CALCULAR RESULTADOS DE NUEVO " onclick="validarPlanilla4();" />
			&nbsp;&nbsp; <input type="hidden" id="datos_a_enviar"
			name="datos_a_enviar" /> <input type="button"
			value="Exportar a excel" onclick="genrarTabla()" />

		</font>

	</form>
</center>





<input type="hidden" value="1" name="exitoso" id="exitoso">

<%
	} else {
%>
<input type="hidden" value="0" name="exitoso" id="exitoso">
<%
	}
	
}catch(Exception e){
	out.println(e.toString());
}
%>
