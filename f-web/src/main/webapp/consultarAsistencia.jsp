
<%@ page contentType="text/html; charset=iso-8859-1" language="java"
	import="java.sql.*,java.util.*,java.text.SimpleDateFormat"
	session="true"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="bSeguridad" class="beans.Seguridad" scope="page" />
<jsp:useBean id="bUsuario" class="beans.Usuario" scope="session" />
<%@page import="beans.Certificado"%>
<jsp:useBean id="bAdministrarPublicaciones"
	class="beans.AdministrarPublicaciones" scope="page" />
<%@page import="beans.Publicacion"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>SOFTWARE SIMYF</title>
<meta name="Description" content="SOFTWARE SIMYF">

<script type="text/javascript" src="Scripts/noticias.js" charset="UTF-8"></script>
<script type="text/javascript" src="Scripts/claves.js" charset="UTF-8"></script>



<meta name="viewport" content="initial-scale=1.0,width=device-width">
<link rel="stylesheet" type="text/css" href="home_files/bootstrap.css">



<style>
.filters:before {
	width: 0% !important;
}
</style>
<style>
.fluidvids-elem {
	position: absolute;
	top: 0px;
	left: 0px;
	width: 100%;
	height: 100%;
}

.fluidvids {
	width: 100%;
	position: relative;
}
</style>
<style>
.filters:before {
	width: 100% !important;
}
</style>
<style>
.filters:before {
	width: 100% !important;
}
</style>
<style>
.filters:before {
	width: 0% !important;
}
</style>
<style>
.filters:before {
	width: 0% !important;
}
</style>
<link rel="stylesheet" type="text/css" href="css/epoch_styles.css" />
<script type="text/javascript" src="Scripts/epoch_classes.js"></script>
<script language="JavaScript">
	//Este script debe ponerse antes del Formulario
	//Empieza Calendario
	var dp_cal;
	var dp_cal2;
	window.onload = function() {
		dp_cal = new Epoch('dp_cal', 'popup', document.getElementById('fecha_desde'));
		dp_cal2 = new Epoch('dp_cal2', 'popup', document.getElementById('fecha_hasta'));

	};
	//Termina Calendario
	//Esta funcion asigna el calendario al campo5  del formulario
</script>
<link rel="stylesheet" type="text/css" href="home_files/style.css">
<script language="javascript">

   
	function genrarTabla() {

		tabla = document.getElementById("Exportar_a_Excel").innerHTML;
	
		document.getElementById("datos_a_enviar").value = tabla;
		document.form1.action="imprimirExcel.jsp"
		document.form1.submit();


	}
</script>
</head>
<!--****************************INICIO SESION************************************* -->
<%
	java.util.Date fechaActual = new java.util.Date();
	SimpleDateFormat vFormato = new SimpleDateFormat("dd'/'MMMM'/'yyyy");
	String vFechaActual = vFormato.format(fechaActual);
	SimpleDateFormat vFormato2 = new SimpleDateFormat("yyy-MM-dd");
	String vFechaActual2 = vFormato2.format(fechaActual);

	String url = "";
	String field = "";
	String tipoUsuario = new String();
	String contrasena = new String();
	String usuario = new String();
	String rol = new String();
	int usuarioEncontrado = 0;

	if (session.isNew()) {
		//out.println("IdSesion: " + session.getId());
		usuario = (String) request.getParameter("usuario");
		contrasena = (String) request.getParameter("contrasena");

		if (usuario != null && !usuario.trim().equals("")) {
	usuarioEncontrado = bSeguridad.consultarExistenciaUsuario(
	usuario, contrasena, null).intValue();
	if (usuarioEncontrado != 0) {
		bUsuario = bSeguridad.registrarSesion(usuario,
		contrasena, usuarioEncontrado);
		if (bUsuario != null) {
	session.setAttribute("sesionCreada", bUsuario);
	session.setMaxInactiveInterval(7200); //2h-7200
	bUsuario = (beans.Usuario) session
			.getAttribute("sesionCreada");
		} else {
	session.invalidate();
	url = "notificacion.jsp";
	field = "*Su documento y/o contrase�as son incorrectos*";
		}

	} else {
		session.invalidate();
		url = "notificacion.jsp";
		field = "*Su documento y/o contrase�as son incorrectos*";
	}

		}

	} else {
		bUsuario = (beans.Usuario) session.getAttribute("sesionCreada");
		if (bUsuario == null) {
	session.invalidate();
	url = "notificacion.jsp";
	field = "Debe ingresar con su documento y contrase�a...";
		}
	}

	if (!field.equals("")) {
%>
<jsp:forward page="<%=url%>">
	<jsp:param name="campo" value="<%=field%>" />
</jsp:forward>
<%
	}

	String tipoEgresado = "ADMINISTRADOR";
%>


<!--****************************FIN SESION************************************* -->
<body>
	<%
		String numero_personas = request.getParameter("total_asistencia");

			String [][] datos = null;
			
			
			String hdnGuardarPublicacion = request.getParameter("hdnGuardarPublicacion");


			int actualizo = 0;
			if(hdnGuardarPublicacion!=null && hdnGuardarPublicacion.equals("1")){

		datos = new String[Integer.parseInt(numero_personas)][10];
		for(int i=0; i<=Integer.parseInt(numero_personas)-1; i++){
			datos[i][0] =  request.getParameter("mujer_curso"+(i+1)); 
			datos[i][1] =  request.getParameter("asistio"+(i+1));
			if(datos[i][1]==null){
		datos[i][1] = "N";
			}
			datos[i][2] =  request.getParameter("fecha"); 
			datos[i][3] =  request.getParameter("horas_certificadas"); 
			datos[i][4] =  request.getParameter("curso"); 
			datos[i][5] =  request.getParameter("temas"); 
		
		}
		actualizo = bAdministrarPublicaciones.guardarPlanilla(datos, Integer.parseInt(numero_personas));
		
			}	 		
			
		if(actualizo==1){
	%>
	<script>
		alert("PLANILLA DE ASISTENCIA GUARDADA EXITOSAMENTE.");
	</script>
	<%
		}










		List<Object[]> cursos = bAdministrarPublicaciones.getCursos();
	%>
	
	<%
List<Object[]> proyectos = bAdministrarPublicaciones.getProyectos();
List<Object[]> lineas = bAdministrarPublicaciones.getLineas();
List<Object[]> financiadores = bAdministrarPublicaciones.getFinanciadores();
%>
	<form name="form1" id="form1" method="post">

		<!--HEADER-->  
	<header>
	
		<%
	String absoluta  = request.getRealPath("/imagenes/logosLogos/");
	bAdministrarPublicaciones.logoDinamico(absoluta);
	%>
	<img src="imagenes/logosLogos/logo_financiador_OK.jpg" alt="logo" width="220px" height="80px">
	<div class="container">
		
		<!--MENU-->
		<a href="" id="responsive-menu-button"><i class="fa fa-bars"></i></a>
		<nav class="menu" style="display: block;">
		
		<%@include file="menu.html" %>
		</nav>
		<!--END MENU-->
		<p><%=bUsuario.getPrimerNombre().trim() + " " + bUsuario.getSegundoNombre().trim() + " " + bUsuario.getPrimerApellido().trim() + " " + bUsuario.getSegundoApellido().trim()%><a
				href="#"
				onclick="document.getElementById('form1').action='index.jsp?sesion=false'; document.getElementById('form1').submit()"
				class="cerrar" style="text-decoration: none;"> (Cerrar sesi�n)</a>
		</p>
	</div>
	</header>
	<!--END HEADER-->

		<!--MAIN SECTION-->
		<div class="main work-page">
			<div class="container">
				<div class="row">
					<div class="col-md-12">
						<!--POST-->
						<div class="post">

							<div class="content">
								<h4>Consultar/Eliminar asistencia</h4>
								 <table border="1" style="width:100%"><tr><th>Criterios (cruce campos, presione consultar y ser� m�s especifico lo buscado)</th><tr><td>
							
								<div align="left">
									<table width="100%" border="0" cellspacing="2" cellpadding="2">
										<tr>
											<td>Fecha desde:</td>
											<td><input name="fecha_desde" id="fecha_desde" class="texto"
												type="text"
												style="background-color: #D1D6E2; text-align: center; vertical-align: middle"
												readonly="true"  size="14"
												value="" /> <img id="cal" name="cal"
												style="vertical-align: middle"
												src="images/iconocalendario.gif" title="Calendario"
												width="25" height="25" onClick="dp_cal.toggle();" /></td>


											<td>Fecha hasta:</td>
											<td><input name="fecha_hasta" id="fecha_hasta" class="texto"
												type="text"
												style="background-color: #D1D6E2; text-align: center; vertical-align: middle"
												readonly="true"  size="14"
												value="" /> <img id="cal2" name="cal2"
												style="vertical-align: middle"
												src="images/iconocalendario.gif" title="Calendario"
												width="25" height="25" onClick="dp_cal2.toggle();" /></td>
										</tr>

										<tr>


											<td>Curso:</td>
											<td><select name="curso" id="curso" class="js-example-basic-single"
												onchange="cargarTemasCombo()" style="width:300px">
													<option value="" selected>Seleccione..</option>
													<%
														if(cursos!=null && cursos.size()>0){
																																			for(Object[] c: cursos){
													%>
													<option value="<%=c[0]%>"><%=c[1]%></option>
													<%
														}
																																		}
													%>

											</select>
											<%
														if(cursos!=null && cursos.size()>0){
																																			for(Object[] c: cursos){
													%>
													
													<input type="hidden" value="<%=c[3] + " - "+c[4] + " - "+c[5]%>" id="curso<%=c[0]%>" name="curso<%=c[0]%>"/>
													<%
														}
																																		}
													%>
													<input name="proyecto" id="proyecto" 		type="hidden" />
											</td>
											<td>Tema:</td>
											<td><span id="span_tema"></span></td>
										</tr>
										
										<tr>
											<td>Proyecto:</td>
											<td>
											<select name="proyecto2" id="proyecto2" style="width:300px">
					<option value="" selected>Seleccione...</option>
					<%
						if(proyectos!=null && proyectos.size()>0){
							for(Object[] l: proyectos){
								%>
								<option value="<%=l[0] %>"><%=l[1] %></option>
								<%
							}
							
						}
					
					%>
					
		</select>
											</td>
											
											<td>Tipo asistencia:</td>
											<td>
											<select name="tipo" id="tipo" style="width:300px">
													<option value="0" selected>Seleccione...</option>
													<option value="1">Inscritas Fundaci�n</option>
													<option value="2">NO inscritas</option>
											</select>
											</td>


											
										</tr>
										
										<tr>
										<td>Financiador:</td>
											<td>
											<select name="financiador" id="financiador" style="width:300px">
					<option value="" selected>Seleccione...</option>
					<%
						if(financiadores!=null && financiadores.size()>0){
							for(Object[] l: financiadores){
								%>
								<option value="<%=l[0] %>"><%=l[1] %></option>
								<%
							}
							
						}
					
					%>
					
		</select>
											</td>
											
											<td>Asisti� ?:</td>
											<td>
											<select name="asistio_mujer" id="asistio_mujer" style="width:300px">
													<option value="0" selected>Seleccione...</option>
													<option value="S">Si</option>
													<option value="N">No</option>
											</select>
											</td>
											
										
											


											
										</tr>
										
										<tr>
										<td>L�nea estrat�gica:</td>
											<td>
											<select name="linea" id="linea" style="width:300px">
					<option value="" selected>Seleccione...</option>
					<%
						if(lineas!=null && lineas.size()>0){
							for(Object[] l: lineas){
								%>
								<option value="<%=l[0] %>"><%=l[1] %></option>
								<%
							}
							
						}
					
					%>
					
		</select>
											</td>
										
										
											
											<td>Documento:</td>
											<td><input name="documento" id="documento" class="texto"
												type="text"></td>
											
										</tr>
										
											<tr>
										
											<td>Tipo direcci�n:</td>
										<td><select name="control14" id="control14"
											onchange="cargarTiposDireccionesConsulta()" style="width: 250px">
												<option value="" selected>Seleccione...</option>
												<option value="C">COMUNA</option>
												<option value="CO">CORREGIMIENTO</option>
										</select></td>
										<td></td>
										<td></td>
									</tr>
									
									<tr>
										<td><span id="span_1"><font color="black">Comuna/Corregimiento:</font></span></td>
										<td><span id="span_2"><select  style="width:250px; color:black" name="control15" id="control15">
												<option value="" selected>Seleccione...</option>
											</select></span>
</td>
										<td><span id="span_3"><font color="black">Barrio/Vereda/asentamiento:</font></span></td>
										<td><span id="span_4">
										<select  style="width:250px; color:black" name="control16" id="control16">
												<option value="" selected>Seleccione...</option>
											</select>
										</span></td>
									</tr>
										
										
										
										
									</table>
								</div>
								</td></tr></table>
								<script>
									cargarTemasCombo();
								</script>

								<br /> <span id="detalleFechas"></span><br> <span
									id="detalleLote" style="text-align: center">
									<center>
										<font color="black"> <input type="button"
											value=" Consultar " onclick="validarPlanilla3();" />
										</font>
									</center>
 
								</span> <input name="hdnUs" id="hdnUs" type="hidden"
									value="<%=bUsuario.getIdUsuario()%>" /> <br /> <br /> <br />
								<br />

							</div>
						</div>
						<!--END POST-->


					</div>
				</div>
			</div>
		</div>

		<!--END MAIN SECTION-->


		<!--FOOTER-->
		<footer>
		<center>
			<div class="container">
				<img src="home_files/logo-sm.png" alt="">
				<ul class="list-inline social">
				


				</ul>
				<p>
				SOFTWARE SIMYF<br>Dise�ado por:
					quimerapps.com
				</p>
			</div>
		</center>
		</footer>
		<!--END FOOTER-->

<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/css/select2.min.css" rel="stylesheet" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>


		<script src="home_files/smoothscroll.js"></script>
		<script src="home_files/snap.svg-min.js"></script>
	
		<script src="home_files/retina.min.js"></script>
		<script src="home_files/imagesloaded.pkgd.min.js"></script>
		<script src="home_files/masonry.pkgd.min.js"></script>
		<script src="home_files/classie.js"></script>
		<script src="home_files/modernizr.custom.js"></script>
		<script src="home_files/cbpGridGallery.js"></script>
		<script src="home_files/jquery.resizestop.min.js"></script>
		<script src="home_files/fluidvids.js"></script>
		<script src="home_files/doubletaptogo.js"></script>

		<script src="home_files/main.js"></script>
		<input name="hdnGuardarPublicacion" id="hdnGuardarPublicacion"
			type="hidden" value="0" />
			
				 <script>

				// In your Javascript (external .js resource or <script> tag)
				 $(document).ready(function() {
				     $('.js-example-basic-single').select2();
				 });

				 </script>
	</form>
</body>
</html>

