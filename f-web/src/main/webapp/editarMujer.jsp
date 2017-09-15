
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
		dp_cal = new Epoch('dp_cal', 'popup', document
				.getElementById('control6'));

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
	
	
		String id = request.getParameter("id");
		
	
		String [] datos = null;
			
			
			String hdnGuardarPublicacion = request.getParameter("hdnGuardarPublicacion");
		 	int numeroDatos = 36;

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
		 
		   
		actualizo = bAdministrarPublicaciones.actualizarHojaVida(datos,id);
		//out.println(actualizo);
		
			}	 		
			
		if(actualizo==1){
	%>
	<script>
		alert("HOJA DE VIDA ACTUALIZADA EXITOSAMENTE.");
	</script>
	<%
		}


		Object[] control = bAdministrarPublicaciones.getMujer(id);
		if(!(control!=null && control.length>0)){
			%>
			<jsp:forward page="mujeres.jsp">
				<jsp:param name="campo" value="-1" />
			</jsp:forward>
			<%
			
			
		}
		for(int i=0; i<=numeroDatos; i++){
			if(control[i]==null){
				control[i] = "";
			}
			
		}
	
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
								<h4>VER/EDITAR HOJA DE VIDA MUJERES FUNDACIÓN</h4>
								<div align="left">
									<table border="0" cellspacing="2" cellpadding="2"
										style="width: 100%">
										<tr>

											<td colspan="4" style="text-align: left"><strong>ASPECTOS
													DEMOGRÁFICOS</strong><br /> <br /></td>



										</tr>

										<tr>

											<td>Primer Nombre *:</td>
											<td><input id="control1" name="control1" type="text"
												value="<%=control[1] %>" /></td>
											<td>Segundo Nombre:</td>
											<td><input id="control2" name="control2" type="text"
												value="<%=control[2] %>" /></td>


										</tr>
										<tr>
											<td>Primer Apellido *:</td>
											<td><input id="control3" name="control3" type="text"
												value="<%=control[3] %>" /></td>
											<td>Segundo Apellido:</td>
											<td><input id="control4" name="control4" type="text"
												value="<%=control[4] %>" /></td>
										</tr>
										<tr>
											<td>Número de Cédula *:</td>
											<td><input id="control5" name="control5" type="text"
												value="<%=control[5] %>" /></td>
											<td>Estado Civil *:</td>
											<td><select name="control7" id="control7">
													<option value="">Seleccione..</option>
													<option value="1">SOLTERO(A)</option>
													<option value="2">CASADO(A)</option>
													<option value="3">VIUDO(A)</option>
													<option value="4">SEPARADO(A)</option>
													<option value="5">UNION LIBRE</option>
													<option value="6">DIVORCIADO(A)</option>

											</select>
											<script>seleccionarCombo(7,"<%=control[7] %>");</script>
											</td>
										</tr>
										<tr>
											<td>Fecha Nacimiento *:</td>
											<td><input name="control6" id="control6" class="texto"
												type="text"
												style="background-color: #D1D6E2; text-align: center; vertical-align: middle"
												readonly="true" tabindex="2" size="14"
												value="<%=control[6] %>" /> <img id="cal" name="cal"
												style="vertical-align: middle"
												src="images/iconocalendario.gif" title="Calendario"
												width="25" height="25" onClick="dp_cal.toggle();" /></td>
											<td>Sexo:</td>
											<td><select name="control9" id="control9">
													<option value="M" >MUJER</option>
													<option value="H">HOMBRE</option>
											</select>
											<script>seleccionarCombo(9,"<%=control[9] %>");</script>
											</td>
										</tr>
										<tr>
											<td>Número Hijas *:</td>
											<td><input id="control10" name="control10" type="text"
												value="<%=control[10] %>" style="width: 30px" /></td>
											<td>Número Hijos *:</td>
											<td><input id="control11" name="control11" type="text"
												value="<%=control[11] %>" style="width: 30px" /></td>
										</tr>
										<tr>
											<td>Dirección *:</td>
											<td><input id="control12" name="control12" type="text"
												value="<%=control[12] %>" /></td>
											<td>Teléfono(s) *:</td>
											<td><input id="control13" name="control13" type="text"
												value="<%=control[13] %>"/></td>
										</tr>
										<tr>
											<td>Correo electrónico:</td>
											<td><input id="control8" name="control8" type="text"
												value="<%=control[8] %>" /></td>
											<td></td>
											<td></td>

										</tr>
										<tr>
											<td>Tipo dirección:</td>
											<td><select name="control14" id="control14"
												onchange="esconderComuna();">
													<option value="B" >BARRIO</option>
													<option value="C">COMUNA</option>
													<option value="V">VEREDA</option>
													<option value="CO">CORREGIMIENTO</option>
											</select>
											<script>seleccionarCombo(14,"<%=control[14] %>");</script>
											</td>
											<td>Nombre *:</td>
											<td><input id="control15" name="control15" type="text"
												value="<%=control[15] %>" /></td>
										</tr>

										<tr>
											<td><span id="label16" style="color: #000000;">Número
													Comuna:</span></td>
											<td><input id="control16" name="control16" type="text"
												value="<%=control[16] %>" style="width: 30px" /></td>
											<td></td>
											<td></td>
										</tr>


										<tr>

											<td colspan="4" style="text-align: left"><br /> <strong>ASPECTOS
													SOCIOECONÓMICOS</strong><br /> <br /></td>



										</tr>

										<tr>
											<td>Nivel Educativo *:</td>
											<td><select name="control17" id="control17">
													<option value="" >Seleccione..</option>
													<option value="1">PRIMARIA INCOMPLETA</option>
													<option value="2">PRIMARIA COMPLETA</option>
													<option value="3">SECUNDARIA INCOMPLETA</option>
													<option value="4">SECUNDARIA COMPLETA</option>
													<option value="5">TÉCNICO INCOMPLETO</option>
													<option value="6">TÉCNICO COMPLETO</option>
													<option value="7">TÉCNOLOGÍA INCOMPLETA</option>
													<option value="8">TÉCNOLOGÍA COMPLETA</option>
													<option value="9">UNIVERSIDAD INCOMPLETA</option>
													<option value="10">UNIVERSIDAD COMPLETA</option>
													<option value="11">POSGRADO</option>
													<option value="12">NINGUNO</option>
													<option value="13">OTRO</option>

											</select>
											
											<script>seleccionarCombo(17,"<%=control[17] %>");</script>
											</td>
											<td>Actividad Económica *:</td>
											<td><select name="control18" id="control18">
													<option value="" >Seleccione..</option>
													<option value="1">TRABAJA</option>
													<option value="2">ESTUDIA</option>
													<option value="3">TRABAJA Y ESTUDIA</option>
													<option value="4">TRABJA EN EL HOGAR</option>
													<option value="5">NO TRABAJA NI ESTUDIA</option>
													<option value="6">TRABAJA INDEPENDIENTE</option>
											</select>
											<script>seleccionarCombo(18,"<%=control[18] %>");</script>
											</td>
										</tr>
										<tr>

											<td colspan="4" style="text-align: left"><br /> <strong>ASPECTOS
													PARTICIPATIVOS</strong><br /> <br /></td>



										</tr>
										<tr>
											<td>Participa en alguna organización:</td>
											<td><select name="control19" id="control19">
													<option value="N">NO</option>
													<option value="S">SI</option>
											</select>
											<script>seleccionarCombo(19,"<%=control[19] %>");</script>
											</td>


											<td>Tiempo de Liderazgo:</td>
											<td>Años: <input id="control21" name="control21"
												type="text" value="<%=control[21] %>" style="width: 30px" />, Meses: <input
												id="control22" name="control22" type="text" value="<%=control[22] %>"
												style="width: 30px" />
											</td>

										</tr>
										<tr>
											<td>Organizaciones participando/participado:</td>
											<td><input id="control20" name="control20" type="text"
												value="<%=control[20] %>" /></td>

											<td></td>
											<td><br /> <br /></td>
										</tr>

										<tr>
											<td>¿En qué está usted capacitado(a)?:<br /></td>
											<td colspan="3"></td>
										</tr>

										<tr>
											<td colspan="4">
												<table style="width: 100%" cellpadding="2" cellspacing="2">
													<tr>
														<td bgcolor="#E81D8F"
															style="color: #FFFFFF; text-align: center">Capacitación
															Recibida</td>
														<td bgcolor="#E81D8F"
															style="color: #FFFFFF; text-align: center">Institución
															que la ofreció</td>
														<td bgcolor="#E81D8F"
															style="color: #FFFFFF; text-align: center">Nivel de
															Capacitación</td>
													</tr>
													<tr>
														<td>Liderazgo</td>
														<td style="text-align: center"><input id="control23"
															name="control23" type="text" value="<%=control[23] %>" /></td>
														<td style="text-align: center"><select
															name="control24" id="control24">
																<option value="">Seleccione..</option>
																<option value="A">ALTO</option>
																<option value="M">MEDIO</option>
																<option value="B">BAJO</option>
														</select>
														<script>seleccionarCombo(24,"<%=control[24] %>");</script>
														</td>
													</tr>
													<tr>
														<td>Gestión</td>
														<td style="text-align: center"><input id="control25"
															name="control25" type="text" value="<%=control[25] %>" /></td>
														<td style="text-align: center"><select
															name="control26" id="control26">
																<option value="">Seleccione..</option>
																<option value="A">ALTO</option>
																<option value="M">MEDIO</option>
																<option value="B">BAJO</option>
														</select>
														<script>seleccionarCombo(26,"<%=control[26] %>");</script>
														</td>
													</tr>
													<tr>
														<td>Legislación Comunal</td>
														<td style="text-align: center"><input id="control27"
															name="control27" type="text" value="<%=control[27] %>" /></td>
														<td style="text-align: center"><select
															name="control28" id="control28">
																<option value="">Seleccione..</option>
																<option value="A">ALTO</option>
																<option value="M">MEDIO</option>
																<option value="B">BAJO</option>
														</select>
														<script>seleccionarCombo(28,"<%=control[28] %>");</script>
														</td>
													</tr>
													<tr>
														<td>Participación</td>
														<td style="text-align: center"><input id="control29"
															name="control29" type="text" value="<%=control[29] %>" /></td>
														<td style="text-align: center"><select
															name="control30" id="control30">
																<option value="">Seleccione..</option>
																<option value="A">ALTO</option>
																<option value="M">MEDIO</option>
																<option value="B">BAJO</option>
														</select>
														<script>seleccionarCombo(30,"<%=control[30] %>");</script>
														</td>
													</tr>
													<tr>
														<td>Planeación</td>
														<td style="text-align: center"><input id="control31"
															name="control31" type="text" value="<%=control[31] %>" /></td>
														<td style="text-align: center"><select
															name="control32" id="control32">
																<option value="">Seleccione..</option>
																<option value="A">ALTO</option>
																<option value="M">MEDIO</option>
																<option value="B">BAJO</option>
														</select>
														<script>seleccionarCombo(32,"<%=control[32] %>");</script>
														</td>
													</tr>
													<tr>
														<td>Otra:<input id="control33" name="control33"
															type="text" value="<%=control[33] %>" />
														</td>
														<td style="text-align: center"><input id="control34"
															name="control34" type="text" value="<%=control[34] %>" /></td>
														<td style="text-align: center"><select
															name="control35" id="control35">
																<option value="">Seleccione..</option>
																<option value="A">ALTO</option>
																<option value="M">MEDIO</option>
																<option value="B">BAJO</option>
														</select>
														<script>seleccionarCombo(35,"<%=control[35] %>");</script>
														</td>
													</tr>
												</table>

											</td>

										</tr>
										<tr>
											<td><br /> <br /> <strong><%=control[35] %>OBERVACIONES</strong>:</td>
											<td colspan="3"><br /> <br /></td>

										</tr>
										<tr>

											<td colspan="4"><textarea cols="100" rows="10" name="control36" id="control36"><%=control[36] %></textarea></td>


										</tr>
									</table>
								</div>

<input name="id" id="id" type="hidden"
									value="<%=id%>" />

								<input name="hdnUs" id="hdnUs" type="hidden"
									value="<%=bUsuario.getIdUsuario()%>" /> <br /> <input
									type="button" value=" ACTUALIZAR " onclick="validarMujer();" /> &nbsp;<input
									type="button" value=" REGRESAR " onclick="document.form1.action='mujeres.jsp'; document.form1.submit(); " /> </a><br />
								<br /> <br />

							</div>
						</div>
						<!--END POST-->


					</div>
				</div>
			</div>
		</div>

		<!--END MAIN SECTION-->

		<!--FOOTER-->
	<footer><center>
	<div class="container">
		<img src="home_files/logo-sm.png" alt="">
		<ul class="list-inline social">
			<li><a href="https://www.facebook.com/fundacionmujeryfuturo" target="_blank"><i class="fa fa-facebook"></i></a></li>
			<li><a href="http://www.mujeryfuturo.org" target="_blank" ><i class="fa fa-twitter"></i></a></li>
			

		</ul>
		<p>
			Contacto: direccion@mujeryfuturo.org<br>Teléfonos: (+57-7)6341589 - (+57)3105765181<br>Diseñado por: quimerapps.com
		</p>
	</div></center>
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

		<script>
			esconderComuna();
		</script>
	</form>
</body>
</html>

