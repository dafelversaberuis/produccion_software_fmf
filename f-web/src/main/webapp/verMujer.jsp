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
    <meta name="Description" content="SOFTWARE SIMYF">
  

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

String id = request.getParameter("id");
		String [] datos = null;
			
			
			String hdnGuardarPublicacion = request.getParameter("hdnGuardarPublicacion");
		 	int numeroDatos = 17;

			int actualizo = 0;
			if(hdnGuardarPublicacion!=null && hdnGuardarPublicacion.equals("1")){

		datos = new String[numeroDatos+2];//+2 para cambiar a los 2 nulos
		for(int i=0; i<=numeroDatos-1; i++){
			
			
			datos[i] = request.getParameter("control"+(i+1)); 
			
			if(datos[i]!=null && datos[i].trim().equals("")){
				datos[i] = null;
			}
			
			if(datos[i]!=null && datos[i].trim().equals("null")){
					datos[i] = null;
				}
			
			//out.println("* "+datos[i]);
			}
		
		if(("" + datos[13]).equals("CO")){
			
			datos[17] = datos[14] ;
			datos[18] = datos[15] ;
			
			datos[14] = null ;
			datos[15] = null ;
			
		}else{
			
			datos[17] = null ;
			datos[18] = null ;
			
			
		}
		
		
		
		
		      
		actualizo = bAdministrarPublicaciones.actualizarHojaVida(datos,id);
		
		
			}	 		
			
		if(actualizo==1){
	%>
	<script>
		alert("HOJA DE VIDA ACTUALIZADA EXITOSAMENTE.");

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


Object[] mujer = bAdministrarPublicaciones.getMujer(id);

if(mujer[2]==null){
	mujer[2]= "";
}
if(mujer[4]==null){
	mujer[4]= "";
}
if(mujer[8]==null){
	mujer[8]= "";
}

%>

<form method="post" name="form1" id="form1">  
<table border="0" cellspacing="2" cellpadding="2"
										style="width: 100%">
										<tr>

											<td colspan="4" style="text-align: left"><strong>Mujer seleccionada - Aspectos Demográficos</strong><br /> <br /></td>



										</tr>
										
										<tr>
											<td>Tipo Mujer *:</td>
											<td><select name="control17" id="control17" style="width:250px">
													<option value="" selected>Seleccione..</option>
													<option value="S">Inscrita Fundación</option>
													<option value="N">NO inscrita</option>
													<option value="T">SOCIA</option>
											</select>
											<script>
														document.getElementById("control17").value = "<%= mujer[37]%>";		
											
											</script>
											
											</td>
											<td></td>
											<td></td>
										</tr>

										<tr>

											<td>Primer Nombre *:</td>
											<td><input id="control1" name="control1" type="text"
												value="<%= mujer[1]%>" /></td>
											<td>Segundo Nombre:</td>
											<td><input id="control2" name="control2" type="text"
												value="<%= mujer[2]%>" /></td>


										</tr>
										<tr>
											<td>Primer Apellido *:</td>
											<td><input id="control3" name="control3" type="text"
												value="<%= mujer[3]%>" /></td>
											<td>Segundo Apellido:</td>
											<td><input id="control4" name="control4" type="text"
												value="<%= mujer[4]%>" /></td>
										</tr>
										<tr>
											<td>Número de Cédula *:</td>
											<td><input id="control5" name="control5" type="text"
												value="<%= mujer[5]%>" /></td>
											<td>Estado Civil *:</td>
											<td><select name="control7" id="control7" style="width:250px">
													<option value="" selected>Seleccione..</option>
													<option value="1">SOLTERO(A)</option>
													<option value="2">CASADO(A)</option>
													<option value="3">VIUDO(A)</option>
													<option value="4">SEPARADO(A)</option>
													<option value="5">UNION LIBRE</option>
													<option value="6">DIVORCIADO(A)</option>

											</select>
											<script>
														document.getElementById("control7").value = "<%= mujer[7]%>";		
											
											</script>
											</td>
										</tr>
										<tr>
											<td>Fecha Nacimiento *:</td>
											<td><input name="control6" id="control6" class="texto"
												type="text"
												style="background-color: #D1D6E2; text-align: center; vertical-align: middle"
												readonly="true" tabindex="2" size="14"
												value="<%= mujer[6]%>" /> <img id="cal" name="cal"
												style="vertical-align: middle"
												src="images/iconocalendario.gif" title="Calendario"
												width="25" height="25" onClick="dp_cal.toggle();" /></td>
											<td>Sexo:</td>
											<td><select name="control9" id="control9" style="width:250px">
													<option value="M" selected>MUJER</option>
													<option value="H">HOMBRE</option>
											</select>
											<script>
														document.getElementById("control9").value = "<%= mujer[9]%>";		
											
											</script>
											
											</td>
										</tr>
										<tr>
											<td>Número Hijas *:</td>
											<td><input id="control10" name="control10" type="text"
												value="<%= mujer[10]%>" style="width: 30px" /></td>
											<td>Número Hijos *:</td>
											<td><input id="control11" name="control11" type="text"
												value="<%= mujer[11]%>" style="width: 30px" /></td>
										</tr>
										<tr>
											<td>Dirección :</td>
											<td><input id="control12" name="control12" type="text"
												value="<%= mujer[12]%>" /></td>
											<td>Teléfono(s) *:</td>
											<td><input id="control13" name="control13" type="text"
												value="<%= mujer[13]%>" /></td>
										</tr>
										<tr>
											<td>Correo electrónico:</td>
											<td><input id="control8" name="control8" type="text"
												value="<%= mujer[8]%>" /></td>
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
											</select>
											<script>
														document.getElementById("control14").value = "<%= mujer[14]%>";		
											
											</script>
											
											</td>
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
									type="button" value=" Actualizar " onclick="validarMujer();" />
	    </span></div></td>
	</tr>
</table>
<%

String tipoDir ="";
String barrioVereda = "";
if((""+mujer[14]).equals("C")){
	if(mujer[38]!=null){
	 tipoDir = ""+mujer[38];
	 barrioVereda =""+mujer[40];
	}
	
}else{
	if(mujer[39]!=null){
	 tipoDir =""+mujer[39];
	 barrioVereda =""+mujer[41];
	}
	
}

%>
<input name="hdnTipoDir" id="hdnTipoDir"
			type="hidden" value="<%=tipoDir %>" />
			<input name="hdnBarrioVereda" id="hdnBarrioVereda"
			type="hidden" value="<%=barrioVereda %>" />
<span id="detalle"></span>
<script>
cargarTiposDirecciones2();

</script>
	<input name="hdnGuardarPublicacion" id="hdnGuardarPublicacion"
			type="hidden" value="0" />
			<input name="id" id="id"
			type="hidden" value="<%=id %>" />
			
</form>
</div>
</body>
</html>
