<%@ page language="java" contentType="text/html; charset=UTF-8"
	import="java.sql.*,java.util.*,java.text.SimpleDateFormat"
	session="true"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="bSeguridad" class="beans.Seguridad" scope="page" />
<jsp:useBean id="bUsuario" class="beans.Usuario" scope="session" />
<jsp:useBean id="bAdministrarPublicaciones"
	class="beans.AdministrarPublicaciones" scope="page" />
<%@page import="beans.Publicacion"%>

<%
String idiomaSoftware = new beans.AdministrarPublicaciones().getIdioma();
%>
<input type="hidden" value="<%=idiomaSoftware%>" id="idiomaSoftware"/>
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
			usuarioEncontrado = bSeguridad.consultarExistenciaUsuario(usuario, contrasena, null).intValue();
			if (usuarioEncontrado != 0) {
				bUsuario = bSeguridad.registrarSesion(usuario, contrasena, usuarioEncontrado);
				if (bUsuario != null) {
					session.setAttribute("sesionCreada", bUsuario);
					session.setMaxInactiveInterval(7200); //2h-7200
					bUsuario = (beans.Usuario) session.getAttribute("sesionCreada");
				} else {
					session.invalidate();
					url = "notificacion.jsp";
					field = idiomaSoftware.equals("E") ? "*Su documento y/o contraseñas son incorrectos*" : 
						"You must enter with your document and password ...";
				}

			} else {
				session.invalidate();
				url = "notificacion.jsp";
				field = idiomaSoftware.equals("E") ? "*Su documento y/o contraseñas son incorrectos*" : 
					"* Your document and / or passwords are incorrect *";
			}

		}

	} else {
		bUsuario = (beans.Usuario) session.getAttribute("sesionCreada");
		if (bUsuario == null) {
			session.invalidate();
			url = "notificacion.jsp";
			field = idiomaSoftware.equals("E") ? "Debe ingresar con su documento y contraseña..." : "You must enter with your document and password ...";
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
		<p><%=bUsuario.getPrimerNombre().trim() + " " + bUsuario.getSegundoNombre().trim() + " " + bUsuario.getPrimerApellido().trim() + " " + bUsuario.getSegundoApellido().trim()%><a
				href="#"
				onclick="document.getElementById('form1').action='index.jsp?sesion=false'; document.getElementById('form1').submit()"
				class="cerrar" style="text-decoration: none;"> <%= idiomaSoftware.equals("E") ? "(Cerrar sesión)" : "(Sign out)" %></a>
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
							<h4><%= idiomaSoftware.equals("E") ? "(Hoja de Vida Mujeres Fundación)" : "(Leaflet Women Foundation)" %></h4>
							<p><%= idiomaSoftware.equals("E") ? "Listado de mujeres que participan en la fundación" : "List of women participating in the foundation" %></p>
							<br />
							<br /> <a href="#"
								onclick="window.open('/f-web/crearMujer.jsp', 'popup', 'toolbar=no, menubar=no, scrollbars=no, resizable=no, width=850, height=400'); return false;"
								style="text-decoration: none"><%= idiomaSoftware.equals("E") ? "(Ingresar nueva mujer)" : "(Enter new woman)" %></a><br>
							<br>


							<center>
							 <table border="1" style="width:100%"><tr><th><%= idiomaSoftware.equals("E") ? "Criterios sólo de consulta(cruce campos, presione consultar y será más especifico lo buscado)" : 
								 "Criteria only of consultation (crossing fields, press consult and will be more specific what is sought)" %></th><tr><td>
								<table border="0" width="100%" cellpadding="2">
									<tr>

										<td><%= idiomaSoftware.equals("E") ? "Primer Nombre" : 
											"First name" %> :</td>
										<td><input id="control1" name="control1" type="text"
											value="" /></td>
										<td><%= idiomaSoftware.equals("E") ? "Segundo Nombre" : "Second name" %>:</td>
										<td><input id="control2" name="control2" type="text"
											value="" /></td>


									</tr>
									<tr>
										<td><%= idiomaSoftware.equals("E") ? "Primer Apellido" : "Surname" %> :</td>
										<td><input id="control3" name="control3" type="text"
											value="" /></td>
										<td><%= idiomaSoftware.equals("E") ? "Segundo Apellido" : 
											"Second surname" %>:</td>
										<td><input id="control4" name="control4" type="text"
											value="" /></td>
									</tr>
									<tr>
										<td><%= idiomaSoftware.equals("E") ? "Número de Cédula" : 
											"ID number"%> :</td>
										<td><input id="control5" name="control5" type="text"
											value="" /></td>
											<td><%= idiomaSoftware.equals("E") ? "Tipo dirección" : 
												"Address type" %>:</td>
										<td><select name="control14" id="control14"
											onchange="cargarTiposDireccionesConsulta()" style="width: 250px">
												<option value="" selected><%= idiomaSoftware.equals("E") ? "Seleccione..." : 
													"Select ..." %></option>
												<option value="C"><%= idiomaSoftware.equals("E") ? "COMUNA" : "COMMUNE" %></option>
												<option value="CO"><%= idiomaSoftware.equals("E") ? "CORREGIMIENTO" : "CORREGIMIENTO" %></option>
										</select></td>
									</tr>
									
									<tr>
										<td><span id="span_1"><font color="black"><%= idiomaSoftware.equals("E") ? "Comuna/Corregimiento" : 
											"Commune / Corregimiento" %>:</font></span></td>
										<td><span id="span_2"><select  style="width:250px; color:black" name="control15" id="control15">
												<option value="" selected><%= idiomaSoftware.equals("E") ? "Seleccione..." : 
													"Select ..." %></option>
											</select></span>
</td>
										<td><span id="span_3"><font color="black"><%= idiomaSoftware.equals("E") ? "Barrio/Vereda/asentamiento" : 
											"Neighborhood / Vereda / settlement" %>:</font></span></td>
										<td><span id="span_4">
										<select  style="width:250px; color:black" name="control16" id="control16">
												<option value="" selected><%= idiomaSoftware.equals("E") ? "Seleccione..." : 
													"Select ..." %></option>
											</select>
										</span></td>
									</tr>
								</table>
								
								</td></tr></table>

								<br /> <input type="button" value=" <%= idiomaSoftware.equals("E") ? "Consultar" : 
										"Consult" %> "
									onclick="cargarMujeres()" /> <br /> <br /> <span
									id="detalleProcesos"></span> <span id="detalleAdministradores"></span>
								<input name="hdnUs" id="hdnUs" type="hidden"
									value="<%=bUsuario.getIdUsuario()%>" />

							</center>
							
							

							<br />
							<br />
							<br />
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
			SOFTWARE SIMYF<br><%= idiomaSoftware.equals("E") ? "Diseñado por" : "Designed by" %>:
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

</body>
</html>

