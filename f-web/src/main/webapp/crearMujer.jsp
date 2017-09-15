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

<link rel="stylesheet" type="text/css" href="css/epoch_styles.css" />
<script type="text/javascript" src="Scripts/epoch_classes.js"></script>
<script language="JavaScript">
	//Este script debe ponerse antes del Formulario
	//Empieza Calendario
	var dp_cal;
	var dp_cal2;
	window.onload = function() {
		dp_cal = new Epoch('dp_cal', 'popup', document
				.getElementById('control6'));

	};
	//Termina Calendario
	//Esta funcion asigna el calendario al campo5  del formulario
</script>
<link rel="stylesheet" type="text/css" href="home_files/style.css">
</head>
<body><div id="contenedor">
<%
		String [] datos = null;
			
			
			String hdnGuardarPublicacion = request.getParameter("hdnGuardarPublicacion");
		 	int numeroDatos = 17;

			int actualizo = 0;
			if(hdnGuardarPublicacion!=null && hdnGuardarPublicacion.equals("1")){

		datos = new String[numeroDatos];
		for(int i=0; i<=numeroDatos-1; i++){
			
			
			datos[i] = request.getParameter("control"+(i+1)); 
			
			if(datos[i]!=null && datos[i].trim().equals("")){
				datos[i] = null;
			}
			
			if(datos[i]!=null && datos[i].trim().equals("null")){
					datos[i] = null;
				}
			}
		
		   
		actualizo = bAdministrarPublicaciones.guardarHojaVida(datos);
		//out.println(actualizo);
		
			}	 		
			
		if(actualizo==1){
	%>
	<script>
		alert("HOJA DE VIDA CREADA EXITOSAMENTE.");

		try {
			window.opener.document.form1.submit();
		} catch (e) {
		}
		window.close();
	</script>
	<%
		}




	%>
<%


java.util.Date fechaActual = new java.util.Date();
SimpleDateFormat vFormato = new SimpleDateFormat("dd'/'MMMM'/'yyyy");
String vFechaActual = vFormato.format(fechaActual);
SimpleDateFormat vFormato2 = new SimpleDateFormat("yyy-MM-dd");
String vFechaActual2 = vFormato2.format(fechaActual);

List<Object[]> proyectos = bAdministrarPublicaciones.getProyectos();
%>

<form method="post" name="form1" id="form1">  
<table border="0" cellspacing="2" cellpadding="2"
										style="width: 100%">
										<tr>

											<td colspan="4" style="text-align: left"><strong>Ingreso de Mujeres - Aspectos Demográficos</strong><br /> <br /></td>



										</tr>
										
										<tr>
											<td>Tipo Mujer *:</td>
											<td><select name="control17" id="control17" style="width:250px">
													<option value="" selected>Seleccione..</option>
													<option value="S">Inscrita Fundación</option>
													<option value="N">NO inscrita</option>
													<option value="T">SOCIA</option>
											</select></td>
											<td></td>
											<td></td>
										</tr>

										<tr>

											<td>Primer Nombre *:</td>
											<td><input id="control1" name="control1" type="text"
												value="" /></td>
											<td>Segundo Nombre:</td>
											<td><input id="control2" name="control2" type="text"
												value="" /></td>


										</tr>
										<tr>
											<td>Primer Apellido *:</td>
											<td><input id="control3" name="control3" type="text"
												value="" /></td>
											<td>Segundo Apellido:</td>
											<td><input id="control4" name="control4" type="text"
												value="" /></td>
										</tr>
										<tr>
											<td>Número de Cédula *:</td>
											<td><input id="control5" name="control5" type="text"
												value="" /></td>
											<td>Estado Civil *:</td>
											<td><select name="control7" id="control7" style="width:250px">
													<option value="" selected>Seleccione..</option>
													<option value="1">SOLTERO(A)</option>
													<option value="2">CASADO(A)</option>
													<option value="3">VIUDO(A)</option>
													<option value="4">SEPARADO(A)</option>
													<option value="5">UNION LIBRE</option>
													<option value="6">DIVORCIADO(A)</option>

											</select></td>
										</tr>
										<tr>
											<td>Fecha Nacimiento *:</td>
											<td><input name="control6" id="control6" class="texto"
												type="text"
												style="background-color: #D1D6E2; text-align: center; vertical-align: middle"
												readonly="true" tabindex="2" size="14"
												value="<%=vFechaActual2%>" /> <img id="cal" name="cal"
												style="vertical-align: middle"
												src="images/iconocalendario.gif" title="Calendario"
												width="25" height="25" onClick="dp_cal.toggle();" /></td>
											<td>Sexo:</td>
											<td><select name="control9" id="control9" style="width:250px">
													<option value="M" selected>MUJER</option>
													<option value="H">HOMBRE</option>
											</select></td>
										</tr>
										<tr>
											<td>Número Hijas *:</td>
											<td><input id="control10" name="control10" type="text"
												value="0" style="width: 30px" /></td>
											<td>Número Hijos *:</td>
											<td><input id="control11" name="control11" type="text"
												value="0" style="width: 30px" /></td>
										</tr>
										<tr>
											<td>Dirección :</td>
											<td><input id="control12" name="control12" type="text"
												value="" /></td>
											<td>Teléfono(s) *:</td>
											<td><input id="control13" name="control13" type="text"
												value="" /></td>
										</tr>
										<tr>
											<td>Correo electrónico:</td>
											<td><input id="control8" name="control8" type="text"
												value="" /></td>
											<td></td>
											<td></td>

										</tr>
										<tr>
											<td>Tipo dirección *:</td>
											<td><select name="control14" id="control14" onchange="cargarTiposDirecciones()" style="width:250px"
												>
													<option value="" selected>Seleccione...</option>
													<option value="C">COMUNA</option>
													<option value="CO">CORREGIMIENTO</option>
											</select></td>
											<td></td>
											<td></td>
										</tr>

										<tr>
											<td><span id="span_1"></span></td>
											<td><span id="span_2"></span></td>
											<td><span id="span_3"></span></td>
											<td><span id="span_4"></span></td>
										</tr>
	<tr>
		<td colspan="4"><div align="center"><span id="detalleActualizarDatos">
		 <input
									type="button" value=" Guardar " onclick="validarMujer();" />
	    </span></div></td>
	</tr>
</table>
<span id="detalle"></span>
<script>
cargarTiposDirecciones();

</script>
	<input name="hdnGuardarPublicacion" id="hdnGuardarPublicacion"
			type="hidden" value="0" />
</form>
</div>
</body>
</html>
