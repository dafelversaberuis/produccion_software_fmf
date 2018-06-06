<%@page import="beans.Portafolio"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" import="java.sql.*,java.util.*,java.text.SimpleDateFormat"
    pageEncoding="ISO-8859-1" session="true"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="bAdministrarPublicaciones" class="beans.AdministrarPublicaciones" scope="page" />
<%@page import="beans.Publicacion"%>
<%@page import="beans.Parametro"%>
<%@page import="beans.Seccion"%>
<%@page import="beans.RepositorioFotos"%>	
<html>
<head>
        <title>SOFTWARE SIMYF</title>
    <meta name="Description" content="SOFTWARE SIMYF">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

  
	 <!-- librerias  -->
	<link rel="stylesheet" href="assets/css/bootstrap.css" type="text/css"/>
	<link rel="stylesheet" href="assets/css/bootstrap-datetimepicker.min.css" type="text/css"/>
	<link rel="stylesheet" href="assets/css/font-awesome.css" type="text/css" />
	<link rel="stylesheet" href="assets/css/font-awesome.min.css" type="text/css" />
	<link rel="stylesheet" href="assets/css/animate.min.css" type="text/css" />
	<link rel="stylesheet" href="assets/css/style.css" type="text/css" />
	<link rel="stylesheet" href="assets/css/menu.css" type="text/css" />
	<link rel="stylesheet" href="assets/css/slicknav.css">
	<link rel="stylesheet" href="assets/css/component.css" type="text/css" />
	<link rel="stylesheet" href="assets/css/cycleslider.css">
	<link rel="stylesheet" href="assets/css/supersized.css" type="text/css" media="screen" />
	<link rel="stylesheet" href="assets/css/supersized.shutter.css" type="text/css" media="screen" />
	<link type="text/css" rel="stylesheet" href="assets/css/portfolio_new.css"/>
	<link rel="stylesheet" href="assets/css/prettyPhoto.css" type="text/css" />
	<link rel="stylesheet" href="assets/css/colors/color1.css" id="color" type="text/css" />
	<link rel="shortcut icon" href="assets/assets/images/favicon.html" /> 
	<link rel="apple-touch-icon" href="assets/assets/images/apple_touch_icon.html" />
	<link rel="apple-touch-icon" sizes="72x72" href="assets/assets/images/apple_touch_icon_72x72.html" />
	<link rel="apple-touch-icon" sizes="114x114" href="assets/assets/images/apple_touch_icon_114x114.html" />
	<script src="assets/js/jquery-1.11.1.min.js"></script>
	<script src="assets/js/jquery-ui.min.js"></script>
	<script type="text/javascript" src="assets/js/modernizr.custom.js"></script>
	
		<script type="text/javascript" src="Scripts/noticias.js" charset="UTF-8"></script>
		
		<style type="text/css">
		
		sinestilo:{ 
		
		}
		
		@keyframes blinker {
  50% {
    opacity: 0;
  }
}
		
		</style>


 <script language="javascript" type="text/javascript">
function fMenu()
	{
		var vError1 = false;
		var vError2 = false;
		if(document.getElementById('usuario').value=="")
		{
			vError1=true;
		
		}
		if(document.getElementById('contrasena').value=="")
		{
			vError2=true;
		}
		if(vError1)
		{
			if(vError2)
			{
				alert('¡Debe digitar su documento y contraseña de administrador!');
				document.getElementById('usuario').focus();
				
			}else
			{
				alert('¡Debe digitar su documento!');
				document.getElementById('usuario').focus();
			}
		}else
		{
			if(vError2)
			{
				alert('¡Debe especificar la contraseña!');
				document.getElementById('contrasena').focus();
			}else
			{
				document.siss.submit();
			}
		
		}
		
	}
</script>
</head>
<body>
<!--PRELOADER-->
	<section id="jSplash">
		<div id="circle"></div>
	</section>
<div id="menutop"></div>	
    <%
session.invalidate(); 
					response.setHeader("Cache-Control","no-store");
					response.setHeader("Pragma","no-cache");
					response.setDateHeader("Expires",0);
					
					
					Parametro parametro = new Parametro();
					String [] parametros2  = parametro.getarametros();
					 %>
					 
<%

String bandera = request.getParameter("bandera");

String asunto = "";
String mensaje ="";
String usuarioEnvia ="";
String fromEnvia ="";
String nombreAdjuntoCorreo="";


String seudonimo = "";
String nombres = request.getParameter("nombres");

String correoe =  request.getParameter("correo");
String telefono =  request.getParameter("telefono");
String contenido = request.getParameter("txtContenido");

if(correoe==null){
	

	correoe =  "";
	
	
}

if(nombres==null){
	
	nombres = "";

	
}

if(telefono==null){
	
	
	telefono = "";
	
}

if(contenido==null){
	
	contenido = "";
	
}

if(bandera!=null && bandera.equals("1")){
	
	int exito = bAdministrarPublicaciones.contactar(correoe, nombres, telefono, contenido);
	
	if(exito==1){
		nombres = "";

		correoe =  "";
		telefono = "";
		contenido = "";
		%>
		<script>
alert('Información enviada con éxito');



		</script>
		<%
	}
}


%>					 
					 
					 
					 
	<!--Wrapper 
=============================-->
<div id="wrapper">
<div id="mask">
	
<!--Header 
=============================-->

<div id="header" class="header">
<div class="menu-inner">
<div class="container"><div class="row">
				<div class="header-table col-md-12 header-menu">
        			<!--  Logo section -->
                	<a href="#home" class="nav-link"><h1><font color="red">Fundación</font><br/> Mujer y Futuro</h1> </a>
                
                	
                    <!--  // Logo section -->

		<!-- Sub Page Menu section -->
	  <nav class="main-nav">
						<a href="#" class="nav-toggle"></a>
						<ul id="sub-nav" class="nav"> <li><a href="#home" class="nav-link">Regresar</a></li>
						 <li><a href="#administrador" class="nav-link">Logueo</a></li>
						  <li><a href="#encuestaOK" class="nav-link">Mujer, conoce tu aporte</a></li>
						  <li><a href="#videoOK" class="nav-link">Video explicativo</a></li>
						        
<%
				List<Publicacion> publicaciones = bAdministrarPublicaciones.getNotasPublicas(); int cuenta = 0; 
                List<Seccion> secciones = bAdministrarPublicaciones.getSecciones();
                List<Portafolio> portafolios = bAdministrarPublicaciones.getPortafolios();
                if(secciones!=null && secciones.size()>0){
                for(Seccion s: secciones){
                %>
                
                
                  <%} } %>
			
				  </ul>
				  </nav>
                  <!--  // Sub Page Menu section -->
               
				</div>
</div></div>   
</div>
</div>

<!-- // Header 
=============================-->

<!--Home Page
=============================-->

<div id="home" class="item">
				
				<div class="clearfix">
			<div class="header_details">
				<div class="container">
					<div class="header_icons accura-header-block accura-hidden-2xs">
						<!-- 						<ul class="accura-social-icons accura-stacked accura-jump accura-full-height accura-bordered accura-small accura-colored-bg clearFix">
						<li id="1"><a href="https://www.facebook.com/fundacionmujeryfuturo?fref=ts" target="_blank" class="accura-social-icon-facebook circle"><i class="fa fa-facebook"></i></a></li>
					    <li id="2"><a href="http://www.twitter.com/" target="_blank" class="accura-social-icon-twitter circle"><i class="fa fa-twitter"></i></a></li>
-->
					   
						
					  </ul>
					</div>
				<div class="call">
					<div class="home_address" style="font-size:24px">
				<span style="color:red; animation: blinker 1s linear infinite;">SIMYF</span>, Herramienta informática que da<br/>
un valor al trabajo no remunerado de las mujeres,<br/>cuando trabajan en acciones comunitarias.</div>
					</div>
			</div>
<!-- Mainheader Menu Section -->
<script type="text/javascript">if(typeof wabtn4fg==="undefined"){wabtn4fg=1;h=document.head||document.getElementsByTagName("head")[0],s=document.createElement("script");s.type="text/javascript";s.src="//whatsapp-sharing.com/button";h.appendChild(s);}</script>	
<div class="mainheaderslide" id="slide">
	<div id="mainheader" class="header">
		<div class="menu-inner">
			<div class="container">
				<div class="row">
        <div class="header-table col-md-13 header-menu">
        
        <!--  Logo section --> 
        <div class="brand" style="bgcolor:#000000; height: 90px" ><a href="#home" class="nav-link" style="font-size:23px; line-height:1.2">
			
				<%
	String absoluta  = request.getRealPath("/imagenes/logosLogos/");
	bAdministrarPublicaciones.logoDinamico(absoluta);
	%>
	<img src="imagenes/logosLogos/logo_financiador_OK.jpg" alt="logo" width="230px" height="100px">
			
			
			</a></div>
        <!--  // Logo section -->
        
<!-- Home Page Menu section -->
						<nav class="main-nav">
						<a href="#" class="nav-toggle"></a>
							<ul  id="home_nav" class="nav">
							<% if(secciones!=null && secciones.size()>0){
                for(Seccion s: secciones){
                %>
               
                
                  <%} } %>
						
							<li><a href="#encuestaOK" class="nav-link">Mujer, conoce tu aporte</a></li>
						     
                             	
							
							</ul>
					  </nav>
<!--  // Home Page Menu section -->
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
            <!-- // Mainheader Menu Section -->
		</div>
			<div id="boxgallery" class="boxgallery" data-effect="effect-2">
			<%
	 List<RepositorioFotos> fotos = bAdministrarPublicaciones.getRepositorioFotos();
	%>
				<%
	if(fotos!=null && fotos.size()>0){ for(RepositorioFotos r: fotos){%>
				<div class="panel"><img src="imagenes/cursos/<%=r.getDireccionFoto().trim() %>?rf=<%=Math.random()%>" alt="Mujer y futuro"/></div>
	
	
	<%}} %>
			
			
				
			
			</div>
		</div>
	</div>
		
<!-- // Home Page
=============================-->






<!-- admin
=============================--> 

<div id="administrador" class="item">
			<img src="assets/img/me6.jpg"  alt="the Paxton Gipsy Hill"  class="fullBg">
			<div class="content">
            
				<div class="content_overlay"></div>
				<div class="content_inner" >
                <div class="row contentscroll">
	<div class="container col-md-12">
          <div class="col-md-6 empty">&nbsp;</div>
		  			      <div class="col-md-6 content_text">
                          <div id="contactforms">
                           <h1>LOGUEO</h1>
                           <form id="siss" name="siss" action="home.jsp" method="post"> 
			<p>Por favor ingrese al módulo administrador:<br/><br/></p>
			
		   	
			
			<div class="clearfix cont_form pad_top20"> 
				<input type="text" name="usuario"  id="usuario"  placeholder="* Documento : " style="background-color: #D1D6E2; width: 100%"
                    onfocus="this.placeholder = ''" onBlur="this.placeholder = '* Documento :'" /><br><br><br><input type="password" name="contrasena" id="contrasena" placeholder="* Clave : " style="width: 100%; background-color: #D1D6E2"
                    onfocus="this.placeholder = ''" onBlur="this.placeholder = '* Clave :'" /><br><br><input name="button" type="button" class="submitBtn"  onclick="fMenu()" value="Ingresar" style="background-color:red; color: white; width: 150px" />    
                </div>
				</form>
	</div>
                          </div>
    </div>
                </div>
				</div>
		  </div>
	</div>

   <!-- admin
=============================-->    


<!-- encuesta
=============================--> 

<div id="encuestaOK" class="item">
			<img src="imagenes/cursos/curso_1.jpg"  alt="Mujer y futuro"  class="fullBg">
			<div class="content">
            
				<div class="content_overlay_fullwidth"></div>
				<div class="content_inner" >
                <div class="row contentscroll">
	<div class="container col-md-12">
          
		  			      <div class="col-md-12 content_text">
                          <div id="contactforms">
                           <h1>Mujer, conoce tu aporte</h1>
                           
                           
                           <form id="form1" name="form1" action="index.jsp" method="post"> 
			<p>Para comenzar escriba su documento y presione continuar:<br/><br/></p>
			
			<input type="hidden" id="id_mujer_encuesta" name="id_mujer_encuesta" value="">
			
			<table width="100%" cellpadding="2" cellspacing="2"><tr><td><input type="text" name="documento_mujer" id="documento_mujer" value="" style="background-color: #D1D6E2; width: 100%"></td><td>&nbsp; <input type="button" style="background-color:red; color: white; width: 150px" value="  Continuar  " class="submitBtn" onclick="cargarOpcionesMujer();"></td></tr></table>
			<span id="detalleAdministradores">
				
		   	</span>
			
				</form>
				
				
				
	</div>
                          </div>
    </div>
                </div>
				</div>
		  </div>
	</div>
	
	
	<!-- video tutorial
=============================--> 

<div id="videoOK" class="item">
			<img src="imagenes/cursos/curso_1.jpg"  alt="Mujer y futuro"  class="fullBg">
			<div class="content">
            
				<div class="content_overlay_fullwidth"></div>
				<div class="content_inner" >
                <div class="row contentscroll">
	<div class="container col-md-12">
          
		  			      <div class="col-md-12 content_text">
                          <div id="contactforms">
                           <h1>Video-tutorial</h1>
                           
                           
                          
			<p>Video-tutorial: Uso del software por parte de las mujeres que aportan y se capacitan con la fundación.<br/><br/></p>
			
			<iframe width="560" height="315" src="https://www.youtube.com/embed/YvC1BKB6UT0" frameborder="0" allowfullscreen></iframe>
				
				
				
	</div>
                          </div>
    </div>
                </div>
				</div>
		  </div>
	</div>

   <!-- admin
=============================--> 

















<!-- Gallery  SS
=============================--> 

<div id="galleryss" class="item">

	<!--Thumbnail Navigation-->
	<div id="prevthumb"></div>
	<div id="nextthumb"></div>
	
	<!--Arrow Navigation-->
	<a id="prevslide" class="load-item"></a>
	<a id="nextslide" class="load-item"></a>
	
	<div id="thumb-tray" class="load-item">
		<div id="thumb-back"></div>
		<div id="thumb-forward"></div>
	</div>
	
	<!--Time Bar-->
	<div id="progress-back" class="load-item">
		<div id="progress-bar"></div>
	</div>
	
	<!--Control Bar-->
	<div id="controls-wrapper" class="load-item">
		<div id="controls">
			
			
		
			<!--Slide counter-->
			<div id="slidecounter">
				<span class="slidenumber"></span> / <span class="totalslides"></span>			</div>
			
			<!--Slide captions displayed here-->
			<div id="slidecaption"></div>
			
			<!--Thumb Tray button-->
			<a id="tray-button"><img id="tray-arrow" src="img/button-tray-up.png" alt=""/></a>
			
			<!--Navigation-->
			<ul id="slide-list"></ul>
		</div>
	</div>
<div class="gal-top">
		<div class="container">
			<div class="galheading galleft"><h1>Gallery Super-Sized</h1></div>
		</div>
	</div>
</div>

<!-- // Gallery  SS Ends
=============================--> 




<!-- Filter Gallery 
=============================--> 

<div id="filtergallery" class="item">

<div class="content contentscroll">
            <div class="content_overlay_fullwidth"></div>
<section class="portfolio">
 <!-- Portfolio Section -->    
  <section class="section">
    <div class="container">
	  <div class="prettygalheading clearfix text-center"><h1>Gallery Filter</h1>
      	<p class="text-center pad_top13">Nutritionists, naturopaths, doctors, and journalists weigh in on topics organic food.</p>
      </div>
      <!-- Portfolio Filters -->
      <ul id="filters">
          
      </ul>
      <!-- End Portfolio Filters -->
    </div>
    <div class="portfolio-top"></div> 
    <!-- Portfolio Grid -->
    <ul id="portfolio-grid" class="portfolio-grid">
	
    </ul>
    <!-- End Portfolio Grid -->
  </section>
  <!-- End Portfolio Section -->
 </section>
 </div>
</div>

<!-- // Filter Gallery 
=============================--> 




<!-- Gallery Without Filter
=============================--> 

<div id="gallerywithoutfilter" class="item">
<img src="assets/img/me16.jpg" alt="The Spice Lounge" class="fullBg">
<div class="content contentscroll">
            <div class="content_overlay_fullwidth"></div>
<section class="portfolio">
 <!-- Portfolio Section -->    
  <section class="section">
    <div class="container">
	  <div class="prettygalheading clearfix text-center"><h1>Galería de Fotos</h1></div>
    </div>
    <div class="portfolio-top"></div> 
    <p class="text-center pad_top13">Nuestras imágenes.</p>
	
    <!-- Portfolio Grid -->
    <ul class="portfolio-grid">
	
     
     
     
     
    </ul>
    <!-- End Portfolio Grid -->
  </section>
  <!-- End Portfolio Section -->
 </section>
 </div>
</div>

<!-- // Gallery Without Filter
=============================--> 




<!-- galeria de fotos
=============================--> 
	
	<input type="hidden" value="<%=fotos.size()%>" id="numeroFotos"/>
 <div id="galeriadefotos" class="item">
			<img src="assets/img/me17.jpg" alt="The Spice Lounge" class="fullBg">
			<div class="content">
                             
				<div class="content_overlay"></div>
				<div class="content_inner">
					<div class="row contentscroll">
	<div class="container col-md-12">
          <div class="col-md-6 empty">&nbsp;</div>
                          <div class="col-md-6 content_text">
                          <div class="clearfix" >
                          <h1>Galería</h1>
                          <p class="pad_top13">Nuestras imágenes.</p>
							
<div class="clearfix pad_top20">
 <div class="two_half">
	<ul class="portfolio-grid">
	<%
	if(fotos!=null && fotos.size()>0){ for(RepositorioFotos r: fotos){%>
	
	 <li class="mix all food vimeo mix_all">
	     <div class="view3 third-effect3"><img src="imagenes/cursos/<%=r.getDireccionFoto().trim() %>?rf=<%=Math.random()%>" alt="">
			<div class="mask"><a href="imagenes/cursos/<%=r.getDireccionFoto().trim() %>?rf=<%=Math.random()%>"  data-rel="prettyPhoto[gallery2]" class="viewDetail lightbox info">
            <div class="project-overlay">
          	<h3>Mujer y fututo</h3>
		  	<span class="project-name">Fotos</span>          </div>
            </a>            </div>
	     </div>
     </li>
     
      <%} }%>
     
     
      
    </ul>	
</div>
</div>													
			</div>
</div>
           </div>
    </div>
         </div>
	</div>
</div>

<!-- // galeria de fotos
=============================--> 









<!--certificado 
=============================-->

<div id="certificado" class="item three_fourth">
				<img src="assets/img/me18.jpg" alt="The Spice Lounge" class="fullBg">
				<div class="content">
					<div class="content_overlay_three_fourth"></div>
                        <div class="content_inner">
<div class="row contentscroll">
	<div class="container">
          <div class="col-md-3 empty">&nbsp;</div>
    <div class="col-md-9 content_text">
                          <h1>Certificado online</h1>
						  	
								<p class="row">
								<p>Por favor digite su documento y presione consultar:</p>
								</p>
															
									
			<div class="clearfix cont_form pad_top20"> 
				<input name="documento_certificado" type="text" id="documento_certificado" class="validate['required'] documento_certificado" placeholder="* Escriba aquí su documento " style="background-color: #D1D6E2; width: 50%"
                    onfocus="this.placeholder = ''" onBlur="this.placeholder = '* Escriba aquí su documento'" /><br><br>
				<input id="validarDocumento" value="Consultar" name="validarDocumento" type="button"  class="submitBtn" onclick="validarLoteConsulta2(); return false;" style="background-color:red; color: white; width: 150px">
                </div>
			<br><br>
			<span id="detalleLote" style="text-align: center"></span>
							
						
             
    </div>
                </div>
					</div>
	  </div>
    </div> </div> 


		
		    
<!-- // certificado 
=============================-->









<!-- contactenos
=============================-->

<div id="contactenos" class="item">
			<img src="assets/img/me5.jpg"  alt="the Paxton Gipsy Hill"  class="fullBg">
			<div class="content">
            
				<div class="content_overlay"></div>
				<div class="content_inner" >
                <div class="row contentscroll">
	<div class="container col-md-12">
          <div class="col-md-6 empty">&nbsp;</div>
		  			      <div class="col-md-6 content_text">
                          <div id="contactforms">
                           <h1>Contáctenos</h1>
                           <form id="contact_form" name="contact_form" class="cont_form pad_top13" action="#" method="post"> <input name="bandera" id="bandera" type="hidden" value="0" />
			<p>Puedes comunicarte con nosotros para lo que desees(Con nuestros datos o redes sociales) ó escribe en el formulario y te responderemos enseguida:</p>
			<div class="clearfix pad_top20">
					<h2 class="clearfix address">
				<div class="phone"><i class="fa fa-phone"></i>&nbsp;&nbsp;</div>
				
					<i class="fa fa-envelope"></i> 
				<div class="clearfix">
			</div>
		   	
			
			<div class="clearfix cont_form pad_top20"> 
				<input name="nombres" type="text" id="nombres" class="validate['required'] textbox1" placeholder="* Nombre : "
                    onfocus="this.placeholder = ''" onBlur="this.placeholder = '* Nombre :'" />
				<input name="correo" type="text" id="correo"  class="validate['required','email']  textbox1"
                    placeholder="* Email : " onFocus="this.placeholder = ''" onBlur="this.placeholder = '* Email :'" />
				<input name="telefono" type="text" id="telefono" class="validate['required','phone']  textbox1"
                    placeholder="* teléfono : " onFocus="this.placeholder = ''" onBlur="this.placeholder = '* Teléfono :'" />
				<textarea name="txtContenido"   id="txtContenido" class="validate['required'] messagebox1"
                    placeholder="* Escribe aquí : " onFocus="this.placeholder = ''" onBlur="this.placeholder = '* Escribe aquí :'"></textarea>
				<input id="contactsubmitBtn1" value="Enviar mensaje" name="Confirm" type="submit" class="submitBtn" onclick="enviar_formulario(); return false;" >
                </div>
				</form>
	</div>
                          </div>
    </div>
                </div>
				</div>
		  </div>
	</div>

<!-- // contactenos
=============================-->




<!-- Footer
=============================-->
<div id="footer" class="footer">
	<div class="copyright">Diseñado por Quimerapps.com</div>
</div>
<!-- // Footer Ends
=============================-->


<!--portafolio
=============================-->
<div id="specialmenu" class="toHideTheBubbles hidden-phone">
	<div class="spcontainer">
	<div id="spmenu1">  <a href="#administrador" class="nav-link"><button class="spmenu spmenu3" >
			<span><i class="fa fa-sign-in"></i></span>
			<span class="sptext"><span>Logueo</span>Admin</span>
		</button></a> </div>
     
		
    </div>
</div>
<!-- // portafolio 
=============================-->








<!-- inicio2 librerias-->
<script type="text/javascript" src="assets/js/bootstrap.min.js"></script>
<script type="text/javascript" src="assets/js/jquery.validate.min.js"></script>
<script type="text/javascript" src="assets/js/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript" src="assets/js/jquery.scrollTo.min.js"></script>
<script type="text/javascript" src="assets/js/jquery.fitvids.js"></script>

<script type="text/javascript" src="assets/js/jquery.slicknav.min.js"></script>
<script src="assets/js/jquery.nicescroll.min.js"></script>
<script type="text/javascript" src="assets/js/jquery.mousewheel.min.js"></script>
<script type="text/javascript" src="assets/js/jquery.easing.1.3.js"></script>
<script type="text/javascript" src="assets/js/retina-1.1.0.min.js"></script>
<script type="text/javascript" src="assets/js/jpreloader.min.js"></script>
<script type="text/javascript" src="assets/js/jquery.cycle.all.js"></script>
<script type="text/javascript" src="assets/js/jquery.cycle2.caption2.js"></script>
<script type="text/javascript" src="assets/js/supersized.3.2.7.min.js"></script>
<script type="text/javascript" src="assets/js/supersized.shutter.min.js"></script>
<script type="text/javascript" src="assets/js/supersized_custom.js"></script>
<script type="text/javascript" src="assets/js/jquery.prettyPhoto.js"></script>
<script type="text/javascript" src="assets/js/jquery.mixitup.min.js"></script>
<script type="text/javascript" src="assets/js/classie.js"></script>
<script type="text/javascript" src="assets/js/boxesFx.js"></script>
<script type="text/javascript" src="assets/js/wait.js"></script>
<script type="text/javascript" src="assets/js/jquery.placeholder.min.js"></script>
<script type="text/javascript" src="assets/js/custom_general_box.js"></script>
<script type="text/javascript" src="assets/js/custom_general.js"></script>

<!-- fin2 librerias-->

</body>

</html>
<script>

function enviar_formulario(){

	mensaje = "";
	
	if(document.getElementById('nombres').value.replace(/^\s*|\s*$/g, "")==""){
		mensaje = mensaje + "\n* Debe diligenciar nombre completo.";
	}
	
	
	if(document.getElementById('correo').value.replace(/^\s*|\s*$/g, "")==""){
		mensaje = mensaje + "\n* Debe diligenciar el correo electrónico.";
	}
	
	if ((document.contact_form.correo.value!="") && (!es_correo(document.contact_form.correo.value)))
	{
		mensaje = mensaje + "\n* El correo electrónico no tiene una estructura válida.";
		
	}
	
	if(document.getElementById('telefono').value.replace(/^\s*|\s*$/g, "")==""){
		mensaje = mensaje + "\n* Debe diligenciar el teléfono ó celular.";
	}
	
	if ((document.contact_form.telefono.value!="") && (!es_numero(document.contact_form.telefono.value)))
	{
		mensaje = mensaje + "\n* El teléfono ó celular contiene caractéres no válidos (Debe ser numérico).";
		
	}
	
	if(document.getElementById('txtContenido').value.replace(/^\s*|\s*$/g, "")==""){
		mensaje = mensaje + "\n* Debe diligenciar el correo electrónico.";
	}
	
	
	
	
	
	
	
	
	
	if(mensaje!=""){
				alert("Por favor revise lo siguiente:\n\n "+mensaje);
	
	}else{
		
		
			document.getElementById('bandera').value = "1";
			document.contact_form.submit();	
	}
	
}


function limpiar_formulario(){
	

	document.getElementById('nombres').value = "";
	document.getElementById('correo').value = "";
	document.getElementById('telefono').value = "";
	document.getElementById('txtContenido').value = "";
	alert('Formulario limpiado');
	document.contact_form.nombres.focus();
	

	
}

function es_correo(direccion) 
{
	var filter  = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
	if (filter.test(direccion)) return true;
	else return false;
}


function es_numero(cadena)
{
	var longit = cadena.length;
	
	for(k=0;k<longit;k++)
	{
		var car = cadena.charAt(k);
		if ((car!='1') && (car!='2') && (car!='3') && (car!='4') && (car!='5') && (car!='6') && (car!='7') && (car!='8') && (car!='9') && (car!='0'))
			return false;
	}
	if (longit>0) return true;
	else return false;
}



$(document).ready(function(){
	//$('#bloquecontenido').attr('class', 'sinestilo');
	//$('#bloquecontenido').attr('class', 'sinestilo');
	//alert('ssssssssss');	
	jQuery('#bloquecontenido').css({'color' : 'blue' });
	});
	
	




</script>
<script language="javascript">


	function genrarTabla() {

		tabla = document.getElementById("Exportar_a_Excel").innerHTML;
	
		document.getElementById("datos_a_enviar").value = tabla;
		
		document.FormularioExportacion.submit();
	

	}
</script>