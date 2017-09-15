<%@ page contentType="text/html; charset=iso-8859-1" language="java"
	import="java.sql.*" import="java.util.*,java.text.SimpleDateFormat"
	session="false"%>
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

<script type="text/javascript" src="Scripts/tinymce/tinymce.min.js"></script>
<script type="text/javascript" src="Scripts/noticias.js"></script>
</head>
<body><div id="contenedor">
<%
String id = request.getParameter("id");
%>
<form method="post" name="form1" id="form1">  
<table border="0" width="100%" cellpadding="2">
	
	<tr>
		<td>* Tipo:</td>
		
		</tr>
		<tr>
		<td>
		<select name="tipo" id="tipo">
			<option value="U">UNICA RESPUESTA</option>
			<option value="M">MULTIPLE RESPUESTA</option>
			<option value="A">ABIERTA</option>
			<option value="T">TIEMPO</option>
		</select>
		
		</td>
		</tr>
	
	<tr>   
		<td ><span class="Estilo3"><span
			class="Estilo4 Estilo8">*</span>Pregunta:</span></td>
			</tr>
			<tr>
		<td >
		
		<textarea cols="80" id="pregunta" name="pregunta" rows="10" ><div></div></textarea>
		</td>
	</tr>
	<tr>
		<td ><div align="center"><span id="detalleActualizarDatos">
		  <input class="searchbutton"
			name="btnActualizarDatos" id="btnActualizarDatos" type="button"
			style="cursor: hand" value=" Crear "
			onClick="nuevaPregunta('<%=id%>'); return false;" /> 
	    </span></div></td>
	</tr>
</table>
<span id="detalle"></span>
</form>
</div>
</body>
</html>
<script type="text/javascript">
	//initSample();
	tinymce.init({    
				            selector: "#pregunta",
				            theme: "modern",
				            plugins: [
				                "advlist autolink lists link image charmap print preview hr anchor pagebreak",
				                "searchreplace wordcount visualblocks visualchars code fullscreen",
				                "insertdatetime media nonbreaking save table contextmenu directionality",
				                "emoticons template paste textcolor colorpicker textpattern imagetools",
				                
				                 
				            ],
				            toolbar1: "insertfile undo redo | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link image",
				            toolbar2: "print preview media | forecolor backcolor emoticons",
				           
				            image_advtab: true,
				            templates: [
				                {title: 'Test template 1', content: 'Test 1'},
				                {title: 'Test template 2', content: 'Test 2'}
				            ],
				        
				        
				            
				            
				        });

	tinymce.get('pregunta').insertContent('<div></div>'); 

	
</script>