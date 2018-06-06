<%@page import="beans.Parametro"%>
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
String p = request.getParameter("p");

Object[] pregunta = bAdministrarPublicaciones.getNombrePregunta(p);


//tiempo asociado
if(pregunta[5]==null){
	pregunta[5] = "";
}


%>
<form method="post" name="form1" id="form1">  
<table border="0" width="100%" cellpadding="2">
	
	<tr>
		<td>* Tipo:</td>
		</tr>
		<tr>
		<td>
		<select name="tipo" id="tipo" disabled="true">
			<option value="U">UNICA RESPUESTA</option>
			<option value="M">MULTIPLE RESPUESTA</option>
			<option value="A">ABIERTA</option>
			<option value="T">TIEMPO</option>
		</select>
		<script>
					document.getElementById('tipo').value="<%=pregunta[3]%>";

		</script>
		
		</td>
		</tr>
	
	<tr>   
		<td ><span class="Estilo3"><span
			class="Estilo4 Estilo8">*</span>Pregunta:</span></td>
			</tr>
			<tr>
		<td >
		
		<textarea cols="80" id="pregunta" name="pregunta" rows="10" ><%=pregunta[2]%></textarea>
		</td>
	</tr>
	
	<%
	    List<Object[]> parametrosG = bAdministrarPublicaciones.getPreguntas(id);
		
		//List<Object[]> parametrosG = bAdministrarPublicaciones.getParametrosGlobales();
		
		String tt = "disabled";
		if(pregunta[3]!=null && pregunta[3].toString().trim().equals("T")){
			tt="";
		}
		
	%>
	<tr>   
		<td ><span class="Estilo3"><span
			class="Estilo4 Estilo8">*</span>Pregunta a la que se le asocia (SOLO PARA TIEMPOS):</span></td>
			</tr>
			<tr>
		<td >
		
		<select name="parametro_asociado" id="parametro_asociado" style="width:250px" <%=tt %>>
			<option value="">Seleccione</option>
			<%
			
			if(parametrosG!=null && parametrosG.size()>0){
				for(Object[] o: parametrosG){
					if(o[3]!=null && !o[2].equals("T") && !o[0].equals(p)){
						%>
						<option value="<%=o[0]%>"><%=o[2]%></option>
					
					<%
					}
				}
			}
			
			%>
			
			
		</select>
		<script>
					document.getElementById('parametro_asociado').value="<%=pregunta[5]%>";
					

		</script>
		</td>
	</tr>
	

	<tr>
		<td ><div align="center"><span id="detalleActualizarDatos">
		  <input class="searchbutton"
			name="btnActualizarDatos" id="btnActualizarDatos" type="button"
			style="cursor: hand" value=" Editar "
			onClick="editarPregunta('<%=p%>'); return false;" /> 
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

	//tinymce.get('pregunta').insertContent('<div></div>'); 

	
</script>