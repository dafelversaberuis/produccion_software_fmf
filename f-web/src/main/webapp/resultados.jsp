<%@ page language="java" contentType="text/html; charset=UTF-8"
	import="java.sql.*,java.util.*,java.text.SimpleDateFormat"
	session="true"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="bSeguridad" class="beans.Seguridad" scope="page" />
<jsp:useBean id="bUsuario" class="beans.Usuario" scope="session" />
<jsp:useBean id="bAdministrarPublicaciones"
	class="beans.AdministrarPublicaciones" scope="page" />
<%@page import="beans.Publicacion"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>SOFTWARE SIMYF</title>
<meta name="Description" content="SOFTWARE SIMYF">
<meta name="viewport" content="initial-scale=1.0,width=device-width">
<script type="text/javascript" src="Scripts/noticias.js" charset="UTF-8"></script>
<script type="text/javascript" src="Scripts/claves.js" charset="UTF-8"></script>
<link rel="stylesheet" type="text/css" href="home_files/bootstrap.css">
<link rel="stylesheet" type="text/css"
	href="home_files/font-awesome.min.css">
<link rel="stylesheet" type="text/css" href="home_files/style.css">

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


<link rel="stylesheet" href="assets/css/font-awesome.css"
	type="text/css" />

<script language="javascript">


	function genrarTabla() {

		tabla = document.getElementById("Exportar_a_Excel").innerHTML;
	
		document.getElementById("datos_a_enviar").value = tabla;
		
		document.FormularioExportacion.submit();
	

	}
</script>

</head>
<!--****************************INICIO SESION************************************* -->
<%
	java.util.Date fechaActual = new java.util.Date();
	SimpleDateFormat vFormato = new SimpleDateFormat("dd'/'MMMM'/'yyyy");
	String vFechaActual = vFormato.format(fechaActual);

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
					field = "*Su documento y/o contraseñas son incorrectos*";
				}

			} else {
				session.invalidate();
				url = "notificacion.jsp";
				field = "*Su documento y/o contraseñas son incorrectos*";
			}

		}

	} else {
		bUsuario = (beans.Usuario) session.getAttribute("sesionCreada");
		if (bUsuario == null) {
			session.invalidate();
			url = "notificacion.jsp";
			field = "Debe ingresar con su documento y contraseña...";
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
	
	

	List<Object[]> cursos = bAdministrarPublicaciones.getCursos();



List<Object[]> proyectos = bAdministrarPublicaciones.getProyectos();
List<Object[]> lineas = bAdministrarPublicaciones.getLineas();
List<Object[]> financiadores = bAdministrarPublicaciones.getFinanciadores();
List<Object[]> encuestas = bAdministrarPublicaciones.getEncuestas();
	
%>


<!--****************************FIN SESION************************************* -->
<body>
	<form name="form1" id="form1" method="post"></form>


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
		<nav class="menu" style="display: block;"> <%@include
			file="menu.html"%> </nav>
		<!--END MENU-->
		<p><%=bUsuario.getPrimerNombre().trim() + " "
					+ bUsuario.getSegundoNombre().trim() + " "
					+ bUsuario.getPrimerApellido().trim() + " "
					+ bUsuario.getSegundoApellido().trim()%><a
				href="#"
				onclick="document.getElementById('form1').action='index.jsp?sesion=false'; document.getElementById('form1').submit()"
				class="cerrar" style="text-decoration: none;"> (Cerrar sesión)</a>
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
							<h4>Resultados</h4>

							

							<center>
								<span id="detalleProcesos"></span> <input name="hdnUs"
									id="hdnUs" type="hidden" value="<%=bUsuario.getIdUsuario()%>" />

								Este proceso ejecuta, calcula y muestra los resultados para
								valorar cada mujer. Por favor elija los criterios de consulta que desee y presione calcular
								
								<br/>
									<br/>
								
								<div align="left">
								<table border="1" style="width:100%"><tr><th>Criterios (cruce campos, presione consultar y será más especifico lo buscado)</th><tr><td>
								
								
									<table width="100%" border="0" cellspacing="2" cellpadding="2">
								<tr>
											<td>Encuesta para base de aporte*:</td>
											<td>		
										<select name="encuesta" id="encuesta"
									style="width: 300px">
									<option value="">Seleccione</option>
									<%
										if (encuestas != null && encuestas.size() > 0) {
											for (Object[] o : encuestas) {
									%>
									<option value="<%=o[0]%>"><%=o[1] + " (" + o[2] + " a " + o[3] + ")"%></option>

									<%
										}
										}
									%>


								</select>
								</td><td></td></tr>
										
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
											<td><select name="curso" id="curso"
												onchange="cargarTemasCombo()" style="width:300px" class="js-example-basic-single">
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
											
											<td>Línea estratégica:</td>
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
											
											<td>Documento:</td>
											<td><input name="documento" id="documento" class="texto"
												type="text">
												
												<select name="tipo" id="tipo" style="width:300px; display:none">
													<option value="0" selected>Seleccione...</option>
													
											</select>
											
											<select name="asistio_mujer" id="asistio_mujer" style="width:300px; display:none">   
													<option value="S" selected>Si</option>
													
											</select>
												
												</td>
											
										
											


											
										</tr>
										
										<tr>
										
											<td>Tipo dirección:</td>
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
										
										
									</table></td></tr></table>
								</div>
								<script>
									cargarTemasCombo();
								</script>

								<br /> <span id="detalleFechas"></span><br> <span
									id="detalleLote" style="text-align: center">
									<center>
										<font color="black"> <input type="button"
											value=" CALCULAR RESULTADOS " onclick="validarPlanilla4();" />
										</font>
									</center>

								</span>
								
								
								

								


								<br />
								<br /> <span id="detalleAdministradores"></span> <br />
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
				SOFTWARE SIMYF<br>Diseñado por:
				quimerapps.com
			</p>
		</div>
	</center>
	</footer>
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


	
</body>
</html>

