var mensaje3 = "";

// IsNumeric('-1')

function isEmailAddress2(theElement, nombre_del_elemento) {
	mensaje3 = "";
	var s = theElement.value;
	var filter = /^[A-Za-z][A-Za-z0-9_]*@[A-Za-z0-9_]+\.[A-Za-z0-9_.]+[A-za-z]$/;
	if (s.length == 0)
		return true;
	if (filter.test(s))
		return true;
	else
		mensaje3 = "* INGRESE UNA DIRECCION DE CORREO VALIDA\n";
	// theElement.focus();
	return false;
}

function nuevoPortafolio() {

	var mensaje = "";

	if (document.getElementById('txtTitulo').value.replace(/^\s*|\s*$/g, "") == "") {
		mensaje = mensaje + "* DIGITE EL TITULO DEL SERVICIO\n";
	}

	if (document.getElementById('txtContenido').value.replace(/^\s*|\s*$/g, "") == "") {
		mensaje = mensaje + "* DIGITE EL CONTENIDO DEL SERVICIO\n";
	}

	if (mensaje.replace(/^\s*|\s*$/g, "") == "") {
		cargarCrearPortafolio();

	} else {
		alert(mensaje);
	}

}

function cargarCrearPortafolio() {
	ajax = nuevoAjax();
	parametros = "t=" + document.getElementById("txtTitulo").value + "&c="
			+ document.getElementById("txtContenido").value;
	url = "/f-web/nuevaCreacionPortafolio.jsp";
	ajax.onreadystatechange = function() {
		if (ajax.readyState == 1) {
			document.getElementById('detalle').innerHTML = "<img src='images/ajax/ajax-loader3.gif'> ";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('detalle').innerHTML = "";
				document.getElementById('detalle').style.background = "";
				document.getElementById('detalle').innerHTML = ajax.responseText;

				if (parseInt(document.getElementById("hdnExito").value) == 1) {
					alert('SERVICIO DEL PORTAFOLIO CREADO CON EXITO');
					window.opener.cargarPortafolios();
					try {
						window.opener.document.form1.submit();
					} catch (e) {
					}
					window.close();
				} else {
					alert('NO SE PUEDE CREAR EL SERVICIO');
				}

			} else if (ajax.status == 404) {
				document.getElementById('detalle').innerHTML = "-Inexistencia, contacte administrador-";
			} else {
				document.getElementById('detalle').innerHTML = "-Error, contacte administrador";
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type',
			'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(parametros);
}

function editarPregunta(pregunta) {

	var mensaje = "";

	// if (document.getElementById('pregunta').value.replace(/^\s*|\s*$/g, "")
	// == "") {
	// mensaje = mensaje + "* Escriba la pregunta\n";
	// }
	// alert(document.getElementById('pregunta').value);

	if (tinyMCE.get('pregunta').getContent().replace(/^\s*|\s*$/g, "") == "") {

		mensaje = mensaje + "\n * ESCRIBA LA PREGUNTA.\n";
	}

	if (document.getElementById('tipo').value.replace(/^\s*|\s*$/g, "") == "T") {

		if (document.getElementById('parametro_asociado').value.replace(
				/^\s*|\s*$/g, "") == "") {

			mensaje = mensaje
					+ "\n * DEBE SELECCIONAR EL PARAMETRO ASOCIADO.\n";

		}

	}

	// alert(2);

	if (mensaje.replace(/^\s*|\s*$/g, "") == "") {
		cargarEditarPregunta(pregunta);

	} else {
		alert(mensaje);
	}

}

function nuevaPregunta(id) {

	var mensaje = "";

	// if (document.getElementById('pregunta').value.replace(/^\s*|\s*$/g, "")
	// == "") {
	// mensaje = mensaje + "* Escriba la pregunta\n";
	// }
	// alert(document.getElementById('pregunta').value);

	if (tinyMCE.get('pregunta').getContent().replace(/^\s*|\s*$/g, "") == "") {

		mensajes = mensajes + " * ESCRIBA LA PREGUNTA.\n";
	}

	// alert(2);

	if (mensaje.replace(/^\s*|\s*$/g, "") == "") {
		cargarCrearPregunta(id);

	} else {
		alert(mensaje);
	}

}

function editarOpcion(id) {

	var mensaje = "";

	// if (document.getElementById('opcion').value.replace(/^\s*|\s*$/g, "") ==
	// "") {
	// mensaje = mensaje + "* ESCRIBA LA OPCION DE RESPUESTA\n";
	// }

	if (mensaje.replace(/^\s*|\s*$/g, "") == "") {
		cargarEditarOpcion(id);

	} else {
		alert(mensaje);
	}

}

function nuevaOpcion(id) {

	var mensaje = "";

	// if (document.getElementById('opcion').value.replace(/^\s*|\s*$/g, "") ==
	// "") {
	// mensaje = mensaje + "* ESCRIBA LA OPCION DE RESPUESTA\n";
	// }

	if (mensaje.replace(/^\s*|\s*$/g, "") == "") {
		cargarCrearOpcion(id);

	} else {
		alert(mensaje);
	}

}

function editarTema(id) {

	var mensaje = "";

	if (document.getElementById('txtCurso').value.replace(/^\s*|\s*$/g, "") == "") {
		mensaje = mensaje + "* Escriba el nombre del tema\n";
	}

	if (mensaje.replace(/^\s*|\s*$/g, "") == "") {
		cargarEditarTema(id);

	} else {
		alert(mensaje);
	}

}

function nuevoFinanciadorC(id) {

	var mensaje = "";

	if (document.getElementById('financiador').value.replace(/^\s*|\s*$/g, "") == "") {
		mensaje = mensaje + "* Seleccione financiador a agregar\n";
	}

	if (mensaje.replace(/^\s*|\s*$/g, "") == "") {
		cargarCrearFinanciadorC(id);

	} else {
		alert(mensaje);
	}

}

function nuevaLineaC(id) {

	var mensaje = "";

	if (document.getElementById('linea').value.replace(/^\s*|\s*$/g, "") == "") {
		mensaje = mensaje + "* Seleccione la l�nea a agregar\n";
	}

	if (mensaje.replace(/^\s*|\s*$/g, "") == "") {
		cargarCrearLineaC(id);

	} else {
		alert(mensaje);
	}

}

function nuevaParticipacion(id) {

	var mensaje = "";

	if (document.getElementById('niveles').value.replace(/^\s*|\s*$/g, "") == "") {
		mensaje = mensaje + "* Seleccione tipo de participaci�n\n";
	} else {

		datos = document.getElementById('niveles').value.split("-");
		if (datos != null && datos[1] == "S") {

			if (document.getElementById('cual').value.replace(/^\s*|\s*$/g, "") == "") {

				mensaje = mensaje + "* Especifique cual ?.\n";

			}

		}

	}

	if (document.getElementById('tipo').value.replace(/^\s*|\s*$/g, "") == "") {
		mensaje = mensaje + "* Seleccione el tipo de participacion\n";
	}

	if (document.getElementById('cargos').value.replace(/^\s*|\s*$/g, "") == "") {
		mensaje = mensaje + "* Seleccione el cargo \n";
	}

	if (mensaje.replace(/^\s*|\s*$/g, "") == "") {
		cargarCrearParticipacion(id);

	} else {
		alert(mensaje);
	}

}

function nuevaCapacitacion(id) {

	var mensaje = "";

	if (document.getElementById('niveles').value.replace(/^\s*|\s*$/g, "") == "") {
		mensaje = mensaje + "* Seleccione capacitaci�n recibida\n";
	} else {

		datos = document.getElementById('niveles').value.split("-");
		if (datos != null && datos[1] == "S") {

			if (document.getElementById('cual').value.replace(/^\s*|\s*$/g, "") == "") {

				mensaje = mensaje + "* Especifique cual ?.\n";

			}

		}

	}

	if (document.getElementById('percepcion').value.replace(/^\s*|\s*$/g, "") == "") {
		mensaje = mensaje + "* Seleccione la percepci�n\n";
	}

	if (document.getElementById('institucion').value.replace(/^\s*|\s*$/g, "") == "") {
		mensaje = mensaje + "* Escriba la instituci�n\n";
	}

	if (document.getElementById('tiempo').value.replace(/^\s*|\s*$/g, "") == "") {
		mensaje = mensaje + "* Seleccione el tiempo\n";
	}

	if (mensaje.replace(/^\s*|\s*$/g, "") == "") {
		cargarCrearCapacitacion(id);

	} else {
		alert(mensaje);
	}

}

function nuevoNivel(id) {

	var mensaje = "";

	if (document.getElementById('niveles').value.replace(/^\s*|\s*$/g, "") == "") {
		mensaje = mensaje + "* Seleccione un nivel\n";
	} else {

		datos = document.getElementById('niveles').value.split("-");
		if (datos != null && datos[1] == "S") {

			if (document.getElementById('cual').value.replace(/^\s*|\s*$/g, "") == "") {

				mensaje = mensaje + "* Especifique cual ?.\n";

			}

		}

	}

	if (mensaje.replace(/^\s*|\s*$/g, "") == "") {
		cargarCrearNivel(id);

	} else {
		alert(mensaje);
	}

}

function nuevaActividad(id) {

	var mensaje = "";
	swrango = 0;

	if (document.getElementById('niveles').value.replace(/^\s*|\s*$/g, "") == "") {
		mensaje = mensaje + "* Seleccione un nivel\n";
	} else {

		datos = document.getElementById('niveles').value.split("-");
		if (datos != null && datos[1] == "S") {

			if (document.getElementById('cual').value.replace(/^\s*|\s*$/g, "") == "") {

				mensaje = mensaje + "* Especifique cual ?.\n";

			}

		}

	}

	if (document.getElementById('rango').value.replace(/^\s*|\s*$/g, "") == "") {
		mensaje = mensaje + "* Seleccione un rango de salario mensual\n";
		swrango = 1;
	}

	if (document.getElementById('minimo').value.replace(/^\s*|\s*$/g, "") == "") {
		mensaje = mensaje + "* Diligencie un ingreso promedio semanal\n";
	} else {

		if (swrango == 0) {

			if (document.getElementById('rango').value
					.replace(/^\s*|\s*$/g, "") == "1") {

				if (parseFloat(document.getElementById('minimo').value.replace(
						/^\s*|\s*$/g, "")) < 0
						|| parseFloat(document.getElementById('minimo').value
								.replace(/^\s*|\s*$/g, "")) > parseFloat(document
								.getElementById('salario1').value.replace(
								/^\s*|\s*$/g, ""))) {

					mensaje = mensaje
							+ "* El ingreso promedio semanal debe estar entre 0 y "
							+ document.getElementById('salario1').value + "\n";

				}

			}

			if (document.getElementById('rango').value
					.replace(/^\s*|\s*$/g, "") == "2") {

				if (parseFloat(document.getElementById('minimo').value.replace(
						/^\s*|\s*$/g, "")) < parseFloat(document
						.getElementById('salario1').value.replace(/^\s*|\s*$/g,
						""))
						|| parseFloat(document.getElementById('minimo').value
								.replace(/^\s*|\s*$/g, "")) > parseFloat(document
								.getElementById('salario2').value.replace(
								/^\s*|\s*$/g, ""))) {

					mensaje = mensaje
							+ "* El ingreso promedio semanal debe estar entre "
							+ parseFloat(document.getElementById('salario1').value
									.replace(/^\s*|\s*$/g, "")) + " y "
							+ document.getElementById('salario2').value + "\n";

				}

			}

			if (document.getElementById('rango').value
					.replace(/^\s*|\s*$/g, "") == "3") {

				if (parseFloat(document.getElementById('minimo').value.replace(
						/^\s*|\s*$/g, "")) < parseFloat(document
						.getElementById('salario2').value.replace(/^\s*|\s*$/g,
						""))
						|| parseFloat(document.getElementById('minimo').value
								.replace(/^\s*|\s*$/g, "")) > parseFloat(document
								.getElementById('salario3').value.replace(
								/^\s*|\s*$/g, ""))) {

					mensaje = mensaje
							+ "* El ingreso promedio semanal debe estar entre "
							+ parseFloat(document.getElementById('salario2').value
									.replace(/^\s*|\s*$/g, "")) + " y "
							+ document.getElementById('salario3').value + "\n";

				}

			}

			if (document.getElementById('rango').value
					.replace(/^\s*|\s*$/g, "") == "4") {

				if (parseFloat(document.getElementById('minimo').value.replace(
						/^\s*|\s*$/g, "")) < parseFloat(document
						.getElementById('salario3').value.replace(/^\s*|\s*$/g,
						""))
						|| parseFloat(document.getElementById('minimo').value
								.replace(/^\s*|\s*$/g, "")) > parseFloat(document
								.getElementById('salario4').value.replace(
								/^\s*|\s*$/g, ""))) {

					mensaje = mensaje
							+ "* El ingreso promedio semanal debe estar entre "
							+ parseFloat(document.getElementById('salario3').value
									.replace(/^\s*|\s*$/g, "")) + " y "
							+ document.getElementById('salario4').value + "\n";

				}

			}

			if (document.getElementById('rango').value
					.replace(/^\s*|\s*$/g, "") == "5") {

				if (parseFloat(document.getElementById('minimo').value.replace(
						/^\s*|\s*$/g, "")) < parseFloat(document
						.getElementById('salario4').value.replace(/^\s*|\s*$/g,
						""))
						|| parseFloat(document.getElementById('minimo').value
								.replace(/^\s*|\s*$/g, "")) > parseFloat(document
								.getElementById('salario5').value.replace(
								/^\s*|\s*$/g, ""))) {

					mensaje = mensaje
							+ "* El ingreso promedio semanal debe estar entre "
							+ parseFloat(document.getElementById('salario4').value
									.replace(/^\s*|\s*$/g, "")) + " y "
							+ document.getElementById('salario5').value + "\n";

				}

			}

			if (document.getElementById('rango').value
					.replace(/^\s*|\s*$/g, "") == "6") {

				if (parseFloat(document.getElementById('minimo').value.replace(
						/^\s*|\s*$/g, "")) < parseFloat(document
						.getElementById('salario5').value.replace(/^\s*|\s*$/g,
						""))) {

					mensaje = mensaje
							+ "* El ingreso promedio semanal debe ser mayor o igual a "
							+ parseFloat(document.getElementById('salario5').value
									.replace(/^\s*|\s*$/g, "")) + "\n";

				}

			}

		}

	}

	if (mensaje.replace(/^\s*|\s*$/g, "") == "") {
		cargarCrearActividad(id);

	} else {
		alert(mensaje);
	}

}

function nuevoTema(id) {

	var mensaje = "";

	if (document.getElementById('txtCurso').value.replace(/^\s*|\s*$/g, "") == "") {
		mensaje = mensaje + "* Escriba el nombre del tema\n";
	}

	if (mensaje.replace(/^\s*|\s*$/g, "") == "") {
		cargarCrearTema(id);

	} else {
		alert(mensaje);
	}

}

function validarFechas2(date, date2) {
	var x = new Date();
	var y = new Date();
	var fecha = date.split("-");
	var fecha2 = date2.split("-");
	x.setFullYear(fecha[0], fecha[1] - 1, fecha[2]);
	y.setFullYear(fecha2[0], fecha2[1] - 1, fecha2[2]);

	if (x > y)
		return true;
	else
		return false;
}

function editarEncuesta(id) {

	var mensaje = "";

	if (document.getElementById('encuesta').value.replace(/^\s*|\s*$/g, "") == "") {
		mensaje = mensaje + "* Escriba el nombre de la encuesta\n";
	}

	if (document.getElementById('fecha_desde').value.replace(/^\s*|\s*$/g, "") == "") {
		mensaje = mensaje + "* Seleccione la fecha desde\n";
	}

	if (document.getElementById('fecha_hasta').value.replace(/^\s*|\s*$/g, "") == "") {
		mensaje = mensaje + "* Seleccione la fecha hasta\n";
	}

	if (document.getElementById('fecha_desde').value.replace(/^\s*|\s*$/g, "") != ""
			&& document.getElementById('fecha_hasta').value.replace(
					/^\s*|\s*$/g, "") != "") {
		if (validarFechas2(document.getElementById('fecha_desde').value,
				document.getElementById('fecha_hasta').value)) {
			mensaje = mensaje
					+ "* La fecha hasta debe ser mayor o igual a la fecha desde\n";
		}
	}

	if (mensaje.replace(/^\s*|\s*$/g, "") == "") {
		cargarEditarEncuesta(id);

	} else {
		alert(mensaje);
	}

}

function nuevaEncuesta() {

	var mensaje = "";

	if (document.getElementById('encuesta').value.replace(/^\s*|\s*$/g, "") == "") {
		mensaje = mensaje + "* Escriba el nombre de la encuesta\n";
	}

	if (document.getElementById('fecha_desde').value.replace(/^\s*|\s*$/g, "") == "") {
		mensaje = mensaje + "* Seleccione la fecha desde\n";
	}

	if (document.getElementById('fecha_hasta').value.replace(/^\s*|\s*$/g, "") == "") {
		mensaje = mensaje + "* Seleccione la fecha hasta\n";
	}

	if (document.getElementById('fecha_desde').value.replace(/^\s*|\s*$/g, "") != ""
			&& document.getElementById('fecha_hasta').value.replace(
					/^\s*|\s*$/g, "") != "") {
		if (validarFechas2(document.getElementById('fecha_desde').value,
				document.getElementById('fecha_hasta').value)) {
			mensaje = mensaje
					+ "* La fecha hasta debe ser mayor o igual a la fecha desde\n";
		}
	}

	if (mensaje.replace(/^\s*|\s*$/g, "") == "") {
		cargarCrearEncuesta();

	} else {
		alert(mensaje);
	}

}

function nuevoProyectoLinea() {

	var mensaje = "";

	if (document.getElementById('proyecto').value.replace(/^\s*|\s*$/g, "") == "") {
		mensaje = mensaje + "* Seleccione un proyecto\n";
	}

	if (document.getElementById('linea').value.replace(/^\s*|\s*$/g, "") == "") {
		mensaje = mensaje + "* Seleccione una l�nea estrat�gica\n";
	}

	if (document.getElementById('financiador').value.replace(/^\s*|\s*$/g, "") == "") {
		mensaje = mensaje + "* Seleccione un financiador\n";
	}

	if (mensaje.replace(/^\s*|\s*$/g, "") == "") {
		cargarCrearProyectoLinea();

	} else {
		alert(mensaje);
	}

}

function nuevaLinea() {

	var mensaje = "";

	if (document.getElementById('txtCurso').value.replace(/^\s*|\s*$/g, "") == "") {
		mensaje = mensaje + "* Escriba el nombre de la l�nea\n";
	}

	if (mensaje.replace(/^\s*|\s*$/g, "") == "") {
		cargarCrearLinea();

	} else {
		alert(mensaje);
	}

}

function nuevoProyecto() {

	var mensaje = "";

	if (document.getElementById('txtCurso').value.replace(/^\s*|\s*$/g, "") == "") {
		mensaje = mensaje + "* Escriba el nombre del proyecto\n";
	}

	if (mensaje.replace(/^\s*|\s*$/g, "") == "") {
		cargarCrearProyecto();

	} else {
		alert(mensaje);
	}

}

function nuevoFinanciador() {

	var mensaje = "";

	if (document.getElementById('txtCurso').value.replace(/^\s*|\s*$/g, "") == "") {
		mensaje = mensaje + "* Escriba el nombre del financiador\n";
	}

	if (mensaje.replace(/^\s*|\s*$/g, "") == "") {
		cargarCrearFinanciador();

	} else {
		alert(mensaje);
	}

}

function editarCurso(id) {

	var mensaje = "";

	if (document.getElementById('txtCurso').value.replace(/^\s*|\s*$/g, "") == "") {
		mensaje = mensaje + "* Escriba el nombre del curso\n";
	}

	if (document.getElementById('proyecto').value.replace(/^\s*|\s*$/g, "") == "") {
		mensaje = mensaje
				+ "* Seleccione el proyecto al que pertenece el curso\n";
	}

	if (mensaje.replace(/^\s*|\s*$/g, "") == "") {
		cargarEditarCurso(id);

	} else {
		alert(mensaje);
	}

}

function nuevoCurso() {

	var mensaje = "";

	if (document.getElementById('txtCurso').value.replace(/^\s*|\s*$/g, "") == "") {
		mensaje = mensaje + "* Escriba el nombre del curso\n";
	}

	if (document.getElementById('proyecto').value.replace(/^\s*|\s*$/g, "") == "") {
		mensaje = mensaje
				+ "* Seleccione el proyecto al que pertenece el curso\n";
	}

	if (mensaje.replace(/^\s*|\s*$/g, "") == "") {
		cargarCrearCurso();

	} else {
		alert(mensaje);
	}

}

function cargarEditarPregunta(pregunta) {
	ajax = nuevoAjax();
	parametros = "id="
			+ pregunta
			+ "&c="
			+ encodeURIComponent(tinyMCE.get('pregunta').getContent().replace(
					/^\s*|\s*$/g, "")) + "&tipo="
			+ document.getElementById("tipo").value + "&parametro="
			+ document.getElementById("parametro_asociado").value;
	url = "/f-web/nuevaEdicionPregunta.jsp";
	ajax.onreadystatechange = function() {
		if (ajax.readyState == 1) {
			document.getElementById('detalle').innerHTML = "<img src='images/ajax/ajax-loader3.gif'> ";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('detalle').innerHTML = "";
				document.getElementById('detalle').style.background = "";
				document.getElementById('detalle').innerHTML = ajax.responseText;

				if (parseInt(document.getElementById("hdnExito").value) == 1) {
					alert('PREGUNTA EDITADA CON EXITO');
					// window.opener.cargarTemas(id);
					try {
						window.opener.document.form1.submit();
					} catch (e) {
					}
					window.close();
				} else {
					alert('NO SE PUEDE EDITAR LA PREGUNTA');
				}

			} else if (ajax.status == 404) {
				document.getElementById('detalle').innerHTML = "-Inexistencia, contacte administrador-";
			} else {
				document.getElementById('detalle').innerHTML = "-Error, contacte administrador";
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type',
			'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(parametros);
}

function cargarCrearPregunta(id) {
	ajax = nuevoAjax();
	parametros = "id="
			+ id
			+ "&c="
			+ encodeURIComponent(tinyMCE.get('pregunta').getContent().replace(
					/^\s*|\s*$/g, "")) + "&tipo="
			+ document.getElementById("tipo").value;
	url = "/f-web/nuevaCreacionPregunta.jsp";
	ajax.onreadystatechange = function() {
		if (ajax.readyState == 1) {
			document.getElementById('detalle').innerHTML = "<img src='images/ajax/ajax-loader3.gif'> ";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('detalle').innerHTML = "";
				document.getElementById('detalle').style.background = "";
				document.getElementById('detalle').innerHTML = ajax.responseText;

				if (parseInt(document.getElementById("hdnExito").value) == 1) {
					alert('PREGUNTA CREADA CON EXITO');
					// window.opener.cargarTemas(id);
					try {
						window.opener.document.form1.submit();
					} catch (e) {
					}
					window.close();
				} else {
					alert('NO SE PUEDE CREAR LA PREGUNTA');
				}

			} else if (ajax.status == 404) {
				document.getElementById('detalle').innerHTML = "-Inexistencia, contacte administrador-";
			} else {
				document.getElementById('detalle').innerHTML = "-Error, contacte administrador";
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type',
			'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(parametros);
}

function cargarEditarOpcion(id) {
	ajax = nuevoAjax();
	parametros = "id="
			+ id
			+ "&c="
			+ encodeURIComponent(tinyMCE.get('opcion').getContent().replace(
					/^\s*|\s*$/g, "")) + "&a="
			+ document.getElementById('aclarar').value;

	url = "/f-web/nuevaEdicionOpcion.jsp";
	ajax.onreadystatechange = function() {
		if (ajax.readyState == 1) {
			document.getElementById('detalle').innerHTML = "<img src='images/ajax/ajax-loader3.gif'> ";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('detalle').innerHTML = "";
				document.getElementById('detalle').style.background = "";
				document.getElementById('detalle').innerHTML = ajax.responseText;

				if (parseInt(document.getElementById("hdnExito").value) == 1) {
					alert('OPCION DE RESPUESTA EDITADA CON EXITO');
					// window.opener.cargarTemas(id);
					try {
						window.opener.document.form1.submit();
					} catch (e) {
					}
					window.close();
				} else {
					alert('NO SE PUEDE EDITAR LA OPCION DE RESPUESTA');
				}

			} else if (ajax.status == 404) {
				document.getElementById('detalle').innerHTML = "-Inexistencia, contacte administrador-";
			} else {
				document.getElementById('detalle').innerHTML = "-Error, contacte administrador";
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type',
			'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(parametros);
}

function cargarCrearOpcion(id) {
	ajax = nuevoAjax();
	parametros = "id="
			+ id
			+ "&c="
			+ encodeURIComponent(tinyMCE.get('opcion').getContent().replace(
					/^\s*|\s*$/g, "")) + "&a="
			+ document.getElementById('aclarar').value;

	url = "/f-web/nuevaCreacionOpcion.jsp";
	ajax.onreadystatechange = function() {
		if (ajax.readyState == 1) {
			document.getElementById('detalle').innerHTML = "<img src='images/ajax/ajax-loader3.gif'> ";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('detalle').innerHTML = "";
				document.getElementById('detalle').style.background = "";
				document.getElementById('detalle').innerHTML = ajax.responseText;

				if (parseInt(document.getElementById("hdnExito").value) == 1) {
					alert('OPCION DE RESPUESTA CREADA CON EXITO');
					// window.opener.cargarTemas(id);
					try {
						window.opener.document.form1.submit();
					} catch (e) {
					}
					window.close();
				} else {
					alert('NO SE PUEDE CREAR LA OPCION DE RESPUESTA');
				}

			} else if (ajax.status == 404) {
				document.getElementById('detalle').innerHTML = "-Inexistencia, contacte administrador-";
			} else {
				document.getElementById('detalle').innerHTML = "-Error, contacte administrador";
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type',
			'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(parametros);
}

function cargarEditarTema(id) {
	ajax = nuevoAjax();
	parametros = "id=" + id + "&c="
			+ encodeURIComponent(document.getElementById("txtCurso").value);
	url = "/f-web/nuevaEdicionTema.jsp";
	ajax.onreadystatechange = function() {
		if (ajax.readyState == 1) {
			document.getElementById('detalle').innerHTML = "<img src='images/ajax/ajax-loader3.gif'> ";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('detalle').innerHTML = "";
				document.getElementById('detalle').style.background = "";
				document.getElementById('detalle').innerHTML = ajax.responseText;

				if (parseInt(document.getElementById("hdnExito").value) == 1) {
					alert('TEMA EDITADO CON EXITO');
					// window.opener.cargarTemas(id);
					try {
						window.opener.document.form1.submit();
					} catch (e) {
					}
					window.close();
				} else {
					alert('NO SE EDITAR EL TEMA');
				}

			} else if (ajax.status == 404) {
				document.getElementById('detalle').innerHTML = "-Inexistencia, contacte administrador-";
			} else {
				document.getElementById('detalle').innerHTML = "-Error, contacte administrador";
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type',
			'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(parametros);
}

function cargarCrearFinanciadorC(id) {
	ajax = nuevoAjax();
	parametros = "id=" + id + "&c="
			+ encodeURIComponent(document.getElementById("financiador").value);
	url = "/f-web/nuevaCreacionFinanciadorC.jsp";
	ajax.onreadystatechange = function() {
		if (ajax.readyState == 1) {
			document.getElementById('detalle').innerHTML = "<img src='images/ajax/ajax-loader3.gif'> ";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('detalle').innerHTML = "";
				document.getElementById('detalle').style.background = "";
				document.getElementById('detalle').innerHTML = ajax.responseText;

				if (parseInt(document.getElementById("hdnExito").value) == 1) {
					alert('FINANCIADOR AGREGADO CON EXITO, ADEMAS SE MODIFICO EL PORCENTAJE DE PARTICIPACION');
					// window.opener.cargarTemas(id);
					try {
						window.opener.document.form1.submit();
					} catch (e) {
					}
					window.close();
				} else {
					alert('NO SE PUEDE AGREGAR EL FINANCIADOR');
				}

			} else if (ajax.status == 404) {
				document.getElementById('detalle').innerHTML = "-Inexistencia, contacte administrador-";
			} else {
				document.getElementById('detalle').innerHTML = "-Error, contacte administrador";
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type',
			'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(parametros);
}

function cargarCrearLineaC(id) {
	ajax = nuevoAjax();
	parametros = "id=" + id + "&c="
			+ encodeURIComponent(document.getElementById("linea").value);
	url = "/f-web/nuevaCreacionLineaC.jsp";
	ajax.onreadystatechange = function() {
		if (ajax.readyState == 1) {
			document.getElementById('detalle').innerHTML = "<img src='images/ajax/ajax-loader3.gif'> ";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('detalle').innerHTML = "";
				document.getElementById('detalle').style.background = "";
				document.getElementById('detalle').innerHTML = ajax.responseText;

				if (parseInt(document.getElementById("hdnExito").value) == 1) {
					alert('LINEA AGREGADA CON EXITO, ADEMAS SE MODIFICO EL PORCENTAJE DE PARTICIPACION');
					// window.opener.cargarTemas(id);
					try {
						window.opener.document.form1.submit();
					} catch (e) {
					}
					window.close();
				} else {
					alert('NO SE PUEDE AGREGAR LA LINEA ESTRATEGICA');
				}

			} else if (ajax.status == 404) {
				document.getElementById('detalle').innerHTML = "-Inexistencia, contacte administrador-";
			} else {
				document.getElementById('detalle').innerHTML = "-Error, contacte administrador";
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type',
			'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(parametros);
}

function cambiarRango() {

	if (document.getElementById("rango").value != "") {

		document.getElementById('minimo').value = document
				.getElementById("salario"
						+ document.getElementById('rango').value).value;

	} else {

		document.getElementById("minimo").value = "";

	}

}

function cambiarNivel() {

	document.getElementById("label").style.display = 'none';
	document.getElementById("cual").style.display = 'none';

	if (document.getElementById("niveles").value != "") {

		valores = document.getElementById("niveles").value.split("-");

		if (valores[1] == "S") {

			document.getElementById("label").style.display = 'block';
			document.getElementById("cual").style.display = 'block';
		}

	}

}

function cargarCrearActividad(id) {
	ajax = nuevoAjax();
	parametros = "id=" + id + "&c="
			+ encodeURIComponent(document.getElementById("niveles").value)
			+ "&cual=" + document.getElementById("cual").value + "&rango="
			+ document.getElementById("rango").value + "&minimo="
			+ document.getElementById("minimo").value;
	url = "/f-web/nuevaCreacionActividad.jsp";
	ajax.onreadystatechange = function() {
		if (ajax.readyState == 1) {
			document.getElementById('detalle').innerHTML = "<img src='images/ajax/ajax-loader3.gif'> ";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('detalle').innerHTML = "";
				document.getElementById('detalle').style.background = "";
				document.getElementById('detalle').innerHTML = ajax.responseText;

				if (parseInt(document.getElementById("hdnExito").value) == 1) {
					alert('ACTIVIDAD ECONOMICA AGREGADA CON EXITO');
					// window.opener.cargarTemas(id);
					try {
						window.opener.document.form1.submit();
					} catch (e) {
					}
					window.close();
				} else {
					alert('NO SE PUEDE AGREGAR LA ACTIVIDAD ECONOMICA');
				}

			} else if (ajax.status == 404) {
				document.getElementById('detalle').innerHTML = "-Inexistencia, contacte administrador-";
			} else {
				document.getElementById('detalle').innerHTML = "-Error, contacte administrador";
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type',
			'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(parametros);
}

function cargarCrearCapacitacion(id) {
	ajax = nuevoAjax();
	parametros = "id=" + id + "&c="
			+ encodeURIComponent(document.getElementById("niveles").value)
			+ "&cual=" + document.getElementById("cual").value
			+ "&institucion=" + document.getElementById("institucion").value
			+ "&percepcion=" + document.getElementById("percepcion").value
			+ "&tiempo=" + document.getElementById("tiempo").value;
	url = "/f-web/nuevaCreacionCapacitacion.jsp";
	ajax.onreadystatechange = function() {
		if (ajax.readyState == 1) {
			document.getElementById('detalle').innerHTML = "<img src='images/ajax/ajax-loader3.gif'> ";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('detalle').innerHTML = "";
				document.getElementById('detalle').style.background = "";
				document.getElementById('detalle').innerHTML = ajax.responseText;

				if (parseInt(document.getElementById("hdnExito").value) == 1) {
					alert('CAPACITACION AGREGADA CON EXITO');
					// window.opener.cargarTemas(id);
					try {
						window.opener.document.form1.submit();
					} catch (e) {
					}
					window.close();
				} else {
					alert('NO SE PUEDE AGREGAR LA CAPACITACION');
				}

			} else if (ajax.status == 404) {
				document.getElementById('detalle').innerHTML = "-Inexistencia, contacte administrador-";
			} else {
				document.getElementById('detalle').innerHTML = "-Error, contacte administrador";
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type',
			'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(parametros);
}

function cargarCrearNivel(id) {
	ajax = nuevoAjax();
	parametros = "id=" + id + "&c="
			+ encodeURIComponent(document.getElementById("niveles").value)
			+ "&cual=" + document.getElementById("cual").value;
	url = "/f-web/nuevaCreacionNivel.jsp";
	ajax.onreadystatechange = function() {
		if (ajax.readyState == 1) {
			document.getElementById('detalle').innerHTML = "<img src='images/ajax/ajax-loader3.gif'> ";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('detalle').innerHTML = "";
				document.getElementById('detalle').style.background = "";
				document.getElementById('detalle').innerHTML = ajax.responseText;

				if (parseInt(document.getElementById("hdnExito").value) == 1) {
					alert('NIVEL DE ESTUDIO AGREGADO CON EXITO');
					// window.opener.cargarTemas(id);
					try {
						window.opener.document.form1.submit();
					} catch (e) {
					}
					window.close();
				} else {
					alert('NO SE PUEDE AGREGAR EL NIVEL DE ESTUDIO');
				}

			} else if (ajax.status == 404) {
				document.getElementById('detalle').innerHTML = "-Inexistencia, contacte administrador-";
			} else {
				document.getElementById('detalle').innerHTML = "-Error, contacte administrador";
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type',
			'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(parametros);
}

function cargarCrearParticipacion(id) {
	ajax = nuevoAjax();
	parametros = "id=" + id + "&c="
			+ encodeURIComponent(document.getElementById("niveles").value)
			+ "&cual=" + document.getElementById("cual").value + "&tipo="
			+ document.getElementById("tipo").value + "&cargos="
			+ document.getElementById("cargos").value;
	url = "/f-web/nuevaCreacionParticipacion.jsp";
	ajax.onreadystatechange = function() {
		if (ajax.readyState == 1) {
			document.getElementById('detalle').innerHTML = "<img src='images/ajax/ajax-loader3.gif'> ";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('detalle').innerHTML = "";
				document.getElementById('detalle').style.background = "";
				document.getElementById('detalle').innerHTML = ajax.responseText;

				if (parseInt(document.getElementById("hdnExito").value) == 1) {
					alert('PARTICIPACION AGREGADA CON EXITO');
					// window.opener.cargarTemas(id);
					try {
						window.opener.document.form1.submit();
					} catch (e) {
					}
					window.close();
				} else {
					alert('NO SE PUEDE AGREGAR LA PARTICIPACION');
				}

			} else if (ajax.status == 404) {
				document.getElementById('detalle').innerHTML = "-Inexistencia, contacte administrador-";
			} else {
				document.getElementById('detalle').innerHTML = "-Error, contacte administrador";
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type',
			'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(parametros);
}

function cargarCrearTema(id) {
	ajax = nuevoAjax();
	parametros = "id=" + id + "&c="
			+ encodeURIComponent(document.getElementById("txtCurso").value);
	url = "/f-web/nuevaCreacionTema.jsp";
	ajax.onreadystatechange = function() {
		if (ajax.readyState == 1) {
			document.getElementById('detalle').innerHTML = "<img src='images/ajax/ajax-loader3.gif'> ";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('detalle').innerHTML = "";
				document.getElementById('detalle').style.background = "";
				document.getElementById('detalle').innerHTML = ajax.responseText;

				if (parseInt(document.getElementById("hdnExito").value) == 1) {
					alert('TEMA CREADO CON EXITO');
					// window.opener.cargarTemas(id);
					try {
						window.opener.document.form1.submit();
					} catch (e) {
					}
					window.close();
				} else {
					alert('NO SE PUEDE CREAR EL TEMA');
				}

			} else if (ajax.status == 404) {
				document.getElementById('detalle').innerHTML = "-Inexistencia, contacte administrador-";
			} else {
				document.getElementById('detalle').innerHTML = "-Error, contacte administrador";
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type',
			'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(parametros);
}

function cargarEditarEncuesta(id) {
	ajax = nuevoAjax();
	parametros = "id=" + id + "&c="
			+ encodeURIComponent(document.getElementById("encuesta").value)
			+ "&fecha_desde=" + document.getElementById("fecha_desde").value
			+ "&fecha_hasta=" + document.getElementById("fecha_hasta").value;
	url = "/f-web/nuevaEdicionEncuesta.jsp";
	ajax.onreadystatechange = function() {
		if (ajax.readyState == 1) {
			document.getElementById('detalle').innerHTML = "<img src='images/ajax/ajax-loader3.gif'> ";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('detalle').innerHTML = "";
				document.getElementById('detalle').style.background = "";
				document.getElementById('detalle').innerHTML = ajax.responseText;

				if (parseInt(document.getElementById("hdnExito").value) == 1) {
					alert('ENCUESTA EDITADA CON EXITO');
					// window.opener.cargarEncu;
					try {
						window.opener.document.form1.submit();
					} catch (e) {
					}
					window.close();
				} else {
					alert('NO SE PUEDE EDITAR LA ENCUESTA');
				}

			} else if (ajax.status == 404) {
				document.getElementById('detalle').innerHTML = "-Inexistencia, contacte administrador-";
			} else {
				document.getElementById('detalle').innerHTML = "-Error, contacte administrador";
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type',
			'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(parametros);
}

function cargarCrearEncuesta() {
	ajax = nuevoAjax();
	parametros = "c="
			+ encodeURIComponent(document.getElementById("encuesta").value)
			+ "&fecha_desde=" + document.getElementById("fecha_desde").value
			+ "&fecha_hasta=" + document.getElementById("fecha_hasta").value;
	url = "/f-web/nuevaCreacionEncuesta.jsp";
	ajax.onreadystatechange = function() {
		if (ajax.readyState == 1) {
			document.getElementById('detalle').innerHTML = "<img src='images/ajax/ajax-loader3.gif'> ";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('detalle').innerHTML = "";
				document.getElementById('detalle').style.background = "";
				document.getElementById('detalle').innerHTML = ajax.responseText;

				if (parseInt(document.getElementById("hdnExito").value) == 1) {
					alert('ENCUESTA CREADA CON EXITO');
					// window.opener.cargarEncu;
					try {
						window.opener.document.form1.submit();
					} catch (e) {
					}
					window.close();
				} else {
					alert('NO SE PUEDE CREAR LA ENCUESTA');
				}

			} else if (ajax.status == 404) {
				document.getElementById('detalle').innerHTML = "-Inexistencia, contacte administrador-";
			} else {
				document.getElementById('detalle').innerHTML = "-Error, contacte administrador";
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type',
			'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(parametros);
}

function cargarCrearProyectoLinea() {
	ajax = nuevoAjax();
	parametros = "p="
			+ encodeURIComponent(document.getElementById("proyecto").value)
			+ "&l="
			+ encodeURIComponent(document.getElementById("linea").value)
			+ "&f="
			+ encodeURIComponent(document.getElementById("financiador").value);
	url = "/f-web/nuevaCreacionProyectoLinea.jsp";
	ajax.onreadystatechange = function() {
		if (ajax.readyState == 1) {
			document.getElementById('detalle').innerHTML = "<img src='images/ajax/ajax-loader3.gif'> ";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('detalle').innerHTML = "";
				document.getElementById('detalle').style.background = "";
				document.getElementById('detalle').innerHTML = ajax.responseText;

				if (parseInt(document.getElementById("hdnExito").value) == 1) {
					alert('RELACION PROYECTO-LINEA-FINANCIADOR CREADA CON EXITO');
					window.opener.cargarProyectosLineas();
					try {
						window.opener.document.form1.submit();
					} catch (e) {
					}
					window.close();
				} else {
					alert('NO SE PUEDE CREAR LA RELACION PROYECTO-LINEA-FINANCIADOR');
				}

			} else if (ajax.status == 404) {
				document.getElementById('detalle').innerHTML = "-Inexistencia, contacte administrador-";
			} else {
				document.getElementById('detalle').innerHTML = "-Error, contacte administrador";
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type',
			'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(parametros);
}

function cargarCrearLinea() {
	ajax = nuevoAjax();
	parametros = "c="
			+ encodeURIComponent(document.getElementById("txtCurso").value);
	url = "/f-web/nuevaCreacionLinea.jsp";
	ajax.onreadystatechange = function() {
		if (ajax.readyState == 1) {
			document.getElementById('detalle').innerHTML = "<img src='images/ajax/ajax-loader3.gif'> ";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('detalle').innerHTML = "";
				document.getElementById('detalle').style.background = "";
				document.getElementById('detalle').innerHTML = ajax.responseText;

				if (parseInt(document.getElementById("hdnExito").value) == 1) {
					alert('LINEA CREADA CON EXITO');
					window.opener.cargarLineas();
					try {
						window.opener.document.form1.submit();
					} catch (e) {
					}
					window.close();
				} else {
					alert('NO SE PUEDE CREAR LA LINEA');
				}

			} else if (ajax.status == 404) {
				document.getElementById('detalle').innerHTML = "-Inexistencia, contacte administrador-";
			} else {
				document.getElementById('detalle').innerHTML = "-Error, contacte administrador";
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type',
			'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(parametros);
}

function cargarCrearProyecto() {
	ajax = nuevoAjax();
	parametros = "c="
			+ encodeURIComponent(document.getElementById("txtCurso").value);
	url = "/f-web/nuevaCreacionProyecto.jsp";
	ajax.onreadystatechange = function() {
		if (ajax.readyState == 1) {
			document.getElementById('detalle').innerHTML = "<img src='images/ajax/ajax-loader3.gif'> ";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('detalle').innerHTML = "";
				document.getElementById('detalle').style.background = "";
				document.getElementById('detalle').innerHTML = ajax.responseText;

				if (parseInt(document.getElementById("hdnExito").value) == 1) {
					alert('PROYECTO CREADO CON EXITO');
					window.opener.cargarProyectos();
					try {
						window.opener.document.form1.submit();
					} catch (e) {
					}
					window.close();
				} else {
					alert('NO SE PUEDE CREAR EL PROYECTO');
				}

			} else if (ajax.status == 404) {
				document.getElementById('detalle').innerHTML = "-Inexistencia, contacte administrador-";
			} else {
				document.getElementById('detalle').innerHTML = "-Error, contacte administrador";
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type',
			'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(parametros);
}

function cargarCrearFinanciador() {
	ajax = nuevoAjax();
	parametros = "c="
			+ encodeURIComponent(document.getElementById("txtCurso").value);
	url = "/f-web/nuevaCreacionFinanciador.jsp";
	ajax.onreadystatechange = function() {
		if (ajax.readyState == 1) {
			document.getElementById('detalle').innerHTML = "<img src='images/ajax/ajax-loader3.gif'> ";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('detalle').innerHTML = "";
				document.getElementById('detalle').style.background = "";
				document.getElementById('detalle').innerHTML = ajax.responseText;

				if (parseInt(document.getElementById("hdnExito").value) == 1) {
					alert('FINANCIADOR CREADO CON EXITO');
					window.opener.cargarFinanciadores();
					try {
						window.opener.document.form1.submit();
					} catch (e) {
					}
					window.close();
				} else {
					alert('NO SE PUEDE CREAR EL FINANCIADOR');
				}

			} else if (ajax.status == 404) {
				document.getElementById('detalle').innerHTML = "-Inexistencia, contacte administrador-";
			} else {
				document.getElementById('detalle').innerHTML = "-Error, contacte administrador";
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type',
			'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(parametros);
}

function cargarEditarCurso(id) {
	ajax = nuevoAjax();
	parametros = "id=" + id + "&c="
			+ encodeURIComponent(document.getElementById("txtCurso").value)
			+ "&p="
			+ encodeURIComponent(document.getElementById("proyecto").value);
	url = "/f-web/nuevaEdicionCurso.jsp";
	ajax.onreadystatechange = function() {
		if (ajax.readyState == 1) {
			document.getElementById('detalle').innerHTML = "<img src='images/ajax/ajax-loader3.gif'> ";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('detalle').innerHTML = "";
				document.getElementById('detalle').style.background = "";
				document.getElementById('detalle').innerHTML = ajax.responseText;

				if (parseInt(document.getElementById("hdnExito").value) == 1) {
					alert('CURSO EDITADO CON EXITO');
					window.opener.cargarCursos();
					try {
						window.opener.document.form1.submit();
					} catch (e) {
					}
					window.close();
				} else {
					alert('NO SE PUEDE EDITAR EL CURSO');
				}

			} else if (ajax.status == 404) {
				document.getElementById('detalle').innerHTML = "-Inexistencia, contacte administrador-";
			} else {
				document.getElementById('detalle').innerHTML = "-Error, contacte administrador";
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type',
			'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(parametros);
}

function cargarCrearCurso() {
	ajax = nuevoAjax();
	parametros = "c="
			+ encodeURIComponent(document.getElementById("txtCurso").value)
			+ "&p="
			+ encodeURIComponent(document.getElementById("proyecto").value);
	url = "/f-web/nuevaCreacionCurso.jsp";
	ajax.onreadystatechange = function() {
		if (ajax.readyState == 1) {
			document.getElementById('detalle').innerHTML = "<img src='images/ajax/ajax-loader3.gif'> ";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('detalle').innerHTML = "";
				document.getElementById('detalle').style.background = "";
				document.getElementById('detalle').innerHTML = ajax.responseText;

				if (parseInt(document.getElementById("hdnExito").value) == 1) {
					alert('CURSO CREADO CON EXITO');
					window.opener.cargarCursos();
					try {
						window.opener.document.form1.submit();
					} catch (e) {
					}
					window.close();
				} else {
					alert('NO SE PUEDE CREAR EL CURSO');
				}

			} else if (ajax.status == 404) {
				document.getElementById('detalle').innerHTML = "-Inexistencia, contacte administrador-";
			} else {
				document.getElementById('detalle').innerHTML = "-Error, contacte administrador";
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type',
			'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(parametros);
}

function nuevoAdmin() {

	var mensaje = "";

	if (document.getElementById('txtDocumento').value.replace(/^\s*|\s*$/g, "") == "") {
		mensaje = mensaje + "* DIGITE EL DOCUMENTO DE IDENTIFICACION\n";
	}

	if (document.getElementById('txtNombre1').value.replace(/^\s*|\s*$/g, "") == "") {
		mensaje = mensaje + "* DIGITE EL PRIMER NOMBRE\n";
	}

	if (document.getElementById('txtApellido1').value.replace(/^\s*|\s*$/g, "") == "") {
		mensaje = mensaje + "* DIGITE EL PRIMER APELLIDO\n";
	}

	if (document.getElementById('txtCorreo').value.replace(/^\s*|\s*$/g, "") == "") {
		mensaje = mensaje + "* DIGITE EL CORREO ELECTRONICO\n";
	} else {
		isEmailAddress2(document.getElementById('txtCorreo'), 'txtCorreo');
		mensaje = mensaje + mensaje3;
	}

	var claveIncorrecta = 0;
	if (document.getElementById("txtClave").value == "") {
		mensaje = mensaje + "* DIGITE UNA NUEVA CLAVEa\n";
		claveIncorrecta = 1;
	}
	if (claveIncorrecta == 0
			&& document.getElementById("txtClave2").value == "") {
		mensaje = mensaje + "* DEBE DIGITAR NUEVAMENTE LA CLAVE\n";
		claveIncorrecta = 2;
	}
	if (claveIncorrecta == 0
			&& document.getElementById("txtClave").value != document
					.getElementById("txtClave2").value) {
		mensaje = mensaje + "* LAS CLAVES NO COINCIDEN\n";
	} else {
		if (claveIncorrecta == 0
				&& document.getElementById("txtClave").value.length < 4) {
			mensaje = mensaje
					+ "* LA CLAVE DEBE TENER POR LO MENOS 4 CARACTERES\n";
		}
	}

	if (mensaje.replace(/^\s*|\s*$/g, "") == "") {
		cargarCrearAdmin();

	} else {
		alert(mensaje);
	}

}

function cargarCrearMC(id_mujer, id) {
	ajax = nuevoAjax();
	parametros = "id=" + id + "&id_mujer=" + id_mujer;
	url = "/f-web/nuevaCreacionMC.jsp";
	ajax.onreadystatechange = function() {
		if (ajax.readyState == 1) {
			document.getElementById('detalle').innerHTML = "<img src='images/ajax/ajax-loader3.gif'> ";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('detalle').innerHTML = "";
				document.getElementById('detalle').style.background = "";
				document.getElementById('detalle').innerHTML = ajax.responseText;

				if (parseInt(document.getElementById("hdnExito").value) == 1) {
					alert('MUJER INSCRITA EN EL CURSO EXITOSAMENTE');
					// window.opener.cargarTemas(id);
					try {
						window.opener.document.form1.submit();
					} catch (e) {
					}
					window.close();
				} else {
					alert('NO SE PUEDE INSCRIBIR LA MUJER EN EL CURSO');
				}

			} else if (ajax.status == 404) {
				document.getElementById('detalle').innerHTML = "-Inexistencia, contacte administrador-";
			} else {
				document.getElementById('detalle').innerHTML = "-Error, contacte administrador";
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type',
			'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(parametros);
}

function cargarCrearAdmin() {
	ajax = nuevoAjax();
	parametros = "pn=" + document.getElementById("txtNombre1").value + "&sn="
			+ document.getElementById("txtNombre2").value + "&pa="
			+ document.getElementById("txtApellido1").value + "&sa="
			+ document.getElementById("txtApellido2").value + "&correo="
			+ document.getElementById("txtCorreo").value + "&clave="
			+ document.getElementById("txtClave").value + "&doc="
			+ document.getElementById("txtDocumento").value;
	url = "/f-web/nuevaCreacion.jsp";
	ajax.onreadystatechange = function() {
		if (ajax.readyState == 1) {
			document.getElementById('detalle').innerHTML = "<img src='images/ajax/ajax-loader3.gif'> ";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('detalle').innerHTML = "";
				document.getElementById('detalle').style.background = "";
				document.getElementById('detalle').innerHTML = ajax.responseText;

				if (parseInt(document.getElementById("hdnExito").value) == 1) {
					alert('ADMINISTRADOR(A) CREADO CON EXITO');
					window.opener.cargarAdministradores();
					try {
						window.opener.document.form1.submit();
					} catch (e) {
					}
					window.close();
				} else {
					alert('NO SE PUEDE CREAR EL ADMINISTRADOR CON ESE DOCUMENTO');
				}

			} else if (ajax.status == 404) {
				document.getElementById('detalle').innerHTML = "-Inexistencia, contacte administrador-";
			} else {
				document.getElementById('detalle').innerHTML = "-Error, contacte administrador";
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type',
			'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(parametros);
}

function cargarAjaxGuardar() {
	ajax = nuevoAjax();
	parametros = "us=" + document.getElementById('hdnUs').value + "&pt="
			+ document.getElementById('txtTitulo').value + "&pc="
			+ document.getElementById('txtContenido').value + "&pd="
			+ document.getElementById('sltDirigido').value + "&pe="
			+ document.getElementById('hdnEgresado').value + "&pf="
			+ document.getElementById('hdnFoto').value + "&tu="
			+ document.getElementById('hdnTipoUs').value;

	url = "/f-web/guardarPublicacion.jsp";
	ajax.onreadystatechange = function() {
		if (ajax.readyState == 1) {
			document.getElementById('detalleGuardar').innerHTML = "<img src='images/ajax/ajax-loader3.gif'>";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('detalleGuardar').innerHTML = "";
				document.getElementById('detalleGuardar').style.background = "";
				document.getElementById('detalleGuardar').innerHTML = ajax.responseText;
				if (document.getElementById('hdnGuardarPublicacion').value == 1) {
					alert('PUBLICACION GUARDADA CON EXITO');
					cargarPropias();
					if (confirm('DESEA REALIZAR UNA NUEVA PUBLICACION ?, DE SER ASI HAGA CLIC EN ACEPTAR')) {
						document.getElementById('detalleEgresado').innerHTML = "";
						document.getElementById('detalleEgresado2').innerHTML = "";

						document.getElementById('txtTitulo').value = "";
						document.getElementById('txtContenido').value = "";
						document.getElementById('sltDirigido').value = "2";
						removerFoto();

					}
				}

			} else if (ajax.status == 404) {
				document.getElementById('detalleGuardar').innerHTML = "-Inexistencia, contacte administrador-";
			} else {
				document.getElementById('detalleGuardar').innerHTML = "-Error, contacte administrador";
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type',
			'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(parametros);
}

function cargarAjaxGuardarSeccion() {
	ajax = nuevoAjax();

	parametros = "pt=" + document.getElementById('txtTitulo').value + "&pc="
			+ document.getElementById('txtContenido').value + "&pd="
			+ document.getElementById('sltDirigido').value + "&pf="
			+ document.getElementById('hdnFoto').value;

	url = "/f-web/guardarSeccion.jsp";
	ajax.onreadystatechange = function() {
		if (ajax.readyState == 1) {
			document.getElementById('detalleGuardar').innerHTML = "<img src='images/ajax/ajax-loader3.gif'>";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('detalleGuardar').innerHTML = "";
				document.getElementById('detalleGuardar').style.background = "";
				document.getElementById('detalleGuardar').innerHTML = ajax.responseText;
				if (document.getElementById('hdnGuardarPublicacion').value == 1) {
					alert('SECCION ACTUALIZADA CON EXITO');

				}

			} else if (ajax.status == 404) {
				document.getElementById('detalleGuardar').innerHTML = "-Inexistencia, contacte administrador-";
			} else {
				document.getElementById('detalleGuardar').innerHTML = "-Error, contacte administrador";
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type',
			'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(parametros);
}

function guardarSeccion() {
	var mensajes = "";

	var contenido = document.getElementById('txtContenido').value;

	document.getElementById('hdnGuardarPublicacion').value = "0";
	if (document.getElementById('txtTitulo').value.replace(/^\s*|\s*$/g, "") == "") {
		mensajes = mensajes + " * DIGITE EL TITULO.\n";
		alert(mensajes);
		return;
	}

	// if (document.getElementById('txtContenido').value.replace(/^\s*|\s*$/g,
	// "") == "") {
	// mensajes = mensajes + " * DIGITE EL CONTENIDO.\n";
	// }

	if (mensajes != "") {
		// alert(mensajes);
	} else {
		document.getElementById('txtContenido').value = contenido;
		document.getElementById('hdnGuardarPublicacion').value = "1";
		document.form1.submit();
		// cargarAjaxGuardarSeccion();
	}

}

function guardarPublicacion() {
	var mensajes = "";
	var contenido = document.getElementById('txtContenido').value;
	if (document.getElementById('txtTitulo').value.replace(/^\s*|\s*$/g, "") == "") {
		mensajes = mensajes + " * DIGITE EL TITULO.\n";
		alert(mensajes);
	}

	// if (document.getElementById('txtContenido').value.replace(/^\s*|\s*$/g,
	// "") == "") {
	// mensajes = mensajes + " * DIGITE EL CONTENIDO.\n";
	// }

	// if (mensajes != "") {
	// alert(mensajes);
	// } else {
	//		
	// cargarAjaxGuardar();
	// }
	//	

	if (mensajes != "") {
		// alert(mensajes);
	} else {
		document.getElementById('txtContenido').value = contenido;
		document.getElementById('hdnGuardarPublicacion').value = "1";
		document.form1.submit();
		// cargarAjaxGuardarSeccion();
	}

}

function removerFoto() {
	document.getElementById('detalleFoto1').innerHTML = "";
	document.getElementById('detalleFoto2').innerHTML = "";
	document.getElementById('hdnFoto').value = "";

}

function agregarFoto(foto) {

	// alert(foto);
	// temporalmente
	// foto = "publicacion.jpg";
	window.opener.document.getElementById('detalleFoto1').innerHTML = "<img src='/f-web/images/publicaciones/"
			+ foto + "' width='317' height='187' />";
	window.opener.document.getElementById('detalleFoto2').innerHTML = "<a class='current' href='#' onclick='removerFoto(); return false;'>(Remover imagen)</a><br>";
	window.opener.document.getElementById('hdnFoto').value = foto;
	window.close();

}

function buscarFoto() {
	window
			.open('/f-web/subirFotoPublicacion.jsp', 'popup',
					'toolbar=no, menubar=no, scrollbars=no, resizable=no, width=400, height=300');
}

function escogerEgresado(egresado, registrado, nombre) {
	document.getElementById('hdnEgresado').value = "0";

	if (registrado == 1) {
		document.getElementById('hdnEgresado').value = egresado;
		document.getElementById('hdnNombreEgresado').value = nombre;

	}

}

function escogerEgresado2(egresado, registrado, nombre) {
	document.getElementById('hdnEgresado').value = egresado;
}

function aceptar() {
	if (document.getElementById('hdnEgresado').value == "-1") {
		alert('Escoja primero un egresado');
	} else {
		if (document.getElementById('hdnEgresado').value == "0") {
			alert('EL egresado escogido no se encuentra registrado en el portal, escoja otro');
		} else {
			try {

				window.opener.document.getElementById('hdnEgresado').value = document
						.getElementById('hdnEgresado').value;
				window.opener.document.getElementById('txtEgresado').value = document
						.getElementById('hdnNombreEgresado').value;
				window.close();
			} catch (e) {
				alert('La ventana que abri� este buscador fue cerrada o se cambi� la opci�n de egresado particular a otra, en la opci�n dirigido a: . Por favor verifique');
			}

		}
	}
}

function aceptar2Sugerido() {
	if (document.getElementById('hdnEgresado').value == "-1") {
		alert('Escoja primero un egresado');
	} else {
		cargarAjaxInvitarSugerido();
	}
}

function cargarAjaxInvitarSugerido() {
	ajax = nuevoAjax();
	var correoSugerido = prompt(
			'Sugi�ranos un correo del egresado a invitar y clic en aceptar, sino digita nada o cancela se enviar� al predeterminado',
			'');
	var ti = 0;
	if (correoSugerido != null
			&& correoSugerido.replace(/^\s*|\s*$/g, "") != "") {
		ti = 2;
	} else {
		ti = 1;
	}
	parametros = "us=" + document.getElementById('hdnUs').value + "&usd="
			+ document.getElementById('hdnEgresado').value + "&ti=" + ti
			+ "&correo=" + correoSugerido;
	url = "/f-web/invitarEgresados/enviarInvitacion.jsp";
	ajax.onreadystatechange = function() {
		if (ajax.readyState == 1) {
			document.getElementById('detalleInvitacion').innerHTML = "<img src='images/ajax/ajax-loader3.gif'> Invitando egresado...";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('detalleInvitacion').innerHTML = "";
				document.getElementById('detalleInvitacion').style.background = "";
				document.getElementById('detalleInvitacion').innerHTML = ajax.responseText;
				if (parseInt(document.getElementById('hdnInvito').value) == 1) {
					alert('Perfecto ya el egresado ha sido invitado o contactado. Para ello se le ha enviado un correo electr�nico con el mensaje correspondiente (antes descrito)');
				} else {
					alert('Lamentablemente no se puede contactar el egresado ya que no posee un correo electr�nico actualizado, donde pueda contactarse');
				}

			} else if (ajax.status == 404) {
				document.getElementById('detalleInvitacion').innerHTML = "-Inexistencia, contacte administrador-";
			} else {
				document.getElementById('detalleInvitacion').innerHTML = "-Error, contacte administrador";
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type',
			'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(parametros);
}

function aceptar2() {
	if (document.getElementById('hdnEgresado').value == "-1") {
		alert('Escoja primero un egresado');
	} else {
		cargarAjaxInvitar();
	}
}

function cargarAjaxInvitar() {
	ajax = nuevoAjax();
	parametros = "us=" + document.getElementById('hdnUs').value + "&usd="
			+ document.getElementById('hdnEgresado').value
			+ "&ti=0&correo=vacio";
	url = "/f-web/invitarEgresados/enviarInvitacion.jsp";
	ajax.onreadystatechange = function() {
		if (ajax.readyState == 1) {
			document.getElementById('detalleInvitacion').innerHTML = "<img src='images/ajax/ajax-loader3.gif'> Invitando egresado...";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('detalleInvitacion').innerHTML = "";
				document.getElementById('detalleInvitacion').style.background = "";
				document.getElementById('detalleInvitacion').innerHTML = ajax.responseText;
				if (parseInt(document.getElementById('hdnInvito').value) == 1) {
					alert('Perfecto ya el egresado ha sido invitado o contactado. Para ello se le ha enviado un correo electr�nico con el mensaje correspondiente (antes descrito)');
				} else {
					alert('Lamentablemente no se puede contactar el egresado ya que no posee un correo electr�nico actualizado, donde pueda contactarse');
				}

			} else if (ajax.status == 404) {
				document.getElementById('detalleInvitacion').innerHTML = "-Inexistencia, contacte administrador-";
			} else {
				document.getElementById('detalleInvitacion').innerHTML = "-Error, contacte administrador";
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type',
			'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(parametros);
}

function nuevoAjax() {
	var xmlhttp = false;
	try {
		xmlhttp = new ActiveXObject("Msxml2.XMLHTTP"); // Creacion del objeto
		// AJAX para navegadores
		// no IE.
	} catch (e) {
		try {
			xmlhttp = new ActiveXObject("Microsoft.XMLHTTP"); // Creacion del
			// objet AJAX
			// para IE.
		} catch (E) {
			xmlhttp = false;
		}
	}

	if (!xmlhttp && typeof XMLHttpRequest != 'undefined') {
		xmlhttp = new XMLHttpRequest();
	}
	return xmlhttp;
}

function cargarAjaxEgresados() {
	ajax = nuevoAjax();
	parametros = "pn=" + document.getElementById('txtNombre1').value + "&sn="
			+ document.getElementById('txtNombre2').value + "&pa="
			+ document.getElementById('txtApellido1').value + "&sa="
			+ document.getElementById('txtApellido2').value;
	url = "/f-web/buscadores/resultadosEgresados.jsp";
	ajax.onreadystatechange = function() {
		if (ajax.readyState == 1) {
			document.getElementById('detalleBusqueda').innerHTML = "<img src='images/ajax/ajax-loader3.gif'> Buscando...";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('detalleBusqueda').innerHTML = "";
				document.getElementById('detalleBusqueda').style.background = "";
				document.getElementById('detalleBusqueda').innerHTML = ajax.responseText;

			} else if (ajax.status == 404) {
				document.getElementById('detalleBusqueda').innerHTML = "-Inexistencia, contacte administrador-";
			} else {
				document.getElementById('detalleBusqueda').innerHTML = "-Error, contacte administrador";
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type',
			'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(parametros);
}

function cargarAjaxEgresados2() {
	ajax = nuevoAjax();
	parametros = "pn=" + document.getElementById('txtNombre1').value + "&sn="
			+ document.getElementById('txtNombre2').value + "&pa="
			+ document.getElementById('txtApellido1').value + "&sa="
			+ document.getElementById('txtApellido2').value;
	url = "/f-web/buscadores/resultadosEgresados2.jsp";
	ajax.onreadystatechange = function() {
		if (ajax.readyState == 1) {
			document.getElementById('detalleBusqueda').innerHTML = "<img src='images/ajax/ajax-loader3.gif'> Buscando...";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('detalleBusqueda').innerHTML = "";
				document.getElementById('detalleBusqueda').style.background = "";
				document.getElementById('detalleBusqueda').innerHTML = ajax.responseText;

			} else if (ajax.status == 404) {
				document.getElementById('detalleBusqueda').innerHTML = "-Inexistencia, contacte administrador-";
			} else {
				document.getElementById('detalleBusqueda').innerHTML = "-Error, contacte administrador";
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type',
			'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(parametros);
}

function cargarAjaxEgresados3() {
	var continuar = 1;
	var mensaje = "";
	if (document.getElementById('txtAno').value.replace(/^\s*|\s*$/g, "") != ""
			&& document.getElementById('txtAno2').value.replace(/^\s*|\s*$/g,
					"") != "") {

		try {

			if (parseInt(document.getElementById('txtAno').value) > parseInt(document
					.getElementById('txtAno2').value)) {
				mensaje = mensaje
						+ "* El a�o comienzo debe ser menor o igual al a�o fin\n";
			}

		} catch (e) {
			mensaje = mensaje + "* Error en las fechas\n";
		}

	}

	if (document.getElementById('lstPeriodo').value != "0"
			&& document.getElementById('lstPeriodo2').value != "0") {

		try {

			if (parseInt(document.getElementById('lstPeriodo').value) > parseInt(document
					.getElementById('lstPeriodo2').value)) {
				mensaje = mensaje
						+ "* El periodo comienzo debe ser menor o igual al periodo fin\n";
			}

		} catch (e) {
			mensaje = mensaje + "* Error en los periodos\n";
		}
	}

	if (mensaje == "") {
		// alert(document.getElementById('lstTipoEgresado').value);
		ajax = nuevoAjax();
		parametros = "pn=" + document.getElementById('txtNombre1').value
				+ "&sn=" + document.getElementById('txtNombre2').value + "&pa="
				+ document.getElementById('txtApellido1').value + "&sa="
				+ document.getElementById('txtApellido2').value + "&sexo="
				+ document.getElementById('lstSexo').value + "&periodo="
				+ document.getElementById('lstPeriodo').value + "&ano="
				+ document.getElementById('txtAno').value + "&ano2="
				+ document.getElementById('txtAno2').value + "&periodo2="
				+ document.getElementById('lstPeriodo2').value + "&correo="
				+ document.getElementById('lstCorreo').value + "&te="
				+ document.getElementById('lstTipoEgresado').value;
		url = "/f-web/buscadores/resultadosEgresados3.jsp";
		ajax.onreadystatechange = function() {
			if (ajax.readyState == 1) {
				document.getElementById('detalleBusqueda').innerHTML = "<img src='images/ajax/ajax-loader3.gif'> Generando listado...";
			} else if (ajax.readyState == 4) {
				if (ajax.status == 200) {
					document.getElementById('detalleBusqueda').innerHTML = "";
					document.getElementById('detalleBusqueda').style.background = "";
					document.getElementById('detalleBusqueda').innerHTML = ajax.responseText;

				} else if (ajax.status == 404) {
					document.getElementById('detalleBusqueda').innerHTML = "-Inexistencia, contacte administrador-";
				} else {
					document.getElementById('detalleBusqueda').innerHTML = "-Error, contacte administrador";
				}
			}
		}

		ajax.open("POST", url, true);
		ajax.setRequestHeader('Content-Type',
				'application/x-www-form-urlencoded; charset=utf-8');
		ajax.send(parametros);

	} else {

		alert(mensaje);
	}
}

function cambiarDirigido() {
	document.getElementById('hdnEgresado').value = "0";
	if (document.getElementById('sltDirigido').value == "3") {
		document.getElementById('detalleEgresado').innerHTML = "<input name='txtEgresado' type='text' disabled='disabled' class='searchfield' id='txtEgresado' style='text-align: center' value='Busque un egresado en el logo(lupa)' />";
		document.getElementById('detalleEgresado2').innerHTML = "<img src='/f-web/images/buscar.png' width='32' height='32' class='none' style='width: 27px; height: 26px; cursor: hand'	onclick='buscarEgresado(); return false;' />";

	} else {
		document.getElementById('detalleEgresado').innerHTML = "";
		document.getElementById('detalleEgresado2').innerHTML = "";
	}

}

function buscarEgresado() {
	window
			.open('/f-web/buscadores/buscarEgresado.jsp', 'popup',
					'toolbar=no, menubar=no, scrollbars=no, resizable=no, width=800, height=500');
}

function cargarEliminarArchivos(archivo, idarchivo) {
	ajax = nuevoAjax();
	parametros = "archivo=" + archivo + "&idarchivo=" + idarchivo;
	url = "/f-web/archivosPlanos/eliminarArchivoPlano.jsp";
	ajax.onreadystatechange = function() {
		if (ajax.readyState == 1) {
			document.getElementById('detalleProcesos').innerHTML = "<img src='images/ajax/ajax-loader3.gif'> Eliminando archivo espere un momento...";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('detalleProcesos').innerHTML = "";
				document.getElementById('detalleProcesos').style.background = "";
				document.getElementById('detalleProcesos').innerHTML = ajax.responseText;

				if (parseInt(document.getElementById('hdnElimino').value) == 1) {
					alert('archivo eliminado con �xito');
					cargarPlanos();

				}

			} else if (ajax.status == 404) {
				document.getElementById('detalleProcesos').innerHTML = "-Inexistencia, contacte administrador-";
			} else {
				document.getElementById('detalleProcesos').innerHTML = "-Error, contacte administrador";
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type',
			'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(parametros);
}

function cargarEliminarPortafolio(admin) {

	if (confirm('REALMENTE DESEA ELIMINAR EL SERVICIO DE SU PORTAFOLIO?')) {
		ajax = nuevoAjax();
		parametros = "id=" + admin;
		url = "/f-web/eliminarPortafolio.jsp";
		ajax.onreadystatechange = function() {
			if (ajax.readyState == 1) {
				document.getElementById('detalleProcesos').innerHTML = "<img src='images/ajax/ajax-loader3.gif'> Eliminando servicio espere un momento...";
			} else if (ajax.readyState == 4) {
				if (ajax.status == 200) {
					document.getElementById('detalleProcesos').innerHTML = "";
					document.getElementById('detalleProcesos').style.background = "";
					document.getElementById('detalleProcesos').innerHTML = ajax.responseText;

					if (parseInt(document.getElementById('hdnElimino').value) == 1) {
						alert('SERVICIO ELIMINADO CON EXITO');
						cargarPortafolios();

					} else {
						alert('NO SE PUEDE ELIMINAR EL SERVICIO.');

					}

				} else if (ajax.status == 404) {
					document.getElementById('detalleProcesos').innerHTML = "-Inexistencia, contacte administrador-";
				} else {
					document.getElementById('detalleProcesos').innerHTML = "-Error, contacte administrador";
				}
			}
		}

		ajax.open("POST", url, true);
		ajax.setRequestHeader('Content-Type',
				'application/x-www-form-urlencoded; charset=utf-8');
		ajax.send(parametros);

	}
}

function cargarEliminarCertificado(admin) {

	if (confirm('REALMENTE DESEA ELIMINAR EL CAPACITADO?')) {
		ajax = nuevoAjax();
		parametros = "id=" + admin;
		url = "/f-web/eliminarCertificado.jsp";
		ajax.onreadystatechange = function() {
			if (ajax.readyState == 1) {
				document.getElementById('detalleLote').innerHTML = "<img src='images/ajax/ajax-loader3.gif'> Eliminando espere un momento...";
			} else if (ajax.readyState == 4) {
				if (ajax.status == 200) {
					document.getElementById('detalleLote').innerHTML = "";
					document.getElementById('detalleLote').style.background = "";
					document.getElementById('detalleLote').innerHTML = ajax.responseText;

					if (parseInt(document.getElementById('hdnElimino').value) == 1) {
						alert('REGISTRO ELIMINADO CON EXITO');
						validarLoteConsulta();

					} else {
						alert('NO SE PUEDE ELIMINAR EL REGISTRO PUES TIENE ASOCIADO CONTENIDO.');

					}

				} else if (ajax.status == 404) {
					document.getElementById('detalleProcesos').innerHTML = "-Inexistencia, contacte administrador-";
				} else {
					document.getElementById('detalleProcesos').innerHTML = "-Error, contacte administrador";
				}
			}
		}

		ajax.open("POST", url, true);
		ajax.setRequestHeader('Content-Type',
				'application/x-www-form-urlencoded; charset=utf-8');
		ajax.send(parametros);

	}
}

function seleccionarCombo(numero, valor) {

	document.getElementById("control" + numero).value = "" + valor;
}

function cargarEliminarMujer(admin) {

	if (confirm('REALMENTE DESEA ELIMINAR LA HOJA DE VIDA?')) {
		ajax = nuevoAjax();
		parametros = "id=" + admin;
		url = "/f-web/eliminarMujer.jsp";
		ajax.onreadystatechange = function() {
			if (ajax.readyState == 1) {
				document.getElementById('detalleProcesos').innerHTML = "<img src='images/ajax/ajax-loader3.gif'> Eliminando hoja de vida espere un momento...";
			} else if (ajax.readyState == 4) {
				if (ajax.status == 200) {
					document.getElementById('detalleProcesos').innerHTML = "";
					document.getElementById('detalleProcesos').style.background = "";
					document.getElementById('detalleProcesos').innerHTML = ajax.responseText;

					if (parseInt(document.getElementById('hdnElimino').value) == 1) {
						alert('HOJA DE VIDA ELIMINADA CON EXITO');
						cargarMujeres();

					} else {
						alert('NO SE PUEDE ELIMINAR LA HOJA DE VIDA PUES TIENE ASOCIADA CONTENIDO.');

					}

				} else if (ajax.status == 404) {
					document.getElementById('detalleProcesos').innerHTML = "-Inexistencia, contacte administrador-";
				} else {
					document.getElementById('detalleProcesos').innerHTML = "-Error, contacte administrador";
				}
			}
		}

		ajax.open("POST", url, true);
		ajax.setRequestHeader('Content-Type',
				'application/x-www-form-urlencoded; charset=utf-8');
		ajax.send(parametros);

	}
}

function cargarEliminarMC(admin, curso) {

	if (confirm('REALMENTE DESEA ELIMINAR EL LA MUJER DEL CURSO?')) {
		ajax = nuevoAjax();
		parametros = "id=" + admin;
		url = "/f-web/eliminarMC.jsp";
		ajax.onreadystatechange = function() {
			if (ajax.readyState == 1) {
				document.getElementById('detalleProcesos').innerHTML = "<img src='images/ajax/ajax-loader3.gif'> Eliminando tema del curso espere un momento...";
			} else if (ajax.readyState == 4) {
				if (ajax.status == 200) {
					document.getElementById('detalleProcesos').innerHTML = "";
					document.getElementById('detalleProcesos').style.background = "";
					document.getElementById('detalleProcesos').innerHTML = ajax.responseText;

					if (parseInt(document.getElementById('hdnElimino').value) == 1) {
						alert('MUJER DEL CURSO ELIMINADA CON EXITO');
						cargarMujeresCurso(curso);

					} else {
						alert('NO SE PUEDE ELIMINAR LA MUJER DEL CURSO PUES TIENE ASOCIADO CONTENIDO.');

					}

				} else if (ajax.status == 404) {
					document.getElementById('detalleProcesos').innerHTML = "-Inexistencia, contacte administrador-";
				} else {
					document.getElementById('detalleProcesos').innerHTML = "-Error, contacte administrador";
				}
			}
		}

		ajax.open("POST", url, true);
		ajax.setRequestHeader('Content-Type',
				'application/x-www-form-urlencoded; charset=utf-8');
		ajax.send(parametros);

	}
}

function cargarEliminarPregunta(admin, curso) {

	if (confirm('REALMENTE DESEA ELIMINAR LA PREGUNTA DE LA ENCUESTA?')) {
		ajax = nuevoAjax();
		parametros = "id=" + admin;
		url = "/f-web/eliminarPregunta.jsp";
		ajax.onreadystatechange = function() {
			if (ajax.readyState == 1) {
				document.getElementById('detalleProcesos').innerHTML = "<img src='images/ajax/ajax-loader3.gif'> Eliminando pregunta espere un momento...";
			} else if (ajax.readyState == 4) {
				if (ajax.status == 200) {
					document.getElementById('detalleProcesos').innerHTML = "";
					document.getElementById('detalleProcesos').style.background = "";
					document.getElementById('detalleProcesos').innerHTML = ajax.responseText;

					if (parseInt(document.getElementById('hdnElimino').value) == 1) {
						alert('PREGUNTA ELIMINADA CON EXITO');
						cargarPreguntas(curso);

					} else {
						alert('NO SE PUEDE ELIMINAR LA PREGUNTA PUES TIENE ASOCIADO CONTENIDO.');

					}

				} else if (ajax.status == 404) {
					document.getElementById('detalleProcesos').innerHTML = "-Inexistencia, contacte administrador-";
				} else {
					document.getElementById('detalleProcesos').innerHTML = "-Error, contacte administrador";
				}
			}
		}

		ajax.open("POST", url, true);
		ajax.setRequestHeader('Content-Type',
				'application/x-www-form-urlencoded; charset=utf-8');
		ajax.send(parametros);

	}
}

function cargarEliminarOpcion(admin, curso) {

	if (confirm('REALMENTE DESEA ELIMINAR LA OPCION DE RESPUESTA?')) {
		ajax = nuevoAjax();
		parametros = "id=" + admin;
		url = "/f-web/eliminarOpcion.jsp";
		ajax.onreadystatechange = function() {
			if (ajax.readyState == 1) {
				document.getElementById('detalleProcesos').innerHTML = "<img src='images/ajax/ajax-loader3.gif'> Eliminando espere un momento...";
			} else if (ajax.readyState == 4) {
				if (ajax.status == 200) {
					document.getElementById('detalleProcesos').innerHTML = "";
					document.getElementById('detalleProcesos').style.background = "";
					document.getElementById('detalleProcesos').innerHTML = ajax.responseText;

					if (parseInt(document.getElementById('hdnElimino').value) == 1) {
						alert('OPCION DE RESPUESTA ELIMINADA CON EXITO');
						cargarOpciones(curso);

					} else {
						alert('NO SE PUEDE ELIMINAR LA OPCION DE RESPUESTA PUES TIENE ASOCIADO CONTENIDO.');

					}

				} else if (ajax.status == 404) {
					document.getElementById('detalleProcesos').innerHTML = "-Inexistencia, contacte administrador-";
				} else {
					document.getElementById('detalleProcesos').innerHTML = "-Error, contacte administrador";
				}
			}
		}

		ajax.open("POST", url, true);
		ajax.setRequestHeader('Content-Type',
				'application/x-www-form-urlencoded; charset=utf-8');
		ajax.send(parametros);

	}
}

function cargarEliminarFinanciadorC(admin, curso) {

	if (confirm('REALMENTE DESEA ELIMINAR EL FINANCIADOR DEL CURSO?')) {
		ajax = nuevoAjax();
		parametros = "id=" + admin;
		url = "/f-web/eliminarFinanciadorC.jsp";
		ajax.onreadystatechange = function() {
			if (ajax.readyState == 1) {
				document.getElementById('detalleProcesos').innerHTML = "<img src='images/ajax/ajax-loader3.gif'> Eliminando espere un momento...";
			} else if (ajax.readyState == 4) {
				if (ajax.status == 200) {
					document.getElementById('detalleProcesos').innerHTML = "";
					document.getElementById('detalleProcesos').style.background = "";
					document.getElementById('detalleProcesos').innerHTML = ajax.responseText;

					if (parseInt(document.getElementById('hdnElimino').value) == 1) {
						alert('FINANCIADOR DEL CURSO ELIMINADO CON EXITO');
						cargarFinanciadoresC(curso);

					} else {
						alert('NO SE PUEDE ELIMINAR EL FINANCIADOR DEL CURSO PUES TIENE ASOCIADO CONTENIDO.');

					}

				} else if (ajax.status == 404) {
					document.getElementById('detalleProcesos').innerHTML = "-Inexistencia, contacte administrador-";
				} else {
					document.getElementById('detalleProcesos').innerHTML = "-Error, contacte administrador";
				}
			}
		}

		ajax.open("POST", url, true);
		ajax.setRequestHeader('Content-Type',
				'application/x-www-form-urlencoded; charset=utf-8');
		ajax.send(parametros);

	}
}

function cargarEliminarLineaC(admin, curso) {

	if (confirm('REALMENTE DESEA ELIMINAR LA LINEA ESTRATEGICA DEL CURSO?')) {
		ajax = nuevoAjax();
		parametros = "id=" + admin;
		url = "/f-web/eliminarLineaC.jsp";
		ajax.onreadystatechange = function() {
			if (ajax.readyState == 1) {
				document.getElementById('detalleProcesos').innerHTML = "<img src='images/ajax/ajax-loader3.gif'> Eliminando espere un momento...";
			} else if (ajax.readyState == 4) {
				if (ajax.status == 200) {
					document.getElementById('detalleProcesos').innerHTML = "";
					document.getElementById('detalleProcesos').style.background = "";
					document.getElementById('detalleProcesos').innerHTML = ajax.responseText;

					if (parseInt(document.getElementById('hdnElimino').value) == 1) {
						alert('LINEA ESTRATEGICA DEL CURSO ELIMINADO CON EXITO');
						cargarLineasC(curso);

					} else {
						alert('NO SE PUEDE ELIMINAR LINEA ESTRAT�GICA DEL CURSO PUES TIENE ASOCIADO CONTENIDO.');

					}

				} else if (ajax.status == 404) {
					document.getElementById('detalleProcesos').innerHTML = "-Inexistencia, contacte administrador-";
				} else {
					document.getElementById('detalleProcesos').innerHTML = "-Error, contacte administrador";
				}
			}
		}

		ajax.open("POST", url, true);
		ajax.setRequestHeader('Content-Type',
				'application/x-www-form-urlencoded; charset=utf-8');
		ajax.send(parametros);

	}
}

function cargarEliminarArchivoTema(admin, curso) {

	if (confirm('REALMENTE DESEA ELIMINAR EL ARCHIVO DEL TEMA?')) {
		ajax = nuevoAjax();
		parametros = "id=" + admin;
		url = "/f-web/eliminarArchivoTema.jsp";
		ajax.onreadystatechange = function() {
			if (ajax.readyState == 1) {
				document.getElementById('detalleProcesos').innerHTML = "<img src='images/ajax/ajax-loader3.gif'> Eliminando archivo espere un momento...";
			} else if (ajax.readyState == 4) {
				if (ajax.status == 200) {
					document.getElementById('detalleProcesos').innerHTML = "";
					document.getElementById('detalleProcesos').style.background = "";
					document.getElementById('detalleProcesos').innerHTML = ajax.responseText;

					if (parseInt(document.getElementById('hdnElimino').value) == 1) {
						alert('ARCHIVO ELIMINADO CON EXITO');
						cargarTemas(curso);

					} else {
						alert('NO SE PUEDE ELIMINAR EL ARCHIVO.');

					}

				} else if (ajax.status == 404) {
					document.getElementById('detalleProcesos').innerHTML = "-Inexistencia, contacte administrador-";
				} else {
					document.getElementById('detalleProcesos').innerHTML = ajax.responseText;
				}
			}
		}

		ajax.open("POST", url, true);
		ajax.setRequestHeader('Content-Type',
				'application/x-www-form-urlencoded; charset=utf-8');
		ajax.send(parametros);

	}
}

function cargarEliminarActividad(admin, curso) {

	if (confirm('REALMENTE DESEA ELIMINAR LA ACTIVIDAD ECONOMICA REPORTADA?')) {
		ajax = nuevoAjax();
		parametros = "id=" + admin;
		url = "/f-web/eliminarActividad.jsp";
		ajax.onreadystatechange = function() {
			if (ajax.readyState == 1) {
				document.getElementById('detalleProcesos').innerHTML = "<img src='images/ajax/ajax-loader3.gif'> Eliminando espere un momento...";
			} else if (ajax.readyState == 4) {
				if (ajax.status == 200) {
					document.getElementById('detalleProcesos').innerHTML = "";
					document.getElementById('detalleProcesos').style.background = "";
					document.getElementById('detalleProcesos').innerHTML = ajax.responseText;

					if (parseInt(document.getElementById('hdnElimino').value) == 1) {
						alert('ACTIVIDAD ECONOMICA ELIMINADA CON EXITO');
						cargarActividades(curso);

					} else {
						alert('NO SE PUEDE ELIMINAR LA ACTIVIDAD ECONOMICA PUES TIENE ASOCIADO CONTENIDO.');

					}

				} else if (ajax.status == 404) {
					document.getElementById('detalleProcesos').innerHTML = "-Inexistencia, contacte administrador-";
				} else {
					document.getElementById('detalleProcesos').innerHTML = ajax.responseText;
				}
			}
		}

		ajax.open("POST", url, true);
		ajax.setRequestHeader('Content-Type',
				'application/x-www-form-urlencoded; charset=utf-8');
		ajax.send(parametros);

	}
}

function cargarEliminarParticipaciones(admin, curso) {

	if (confirm('REALMENTE DESEA ELIMINAR LA PARTICIPACION REGISTRADA?')) {
		ajax = nuevoAjax();
		parametros = "id=" + admin;
		url = "/f-web/eliminarParticipacion.jsp";
		ajax.onreadystatechange = function() {
			if (ajax.readyState == 1) {
				document.getElementById('detalleProcesos').innerHTML = "<img src='images/ajax/ajax-loader3.gif'> Eliminando espere un momento...";
			} else if (ajax.readyState == 4) {
				if (ajax.status == 200) {
					document.getElementById('detalleProcesos').innerHTML = "";
					document.getElementById('detalleProcesos').style.background = "";
					document.getElementById('detalleProcesos').innerHTML = ajax.responseText;

					if (parseInt(document.getElementById('hdnElimino').value) == 1) {
						alert('PARTICIPACION ELIMINADA CON EXITO');
						cargarParticipaciones(curso);

					} else {

						alert('NO SE PUEDE ELIMINAR LA PARTICIPACION PUES TIENE ASOCIADO CONTENIDO.');

					}

				} else if (ajax.status == 404) {
					document.getElementById('detalleProcesos').innerHTML = "-Inexistencia, contacte administrador-";
				} else {
					document.getElementById('detalleProcesos').innerHTML = ajax.responseText;
				}
			}
		}

		ajax.open("POST", url, true);
		ajax.setRequestHeader('Content-Type',
				'application/x-www-form-urlencoded; charset=utf-8');
		ajax.send(parametros);

	}
}

function cargarEliminarCapacitacion(admin, curso) {

	if (confirm('REALMENTE DESEA ELIMINAR LA CAPACITACION RECIBIDA?')) {
		ajax = nuevoAjax();
		parametros = "id=" + admin;
		url = "/f-web/eliminarCapacitacion.jsp";
		ajax.onreadystatechange = function() {
			if (ajax.readyState == 1) {
				document.getElementById('detalleProcesos').innerHTML = "<img src='images/ajax/ajax-loader3.gif'> Eliminando espere un momento...";
			} else if (ajax.readyState == 4) {
				if (ajax.status == 200) {
					document.getElementById('detalleProcesos').innerHTML = "";
					document.getElementById('detalleProcesos').style.background = "";
					document.getElementById('detalleProcesos').innerHTML = ajax.responseText;

					if (parseInt(document.getElementById('hdnElimino').value) == 1) {
						alert("CAPACITACION ELIMINADA CON EXITO");
						cargarCapacitaciones(curso);

					} else {
						alert('NO SE PUEDE ELIMINAR LA CAPACITACION PUES TIENE ASOCIADO CONTENIDO.');

					}

				} else if (ajax.status == 404) {
					document.getElementById('detalleProcesos').innerHTML = "-Inexistencia, contacte administrador-";
				} else {
					document.getElementById('detalleProcesos').innerHTML = ajax.responseText;
				}
			}
		}

		ajax.open("POST", url, true);
		ajax.setRequestHeader('Content-Type',
				'application/x-www-form-urlencoded; charset=utf-8');
		ajax.send(parametros);

	}
}

function cargarEliminarNivel(admin, curso) {

	if (confirm('REALMENTE DESEA ELIMINAR EL NIVEL EDUCATIVO DE LA MUJER?')) {
		ajax = nuevoAjax();
		parametros = "id=" + admin;
		url = "/f-web/eliminarNivel.jsp";
		ajax.onreadystatechange = function() {
			if (ajax.readyState == 1) {
				document.getElementById('detalleProcesos').innerHTML = "<img src='images/ajax/ajax-loader3.gif'> Eliminando espere un momento...";
			} else if (ajax.readyState == 4) {
				if (ajax.status == 200) {
					document.getElementById('detalleProcesos').innerHTML = "";
					document.getElementById('detalleProcesos').style.background = "";
					document.getElementById('detalleProcesos').innerHTML = ajax.responseText;

					if (parseInt(document.getElementById('hdnElimino').value) == 1) {
						alert('NIVEL EDUCATIVO ELIMINADO CON EXITO');
						cargarNiveles(curso);

					} else {
						alert('NO SE PUEDE ELIMINAR EL NIVEL EDUCATIVO PUES TIENE ASOCIADO CONTENIDO.');

					}

				} else if (ajax.status == 404) {
					document.getElementById('detalleProcesos').innerHTML = "-Inexistencia, contacte administrador-";
				} else {
					document.getElementById('detalleProcesos').innerHTML = ajax.responseText;
				}
			}
		}

		ajax.open("POST", url, true);
		ajax.setRequestHeader('Content-Type',
				'application/x-www-form-urlencoded; charset=utf-8');
		ajax.send(parametros);

	}
}

function cargarEliminarTema(admin, curso) {

	if (confirm('REALMENTE DESEA ELIMINAR EL TEMA DEL CURSO?')) {
		ajax = nuevoAjax();
		parametros = "id=" + admin;
		url = "/f-web/eliminarTema.jsp";
		ajax.onreadystatechange = function() {
			if (ajax.readyState == 1) {
				document.getElementById('detalleProcesos').innerHTML = "<img src='images/ajax/ajax-loader3.gif'> Eliminando tema del curso espere un momento...";
			} else if (ajax.readyState == 4) {
				if (ajax.status == 200) {
					document.getElementById('detalleProcesos').innerHTML = "";
					document.getElementById('detalleProcesos').style.background = "";
					document.getElementById('detalleProcesos').innerHTML = ajax.responseText;

					if (parseInt(document.getElementById('hdnElimino').value) == 1) {
						alert('TEMA DEL CURSO ELIMINADO CON EXITO');
						cargarTemas(curso);

					} else {
						alert('NO SE PUEDE ELIMINAR EL TEMA DEL CURSO PUES TIENE ASOCIADO CONTENIDO.');

					}

				} else if (ajax.status == 404) {
					document.getElementById('detalleProcesos').innerHTML = "-Inexistencia, contacte administrador-";
				} else {
					document.getElementById('detalleProcesos').innerHTML = ajax.responseText;
				}
			}
		}

		ajax.open("POST", url, true);
		ajax.setRequestHeader('Content-Type',
				'application/x-www-form-urlencoded; charset=utf-8');
		ajax.send(parametros);

	}
}

function cargarEliminarAsistencia(admin) {

	if (confirm('REALMENTE DESEA ELIMINAR EL REGISTRO DE ASISTENCIA DE LA MUJER ?')) {
		ajax = nuevoAjax();
		parametros = "id=" + admin;
		url = "/f-web/eliminarAsistencia.jsp";
		ajax.onreadystatechange = function() {
			if (ajax.readyState == 1) {
				document.getElementById('detalleLote').innerHTML = "<img src='images/ajax/ajax-loader3.gif'> Eliminando asistencia espere un momento...";
			} else if (ajax.readyState == 4) {
				if (ajax.status == 200) {
					document.getElementById('detalleLote').innerHTML = "";
					document.getElementById('detalleLote').style.background = "";
					document.getElementById('detalleLote').innerHTML = ajax.responseText;

					if (parseInt(document.getElementById('hdnElimino').value) == 1) {
						alert('REGISTRO DE ASISTENCIA ELIMINADO CON EXITO');
						validarPlanilla3();

					} else {
						alert('NO SE PUEDE ELIMINAR EL REGISTRO DE ASISTENCIA DE LA MUJER PUES TIENE ASOCIADO CONTENIDO.');

					}

				} else if (ajax.status == 404) {
					document.getElementById('detalleLote').innerHTML = "-Inexistencia, contacte administrador-";
				} else {
					document.getElementById('detalleLote').innerHTML = "-Error, contacte administrador";
				}
			}
		}

		ajax.open("POST", url, true);
		ajax.setRequestHeader('Content-Type',
				'application/x-www-form-urlencoded; charset=utf-8');
		ajax.send(parametros);

	}
}

function activarEncuesta(admin) {

	if (confirm('REALMENTE DESEA ACTIVAR LA ENCUESTA?. LUEGO DE ACTIVA NO PODRA MODIFICARLA.')) {
		ajax = nuevoAjax();
		parametros = "id=" + admin;
		url = "/f-web/activarEncuesta.jsp";
		ajax.onreadystatechange = function() {
			if (ajax.readyState == 1) {
				document.getElementById('detalleProcesos').innerHTML = "<img src='images/ajax/ajax-loader3.gif'> Activando encuesta espere un momento...";
			} else if (ajax.readyState == 4) {
				if (ajax.status == 200) {
					document.getElementById('detalleProcesos').innerHTML = "";
					document.getElementById('detalleProcesos').style.background = "";
					document.getElementById('detalleProcesos').innerHTML = ajax.responseText;

					if (parseInt(document.getElementById('hdnActivo').value) == 1) {
						alert('ENCUESTA ACTIVADA CON EXITO');
						cargarEncuestas();

					} else {
						alert('NO SE PUEDE ACTIVAR LA ENCUESTA. PARA REALIZAR ESTE PROCESO DEBE ESTAR COMPLETA, ES DECIR CON PREGUNTAS Y OPCIONES DE RESPUESTA PARA SUS PREGUNTAS.');

					}

				} else if (ajax.status == 404) {
					document.getElementById('detalleProcesos').innerHTML = "-Inexistencia, contacte administrador-";
				} else {
					document.getElementById('detalleProcesos').innerHTML = "-Error, contacte administrador";
				}
			}
		}

		ajax.open("POST", url, true);
		ajax.setRequestHeader('Content-Type',
				'application/x-www-form-urlencoded; charset=utf-8');
		ajax.send(parametros);

	}
}

function validarLleno(j) {

	iterador = 0;

	parametro = "encuesta=" + document.getElementById('encuesta').value
			+ "&totalPreguntas="
			+ document.getElementById('total_preguntas').value + "&mujer="
			+ document.getElementById('id_mujer_encuesta').value;

	for (var i = 1; i <= parseInt(document.getElementById('total_preguntas').value); i++) {

		
		//unica
		 if(document.getElementById('tipo'+i).value=='U'){
			 for(var k=1; k<=parseInt(document.getElementById('cantidad'+i).value); k++){
			 		if(document.getElementById('radio'+i+'-'+k).checked){
								
			 				//guarda la respuesta correcta para unica respuesta
			 				sarta =	 "&opcion"+i+"="+document.getElementById('radio'+i+'-'+k).value+
			 						 "&observacion"+i+"="+encodeURIComponent(document.getElementById('observacion'+i+'-'+k).value);
			 				parametro = parametro + sarta;
			 				break;
								
			 		}
		 		}
		 }
		 
		 
		 
		 //multiple
		 if(document.getElementById('tipo'+i).value=='M'){
			
			 sarta ="";
			 sarta2 ="";
			 chequeados = 0;
			 for(var k=1; k<=parseInt(document.getElementById('cantidad'+i).value); k++){
			 		if(document.getElementById('chequeo'+i+'-'+k).checked){
			 			
			 			
			 			chequeados++;
			 			
			 				//guarda la respuesta correcta para unica respuesta
			 			
			 			
			 				observacion=document.getElementById('observacion'+i+'-'+k).value;
			 				if(observacion==null || observacion.replace(/^\s*|\s*$/g, "") == ""){ 
			 					observacion = "null";
			 				}
			 				
			 				if(chequeados==1){
					 			    sarta  +=	 ""+document.getElementById('chequeo'+i+'-'+k).value;
					 				sarta2 +=	 ""+observacion;
			 				}else{
			 						sarta  +=	 "-dfvp-"+document.getElementById('chequeo'+i+'-'+k).value;
			 						sarta2 +=	 "-dfvp-"+observacion;
			 				}
			 						
								
			 		}
		 		}
			 
			 	if(chequeados>0){
			 		sarta_envio = "&chequeados"+i+"="+encodeURIComponent(sarta)+"&observaciones"+i+"="+encodeURIComponent(sarta2);
			 		parametro = parametro + sarta_envio;
			 	}
			 
		 }

			
		 //tiempo
		parametro = parametro + "&pregunta" + i + "="
				+ document.getElementById('pregunta' + i).value;
		parametro = parametro + "&tipoPregunta" + i + "="
				+ document.getElementById('tipo' + i).value;

		if (document.getElementById('tipo' + i).value == "T") {

			parametro = parametro + "&horas" + i + "="
					+ document.getElementById('horas' + i).value;
			parametro = parametro + "&minutos" + i + "="
					+ document.getElementById('minutos' + i).value;

		}

				//abierta
		 if(document.getElementById('tipo'+i).value=='A'){
					
			 sarta =	 "&abierta"+i+"="+encodeURIComponent(document.getElementById('abierta'+i).value);	
			 parametro = parametro + sarta;
			 
		 }

	}

	// parametro = parametro + "&registros="

	// parametro = parametro + "&registros="+iterador;

	ajax = nuevoAjax();
	parametros = parametro;
	url = "/f-web/nuevaRespuesta.jsp";
	ajax.onreadystatechange = function() {
		if (ajax.readyState == 1) {
			document.getElementById('detalle_respuesta').innerHTML = "<img src='images/ajax/ajax-loader3.gif'> ";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {

				document.getElementById('detalle_respuesta').innerHTML = "";
				document.getElementById('detalle_respuesta').style.background = "";
				document.getElementById('detalle_respuesta').innerHTML = ajax.responseText;

				// if (parseInt(document.getElementById("hdnExito").value) == 1)
				// {
				alert('Respuestas guardadas exitosamente. Que tengas un buen dia!');
				document.form1.submit();
				// } else {
				// alert('NO SE PUEDE GUARDAR');
				// }

			} else if (ajax.status == 404) {
				document.getElementById('detalle_respuesta').innerHTML = "-Inexistencia, contacte administrador-";
			} else {
				document.getElementById('detalle_respuesta').innerHTML = "-Error, contacte administrador";
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type',
			'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(parametros);

}

function contestarEncuesta(admin) {

	ajax = nuevoAjax();
	parametros = "id=" + admin;
	url = "/f-web/contestarEncuesta.jsp";
	ajax.onreadystatechange = function() {
		if (ajax.readyState == 1) {
			document.getElementById('detalleAdministradores').innerHTML = "<img src='images/ajax/ajax-loader3.gif'>";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('detalleAdministradores').innerHTML = "";
				document.getElementById('detalleAdministradores').style.background = "";
				document.getElementById('detalleAdministradores').innerHTML = ajax.responseText;

				if (parseInt(document.getElementById('hdnExito').value) == 0) {

					alert('YA RESPONDIO ESTA ENCUESTA, ADIOS QUE TENGAS UN BUEN DIA.');

				}

			} else if (ajax.status == 404) {
				document.getElementById('detalleAdministradores').innerHTML = "-Inexistencia, contacte administrador-";
			} else {
				document.getElementById('detalleAdministradores').innerHTML = "-Error, contacte administrador";
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type',
			'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(parametros);

}

function cargarEliminarEncuesta(admin) {

	if (confirm('REALMENTE DESEA ELIMINAR LA ENCUESTA?')) {
		ajax = nuevoAjax();
		parametros = "id=" + admin;
		url = "/f-web/eliminarEncuesta.jsp";
		ajax.onreadystatechange = function() {
			if (ajax.readyState == 1) {
				document.getElementById('detalleProcesos').innerHTML = "<img src='images/ajax/ajax-loader3.gif'> Eliminando encuesta espere un momento...";
			} else if (ajax.readyState == 4) {
				if (ajax.status == 200) {
					document.getElementById('detalleProcesos').innerHTML = "";
					document.getElementById('detalleProcesos').style.background = "";
					document.getElementById('detalleProcesos').innerHTML = ajax.responseText;

					if (parseInt(document.getElementById('hdnElimino').value) == 1) {
						alert('ENCUESTA ELIMINADA CON EXITO');
						cargarEncuestas();

					} else {
						alert('NO SE PUEDE ELIMINAR LA ENCUESTA PUES TIENE ASOCIADO CONTENIDO.');

					}

				} else if (ajax.status == 404) {
					document.getElementById('detalleProcesos').innerHTML = "-Inexistencia, contacte administrador-";
				} else {
					document.getElementById('detalleProcesos').innerHTML = "-Error, contacte administrador";
				}
			}
		}

		ajax.open("POST", url, true);
		ajax.setRequestHeader('Content-Type',
				'application/x-www-form-urlencoded; charset=utf-8');
		ajax.send(parametros);

	}
}

function cargarEliminarProyectoLinea(admin) {

	if (confirm('REALMENTE DESEA ELIMINAR LA RELACION PROYECTO-LINEA-FINANCIADOR?')) {
		ajax = nuevoAjax();
		parametros = "id=" + admin;
		url = "/f-web/eliminarProyectoLinea.jsp";
		ajax.onreadystatechange = function() {
			if (ajax.readyState == 1) {
				document.getElementById('detalleProcesos').innerHTML = "<img src='images/ajax/ajax-loader3.gif'> Eliminando espere un momento...";
			} else if (ajax.readyState == 4) {
				if (ajax.status == 200) {
					document.getElementById('detalleProcesos').innerHTML = "";
					document.getElementById('detalleProcesos').style.background = "";
					document.getElementById('detalleProcesos').innerHTML = ajax.responseText;

					if (parseInt(document.getElementById('hdnElimino').value) == 1) {
						alert('RELACION PROYECTO-LINEA-FINANCIADOR ELIMINADA CON EXITO');
						cargarProyectosLineas();

					} else {
						alert('NO SE PUEDE ELIMINAR LA RELACION PROYECTO-LINEA-FINANCIADOR PUES TIENE ASOCIADO CONTENIDO.');

					}

				} else if (ajax.status == 404) {
					document.getElementById('detalleProcesos').innerHTML = "-Inexistencia, contacte administrador-";
				} else {
					document.getElementById('detalleProcesos').innerHTML = "-Error, contacte administrador";
				}
			}
		}

		ajax.open("POST", url, true);
		ajax.setRequestHeader('Content-Type',
				'application/x-www-form-urlencoded; charset=utf-8');
		ajax.send(parametros);

	}
}

function cargarEliminarLinea(admin) {

	if (confirm('REALMENTE DESEA ELIMINAR LA LINEA?')) {
		ajax = nuevoAjax();
		parametros = "id=" + admin;
		url = "/f-web/eliminarLinea.jsp";
		ajax.onreadystatechange = function() {
			if (ajax.readyState == 1) {
				document.getElementById('detalleProcesos').innerHTML = "<img src='images/ajax/ajax-loader3.gif'> Eliminando espere un momento...";
			} else if (ajax.readyState == 4) {
				if (ajax.status == 200) {
					document.getElementById('detalleProcesos').innerHTML = "";
					document.getElementById('detalleProcesos').style.background = "";
					document.getElementById('detalleProcesos').innerHTML = ajax.responseText;

					if (parseInt(document.getElementById('hdnElimino').value) == 1) {
						alert('LINEA ELIMINADA CON EXITO');
						cargarLineas();

					} else {
						alert('NO SE PUEDE ELIMINAR LA LINEA PUES TIENE ASOCIADO CONTENIDO.');

					}

				} else if (ajax.status == 404) {
					document.getElementById('detalleProcesos').innerHTML = "-Inexistencia, contacte administrador-";
				} else {
					document.getElementById('detalleProcesos').innerHTML = "-Error, contacte administrador";
				}
			}
		}

		ajax.open("POST", url, true);
		ajax.setRequestHeader('Content-Type',
				'application/x-www-form-urlencoded; charset=utf-8');
		ajax.send(parametros);

	}
}

function cargarEliminarProyecto(admin) {

	if (confirm('REALMENTE DESEA ELIMINAR EL PROYECTO?')) {
		ajax = nuevoAjax();
		parametros = "id=" + admin;
		url = "/f-web/eliminarProyecto.jsp";
		ajax.onreadystatechange = function() {
			if (ajax.readyState == 1) {
				document.getElementById('detalleProcesos').innerHTML = "<img src='images/ajax/ajax-loader3.gif'> Eliminando espere un momento...";
			} else if (ajax.readyState == 4) {
				if (ajax.status == 200) {
					document.getElementById('detalleProcesos').innerHTML = "";
					document.getElementById('detalleProcesos').style.background = "";
					document.getElementById('detalleProcesos').innerHTML = ajax.responseText;

					if (parseInt(document.getElementById('hdnElimino').value) == 1) {
						alert('PROYECTO ELIMINADO CON EXITO');
						cargarProyectos();

					} else {
						alert('NO SE PUEDE ELIMINAR EL PROYECTO PUES TIENE ASOCIADO CONTENIDO.');

					}

				} else if (ajax.status == 404) {
					document.getElementById('detalleProcesos').innerHTML = "-Inexistencia, contacte administrador-";
				} else {
					document.getElementById('detalleProcesos').innerHTML = "-Error, contacte administrador";
				}
			}
		}

		ajax.open("POST", url, true);
		ajax.setRequestHeader('Content-Type',
				'application/x-www-form-urlencoded; charset=utf-8');
		ajax.send(parametros);

	}
}

function cargarEliminarLogoFinanciador(admin) {

	if (confirm('REALMENTE DESEA ELIMINAR EL LOGO DEL FINANCIADOR?')) {
		ajax = nuevoAjax();
		parametros = "id=" + admin;
		url = "/f-web/eliminarLogo.jsp";
		ajax.onreadystatechange = function() {
			if (ajax.readyState == 1) {
				document.getElementById('detalleProcesos').innerHTML = "<img src='images/ajax/ajax-loader3.gif'> Eliminando logo espere un momento...";
			} else if (ajax.readyState == 4) {
				if (ajax.status == 200) {
					document.getElementById('detalleProcesos').innerHTML = "";
					document.getElementById('detalleProcesos').style.background = "";
					document.getElementById('detalleProcesos').innerHTML = ajax.responseText;

					if (parseInt(document.getElementById('hdnElimino').value) == 1) {
						alert('LOGO DEL FINANCIADOR ELIMINADO CON EXITO');
						document.form1.submit();

					} else {
						alert('NO SE PUEDE ELIMINAR EL LOGO');

					}

				} else if (ajax.status == 404) {
					document.getElementById('detalleProcesos').innerHTML = "-Inexistencia, contacte administrador-";
				} else {
					// document.getElementById('detalleProcesos').innerHTML =
					// "-Error, contacte administrador";
					document.getElementById('detalleProcesos').innerHTML = ajax.responseText;
				}
			}
		}

		ajax.open("POST", url, true);
		ajax.setRequestHeader('Content-Type',
				'application/x-www-form-urlencoded; charset=utf-8');
		ajax.send(parametros);

	}
}

function cargarEliminarFinanciador(admin) {

	if (confirm('REALMENTE DESEA ELIMINAR FINANCIADOR ?')) {
		ajax = nuevoAjax();
		parametros = "id=" + admin;
		url = "/f-web/eliminarFinanciador.jsp";
		ajax.onreadystatechange = function() {
			if (ajax.readyState == 1) {
				document.getElementById('detalleProcesos').innerHTML = "<img src='images/ajax/ajax-loader3.gif'> Eliminando espere un momento...";
			} else if (ajax.readyState == 4) {
				if (ajax.status == 200) {
					document.getElementById('detalleProcesos').innerHTML = "";
					document.getElementById('detalleProcesos').style.background = "";
					document.getElementById('detalleProcesos').innerHTML = ajax.responseText;

					if (parseInt(document.getElementById('hdnElimino').value) == 1) {
						alert('FINANCIADOR ELIMINADO CON EXITO');
						cargarFinanciadores();

					} else {
						alert('NO SE PUEDE ELIMINAR EL FINANCIADOR PUES TIENE ASOCIADO CONTENIDO.');

					}

				} else if (ajax.status == 404) {
					document.getElementById('detalleProcesos').innerHTML = "-Inexistencia, contacte administrador-";
				} else {
					// document.getElementById('detalleProcesos').innerHTML =
					// "-Error, contacte administrador";
					document.getElementById('detalleProcesos').innerHTML = ajax.responseText;
				}
			}
		}

		ajax.open("POST", url, true);
		ajax.setRequestHeader('Content-Type',
				'application/x-www-form-urlencoded; charset=utf-8');
		ajax.send(parametros);

	}
}

function cargarEliminarCurso(admin) {

	if (confirm('REALMENTE DESEA ELIMINAR EL CURSO?')) {
		ajax = nuevoAjax();
		parametros = "id=" + admin;
		url = "/f-web/eliminarCurso.jsp";
		ajax.onreadystatechange = function() {
			if (ajax.readyState == 1) {
				document.getElementById('detalleProcesos').innerHTML = "<img src='images/ajax/ajax-loader3.gif'> Eliminando curso espere un momento...";
			} else if (ajax.readyState == 4) {
				if (ajax.status == 200) {
					document.getElementById('detalleProcesos').innerHTML = "";
					document.getElementById('detalleProcesos').style.background = "";
					document.getElementById('detalleProcesos').innerHTML = ajax.responseText;

					if (parseInt(document.getElementById('hdnElimino').value) == 1) {
						alert('CURSO ELIMINADO CON EXITO');
						cargarCursos();

					} else {
						alert('NO SE PUEDE ELIMINAR EL CURSO PUES TIENE ASOCIADO CONTENIDO.');

					}

				} else if (ajax.status == 404) {
					document.getElementById('detalleProcesos').innerHTML = "-Inexistencia, contacte administrador-";
				} else {
					document.getElementById('detalleProcesos').innerHTML = "-Error, contacte administrador";
				}
			}
		}

		ajax.open("POST", url, true);
		ajax.setRequestHeader('Content-Type',
				'application/x-www-form-urlencoded; charset=utf-8');
		ajax.send(parametros);

	}
}

function cargarEliminarAdministrador(admin) {

	if (confirm('REALMENTE DESEA ELIMINAR EL ADMINISTRADOR?')) {
		ajax = nuevoAjax();
		parametros = "id=" + admin;
		url = "/f-web/eliminarAdministrador.jsp";
		ajax.onreadystatechange = function() {
			if (ajax.readyState == 1) {
				document.getElementById('detalleProcesos').innerHTML = "<img src='images/ajax/ajax-loader3.gif'> Eliminando administrador espere un momento...";
			} else if (ajax.readyState == 4) {
				if (ajax.status == 200) {
					document.getElementById('detalleProcesos').innerHTML = "";
					document.getElementById('detalleProcesos').style.background = "";
					document.getElementById('detalleProcesos').innerHTML = ajax.responseText;

					if (parseInt(document.getElementById('hdnElimino').value) == 1) {
						alert('ADMINISTRADOR ELIMINADO CON EXITO');
						cargarAdministradores();

					} else {
						alert('NO SE PUEDE ELIMINAR EL ADMINISTRADOR PUES TIENE ASOCIADO CONTENIDO.');

					}

				} else if (ajax.status == 404) {
					document.getElementById('detalleProcesos').innerHTML = "-Inexistencia, contacte administrador-";
				} else {
					document.getElementById('detalleProcesos').innerHTML = "-Error, contacte administrador";
				}
			}
		}

		ajax.open("POST", url, true);
		ajax.setRequestHeader('Content-Type',
				'application/x-www-form-urlencoded; charset=utf-8');
		ajax.send(parametros);

	}
}

function cargarMigrarPlanos(idarchivo) {
	ajax = nuevoAjax();
	parametros = "idarchivo=" + idarchivo;
	url = "/f-web/archivosPlanos/migrarArchivoPlano.jsp";
	ajax.onreadystatechange = function() {
		if (ajax.readyState == 1) {
			document.getElementById('detalleProcesos').innerHTML = "<img src='images/ajax/ajax-loader3.gif'> Migrando egresados EISI UIS a la base de datos espere un momento...";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('detalleProcesos').innerHTML = "";
				document.getElementById('detalleProcesos').style.background = "";
				document.getElementById('detalleProcesos').innerHTML = ajax.responseText;

				if (parseInt(document.getElementById('hdnMigro').value) > 0) {
					alert('Se migraron '
							+ document.getElementById('hdnMigro').value
							+ " egresados EISI UIS a la base de datos");

				} else {
					alert('No se mirg� ning�n egresado EISI UIS a la base de datos');
				}

			} else if (ajax.status == 404) {
				document.getElementById('detalleProcesos').innerHTML = "-Inexistencia, contacte administrador-";
			} else {
				document.getElementById('detalleProcesos').innerHTML = "-Error, contacte administrador";
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type',
			'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(parametros);
}

function cargarPrivadas() {
	ajax = nuevoAjax();
	parametros = "us=" + document.getElementById('hdnUs').value;
	url = "/f-web/notasPrivadasRecientes.jsp";
	ajax.onreadystatechange = function() {
		if (ajax.readyState == 1) {
			document.getElementById('detallePrivadas').innerHTML = "<img src='images/ajax/ajax-loader3.gif'>";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('detallePrivadas').innerHTML = "";
				document.getElementById('detallePrivadas').style.background = "";
				document.getElementById('detallePrivadas').innerHTML = ajax.responseText;

			} else if (ajax.status == 404) {
				document.getElementById('detallePrivadas').innerHTML = "-Inexistencia, contacte administrador-";
			} else {
				document.getElementById('detallePrivadas').innerHTML = "-Error, contacte administrador";
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type',
			'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(parametros);
}

function cargarPlanos() {
	ajax = nuevoAjax();
	url = "/f-web/archivosPlanos/resultadosPlanos.jsp";
	ajax.onreadystatechange = function() {
		if (ajax.readyState == 1) {
			document.getElementById('detalleArchivos').innerHTML = "<img src='images/ajax/ajax-loader3.gif'> Cargando informaci�n...";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('detalleArchivos').innerHTML = "";
				document.getElementById('detalleArchivos').style.background = "";
				document.getElementById('detalleArchivos').innerHTML = ajax.responseText;

			} else if (ajax.status == 404) {
				document.getElementById('detalleArchivos').innerHTML = "-Inexistencia, contacte administrador-";
			} else {
				document.getElementById('detalleArchivos').innerHTML = "-Error, contacte administrador";
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type',
			'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(null);
}

function cargarPortafolios() {
	ajax = nuevoAjax();
	url = "/f-web/resultadosPortafolios.jsp";
	ajax.onreadystatechange = function() {
		if (ajax.readyState == 1) {
			document.getElementById('detalleAdministradores').innerHTML = "<img src='images/ajax/ajax-loader3.gif'>";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('detalleAdministradores').innerHTML = "";
				document.getElementById('detalleAdministradores').style.background = "";
				document.getElementById('detalleAdministradores').innerHTML = ajax.responseText;

			} else if (ajax.status == 404) {
				document.getElementById('detalleAdministradores').innerHTML = "-Inexistencia, contacte administrador-";
			} else {
				document.getElementById('detalleAdministradores').innerHTML = "-Error, contacte administrador";
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type',
			'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(null);
}

function validarLoteConsulta2() {

	sw = 0;

	if ((document.getElementById("documento_certificado").value.replace(
			/^\s*|\s*$/g, "") != "")) {

		if (!(es_numeroCERTIFICADO(document
				.getElementById("documento_certificado").value.replace(
				/^\s*|\s*$/g, "")))) {
			alert('EL DOCUMENTO DEBE SER NUMERICO');
			return false;
		} else {

			sw = 1;
		}
	}

	if (sw == 1) {
		cargarLotes2();

	} else {

		alert('DEBE ESCRIBIR UN NUMERO DE DOCUMENTO');

	}

}

function validarLoteConsulta() {

	sw = 0;
	if (document.getElementById("certificado").value != "0") {
		sw = 1;
	}

	if (document.getElementById("nombre").value.replace(/^\s*|\s*$/g, "") != "") {
		sw = 1;
	}

	if ((document.getElementById("documento").value.replace(/^\s*|\s*$/g, "") != "")) {

		if (!(es_numeroCERTIFICADO(document.getElementById("documento").value
				.replace(/^\s*|\s*$/g, "")))) {
			alert('EL DOCUMENTO DEBE SER NUMERICO');
			return false;
		} else {

			sw = 1;
		}
	}

	if (document.getElementById("fecha_inicio").value.replace(/^\s*|\s*$/g, "") != "") {
		sw = 1;
	}

	if (document.getElementById("fecha_fin").value.replace(/^\s*|\s*$/g, "") != "") {
		sw = 1;
	}

	if (sw == 1) {
		cargarLotes();

	} else {

		alert('DEBE SELECCIONAR O DIGITAR AL MENOS UN CRITERIO DE CONSULTA');

	}

}

function cargarLotes2() {
	ajax = nuevoAjax();
	url = "/f-web/resultadosLotes2.jsp?d="
			+ document.getElementById("documento_certificado").value.replace(
					/^\s*|\s*$/g, "");

	ajax.onreadystatechange = function() {
		if (ajax.readyState == 1) {
			document.getElementById('detalleLote').innerHTML = "<img src='images/ajax/ajax-loader3.gif'> Cargando...";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('detalleLote').innerHTML = "";
				document.getElementById('detalleLote').style.background = "";
				document.getElementById('detalleLote').innerHTML = ajax.responseText;

			} else if (ajax.status == 404) {
				document.getElementById('detalleLote').innerHTML = "";
			} else {
				document.getElementById('detalleLote').innerHTML = "";
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type',
			'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(null);
}

function cargarLotes() {
	ajax = nuevoAjax();
	url = "/f-web/resultadosLotes.jsp?tc="
			+ document.getElementById("certificado").value
			+ "&n="
			+ document.getElementById("nombre").value.replace(/^\s*|\s*$/g, "")
			+ "&d="
			+ document.getElementById("documento").value.replace(/^\s*|\s*$/g,
					"") + "&fi="
			+ document.getElementById("fecha_inicio").value + "&ff="
			+ document.getElementById("fecha_fin").value;

	ajax.onreadystatechange = function() {
		if (ajax.readyState == 1) {
			document.getElementById('detalleLote').innerHTML = "<img src='images/ajax/ajax-loader3.gif'>";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('detalleLote').innerHTML = "";
				document.getElementById('detalleLote').style.background = "";
				document.getElementById('detalleLote').innerHTML = ajax.responseText;

			} else if (ajax.status == 404) {
				document.getElementById('detalleLote').innerHTML = ajax.responseText;
			} else {
				document.getElementById('detalleLote').innerHTML = ajax.responseText;
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type',
			'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(null);
}

function esconderComuna() {

	if (document.getElementById("control14").value.replace(/^\s*|\s*$/g, "") == "C") {
		document.getElementById("control16").style.display = "block";
		document.getElementById("label16").style.display = "block";
	} else {

		document.getElementById("control16").style.display = "none";
		document.getElementById("label16").style.display = "none";
	}

}

function validarMujer() {

	// controles requeridos
	requeridos = [ 1, 3, 5, 7, 6, 10, 11, 13, 14, 15, 16, 17 ]; // antes el 12

	// valida vacios
	mensaje = "";
	vacios = 0;
	// 18 es el maximo de requeridos
	try {

		for (var i = 1; i <= 17; i++) {

			sw = 0;
			for (var j = 0; j <= requeridos.length - 1; j++) {
				if (requeridos[j] == i) {
					sw = 1;
					break;
				}

			}
			if (sw == 1) {

				if (document.getElementById("control" + i).value.replace(
						/^\s*|\s*$/g, "") == "") {
					vacios = 1;
					break;
				}

			}

		}

		if (vacios == 1) {
			mensaje += "* EXISTEN CAMPOS REQUERIDOS QUE DEBE DILIGENCIAR (POSEEN UN *)\n";
		}

		// valida numeros
		snumeros = 0;
		try {

			if (document.getElementById("control5").value.replace(/^\s*|\s*$/g,
					"") != "") {
				var h1 = parseInt(document.getElementById("control5").value
						.replace(/^\s*|\s*$/g, ""));
				if (isNaN(h1)) {
					snumeros = 1;
					mensaje += "* NUMERO DE CEDULA DEBE SER NUMERICO SIN PUNTOS NI COMAS\n";
				} else {

					if (h1 <= 0) {
						mensaje += "* NUMERO DE CEDULA DEBE SER MAYOR A CERO\n";
					}

				}
			}

			if (document.getElementById("control10").value.replace(
					/^\s*|\s*$/g, "") != "") {
				var h2 = parseInt(document.getElementById("control10").value
						.replace(/^\s*|\s*$/g, ""));
				if (isNaN(h2)) {
					snumeros = 1;
					mensaje += "* NUMERO DE HIJAS DEBE SER NUMERICO SIN PUNTOS NI COMAS\n";
				} else {

					if (h2 < 0) {
						mensaje += "* NUMERO DE HIJAS DEBE SER MAYOR O IGUAL A CERO\n";
					}

				}
			}

			if (document.getElementById("control11").value.replace(
					/^\s*|\s*$/g, "") != "") {
				var h3 = parseInt(document.getElementById("control11").value
						.replace(/^\s*|\s*$/g, ""));
				if (isNaN(h3)) {
					snumeros = 1;
					mensaje += "* NUMERO DE HIJOS DEBE SER NUMERICO SIN PUNTOS NI COMAS\n";
				} else {

					if (h3 < 0) {
						mensaje += "* NUMERO DE HIJOS DEBE SER MAYOR O IGUAL A CERO\n";
					}

				}
			}

		} catch (e) {
			snumeros = 1;
			mensaje += "* EXISTEN CAMPOS QUE DEBEN SER NUMERICOS SIN PUNTOS NI COMAS\n";
		}

		// valida correo
		isEmailAddress2(document.getElementById('control8'), 'control8');
		mensaje = mensaje + mensaje3;

		if (mensaje != "") {
			alert("CORRIJA LO SIGUIENTE:\n\n" + mensaje);
		} else {
			if (confirm('DESEA ACTUALIZAR LA NFORMACION DE LA HOJA DE VIDA ?')) {
				document.getElementById("hdnGuardarPublicacion").value = "1";
				document.form1.submit();
			}
		}

	} catch (ee) {
		alert("EXISTEN DATOS VACIOS");
	}

}

function isNumeric(n) {
	return !isNaN(parseFloat(n)) && isFinite(n);
}

function fparametrosupdateCurso() {

	vacios = 0;
	suma = 0;

	for (var i = 1; i <= parseInt(document.getElementById("total").value); i++) {

		if (document.getElementById("valor" + i).value
				.replace(/^\s*|\s*$/g, "") == "") {
			vacios = 1;
			break;
		} else {

			try {
				if (isNumeric(document.getElementById("valor" + i).value
						.replace(/^\s*|\s*$/g, ""))) {

					suma = suma
							+ parseFloat(document.getElementById("valor" + i).value
									.replace(/^\s*|\s*$/g, ""));
				} else {
					vacios = 1;
					break;

				}
			} catch (e) {
				vacios = 1;
				break;
			}

		}

	}

	// alert('22');

	if (vacios == 0) {

		if (suma >= 99.95 && suma <= 100) {
			document.form1.submit();
		} else {

			alert('LA SUMA DE PORCENTAJES NO ES 100%');
		}

	} else {
		alert('EXISTEN PORCENTAJES INVALIDOS O VACIOS REVISE.');
	}

}

function fparametrosupdate() {

	vacios = 0;

	for (var i = 1; i <= parseInt(document.getElementById("total").value); i++) {

		if (document.getElementById("titulo" + i).value.replace(/^\s*|\s*$/g,
				"") == "") {
			vacios = 1;
			break;
		}

		if (document.getElementById("valor" + i).value
				.replace(/^\s*|\s*$/g, "") == "") {
			vacios = 1;
			break;
		}
	}

	if (vacios == 0) {
		document.form1.submit();
	} else {
		alert('EXISTEN DATOS VACIOS REVISE.');
	}

}

function consultarMujer(id) {
	ajax = nuevoAjax();

	parametros = "id=" + id + "&pn="
			+ encodeURIComponent(document.getElementById("control1").value)
			+ "&sn="
			+ encodeURIComponent(document.getElementById("control2").value)
			+ "&pa="
			+ encodeURIComponent(document.getElementById("control3").value)
			+ "&sa="
			+ encodeURIComponent(document.getElementById("control4").value)
			+ "&doc="
			+ encodeURIComponent(document.getElementById("control5").value);

	url = "/f-web/mujeresConsultadas.jsp";
	ajax.onreadystatechange = function() {
		if (ajax.readyState == 1) {
			document.getElementById('detalle').innerHTML = "<img src='images/ajax/ajax-loader3.gif'> ";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('detalle').innerHTML = "";
				document.getElementById('detalle').style.background = "";
				document.getElementById('detalle').innerHTML = ajax.responseText;

			} else if (ajax.status == 404) {
				document.getElementById('detalle').innerHTML = "-Inexistencia, contacte administrador-";
			} else {
				document.getElementById('detalle').innerHTML = "-Error, contacte administrador";
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type',
			'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(parametros);
}

function cargarEliminarParametro(admin) {

	if (confirm('REALMENTE DESEA ELIMINAR EL PARAMETRO?')) {
		ajax = nuevoAjax();
		parametros = "id=" + admin;
		url = "/f-web/eliminarParametro.jsp";
		ajax.onreadystatechange = function() {
			if (ajax.readyState == 1) {
				document.getElementById('detalleProcesos').innerHTML = "<img src='images/ajax/ajax-loader3.gif'> Eliminando espere un momento...";
			} else if (ajax.readyState == 4) {
				if (ajax.status == 200) {
					document.getElementById('detalleProcesos').innerHTML = "";
					document.getElementById('detalleProcesos').style.background = "";
					document.getElementById('detalleProcesos').innerHTML = ajax.responseText;

					if (parseInt(document.getElementById('hdnElimino').value) == 1) {
						alert('ELIMINADO CON EXITO');
						cargarParametros();

					} else {
						alert('NO SE PUEDE ELIMINAR EL PARAMETRO');

					}

				} else if (ajax.status == 404) {
					document.getElementById('detalleProcesos').innerHTML = "-Inexistencia, contacte administrador-";
				} else {
					document.getElementById('detalleProcesos').innerHTML = "-Error, contacte administrador";
				}
			}
		}

		ajax.open("POST", url, true);
		ajax.setRequestHeader('Content-Type',
				'application/x-www-form-urlencoded; charset=utf-8');
		ajax.send(parametros);

	}
}

function nuevoParametro() {

	var mensaje = "";

	if (document.getElementById('txtTitulo').value.replace(/^\s*|\s*$/g, "") == "") {
		mensaje = mensaje + "* DIGITE EL NOMBRE DEL PARAMETRO\n";
	}

	if (document.getElementById('txtValor').value.replace(/^\s*|\s*$/g, "") == "") {
		mensaje = mensaje + "* DIGITE EL VALOR\n";
	}

	if (mensaje.replace(/^\s*|\s*$/g, "") == "") {
		cargarCrearParametro();

	} else {
		alert(mensaje);
	}

}

function cargarCrearParametro() {
	ajax = nuevoAjax();
	parametros = "t="
			+ encodeURIComponent(document.getElementById("txtTitulo").value)
			+ "&v="
			+ encodeURIComponent(document.getElementById("txtValor").value);
	url = "/f-web/nuevaCreacionParametro.jsp";
	ajax.onreadystatechange = function() {
		if (ajax.readyState == 1) {
			document.getElementById('detalle').innerHTML = "<img src='images/ajax/ajax-loader3.gif'> ";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('detalle').innerHTML = "";
				document.getElementById('detalle').style.background = "";
				document.getElementById('detalle').innerHTML = ajax.responseText;

				if (parseInt(document.getElementById("hdnExito").value) == 1) {
					alert('PARAMETRO CREADO CON EXITO');
					window.opener.cargarParametros();
					try {
						window.opener.document.form1.submit();
					} catch (e) {
					}
					window.close();
				} else {
					alert('NO SE PUEDE CREAR');
				}

			} else if (ajax.status == 404) {
				document.getElementById('detalle').innerHTML = "-Inexistencia, contacte administrador-";
			} else {
				document.getElementById('detalle').innerHTML = "-Error, contacte administrador";
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type',
			'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(parametros);
}

function cargarParametros() {
	ajax = nuevoAjax();
	url = "/f-web/resultadosParametros.jsp";
	ajax.onreadystatechange = function() {
		if (ajax.readyState == 1) {
			document.getElementById('detalleAdministradores').innerHTML = "<img src='images/ajax/ajax-loader3.gif'>";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('detalleAdministradores').innerHTML = "";
				document.getElementById('detalleAdministradores').style.background = "";
				document.getElementById('detalleAdministradores').innerHTML = ajax.responseText;

			} else if (ajax.status == 404) {
				document.getElementById('detalleAdministradores').innerHTML = "-Inexistencia, contacte administrador-";
			} else {
				document.getElementById('detalleAdministradores').innerHTML = ajax.responseText;
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type',
			'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(null);
}

function validarLote() {

	mensaje = "";
	if (document.getElementById("certificado").value == "0") {
		mensaje += "* DEBE SELECCIONAR EL CERTIFICADO QUE VA A RECIBIR EL LOTE DE CAPACITADOS\n";
	}

	if (document.getElementById("ciudad_curso").value.replace(/^\s*|\s*$/g, "") == "") {
		mensaje += "* ESCRIBA CIUDAD/DEPARTAMENTO DONDE SE HIZO LA CAPACITACION\n";
	}

	if (document.getElementById("numero_personas").value.replace(/^\s*|\s*$/g,
			"") == "") {
		mensaje += "* ESCRIBA EL NUMERO DE PERSONAS QUE RECIBIO CAPACITACION\n";
	} else {

		if (parseInt(document.getElementById("numero_personas").value) <= 0) {
			mensaje += "* EL NUMERO DE PERSONAS CAPACITADAS DEBE SER MINIMO 1\n";
		}

	}

	if (document.getElementById("horas_certificadas").value.replace(
			/^\s*|\s*$/g, "") == "") {
		mensaje += "* ESCRIBA EL NUMERO DE HORAS A CERTIFICAR\n";
	} else {

		if (parseInt(document.getElementById("horas_certificadas").value) <= 0) {
			mensaje += "* EL NUMERO DE HORAS CERTIFICADAS DEBE SER MINIMO 1\n";
		}

	}

	if (document.getElementById("fecha_inicio").value.replace(/^\s*|\s*$/g, "") == "") {
		mensaje += "* ESCRIBA LA FECHA INICIO DE LA CAPACITACION\n";
	}

	if (document.getElementById("fecha_fin").value.replace(/^\s*|\s*$/g, "") == "") {
		mensaje += "* ESCRIBA LA FECHA FIN DE LA CAPACITACION\n";
	}

	if (document.getElementById("fecha_maxima").value.replace(/^\s*|\s*$/g, "") == "") {
		mensaje += "* ESCRIBA LA FECHA MAXIMA QUE ESTARA DISPONIBLE LA CERTIFICACION\n";
	}

	validarFechas(mensaje)

}

function es_numeroCERTIFICADO(cadena) {
	var longit = cadena.length;

	for (k = 0; k < longit; k++) {
		var car = cadena.charAt(k);
		if ((car != '1') && (car != '2') && (car != '3') && (car != '4')
				&& (car != '5') && (car != '6') && (car != '7') && (car != '8')
				&& (car != '9') && (car != '0'))
			return false;
	}
	if (longit > 0)
		return true;
	else
		return false;
}

function validarFechas(mensaje) {
	document.getElementById('hdnGuardarPublicacion').value = "0";
	ajax = nuevoAjax();
	url = "/f-web/validarFechas.jsp?fi="
			+ document.getElementById("fecha_inicio").value + "&ff="
			+ document.getElementById("fecha_fin").value + "&fm="
			+ document.getElementById("fecha_maxima").value;
	ajax.onreadystatechange = function() {
		if (ajax.readyState == 1) {
			document.getElementById('detalleFechas').innerHTML = "<img src='images/ajax/ajax-loader3.gif'>";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('detalleFechas').innerHTML = "";
				document.getElementById('detalleFechas').style.background = "";
				document.getElementById('detalleFechas').innerHTML = ajax.responseText;

				sw = 0;
				for (var i = 1; i <= parseInt(document
						.getElementById("numero_personas").value); i++) {

					if (document.getElementById("documento" + i).value.replace(
							/^\s*|\s*$/g, "") == "") {
						sw = 1;
						break;
					} else {
						if (!(es_numeroCERTIFICADO(document
								.getElementById("documento" + i).value.replace(
								/^\s*|\s*$/g, "")))) {
							sw = 1;
							break;
						}

					}

					if (document.getElementById("nombre" + i).value.replace(
							/^\s*|\s*$/g, "") == "") {
						sw = 1;
						break;
					}

				}

				if (sw == 1) {
					mensaje += "* LOS DATOS DE TODAS LAS PERSONAS CAPACITADAS ESTAN INCOMPLETOS O SU DOCUMENTO NO ES NUMERICO (SIN COMAS NI PUNTOS)\n";
					mensaje = "SE ENCONTRO LAS SIGUIENTES INCONSISTENCIAS:\n\n"
							+ mensaje + document.getElementById("fechas").value;
					alert(mensaje);

				} else {

					sw = 0;
					for (var i = 1; i <= parseInt(document
							.getElementById("numero_personas").value); i++) {

						if (document.getElementById("ciudad" + i).value
								.replace(/^\s*|\s*$/g, "") == "") {
							sw = 1;
							break;
						}

					}

					if (sw == 0) {
						document.getElementById('hdnGuardarPublicacion').value = "1";
						document.form1.submit();

					} else {

						if (confirm('EXISTEN CIUDADES DE DOCUMENTOS SIN DILIEGENCIAR, DESEA CONTINUAR Y GUARDAR EL CERTIFICADO SIN ESTE ?')) {
							document.getElementById('hdnGuardarPublicacion').value = "1";
							document.form1.submit();
						}

					}

				}

			} else if (ajax.status == 404) {
				document.getElementById('detalleFechas').innerHTML = ajax.responseText;
			} else {
				document.getElementById('detalleFechas').innerHTML = ajax.responseText;
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type',
			'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(null);
}

function cargarNuevoLote() {
	ajax = nuevoAjax();
	url = "/f-web/crearNuevoLote.jsp?n="
			+ document.getElementById("numero_personas").value;
	ajax.onreadystatechange = function() {
		if (ajax.readyState == 1) {
			document.getElementById('detalleLote').innerHTML = "<img src='images/ajax/ajax-loader3.gif'>";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('detalleLote').innerHTML = "";
				document.getElementById('detalleLote').style.background = "";
				document.getElementById('detalleLote').innerHTML = ajax.responseText;

			} else if (ajax.status == 404) {
				document.getElementById('detalleLote').innerHTML = "-Inexistencia, contacte administrador-";
			} else {
				document.getElementById('detalleLote').innerHTML = "-Error, contacte administrador";
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type',
			'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(null);
}




function cargarResultadosOJO2() {

	if (document.getElementById("encuesta").value != "" && document.getElementById("documento_mujer").value!="") {

		ajax = nuevoAjax();
		url = "/f-web/resultadosMujeres2.jsp";

		parametros = "encuesta=" + document.getElementById("encuesta").value+ "&documento_mujer="+ document.getElementById("documento_mujer").value;

		ajax.onreadystatechange = function() {
			if (ajax.readyState == 1) {
				document.getElementById('detalleAdministradores').innerHTML = "<img src='images/ajax/ajax-loader3.gif'>";
			} else if (ajax.readyState == 4) {
				if (ajax.status == 200) {

					document.getElementById('detalleAdministradores').innerHTML = "";
					document.getElementById('detalleAdministradores').style.background = "";
					document.getElementById('detalleAdministradores').innerHTML = ajax.responseText;

				} else if (ajax.status == 404) {

					document.getElementById('detalleAdministradores').innerHTML = ajax.responseText;
					// document.getElementById('detalleAdministradores').innerHTML
					// = "-Inexistencia, contacte administrador-";
				} else {
					document.getElementById('detalleAdministradores').innerHTML = ajax.responseText;
					// document.getElementById('detalleAdministradores').innerHTML
					// = "-Error, contacte administrador";
				}
			}
		}

		ajax.open("POST", url, true);
		ajax.setRequestHeader('Content-Type',
				'application/x-www-form-urlencoded; charset=utf-8');
		ajax.send(parametros);

	} else {

		alert("SELECCIONE UNA ENCUESTA PARA CONTINUAR");

	}
}

function cargarResultadosOJO() {

	if (document.getElementById("encuesta").value != "") {

		ajax = nuevoAjax();
		url = "/f-web/resultadosMujeres2.jsp";

		parametros = "encuesta=" + document.getElementById("encuesta").value;

		ajax.onreadystatechange = function() {
			if (ajax.readyState == 1) {
				document.getElementById('detalleAdministradores').innerHTML = "<img src='images/ajax/ajax-loader3.gif'>";
			} else if (ajax.readyState == 4) {
				if (ajax.status == 200) {

					document.getElementById('detalleAdministradores').innerHTML = "";
					document.getElementById('detalleAdministradores').style.background = "";
					document.getElementById('detalleAdministradores').innerHTML = ajax.responseText;

				} else if (ajax.status == 404) {

					document.getElementById('detalleAdministradores').innerHTML = ajax.responseText;
					// document.getElementById('detalleAdministradores').innerHTML
					// = "-Inexistencia, contacte administrador-";
				} else {
					document.getElementById('detalleAdministradores').innerHTML = ajax.responseText;
					// document.getElementById('detalleAdministradores').innerHTML
					// = "-Error, contacte administrador";
				}
			}
		}

		ajax.open("POST", url, true);
		ajax.setRequestHeader('Content-Type',
				'application/x-www-form-urlencoded; charset=utf-8');
		ajax.send(parametros);

	} else {

		alert("SELECCIONE UNA ENCUESTA PARA CONTINUAR");

	}
}

function cargarMujeres() {
	ajax = nuevoAjax();
	url = "/f-web/resultadosMujeres.jsp";

	parametros = "pn="
			+ encodeURIComponent(document.getElementById("control1").value)
			+ "&sn="
			+ encodeURIComponent(document.getElementById("control2").value)
			+ "&pa="
			+ encodeURIComponent(document.getElementById("control3").value)
			+ "&sa="
			+ encodeURIComponent(document.getElementById("control4").value)
			+ "&doc="
			+ encodeURIComponent(document.getElementById("control5").value);

	ajax.onreadystatechange = function() {
		if (ajax.readyState == 1) {
			document.getElementById('detalleAdministradores').innerHTML = "<img src='images/ajax/ajax-loader3.gif'>";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('detalleAdministradores').innerHTML = "";
				document.getElementById('detalleAdministradores').style.background = "";
				document.getElementById('detalleAdministradores').innerHTML = ajax.responseText;

			} else if (ajax.status == 404) {
				document.getElementById('detalleAdministradores').innerHTML = "-Inexistencia, contacte administrador-";
			} else {
				document.getElementById('detalleAdministradores').innerHTML = "-Error, contacte administrador";
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type',
			'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(parametros);
}

function guardarAsistencia2() {

	mensaje = "";
	sw = 0;
	var h1;
	sw2 = 0;
	for (var i = 1; i <= parseInt(document.getElementById('total_asistencia').value); i++) {
		if (document.getElementById('nombres' + i).value.replace(/^\s*|\s*$/g,
				"") == "") {

			sw = 1;

		}

		if (document.getElementById('documento' + i).value.replace(
				/^\s*|\s*$/g, "") == "") {

			sw = 1;

		}

		if (document.getElementById('residencia' + i).value.replace(
				/^\s*|\s*$/g, "") == "") {

			sw = 1;

		}

		if (document.getElementById('telefono' + i).value.replace(/^\s*|\s*$/g,
				"") == "") {

			sw = 1;

		}

		if (document.getElementById("documento" + i).value.replace(
				/^\s*|\s*$/g, "") != "") {
			h1 = parseInt();
			if (!es_numeroCERTIFICADO(document.getElementById("documento" + i).value
					.replace(/^\s*|\s*$/g, ""))) {
				sw2 = 1;
			} else {

				if (h1 <= 0) {
					sw2 = 2;
				}

			}
		}

	}

	if (sw == 0 && sw2 == 0) {

		if (confirm('DESEA GUARDAR LA PLANILLA ACTUAL DE INVITADAS ?\n\nTotal mujeres invitadas: '
				+ document.getElementById('total_asistencia').value)) {
			document.getElementById('hdnGuardarPublicacion').value = "1";
			document.getElementById("curso").disabled = false;
			document.getElementById("temas").disabled = false;
			document.getElementById("fecha").disabled = false;
			document.getElementById("horas_certificadas").disabled = false;
			document.getElementById("cal").disabled = false;
			document.getElementById("numero_asistentes").disabled = false;
			document.form1.submit();

		}
	} else {

		if (sw == 1) {
			mensaje += "\n*EXISTEN CAMPOS VACIOS";
		}

		if (sw2 == 1) {
			mensaje += "\n*LOS DOCUMENTOS DEBEN SER NUMERICOS";
		}

		if (sw2 == 2) {
			mensaje += "\n*LOS DOCUMENTOS DEBEN SER MAYOR A CERO";
		}

		alert(mensaje);

	}

}

function guardarAsistencia() {

	mensaje = "";
	sw = 0;

	asistentes = 0;
	noAsistentes = 0;

	for (var i = 1; i <= parseInt(document.getElementById('total_asistencia').value); i++) {
		if (document.getElementById('asistio' + i).checked
				&& document.getElementById('asistio' + i).value == 'S') {

			asistentes++;
		} else {

			noAsistentes++;
		}

	}

	if (confirm('DESEA GUARDAR LA PLANILLA ACTUAL ?\n\nTotal mujeres: '
			+ document.getElementById('total_asistencia').value
			+ '\nAsistentes: ' + asistentes + ' \nAusentes: ' + noAsistentes)) {
		document.getElementById('hdnGuardarPublicacion').value = "1";
		document.getElementById("curso").disabled = false;
		document.getElementById("temas").disabled = false;
		document.getElementById("financiadores").disabled = false;
		document.getElementById("lineas").disabled = false;
		// document.getElementById("tipo_asistencia").disabled = false;
		document.getElementById("fecha").disabled = false;

		document.getElementById("horas_certificadas").disabled = false;
		document.getElementById("cal").disabled = false;
		document.form1.submit();

	}

}

function validarPlanilla2() {

	mensaje = "";
	sw = 0;
	if (document.getElementById("temas").value.replace(/^\s*|\s*$/g, "") == "") {
		sw = 1;

	}

	if (document.getElementById("financiadores").value
			.replace(/^\s*|\s*$/g, "") == "") {
		sw = 1;

	}

	if (document.getElementById("lineas").value.replace(/^\s*|\s*$/g, "") == "") {
		sw = 1;

	}

	if (document.getElementById("curso").value.replace(/^\s*|\s*$/g, "") == "") {
		sw = 1;

	}
	if (document.getElementById("fecha").value.replace(/^\s*|\s*$/g, "") == "") {
		sw = 1;

	}
	if (document.getElementById("horas_certificadas").value.replace(
			/^\s*|\s*$/g, "") == "") {
		sw = 1;

	}

	if (document.getElementById("numero_asistentes").value.replace(
			/^\s*|\s*$/g, "") == "") {
		sw = 1;

	}

	if (sw == 1) {

		mensaje = "* EXISTEN CAMPOS VACIOS. DILIGENCIELOS\n";
	}

	// valida numeros
	snumeros = 0;
	try {

		if (document.getElementById("horas_certificadas").value.replace(
				/^\s*|\s*$/g, "") != "") {
			var h1 = parseInt(document.getElementById("horas_certificadas").value
					.replace(/^\s*|\s*$/g, ""));
			if (!es_numeroCERTIFICADO((document
					.getElementById("numero_asistentes").value.replace(
					/^\s*|\s*$/g, "")))) {
				snumeros = 1;
				mensaje += "* NUMERO DE HORAS DEBE SER NUMERICO SIN PUNTOS NI COMAS.\n";
			} else {

				if (h1 <= 0) {
					mensaje += "* NUMERO DE HORAS DEBE SER MAYOR A CERO.\n";
				}

			}
		}

		if (document.getElementById("numero_asistentes").value.replace(
				/^\s*|\s*$/g, "") != "") {
			var h1 = parseInt(document.getElementById("numero_asistentes").value
					.replace(/^\s*|\s*$/g, ""));
			if (!es_numeroCERTIFICADO((document
					.getElementById("numero_asistentes").value.replace(
					/^\s*|\s*$/g, "")))) {
				snumeros = 1;
				mensaje += "* NUMERO DE ASISTENTES DEBE SER NUMERICO SIN PUNTOS NI COMAS.\n";
			} else {

				if (h1 <= 0) {
					mensaje += "* NUMERO DE ASISTENTES DEBE SER MAYOR A CERO.\n";
				}

			}
		}

	} catch (e) {
		snumeros = 1;
		mensaje += "* EXISTEN CAMPOS QUE DEBEN SER NUMERICOS SIN PUNTOS NI COMAS\n";
	}

	if (mensaje != "") {

		alert(mensaje);
	} else {

		window.open("imprimirAsistencia2.jsp?curso="
				+ document.getElementById("curso").value + "&fecha="
				+ document.getElementById("fecha").value + "&tema="
				+ document.getElementById("temas").value + "&horas="
				+ document.getElementById("horas_certificadas").value
				+ "&numero_asistentes="
				+ document.getElementById("numero_asistentes").value
				+ "&linea=" + document.getElementById("lineas").value
				+ "&financiador="
				+ document.getElementById("financiadores").value, '_blank');

		// cargarMujeresAsistencia2();
	}

}


function validarPlanilla3() {

	mensaje = "";
	sw = 0;
	if (document.getElementById("temas").value.replace(/^\s*|\s*$/g, "") == "") {
		sw += 1;

	}

	if (document.getElementById("tipo").value.replace(/^\s*|\s*$/g, "") == "0") {
		sw += 1;

	}

	if (document.getElementById("proyecto2").value.replace(/^\s*|\s*$/g, "") == "") {
		sw += 1;

	}

	if (document.getElementById("asistio_mujer").value
			.replace(/^\s*|\s*$/g, "") == "0") {
		sw += 1;

	}

	if (document.getElementById("curso").value.replace(/^\s*|\s*$/g, "") == "") {
		sw += 1;

	}
	if (document.getElementById("fecha_desde").value.replace(/^\s*|\s*$/g, "") == "") {
		sw += 1;

	}

	if (document.getElementById("fecha_hasta").value.replace(/^\s*|\s*$/g, "") == "") {
		sw += 1;

	}

	// if (document.getElementById("proyecto").value.replace(/^\s*|\s*$/g, "")
	// == "") {
	// sw += 1;

	// }

	if (document.getElementById("linea").value.replace(/^\s*|\s*$/g, "") == "") {
		sw += 1;

	}

	if (document.getElementById("financiador").value.replace(/^\s*|\s*$/g, "") == "") {
		sw += 1;

	}

	if (document.getElementById("documento").value.replace(/^\s*|\s*$/g, "") == "") {
		sw += 1;

	}
	
	
	
	

	if (sw == 10) {

		mensaje = "* POR LO MENOS UN CAMPO DEBE ESTAR DILIGENCIADO\n";
	}

	if (mensaje != "") {

		alert(mensaje);
	} else {

		cargarMujeresAsistencia3();
	}

}

function validarPlanilla4() {

	mensaje = "";
	sw = 0;
	if (document.getElementById("temas").value.replace(/^\s*|\s*$/g, "") == "") {
		sw += 1;

	}

	if (document.getElementById("tipo").value.replace(/^\s*|\s*$/g, "") == "0") {
		sw += 1;

	}

	if (document.getElementById("proyecto2").value.replace(/^\s*|\s*$/g, "") == "") {
		sw += 1;

	}

	if (document.getElementById("asistio_mujer").value
			.replace(/^\s*|\s*$/g, "") == "0") {
		sw += 1;

	}

	if (document.getElementById("curso").value.replace(/^\s*|\s*$/g, "") == "") {
		sw += 1;

	}
	if (document.getElementById("fecha_desde").value.replace(/^\s*|\s*$/g, "") == "") {
		sw += 1;

	}

	if (document.getElementById("fecha_hasta").value.replace(/^\s*|\s*$/g, "") == "") {
		sw += 1;

	}

	// if (document.getElementById("proyecto").value.replace(/^\s*|\s*$/g, "")
	// == "") {
	// sw += 1;

	// }

	if (document.getElementById("linea").value.replace(/^\s*|\s*$/g, "") == "") {
		sw += 1;

	}

	if (document.getElementById("financiador").value.replace(/^\s*|\s*$/g, "") == "") {
		sw += 1;

	}

	if (document.getElementById("documento").value.replace(/^\s*|\s*$/g, "") == "") {
		sw += 1;

	}
	
	
	if (document.getElementById("encuesta").value.replace(/^\s*|\s*$/g, "") == "") {
		sw += 1;
		mensaje = "* POR LO MENOS SE DEBE SELECCIONAR LA ENCUESTA BASE PARA DETERMINAR EL APORTE\n";

	}
	
	
	

	if (sw == 10) {

		//mensaje = "* POR LO MENOS UN CAMPO DEBE ESTAR DILIGENCIADO\n";
	}

	if (mensaje != "") {

		alert(mensaje);
	} else {

		cargarMujeresAsistenciaResultado();
	}

}

function validarPlanilla() {

	mensaje = "";
	sw = 0;
	if (document.getElementById("temas").value.replace(/^\s*|\s*$/g, "") == "") {
		sw = 1;

	}

	if (document.getElementById("financiadores").value
			.replace(/^\s*|\s*$/g, "") == "") {
		sw = 1;

	}

	if (document.getElementById("lineas").value.replace(/^\s*|\s*$/g, "") == "") {
		sw = 1;

	}

	if (document.getElementById("curso").value.replace(/^\s*|\s*$/g, "") == "") {
		sw = 1;

	}
	if (document.getElementById("fecha").value.replace(/^\s*|\s*$/g, "") == "") {
		sw = 1;

	}
	if (document.getElementById("horas_certificadas").value.replace(
			/^\s*|\s*$/g, "") == "") {
		sw = 1;

	}

	if (sw == 1) {

		mensaje = "* EXISTEN CAMPOS VACIOS. DILIGENCIELOS\n";
	}

	// valida numeros
	snumeros = 0;
	try {

		if (document.getElementById("horas_certificadas").value.replace(
				/^\s*|\s*$/g, "") != "") {
			var h1 = parseInt(document.getElementById("horas_certificadas").value
					.replace(/^\s*|\s*$/g, ""));
			if (isNaN(h1)) {
				snumeros = 1;
				mensaje += "* NUMERO DE HORAS DEBE SER NUMERICO SIN PUNTOS NI COMAS\n";
			} else {

				if (h1 <= 0) {
					mensaje += "* NUMERO DE HORAS DEBE SER MAYOR A CERO\n";
				}

			}
		}

	} catch (e) {
		snumeros = 1;
		mensaje += "* EXISTEN CAMPOS QUE DEBEN SER NUMERICOS SIN PUNTOS NI COMAS\n";
	}

	if (mensaje != "") {

		alert(mensaje);
	} else {

		cargarMujeresAsistencia();
	}

}

function regresarAsistencia3() {

	document.getElementById('detalleLote').innerHTML = "<font color='black'><input	type='button' value=' Consultar ' onclick='validarPlanilla3();' /></font>";

	// document.getElementById("curso").disabled = false;
	// document.getElementById("temas").disabled = false;
	// document.getElementById("fecha_desde").disabled = false;
	// document.getElementById("fecha_hasta").disabled = false;
	// document.getElementById("cal").disabled = false;
	// document.getElementById("cal2").disabled = false;
	// document.getElementById("tipo").disabled = false;

}

function regresarAsistencia2() {

	document.getElementById('detalleLote').innerHTML = "<font color='black'><input	type='button' value=' Generar planilla ' onclick='validarPlanilla2();' /></font>";

	document.getElementById("curso").disabled = false;
	document.getElementById("temas").disabled = false;
	document.getElementById("fecha").disabled = false;
	document.getElementById("horas_certificadas").disabled = false;
	document.getElementById("cal").disabled = false;
	document.getElementById("numero_asistentes").disabled = false;

}

function regresarAsistencia() {

	document.getElementById('detalleLote').innerHTML = "<font color='black'><input	type='button' value=' Generar planilla ' onclick='validarPlanilla();' /></font>";

	document.getElementById("curso").disabled = false;
	document.getElementById("temas").disabled = false;
	document.getElementById("financiadores").disabled = false;
	document.getElementById("lineas").disabled = false;
	document.getElementById("fecha").disabled = false;
	document.getElementById("horas_certificadas").disabled = false;
	document.getElementById("cal").disabled = false;

}

function cargarMujeresAsistencia2() {
	ajax = nuevoAjax();

	url = "/f-web/resultadosMujeresAsistencia2.jsp";
	parametros = "numero_asistentes="
			+ document.getElementById("numero_asistentes").value + "&curso="
			+ document.getElementById("curso").value + "&tema="
			+ document.getElementById("temas").value + "&fecha="
			+ document.getElementById("fecha").value + "&horas="
			+ document.getElementById("horas_certificadas").value;

	ajax.onreadystatechange = function() {
		if (ajax.readyState == 1) {
			document.getElementById('detalleLote').innerHTML = "<img src='images/ajax/ajax-loader3.gif'>";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('detalleLote').innerHTML = "";
				document.getElementById('detalleLote').style.background = "";
				document.getElementById('detalleLote').innerHTML = ajax.responseText;

				document.getElementById("curso").disabled = true;
				document.getElementById("temas").disabled = true;
				document.getElementById("fecha").disabled = true;
				document.getElementById("cal").disabled = true;
				document.getElementById("horas_certificadas").disabled = true;
				document.getElementById("numero_asistentes").disabled = true;

			} else if (ajax.status == 404) {
				document.getElementById('detalleLote').innerHTML = ajax.responseText;
			} else {
				document.getElementById('detalleLote').innerHTML = ajax.responseText;
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type',
			'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(parametros);
}



function cargarMujeresAsistenciaResultado() {
	ajax = nuevoAjax();

	url = "/f-web/resultadosMujeresAsistenciaResultado.jsp";
	parametros = "curso=" + document.getElementById("curso").value + "&tema="
			+ document.getElementById("temas").value + "&fecha_desde="
			+ document.getElementById("fecha_desde").value + "&fecha_hasta="
			+ document.getElementById("fecha_hasta").value + "&tipo="
			+ document.getElementById("tipo").value + "&asistio_mujer="
			+ document.getElementById("asistio_mujer").value + "&proyecto="
			+ document.getElementById("proyecto2").value + "&linea="
			+ document.getElementById("linea").value + "&financiador="
			+ document.getElementById("financiador").value + "&documento="
			+ document.getElementById("documento").value+ "&encuesta="
			+ document.getElementById("encuesta").value;

	ajax.onreadystatechange = function() {
		if (ajax.readyState == 1) {
			document.getElementById('detalleLote').innerHTML = "<img src='images/ajax/ajax-loader3.gif'>";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('detalleLote').innerHTML = "";
				document.getElementById('detalleLote').style.background = "";
				document.getElementById('detalleLote').innerHTML = ajax.responseText;

				if (document.getElementById("exitoso").value == "0") {

					// document.getElementById("curso").disabled = true;
					// document.getElementById("temas").disabled = true;
					// document.getElementById("fecha_desde").disabled = true;
					// document.getElementById("fecha_hasta").disabled = true;
					// document.getElementById("cal").disabled = true;
					// document.getElementById("cal2").disabled = true;
					// document.getElementById("tipo").disabled = true;

					document.getElementById('detalleLote').innerHTML = "<font color='black'><input	type='button' value=' Consultar ' onclick='validarPlanilla4();' /></font>";
					alert('NO EXISTEN DATOS CON LOS CRITERIOS DILIGENCIADOS.');

				} else {

					// document.getElementById("curso").disabled = false;
					// document.getElementById("temas").disabled = false;
					// document.getElementById("fecha_desde").disabled = false;
					// document.getElementById("fecha_hasta").disabled = false;
					// document.getElementById("cal").disabled = false;
					// document.getElementById("cal2").disabled = false;
					// document.getElementById("tipo").disabled = false;

				}

			} else if (ajax.status == 404) {
				document.getElementById('detalleLote').innerHTML = ajax.responseText;
			} else {
				document.getElementById('detalleLote').innerHTML = ajax.responseText;
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type',
			'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(parametros);
}


function cargarMujeresAsistencia3() {
	ajax = nuevoAjax();

	url = "/f-web/resultadosMujeresAsistencia3.jsp";
	parametros = "curso=" + document.getElementById("curso").value + "&tema="
			+ document.getElementById("temas").value + "&fecha_desde="
			+ document.getElementById("fecha_desde").value + "&fecha_hasta="
			+ document.getElementById("fecha_hasta").value + "&tipo="
			+ document.getElementById("tipo").value + "&asistio_mujer="
			+ document.getElementById("asistio_mujer").value + "&proyecto="
			+ document.getElementById("proyecto2").value + "&linea="
			+ document.getElementById("linea").value + "&financiador="
			+ document.getElementById("financiador").value + "&documento="
			+ document.getElementById("documento").value;

	ajax.onreadystatechange = function() {
		if (ajax.readyState == 1) {
			document.getElementById('detalleLote').innerHTML = "<img src='images/ajax/ajax-loader3.gif'>";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('detalleLote').innerHTML = "";
				document.getElementById('detalleLote').style.background = "";
				document.getElementById('detalleLote').innerHTML = ajax.responseText;

				if (document.getElementById("exitoso").value == "0") {

					// document.getElementById("curso").disabled = true;
					// document.getElementById("temas").disabled = true;
					// document.getElementById("fecha_desde").disabled = true;
					// document.getElementById("fecha_hasta").disabled = true;
					// document.getElementById("cal").disabled = true;
					// document.getElementById("cal2").disabled = true;
					// document.getElementById("tipo").disabled = true;

					document.getElementById('detalleLote').innerHTML = "<font color='black'><input	type='button' value=' Consultar ' onclick='validarPlanilla3();' /></font>";
					alert('NO EXISTEN DATOS CON LOS CRITERIOS DILIGENCIADOS.');

				} else {

					// document.getElementById("curso").disabled = false;
					// document.getElementById("temas").disabled = false;
					// document.getElementById("fecha_desde").disabled = false;
					// document.getElementById("fecha_hasta").disabled = false;
					// document.getElementById("cal").disabled = false;
					// document.getElementById("cal2").disabled = false;
					// document.getElementById("tipo").disabled = false;

				}

			} else if (ajax.status == 404) {
				document.getElementById('detalleLote').innerHTML = ajax.responseText;
			} else {
				document.getElementById('detalleLote').innerHTML = ajax.responseText;
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type',
			'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(parametros);
}

function cargarMujeresAsistencia() {
	ajax = nuevoAjax();

	url = "/f-web/resultadosMujeresAsistencia.jsp";
	parametros = "curso=" + document.getElementById("curso").value + "&tema="
			+ document.getElementById("temas").value + "&fecha="
			+ document.getElementById("fecha").value + "&horas="
			+ document.getElementById("horas_certificadas").value + "&linea="
			+ document.getElementById("lineas").value + "&financiador="
			+ document.getElementById("financiadores").value;

	ajax.onreadystatechange = function() {
		if (ajax.readyState == 1) {
			document.getElementById('detalleLote').innerHTML = "<img src='images/ajax/ajax-loader3.gif'>";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('detalleLote').innerHTML = "";
				document.getElementById('detalleLote').style.background = "";
				document.getElementById('detalleLote').innerHTML = ajax.responseText;

				if (document.getElementById("exitoso").value == "0") {

					document.getElementById("curso").disabled = false;
					document.getElementById("temas").disabled = false;
					document.getElementById("financiadores").disabled = false;
					document.getElementById("lineas").disabled = false;
					// document.getElementById("tipo_asistencia").disabled =
					// false;

					document.getElementById("fecha").disabled = false;
					document.getElementById("cal").disabled = false;
					document.getElementById("horas_certificadas").disabled = false;

					document.getElementById('detalleLote').innerHTML = "<font color='black'><input	type='button' value=' Generar planilla ' onclick='validarPlanilla();' /></font>";
					alert('NO EXISTEN MUJER PENDIENTES POR REGISTRAR PLANILLA DE ASISTENCIA PARA LA FECHA, CURSO Y TEMA SELECCIONADOS.');

				} else {

					document.getElementById("curso").disabled = true;
					document.getElementById("temas").disabled = true;
					document.getElementById("financiadores").disabled = true;
					document.getElementById("lineas").disabled = true;
					// document.getElementById("tipo_asistencia").disabled =
					// true;

					document.getElementById("fecha").disabled = true;
					document.getElementById("cal").disabled = true;
					document.getElementById("horas_certificadas").disabled = true;

				}

			} else if (ajax.status == 404) {
				document.getElementById('detalleLote').innerHTML = ajax.responseText;
			} else {
				document.getElementById('detalleLote').innerHTML = ajax.responseText;
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type',
			'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(parametros);
}

function cargarMujeresCurso(curso) {
	ajax = nuevoAjax();

	url = "/f-web/resultadosMujeresCurso.jsp";
	parametros = "id=" + curso;
	ajax.onreadystatechange = function() {
		if (ajax.readyState == 1) {
			document.getElementById('detalleAdministradores').innerHTML = "<img src='images/ajax/ajax-loader3.gif'>";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('detalleAdministradores').innerHTML = "";
				document.getElementById('detalleAdministradores').style.background = "";
				document.getElementById('detalleAdministradores').innerHTML = ajax.responseText;

			} else if (ajax.status == 404) {
				document.getElementById('detalleAdministradores').innerHTML = "-Inexistencia, contacte administrador-";
			} else {
				document.getElementById('detalleAdministradores').innerHTML = ajax.responseText;
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type',
			'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(parametros);
}

function cargarBarriosVeredas2() {
	ajax = nuevoAjax();

	url = "/f-web/resultadosBarriosVeredas.jsp";
	parametros = "tipo=" + document.getElementById("control14").value + "&id="
			+ document.getElementById("control15").value;

	ajax.onreadystatechange = function() {
		if (ajax.readyState == 1) {
			document.getElementById('span_4').innerHTML = "Cargando...";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('span_4').innerHTML = "";
				document.getElementById('span_4').style.background = "";
				document.getElementById('span_4').innerHTML = ajax.responseText;

				document.getElementById("control16").value = document
						.getElementById("hdnBarrioVereda").value;

			} else if (ajax.status == 404) {
				document.getElementById('span_4').innerHTML = "-Inexistencia, contacte administrador-";
			} else {
				document.getElementById('span_4').innerHTML = ajax.responseText;
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type',
			'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(parametros);

}

function cargarBarriosVeredas() {
	ajax = nuevoAjax();

	url = "/f-web/resultadosBarriosVeredas.jsp";
	parametros = "tipo=" + document.getElementById("control14").value + "&id="
			+ document.getElementById("control15").value;

	ajax.onreadystatechange = function() {
		if (ajax.readyState == 1) {
			document.getElementById('span_4').innerHTML = "Cargando...";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('span_4').innerHTML = "";
				document.getElementById('span_4').style.background = "";
				document.getElementById('span_4').innerHTML = ajax.responseText;

			} else if (ajax.status == 404) {
				document.getElementById('span_4').innerHTML = "-Inexistencia, contacte administrador-";
			} else {
				document.getElementById('span_4').innerHTML = ajax.responseText;
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type',
			'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(parametros);

}

function cargarTiposDirecciones2() {
	ajax = nuevoAjax();

	url = "/f-web/resultadosTiposDirecciones.jsp";
	parametros = "tipo=" + document.getElementById("control14").value;

	if (document.getElementById("control14").value != "") {

		if (document.getElementById("control14").value == "C") {

			document.getElementById('span_1').innerHTML = "<font color=\"black\">Comuna *: </font>";
			document.getElementById('span_3').innerHTML = "<font color=\"black\">Barrio *: </font>";

		} else {

			document.getElementById('span_1').innerHTML = "<font color=\"black\">Corregimiento *: </font>";
			document.getElementById('span_3').innerHTML = "<font color=\"black\">Vereda/Asentamiento *: </font>";
		}

		document.getElementById('span_2').innerHTML = "Cargando...";

		document.getElementById('span_4').innerHTML = "<select id='control16' style=\"width:250px\"><option>Seleccione...</option></select>";

		ajax.onreadystatechange = function() {
			if (ajax.readyState == 1) {
				document.getElementById('span_2').innerHTML = "Cargando...";
			} else if (ajax.readyState == 4) {
				if (ajax.status == 200) {
					document.getElementById('span_2').innerHTML = "";
					document.getElementById('span_2').style.background = "";
					document.getElementById('span_2').innerHTML = ajax.responseText;

					if (document.getElementById("hdnTipoDir").value != "") {
						document.getElementById("control15").value = document
								.getElementById("hdnTipoDir").value;
					}

					if (document.getElementById("hdnBarrioVereda").value != "") {
						cargarBarriosVeredas2();
					}

				} else if (ajax.status == 404) {
					document.getElementById('span_2').innerHTML = "-Inexistencia, contacte administrador-";
				} else {
					document.getElementById('span_2').innerHTML = ajax.responseText;
				}
			}
		}

		ajax.open("POST", url, true);
		ajax.setRequestHeader('Content-Type',
				'application/x-www-form-urlencoded; charset=utf-8');
		ajax.send(parametros);

	} else {

		document.getElementById('span_1').innerHTML = "";
		document.getElementById('span_2').innerHTML = "";
		document.getElementById('span_3').innerHTML = "";
		document.getElementById('span_4').innerHTML = "";

	}
}

function cargarTiposDirecciones() {
	ajax = nuevoAjax();

	url = "/f-web/resultadosTiposDirecciones.jsp";
	parametros = "tipo=" + document.getElementById("control14").value;

	if (document.getElementById("control14").value != "") {

		if (document.getElementById("control14").value == "C") {

			document.getElementById('span_1').innerHTML = "<font color=\"black\">Comuna *: </font>";
			document.getElementById('span_3').innerHTML = "<font color=\"black\">Barrio *: </font>";

		} else {

			document.getElementById('span_1').innerHTML = "<font color=\"black\">Corregimiento *: </font>";
			document.getElementById('span_3').innerHTML = "<font color=\"black\">Vereda/Asentamiento *: </font>";
		}

		document.getElementById('span_2').innerHTML = "Cargando...";

		document.getElementById('span_4').innerHTML = "<select id='control16' style=\"width:250px\"><option>Seleccione...</option></select>";

		ajax.onreadystatechange = function() {
			if (ajax.readyState == 1) {
				document.getElementById('span_2').innerHTML = "Cargando...";
			} else if (ajax.readyState == 4) {
				if (ajax.status == 200) {
					document.getElementById('span_2').innerHTML = "";
					document.getElementById('span_2').style.background = "";
					document.getElementById('span_2').innerHTML = ajax.responseText;

				} else if (ajax.status == 404) {
					document.getElementById('span_2').innerHTML = "-Inexistencia, contacte administrador-";
				} else {
					document.getElementById('span_2').innerHTML = ajax.responseText;
				}
			}
		}

		ajax.open("POST", url, true);
		ajax.setRequestHeader('Content-Type',
				'application/x-www-form-urlencoded; charset=utf-8');
		ajax.send(parametros);

	} else {

		document.getElementById('span_1').innerHTML = "";
		document.getElementById('span_2').innerHTML = "";
		document.getElementById('span_3').innerHTML = "";
		document.getElementById('span_4').innerHTML = "";

	}
}

function cargarLineasCombo() {
	ajax = nuevoAjax();

	url = "/f-web/resultadosLineas2.jsp";
	parametros = "id=" + document.getElementById("curso").value;

	ajax.onreadystatechange = function() {
		if (ajax.readyState == 1) {
			document.getElementById('span_lineas').innerHTML = "Cargando...";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('span_lineas').innerHTML = "";
				document.getElementById('span_lineas').style.background = "";
				document.getElementById('span_lineas').innerHTML = ajax.responseText;

			} else if (ajax.status == 404) {
				document.getElementById('span_lineas').innerHTML = "-Inexistencia, contacte administrador-";
			} else {
				document.getElementById('span_lineas').innerHTML = ajax.responseText;
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type',
			'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(parametros);
}

function cargarFinanciadoresCombo() {
	ajax = nuevoAjax();

	url = "/f-web/resultadosFinanciadores2.jsp";
	parametros = "id=" + document.getElementById("curso").value;

	ajax.onreadystatechange = function() {
		if (ajax.readyState == 1) {
			document.getElementById('span_financiadores').innerHTML = "Cargando...";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('span_financiadores').innerHTML = "";
				document.getElementById('span_financiadores').style.background = "";
				document.getElementById('span_financiadores').innerHTML = ajax.responseText;

				cargarLineasCombo();

			} else if (ajax.status == 404) {
				document.getElementById('span_financiadores').innerHTML = "-Inexistencia, contacte administrador-";
			} else {
				document.getElementById('span_financiadores').innerHTML = ajax.responseText;
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type',
			'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(parametros);
}

function cargarTemasCombo() {
	ajax = nuevoAjax();

	url = "/f-web/resultadosTemas2.jsp";
	parametros = "id=" + document.getElementById("curso").value;

	if (document.getElementById("curso").value == "") {
		document.getElementById("proyecto").value = "";
	} else {
		document.getElementById("proyecto").value = document
				.getElementById("curso"
						+ document.getElementById("curso").value).value;
	}

	ajax.onreadystatechange = function() {
		if (ajax.readyState == 1) {
			document.getElementById('span_tema').innerHTML = "Cargando...";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('span_tema').innerHTML = "";
				document.getElementById('span_tema').style.background = "";
				document.getElementById('span_tema').innerHTML = ajax.responseText;

				cargarFinanciadoresCombo();

			} else if (ajax.status == 404) {
				document.getElementById('span_tema').innerHTML = "-Inexistencia, contacte administrador-";
			} else {
				document.getElementById('span_tema').innerHTML = ajax.responseText;
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type',
			'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(parametros);
}

function cargarPreguntas(curso) {
	ajax = nuevoAjax();

	url = "/f-web/resultadosPreguntas.jsp";
	parametros = "id=" + curso + "&encuesta="
			+ document.getElementById('encuesta').value;
	ajax.onreadystatechange = function() {
		if (ajax.readyState == 1) {
			document.getElementById('detalleAdministradores').innerHTML = "<img src='images/ajax/ajax-loader3.gif'>";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('detalleAdministradores').innerHTML = "";
				document.getElementById('detalleAdministradores').style.background = "";
				document.getElementById('detalleAdministradores').innerHTML = ajax.responseText;

			} else if (ajax.status == 404) {
				document.getElementById('detalleAdministradores').innerHTML = "-Inexistencia, contacte administrador-";
			} else {
				document.getElementById('detalleAdministradores').innerHTML = ajax.responseText;
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type',
			'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(parametros);
}

function cargarOpciones(curso) {
	ajax = nuevoAjax();

	url = "/f-web/resultadosOpciones.jsp";
	parametros = "id=" + curso;
	ajax.onreadystatechange = function() {
		if (ajax.readyState == 1) {
			document.getElementById('detalleAdministradores').innerHTML = "<img src='images/ajax/ajax-loader3.gif'>";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('detalleAdministradores').innerHTML = "";
				document.getElementById('detalleAdministradores').style.background = "";
				document.getElementById('detalleAdministradores').innerHTML = ajax.responseText;

			} else if (ajax.status == 404) {
				document.getElementById('detalleAdministradores').innerHTML = "-Inexistencia, contacte administrador-";
			} else {
				document.getElementById('detalleAdministradores').innerHTML = ajax.responseText;
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type',
			'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(parametros);
}

function cargarFinanciadoresC(curso) {
	ajax = nuevoAjax();

	url = "/f-web/resultadosFinanciadorC.jsp";
	parametros = "id=" + curso;
	ajax.onreadystatechange = function() {
		if (ajax.readyState == 1) {
			document.getElementById('detalleAdministradores').innerHTML = "<img src='images/ajax/ajax-loader3.gif'>";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('detalleAdministradores').innerHTML = "";
				document.getElementById('detalleAdministradores').style.background = "";
				document.getElementById('detalleAdministradores').innerHTML = ajax.responseText;

			} else if (ajax.status == 404) {
				document.getElementById('detalleAdministradores').innerHTML = "-Inexistencia, contacte administrador-";
			} else {
				document.getElementById('detalleAdministradores').innerHTML = ajax.responseText;
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type',
			'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(parametros);
}

function cargarLineasC(curso) {
	ajax = nuevoAjax();

	url = "/f-web/resultadosLineasC.jsp";
	parametros = "id=" + curso;
	ajax.onreadystatechange = function() {
		if (ajax.readyState == 1) {
			document.getElementById('detalleAdministradores').innerHTML = "<img src='images/ajax/ajax-loader3.gif'>";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('detalleAdministradores').innerHTML = "";
				document.getElementById('detalleAdministradores').style.background = "";
				document.getElementById('detalleAdministradores').innerHTML = ajax.responseText;

			} else if (ajax.status == 404) {
				document.getElementById('detalleAdministradores').innerHTML = "-Inexistencia, contacte administrador-";
			} else {
				document.getElementById('detalleAdministradores').innerHTML = ajax.responseText;
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type',
			'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(parametros);
}

function cargarActividades(curso) {
	ajax = nuevoAjax();

	url = "/f-web/resultadosActividades.jsp";
	parametros = "id=" + curso;
	ajax.onreadystatechange = function() {
		if (ajax.readyState == 1) {
			document.getElementById('detalleAdministradores').innerHTML = "<img src='images/ajax/ajax-loader3.gif'>";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('detalleAdministradores').innerHTML = "";
				document.getElementById('detalleAdministradores').style.background = "";
				document.getElementById('detalleAdministradores').innerHTML = ajax.responseText;

			} else if (ajax.status == 404) {
				document.getElementById('detalleAdministradores').innerHTML = "-Inexistencia, contacte administrador-";
			} else {
				document.getElementById('detalleAdministradores').innerHTML = ajax.responseText;
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type',
			'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(parametros);
}

function cargarParticipaciones(curso) {
	ajax = nuevoAjax();

	url = "/f-web/resultadosParticipaciones.jsp";
	parametros = "id=" + curso;
	ajax.onreadystatechange = function() {
		if (ajax.readyState == 1) {
			document.getElementById('detalleAdministradores').innerHTML = "<img src='images/ajax/ajax-loader3.gif'>";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('detalleAdministradores').innerHTML = "";
				document.getElementById('detalleAdministradores').style.background = "";
				document.getElementById('detalleAdministradores').innerHTML = ajax.responseText;

			} else if (ajax.status == 404) {
				document.getElementById('detalleAdministradores').innerHTML = "-Inexistencia, contacte administrador-";
			} else {
				document.getElementById('detalleAdministradores').innerHTML = ajax.responseText;
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type',
			'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(parametros);
}

function cargarCapacitaciones(curso) {
	ajax = nuevoAjax();

	url = "/f-web/resultadosCapacitaciones.jsp";
	parametros = "id=" + curso;
	ajax.onreadystatechange = function() {
		if (ajax.readyState == 1) {
			document.getElementById('detalleAdministradores').innerHTML = "<img src='images/ajax/ajax-loader3.gif'>";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('detalleAdministradores').innerHTML = "";
				document.getElementById('detalleAdministradores').style.background = "";
				document.getElementById('detalleAdministradores').innerHTML = ajax.responseText;

			} else if (ajax.status == 404) {
				document.getElementById('detalleAdministradores').innerHTML = "-Inexistencia, contacte administrador-";
			} else {
				document.getElementById('detalleAdministradores').innerHTML = ajax.responseText;
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type',
			'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(parametros);
}

function cargarNiveles(curso) {
	ajax = nuevoAjax();

	url = "/f-web/resultadosNiveles.jsp";
	parametros = "id=" + curso;
	ajax.onreadystatechange = function() {
		if (ajax.readyState == 1) {
			document.getElementById('detalleAdministradores').innerHTML = "<img src='images/ajax/ajax-loader3.gif'>";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('detalleAdministradores').innerHTML = "";
				document.getElementById('detalleAdministradores').style.background = "";
				document.getElementById('detalleAdministradores').innerHTML = ajax.responseText;

			} else if (ajax.status == 404) {
				document.getElementById('detalleAdministradores').innerHTML = "-Inexistencia, contacte administrador-";
			} else {
				document.getElementById('detalleAdministradores').innerHTML = ajax.responseText;
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type',
			'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(parametros);
}

function cargarTemas(curso) {
	ajax = nuevoAjax();

	url = "/f-web/resultadosTemas.jsp";
	parametros = "id=" + curso;
	ajax.onreadystatechange = function() {
		if (ajax.readyState == 1) {
			document.getElementById('detalleAdministradores').innerHTML = "<img src='images/ajax/ajax-loader3.gif'>";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('detalleAdministradores').innerHTML = "";
				document.getElementById('detalleAdministradores').style.background = "";
				document.getElementById('detalleAdministradores').innerHTML = ajax.responseText;

			} else if (ajax.status == 404) {
				document.getElementById('detalleAdministradores').innerHTML = "-Inexistencia, contacte administrador-";
			} else {
				document.getElementById('detalleAdministradores').innerHTML = ajax.responseText;
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type',
			'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(parametros);
}


function cargarOpcionesMujer2() {

	if (document.getElementById('documento_mujer').value.replace(/^\s*|\s*$/g,
			"") != "") {

		ajax = nuevoAjax();
		url = "/f-web/resultadosElegirEncuestaUsuario.jsp";
		parametros = "documento_mujer="
				+ document.getElementById('documento_mujer').value;
		ajax.onreadystatechange = function() {
			if (ajax.readyState == 1) {
				document.getElementById('detalleAdministradores').innerHTML = "<img src='images/ajax/ajax-loader3.gif'>";
			} else if (ajax.readyState == 4) {
				if (ajax.status == 200) {
					document.getElementById('detalleAdministradores').innerHTML = "";
					document.getElementById('detalleAdministradores').style.background = "";
					document.getElementById('detalleAdministradores').innerHTML = ajax.responseText;

					document.getElementById('id_mujer_encuesta').value = document
							.getElementById('mujer_recuperada').value;

				} else if (ajax.status == 404) {
					document.getElementById('detalleAdministradores').innerHTML = "-Inexistencia, contacte administrador-";
				} else {
					document.getElementById('detalleAdministradores').innerHTML = ajax.responseText;
				}
			}
		}

		ajax.open("POST", url, true);
		ajax.setRequestHeader('Content-Type',
				'application/x-www-form-urlencoded; charset=utf-8');
		ajax.send(parametros);

	} else {

		alert('ESCRIBA UN DOCUMENTO');

	}
}

function cargarOpcionesMujer() {

	if (document.getElementById('documento_mujer').value.replace(/^\s*|\s*$/g,
			"") != "") {

		ajax = nuevoAjax();
		url = "/f-web/resultadosElegirResultado.jsp";
		parametros = "documento_mujer="
				+ document.getElementById('documento_mujer').value;
		ajax.onreadystatechange = function() {
			if (ajax.readyState == 1) {
				document.getElementById('detalleAdministradores').innerHTML = "<img src='images/ajax/ajax-loader3.gif'>";
			} else if (ajax.readyState == 4) {
				if (ajax.status == 200) {
					document.getElementById('detalleAdministradores').innerHTML = "";
					document.getElementById('detalleAdministradores').style.background = "";
					document.getElementById('detalleAdministradores').innerHTML = ajax.responseText;

					document.getElementById('id_mujer_encuesta').value = document
							.getElementById('mujer_recuperada').value;

				} else if (ajax.status == 404) {
					document.getElementById('detalleAdministradores').innerHTML = "-Inexistencia, contacte administrador-";
				} else {
					document.getElementById('detalleAdministradores').innerHTML = ajax.responseText;
				}
			}
		}

		ajax.open("POST", url, true);
		ajax.setRequestHeader('Content-Type',
				'application/x-www-form-urlencoded; charset=utf-8');
		ajax.send(parametros);

	} else {

		alert('ESCRIBA UN DOCUMENTO');

	}
}

function cargarEncuestasMujer() {

	if (document.getElementById('documento_mujer').value.replace(/^\s*|\s*$/g,
			"") != "") {

		ajax = nuevoAjax();
		url = "/f-web/resultadosEncuestasMujer.jsp";
		parametros = "documento_mujer="
				+ document.getElementById('documento_mujer').value;
		ajax.onreadystatechange = function() {
			if (ajax.readyState == 1) {
				document.getElementById('detalleAdministradores').innerHTML = "<img src='images/ajax/ajax-loader3.gif'>";
			} else if (ajax.readyState == 4) {
				if (ajax.status == 200) {
					document.getElementById('detalleAdministradores').innerHTML = "";
					document.getElementById('detalleAdministradores').style.background = "";
					document.getElementById('detalleAdministradores').innerHTML = ajax.responseText;

					document.getElementById('id_mujer_encuesta').value = document
							.getElementById('mujer_recuperada').value;

				} else if (ajax.status == 404) {
					document.getElementById('detalleAdministradores').innerHTML = "-Inexistencia, contacte administrador-";
				} else {
					document.getElementById('detalleAdministradores').innerHTML = ajax.responseText;
				}
			}
		}

		ajax.open("POST", url, true);
		ajax.setRequestHeader('Content-Type',
				'application/x-www-form-urlencoded; charset=utf-8');
		ajax.send(parametros);

	} else {

		alert('ESCRIBA UN DOCUMENTO');

	}
}

function cargarEncuestas() {
	ajax = nuevoAjax();
	url = "/f-web/resultadosEncuestas.jsp";
	ajax.onreadystatechange = function() {
		if (ajax.readyState == 1) {
			document.getElementById('detalleAdministradores').innerHTML = "<img src='images/ajax/ajax-loader3.gif'>";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('detalleAdministradores').innerHTML = "";
				document.getElementById('detalleAdministradores').style.background = "";
				document.getElementById('detalleAdministradores').innerHTML = ajax.responseText;

			} else if (ajax.status == 404) {
				document.getElementById('detalleAdministradores').innerHTML = "-Inexistencia, contacte administrador-";
			} else {
				document.getElementById('detalleAdministradores').innerHTML = ajax.responseText;
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type',
			'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(null);
}

function cargarCursos() {
	ajax = nuevoAjax();
	url = "/f-web/resultadosCursos.jsp";
	ajax.onreadystatechange = function() {
		if (ajax.readyState == 1) {
			document.getElementById('detalleAdministradores').innerHTML = "<img src='images/ajax/ajax-loader3.gif'>";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('detalleAdministradores').innerHTML = "";
				document.getElementById('detalleAdministradores').style.background = "";
				document.getElementById('detalleAdministradores').innerHTML = ajax.responseText;

			} else if (ajax.status == 404) {
				document.getElementById('detalleAdministradores').innerHTML = "-Inexistencia, contacte administrador-";
			} else {
				document.getElementById('detalleAdministradores').innerHTML = ajax.responseText;
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type',
			'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(null);
}

function cargarProyectosLineas() {
	ajax = nuevoAjax();
	url = "/f-web/resultadosProyectosLineas.jsp";
	ajax.onreadystatechange = function() {
		if (ajax.readyState == 1) {
			document.getElementById('detalleAdministradores').innerHTML = "<img src='images/ajax/ajax-loader3.gif'>";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('detalleAdministradores').innerHTML = "";
				document.getElementById('detalleAdministradores').style.background = "";
				document.getElementById('detalleAdministradores').innerHTML = ajax.responseText;

			} else if (ajax.status == 404) {
				document.getElementById('detalleAdministradores').innerHTML = "-Inexistencia, contacte administrador-";
			} else {
				document.getElementById('detalleAdministradores').innerHTML = ajax.responseText;
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type',
			'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(null);
}

function cargarLineas() {
	ajax = nuevoAjax();
	url = "/f-web/resultadosLineas.jsp";
	ajax.onreadystatechange = function() {
		if (ajax.readyState == 1) {
			document.getElementById('detalleAdministradores').innerHTML = "<img src='images/ajax/ajax-loader3.gif'>";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('detalleAdministradores').innerHTML = "";
				document.getElementById('detalleAdministradores').style.background = "";
				document.getElementById('detalleAdministradores').innerHTML = ajax.responseText;

			} else if (ajax.status == 404) {
				document.getElementById('detalleAdministradores').innerHTML = "-Inexistencia, contacte administrador-";
			} else {
				document.getElementById('detalleAdministradores').innerHTML = ajax.responseText;
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type',
			'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(null);
}

function cargarProyectos() {
	ajax = nuevoAjax();
	url = "/f-web/resultadosProyectos.jsp";
	ajax.onreadystatechange = function() {
		if (ajax.readyState == 1) {
			document.getElementById('detalleAdministradores').innerHTML = "<img src='images/ajax/ajax-loader3.gif'>";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('detalleAdministradores').innerHTML = "";
				document.getElementById('detalleAdministradores').style.background = "";
				document.getElementById('detalleAdministradores').innerHTML = ajax.responseText;

			} else if (ajax.status == 404) {
				document.getElementById('detalleAdministradores').innerHTML = "-Inexistencia, contacte administrador-";
			} else {
				document.getElementById('detalleAdministradores').innerHTML = ajax.responseText;
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type',
			'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(null);
}

function cargarFinanciadores() {
	ajax = nuevoAjax();
	url = "/f-web/resultadosFinanciadores.jsp";
	ajax.onreadystatechange = function() {
		if (ajax.readyState == 1) {
			document.getElementById('detalleAdministradores').innerHTML = "<img src='images/ajax/ajax-loader3.gif'>";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('detalleAdministradores').innerHTML = "";
				document.getElementById('detalleAdministradores').style.background = "";
				document.getElementById('detalleAdministradores').innerHTML = ajax.responseText;

			} else if (ajax.status == 404) {
				document.getElementById('detalleAdministradores').innerHTML = "-Inexistencia, contacte administrador-";
			} else {
				document.getElementById('detalleAdministradores').innerHTML = ajax.responseText;
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type',
			'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(null);
}

function cargarAdministradores() {
	ajax = nuevoAjax();
	url = "/f-web/resultadosAdministradores.jsp";
	ajax.onreadystatechange = function() {
		if (ajax.readyState == 1) {
			document.getElementById('detalleAdministradores').innerHTML = "<img src='images/ajax/ajax-loader3.gif'>";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('detalleAdministradores').innerHTML = "";
				document.getElementById('detalleAdministradores').style.background = "";
				document.getElementById('detalleAdministradores').innerHTML = ajax.responseText;

			} else if (ajax.status == 404) {
				document.getElementById('detalleAdministradores').innerHTML = "-Inexistencia, contacte administrador-";
			} else {
				document.getElementById('detalleAdministradores').innerHTML = "-Error, contacte administrador";
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type',
			'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(null);
}

function cargarPropias() {
	ajax = nuevoAjax();
	parametros = "us=" + document.getElementById('hdnUs').value + "&tu="
			+ document.getElementById('hdnTipoUs').value;
	url = "/f-web/notasRealizadasUsuario.jsp";
	ajax.onreadystatechange = function() {
		if (ajax.readyState == 1) {
			document.getElementById('detallePropias').innerHTML = "<img src='/f-web/images/ajax/ajax-loader3.gif'>";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('detallePropias').innerHTML = "";
				document.getElementById('detallePropias').style.background = "";
				document.getElementById('detallePropias').innerHTML = ajax.responseText;

			} else if (ajax.status == 404) {
				document.getElementById('detallePropias').innerHTML = "-Inexistencia, contacte administrador-";
			} else {
				document.getElementById('detallePropias').innerHTML = "-Error, contacte administrador";
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type',
			'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(parametros);
}

function cargarSeccion() {
	ajax = nuevoAjax();
	parametros = "id=" + document.getElementById('hdnSimulador').value;
	url = "/f-web/actualizacionSeccion.jsp";

	document.getElementById('btnAceptar').style.display = "none";
	document.getElementById('txtContenido').value = "";
	document.getElementById('txtContenido').style.display = "none";

	ajax.onreadystatechange = function() {
		if (ajax.readyState == 1) {
			document.getElementById('pub1').innerHTML = "<img src='/f-web/images/ajax/ajax-loader3.gif'>";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('pub1').innerHTML = "";
				document.getElementById('pub1').style.background = "";
				document.getElementById('pub1').innerHTML = ajax.responseText;

				document.getElementById('hdnSimulador').value = document
						.getElementById('sltDirigido').value;

				if (parseInt(document.getElementById('hdnSimulador').value) != 0) {
					document.getElementById('txtContenido').value = document
							.getElementById('txtContenidoOculto').value;

					document.getElementById('btnAceptar').style.display = "block";

					alert(document.getElementById('txtContenidoOculto').value);
				}

			} else if (ajax.status == 404) {
				document.getElementById('pub1').innerHTML = "-Inexistencia, contacte administrador-";
			} else {
				document.getElementById('pub1').innerHTML = "-Error, contacte administrador";
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type',
			'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(parametros);
}

function recargarSeccion() {

	document.getElementById('hdnSimulador').value = document
			.getElementById('sltDirigido').value;
	// cargarSeccion();
	document.form1.submit();

}

function eliminarPublicacion(idPublicacion) {
	if (confirm('REALMENTE DESEA ELIMINAR LA PUBLICACION?')) {
		eliminarPropia(idPublicacion);

	}

}

function eliminarPropia2(idPublicacion) {
	ajax = nuevoAjax();
	parametros = "pub=" + idPublicacion;
	url = "/f-web/noticias/eliminarPublicacion.jsp";
	ajax.onreadystatechange = function() {
		if (ajax.readyState == 1) {
			document.getElementById('detalleEliminar').innerHTML = "<img src='/f-web/images/ajax/ajax-loader3.gif'>";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('detalleEliminar').innerHTML = "";
				document.getElementById('detalleEliminar').style.background = "";
				document.getElementById('detalleEliminar').innerHTML = ajax.responseText;
				if (document.getElementById('hdnEliminoPublicacion').value == 1) {
					alert('PUBLICACION ELIMINADA CON EXITO');
					cargarPrivadas();
				} else {
					alert('No se ha podido eliminar la publicaci�n, intente mas tarde');
				}

			} else if (ajax.status == 404) {
				document.getElementById('detalleEliminar').innerHTML = "-Inexistencia, contacte administrador-";
			} else {
				document.getElementById('detalleEliminar').innerHTML = "-Error, contacte administrador";
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type',
			'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(parametros);
}

function eliminarPublicacion2(idPublicacion) {
	if (confirm('Realmente desea eliminar la publicaci�n?')) {
		eliminarPropia2(idPublicacion);

	}

}

function eliminarPropia(idPublicacion) {
	ajax = nuevoAjax();
	parametros = "pub=" + idPublicacion;
	url = "/f-web/eliminarPublicacion.jsp";
	ajax.onreadystatechange = function() {
		if (ajax.readyState == 1) {
			document.getElementById('detalleEliminar').innerHTML = "<img src='/f-web/images/ajax/ajax-loader3.gif'>";
		} else if (ajax.readyState == 4) {
			if (ajax.status == 200) {
				document.getElementById('detalleEliminar').innerHTML = "";
				document.getElementById('detalleEliminar').style.background = "";
				document.getElementById('detalleEliminar').innerHTML = ajax.responseText;
				if (document.getElementById('hdnEliminoPublicacion').value == 1) {
					alert('PUBLICACION ELIMINADA CON EXITO');
					cargarPropias();
				} else {
					alert('No se ha podido eliminar la publicaci�n, intente mas tarde');
				}

			} else if (ajax.status == 404) {
				document.getElementById('detalleEliminar').innerHTML = "-Inexistencia, contacte administrador-";
			} else {
				document.getElementById('detalleEliminar').innerHTML = "-Error, contacte administrador";
			}
		}
	}

	ajax.open("POST", url, true);
	ajax.setRequestHeader('Content-Type',
			'application/x-www-form-urlencoded; charset=utf-8');
	ajax.send(parametros);
}
