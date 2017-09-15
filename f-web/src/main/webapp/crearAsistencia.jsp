
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
<title>FUNDACIÓN MUJER Y FUTURO</title>
<meta name="Description" content="Fundación Mujer y Futuro">

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
		dp_cal = new Epoch('dp_cal', 'popup', document.getElementById('fecha'));

	};
	//Termina Calendario
	//Esta funcion asigna el calendario al campo5  del formulario
</script>
<link rel="stylesheet" type="text/css" href="home_files/style.css">
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
			
			datos[i][6] =  request.getParameter("financiadores");
			datos[i][7] =  request.getParameter("lineas"); 
		
		
		}
		
		//out.println(request.getParameter("financiadores")+"-"+request.getParameter("lineas"));
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
	<form name="form1" id="form1" method="post">

		<!--HEADER-->  
	<header><img src="home_files/logo.png" alt="logo" width="220px" height="80px">
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
								<h4>Nueva planilla de asistencia (Inscritas y No a la fundación)</h4>
								<div align="left">
									<table width="100%" border="0" cellspacing="2" cellpadding="2">
										<tr>
											<td>Fecha *:</td>
											<td><input name="fecha" id="fecha" class="texto"
												type="text"
												style="background-color: #D1D6E2; text-align: center; vertical-align: middle"
												readonly="true" tabindex="2" size="14"
												value="<%=vFechaActual2%>" /> <img id="cal" name="cal"
												style="vertical-align: middle"
												src="images/iconocalendario.gif" title="Calendario"
												width="25" height="25" onClick="dp_cal.toggle();" /></td>


											<td>Horas por tema *:</td>
											<td><input id="horas_certificadas"
												name="horas_certificadas" type="text" value="0"
												style="width: 30px" /></td>
										</tr>

										<tr>


											<td>Curso *:</td>
											<td><select name="curso" id="curso"
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
													
													<input type="hidden" value="<%=c[3] %>" id="curso<%=c[0]%>" name="curso<%=c[0]%>"/>
													<%
														}
																																		}
													%>
											
											</td>
											<td>Tema *:</td>
											<td><span id="span_tema"></span></td>
										</tr>
										
										
										
											<tr>
											<td>Financiadores *:</td>
											<td><span id="span_financiadores"></span></td>
											
											<td>Líneas estratégicas *:</td>
											<td><span id="span_lineas"></span></td>
											
											</tr>
										<tr>


											<td>Proyecto:</td>
											<td><input name="proyecto" id="proyecto" class="texto"
												type="text"
												style="background-color: #D1D6E2; text-align: left; vertical-align: middle; width:300px;"
												readonly="true" value="" /></td>
											<td></td>
											<td></td>
										</tr>
									</table>
								</div>
								<script>
									cargarTemasCombo();
								</script>

								<br /> <span id="detalleFechas"></span><br> <span
									id="detalleLote" style="text-align: center">
									<center>
										<font color="black"> <input type="button"
											value=" Generar planilla " onclick="validarPlanilla();" />
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
					<li><a href="https://www.facebook.com/fundacionmujeryfuturo"
						target="_blank"><i class="fa fa-facebook"></i></a></li>
					<li><a href="http://www.mujeryfuturo.org" target="_blank"><i
							class="fa fa-twitter"></i></a></li>


				</ul>
				<p>
					Contacto: direccion@mujeryfuturo.org<br>Teléfonos:
					(+57-7)6341589 - (+57)3105765181<br>Diseñado por:
					quimerapps.com
				</p>
			</div>
		</center>
		</footer>
		<!--END FOOTER-->

		<script src="home_files/jquery-1.11.0.min.js"></script>
		<script src="home_files/jquery-migrate-1.2.1.js"></script>

		<script src="home_files/smoothscroll.js"></script>
		<script src="home_files/snap.svg-min.js"></script>
		<script src="home_files/jquery.bxslider.js"></script>
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
	</form>
</body>
</html>

