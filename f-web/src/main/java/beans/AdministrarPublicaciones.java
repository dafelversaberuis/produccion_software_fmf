package beans;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;

public class AdministrarPublicaciones {

	private int numeroColumnasMujeres = 42;

public void logoDinamico(String abosulta){
	
	//*******************NUEVO LO GO DE BD
	try {
	
		Object[] logoReal = new AdministrarPublicaciones().getLogo(1);
		byte[] archivoLogoReal = (byte[]) logoReal[3];
		if (archivoLogoReal != null) {
			new AdministrarPublicaciones().guardarArchivoDisco(abosulta + "/logo_financiador_OK.jpg", archivoLogoReal);

		}
	} catch (Exception e) {
		

	}
	//********************************************
	
}
	
	
	/**
	 * Redondea un valor a n decimales
	 * 
	 * @param aValor
	 * @param aNumeroDecimales
	 * @return valor
	 */
	public BigDecimal getValorRedondeado(BigDecimal aValor, Integer aNumeroDecimales) {

		BigDecimal valor = new BigDecimal(0);
		try {

			valor = aValor.setScale(aNumeroDecimales, RoundingMode.HALF_UP);

		} catch (Exception e) {
			valor = new BigDecimal(0);
		}

		return valor;
	}

	public int contactar(String correo, String nombre, String telefono, String contenido) {

		int exito = 0;
		try {

			Parametro parametro = new Parametro();
			Email email = new Email();

			String[] parametros = parametro.getarametros();
			int c = 0;

			String asunto = "";
			String mensaje = "";

			if (c == 0) {
				asunto = "Nuevo contacto desde el software de Fundación Mujer y Futuro";
				mensaje = "<table width='100%' border='0'>" + "<tr>" + "<td colspan='2' align='left' valign='middle'><strong><span class='Estilo2'>Software Fundación Mujer y Futuro</strong></td>" + "</tr>" + "<tr>" + "<td colspan='2'>&nbsp;</td>" + "</tr>" + "<tr>" + "<td colspan='2'><p>Estimado administrador(a) existe un nuevo comentario de contacto desde el sitio Web. Éstos son los datos:<br><br>-<strong>Nombres:</strong>" + nombre + "<br><br>-<strong>Correo:</strong>" + correo + "<br><br>-<strong>Teléfono:</strong>" + telefono + "<br><br>-<strong>Contenido</strong>:<br>" + contenido + "<br><br>* Puedes visitar nuestro portal en cualquier momento dirigi&eacute;ndote a la direcci&oacute;n de internet: <a href='" + parametros[0] + "'>" + parametros[0] + "</a> &oacute; contactarnos a nuestro correo: " + parametros[1] + " </span></td></tr></table>";

				try {
					email.enviarEmail(mensaje, asunto, parametros[1]);
				} catch (Exception e) {

					// e.printStackTrace();
				}

				exito = 1;

			}

		} catch (Exception ee) {
			// e//e.printStackTrace();
		} finally {

		}

		return exito;

	}

	public int crearPortafolio(String titulo, String contenido) {
		Conexion conexion = new Conexion();
		int exito = 0;
		try {

			boolean actualizo = conexion.actualizarBD("INSERT INTO portafolio(titulo_portafolio,contenido_portafolio) VALUES('" + titulo + "','" + contenido + "')");
			if (actualizo) {
				exito = 1;
			}

		} catch (Exception ee) {
			// e//e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}

		return exito;

	}

	public int valorGrafica(String encuesta, String pregunta, String opcion) {
		Conexion conexion = new Conexion();
		int valor = 0;

		ResultSet rs2 = conexion.consultarBD("SELECT COUNT(*) FROM respuestas_encuesta WHERE id_encuesta = " + encuesta + " AND id_pregunta= " + pregunta + " AND id_opcion=" + opcion);
		try {
			if (rs2.next()) {
				valor = rs2.getInt(1);
			}
			rs2.close();

		} catch (SQLException e) {
			// e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}

		return valor;

	}

	public int editarPregunta(String nombre, String idPregunta, String tipo, String parametro) {
		Conexion conexion = new Conexion();
		int exito = 0;

		try {

			if (parametro == null) {

				boolean actualizo = conexion.actualizarBD("UPDATE preguntas SET descripcion='" + nombre.trim() + "', tipo_respuesta = '" + tipo + "' WHERE id_pregunta = " + idPregunta);
				if (actualizo) {
					exito = 1;
				}

			} else {

				boolean actualizo = conexion.actualizarBD("UPDATE preguntas SET descripcion='" + nombre.trim() + "', tipo_respuesta = '" + tipo + "' , id_pregunta_sup = " + parametro + " WHERE id_pregunta = " + idPregunta);

				if (actualizo) {
					exito = 1;
				}
			}

		} catch (Exception ee) {
			// e//e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}

		return exito;

	}

	public int crearPregunta(String nombre, String idEncuesta, String tipo) {
		Conexion conexion = new Conexion();
		int exito = 0;

		int c = 0;

		ResultSet rs2 = conexion.consultarBD("SELECT COUNT(*) FROM preguntas WHERE id_encuesta = " + idEncuesta);
		try {
			if (rs2.next()) {
				c = rs2.getInt(1);
			}
			rs2.close();

		} catch (SQLException e) {
			// e.printStackTrace();
		}

		c++;

		try {

			boolean actualizo = conexion.actualizarBD("INSERT INTO preguntas(descripcion,id_encuesta,tipo_respuesta,orden) VALUES('" + nombre.trim() + "'," + idEncuesta + ",'" + tipo + "','" + c + "')");
			if (actualizo) {
				exito = 1;
			}

		} catch (Exception ee) {
			// e//e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}

		return exito;

	}

	public int editarOpcion(String nombre, String idOpcion, String aAmpliar) {
		Conexion conexion = new Conexion();
		int exito = 0;
		try {

			boolean actualizo = conexion.actualizarBD("UPDATE opciones_respuesta SET descripcion= '" + nombre.trim() + "', ampliar='" + aAmpliar + "' where id_op_respuesta=" + idOpcion);
			if (actualizo) {
				exito = 1;
			}

		} catch (Exception ee) {
			// e//e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}

		return exito;

	}

	public int crearOpcion(String nombre, String idPregunta, String aAmpliar) {
		Conexion conexion = new Conexion();
		int exito = 0;
		try {

			boolean actualizo = conexion.actualizarBD("INSERT INTO opciones_respuesta(descripcion,id_pregunta,ampliar) VALUES('" + nombre.trim() + "'," + idPregunta + ",'" + aAmpliar + "')");
			if (actualizo) {
				exito = 1;
			}

		} catch (Exception ee) {
			// e//e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}

		return exito;

	}

	// 2137 -2173 ppto
	
	
	public int eliminarAntesEncuesta(String encuesta, String mujer) {
		Conexion conexion = new Conexion();
		int exito = 0;
		try {

			boolean actualizo = conexion.actualizarBD("DELETE FROM respuestas_encuesta WHERE id_encuesta= "+encuesta+" and id_mujer = "+mujer);
			if (actualizo) {
				exito = 1;
			}

		} catch (Exception ee) {
			// e//e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}

		return exito;

	}
	

	public int crearRespuestaTiempo(String encuesta, String pregunta, String mujer, String horas, String minutos) {
		Conexion conexion = new Conexion();
		int exito = 0;
		try {

			boolean actualizo = conexion.actualizarBD("INSERT INTO respuestas_encuesta(id_encuesta,id_pregunta,id_mujer,horas,minutos) VALUES(" + encuesta + "," + pregunta + "," + mujer + "," + horas + "," + minutos + ")");
			if (actualizo) {
				exito = 1;
			}

		} catch (Exception ee) {
			// e//e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}

		return exito;

	}

	public int crearRespuestaAbierta(String encuesta, String pregunta, String mujer, String abierta) {
		Conexion conexion = new Conexion();
		int exito = 0;
		try {

			boolean actualizo = false;

			actualizo = conexion.actualizarBD("INSERT INTO respuestas_encuesta(id_encuesta,id_pregunta,id_mujer,ampliacion) VALUES(" + encuesta + "," + pregunta + "," + mujer + ",'" + abierta + "')");

			if (actualizo) {
				exito = 1;
			}

		} catch (Exception ee) {
			// e//e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}

		return exito;

	}

	public int crearRespuestaUnica(String encuesta, String pregunta, String opcion, String mujer, String ampliacion) {
		Conexion conexion = new Conexion();
		int exito = 0;
		try {

			boolean actualizo = false;

			if (ampliacion != null && !ampliacion.equals("") && !ampliacion.equals("null")) {

				actualizo = conexion.actualizarBD("INSERT INTO respuestas_encuesta(id_encuesta,id_pregunta,id_opcion,id_mujer,ampliacion) VALUES(" + encuesta + "," + pregunta + "," + opcion + "," + mujer + ",'" + ampliacion + "')");

			} else {

				actualizo = conexion.actualizarBD("INSERT INTO respuestas_encuesta(id_encuesta,id_pregunta,id_opcion,id_mujer) VALUES(" + encuesta + "," + pregunta + "," + opcion + "," + mujer + ")");

			}

			if (actualizo) {
				exito = 1;
			}

		} catch (Exception ee) {
			// e//e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}

		return exito;

	}

	public int crearRespuesta(String encuesta, String pregunta, String opcion) {
		Conexion conexion = new Conexion();
		int exito = 0;
		try {

			boolean actualizo = conexion.actualizarBD("INSERT INTO respuestas_encuesta(id_encuesta,id_pregunta,id_opcion) VALUES(" + encuesta + "," + pregunta + "," + opcion + ")");
			if (actualizo) {
				exito = 1;
			}

		} catch (Exception ee) {
			// e//e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}

		return exito;

	}

	public int editarTema(String nombre, String idTema) {
		Conexion conexion = new Conexion();
		int exito = 0;
		try {

			boolean actualizo = conexion.actualizarBD("UPDATE temas SET nombre='" + nombre.trim() + "' WHERE id=" + idTema);
			if (actualizo) {
				exito = 1;
			}

		} catch (Exception ee) {
			// e//e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}

		return exito;

	}

	public BigDecimal getRedondeado(String aValor) {

		BigDecimal valor = new BigDecimal(0);
		try {

			valor = new BigDecimal(aValor).setScale(2, RoundingMode.HALF_UP);

		} catch (Exception e) {
			valor = new BigDecimal(0);
		}

		return valor;
	}

	public BigDecimal getValorSemanal(String aValor) {

		BigDecimal valor = new BigDecimal(0);
		try {

			valor = new BigDecimal(aValor).setScale(2, RoundingMode.HALF_UP).divide(new BigDecimal(4), 10, RoundingMode.HALF_UP).setScale(2, RoundingMode.HALF_UP);

		} catch (Exception e) {
			valor = new BigDecimal(0);
		}

		return valor;
	}

	public int crearFinanciadorC(String idFinanciador, String idCurso) {
		Conexion conexion = new Conexion();
		int exito = 0;
		try {

			int c = 0;

			ResultSet rs = conexion.consultarBD("SELECT COUNT(*) FROM curso_financiador WHERE id_financiador=" + idFinanciador + " AND id_curso=" + idCurso);
			try {
				if (rs.next()) {
					c = rs.getInt(1);
				}
				rs.close();

			} catch (SQLException e) {
				// e.printStackTrace();
			}
			if (c == 0) {

				boolean actualizo = conexion.actualizarBD("INSERT INTO curso_financiador(id_financiador,id_curso) VALUES(" + idFinanciador + "," + idCurso + ")");
				if (actualizo) {
					c = 0;
					ResultSet rs2 = conexion.consultarBD("SELECT COUNT(*) FROM curso_financiador WHERE id_curso=" + idCurso);
					try {
						if (rs2.next()) {
							c = rs2.getInt(1);
						}
						rs2.close();

					} catch (SQLException e) {
						// e.printStackTrace();
					}

					BigDecimal porcentaje = new BigDecimal(100).divide(new BigDecimal(c), 10, RoundingMode.HALF_UP).setScale(2, RoundingMode.HALF_UP);
					conexion.actualizarBD("UPDATE curso_financiador SET porcentaje=" + porcentaje + " WHERE id_curso=" + idCurso);

					exito = 1;
				}

			}

		} catch (Exception ee) {
			// e//e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}

		return exito;

	}

	public int crearLineaC(String idLinea, String idCurso) {
		Conexion conexion = new Conexion();
		int exito = 0;
		try {

			int c = 0;

			ResultSet rs = conexion.consultarBD("SELECT COUNT(*) FROM curso_linea WHERE id_linea=" + idLinea + " AND id_curso=" + idCurso);
			try {
				if (rs.next()) {
					c = rs.getInt(1);
				}
				rs.close();

			} catch (SQLException e) {
				// e.printStackTrace();
			}
			if (c == 0) {

				boolean actualizo = conexion.actualizarBD("INSERT INTO curso_linea(id_linea,id_curso) VALUES(" + idLinea + "," + idCurso + ")");
				if (actualizo) {
					c = 0;
					ResultSet rs2 = conexion.consultarBD("SELECT COUNT(*) FROM curso_linea WHERE id_curso=" + idCurso);
					try {
						if (rs2.next()) {
							c = rs2.getInt(1);
						}
						rs2.close();

					} catch (SQLException e) {
						// e.printStackTrace();
					}

					BigDecimal porcentaje = new BigDecimal(100).divide(new BigDecimal(c), 10, RoundingMode.HALF_UP).setScale(2, RoundingMode.HALF_UP);
					conexion.actualizarBD("UPDATE curso_linea SET porcentaje=" + porcentaje + " WHERE id_curso=" + idCurso);

					exito = 1;
				}

			}

		} catch (Exception ee) {
			// e//e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}

		return exito;

	}

	public int crearActividad(String idActividad, String idMujer, String justificacion, String idRango, String salarioSemanal) {
		Conexion conexion = new Conexion();
		int exito = 0;
		try {

			boolean actualizo = false;
			if (justificacion != null) {
				actualizo = conexion.actualizarBD("INSERT INTO actividades_mujeres(id_mujer,id_actividad,justificacion,salario,numero_salarios) VALUES('" + idMujer + "','" + idActividad + "','" + justificacion + "','" + salarioSemanal + "','" + idRango + "')");
			} else {

				int c = 0;

				ResultSet rs = conexion.consultarBD("SELECT COUNT(*) FROM actividades_mujeres WHERE id_mujer= " + idMujer + " AND id_actividad=" + idActividad);
				try {
					if (rs.next()) {
						c = rs.getInt(1);
					}
					rs.close();

				} catch (SQLException e) {
					// e.printStackTrace();
				}

				if (c == 0) {
					actualizo = conexion.actualizarBD("INSERT INTO actividades_mujeres(id_mujer,id_actividad,salario,numero_salarios) VALUES('" + idMujer + "','" + idActividad + "','" + salarioSemanal + "','" + idRango + "')");

				}
			}

			if (actualizo) {
				exito = 1;
			}

		} catch (Exception ee) {
			// e//e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}

		return exito;

	}

	public int crearParticipacion(String idNivel, String idMujer, String justificacion, String tipo, String cargo) {
		Conexion conexion = new Conexion();
		int exito = 0;
		try {

			boolean actualizo = false;
			if (justificacion != null) {
				actualizo = conexion.actualizarBD("INSERT INTO participaciones_mujeres(id_mujer,id_organizacion,id_cargo,tipo,justificacion) VALUES('" + idMujer + "','" + idNivel + "','" + cargo + "','" + tipo + "','" + justificacion + "')");
			} else {

				int c = 0;

				ResultSet rs = conexion.consultarBD("SELECT COUNT(*) FROM participaciones_mujeres WHERE id_mujer= " + idMujer + " AND id_organizacion=" + idNivel + " AND id_cargo=" + cargo + " AND tipo='" + tipo + "'");
				try {
					if (rs.next()) {
						c = rs.getInt(1);
					}
					rs.close();

				} catch (SQLException e) {
					// e.printStackTrace();
				}

				if (c == 0) {
					actualizo = conexion.actualizarBD("INSERT INTO participaciones_mujeres(id_mujer,id_organizacion,id_cargo,tipo) VALUES('" + idMujer + "','" + idNivel + "','" + cargo + "','" + tipo + "')");

				}
			}

			if (actualizo) {
				exito = 1;
			}

		} catch (Exception ee) {
			// e//e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}

		return exito;

	}

	public int crearCapacitacion(String idNivel, String idMujer, String justificacion, String institucion, String percepcion, String tiempo, String tipo) {
		Conexion conexion = new Conexion();
		int exito = 0;
		String sql = "";
		try {

			boolean actualizo = false;
			if (justificacion != null) {

				if (tipo != null && tipo.equals("C")) {

					sql = "INSERT INTO capacitaciones_mujeres(id_mujer,id_capacitacion, justificacion,tiempo,institucion,nivel) VALUES(" + idMujer + "," + idNivel + ",'" + justificacion + "','" + tiempo + "','" + institucion + "','" + percepcion + "')";
					actualizo = conexion.actualizarBD(sql);

				} else {

					sql = "INSERT INTO capacitaciones_mujeres(id_mujer,id_linea, justificacion,tiempo,institucion,nivel) VALUES(" + idMujer + "," + idNivel + ",'" + justificacion + "','" + tiempo + "','" + institucion + "','" + percepcion + "')";
					actualizo = conexion.actualizarBD(sql);

				}

			} else {

				if (tipo != null && tipo.equals("C")) {
					sql = "INSERT INTO capacitaciones_mujeres(id_mujer,id_capacitacion, tiempo,institucion,nivel) VALUES(" + idMujer + "," + idNivel + ",'" + tiempo + "','" + institucion + "','" + percepcion + "')";
					actualizo = conexion.actualizarBD(sql);

				} else {

					sql = "INSERT INTO capacitaciones_mujeres(id_mujer,id_linea, tiempo,institucion,nivel) VALUES(" + idMujer + "," + idNivel + ",'" + tiempo + "','" + institucion + "','" + percepcion + "')";
					actualizo = conexion.actualizarBD(sql);

				}

			}

			if (actualizo) {
				exito = 1;
			}

		} catch (Exception ee) {
			// e//e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}

		return exito;

	}

	public int crearNivel(String idNivel, String idMujer, String justificacion) {
		Conexion conexion = new Conexion();
		int exito = 0;
		try {

			boolean actualizo = false;
			if (justificacion != null) {
				actualizo = conexion.actualizarBD("INSERT INTO niveles_mujeres(id_mujer,id_nivel,justificacion) VALUES('" + idMujer + "','" + idNivel + "','" + justificacion + "')");
			} else {

				int c = 0;

				ResultSet rs = conexion.consultarBD("SELECT COUNT(*) FROM niveles_mujeres WHERE id_mujer= " + idMujer + " AND id_nivel=" + idNivel);
				try {
					if (rs.next()) {
						c = rs.getInt(1);
					}
					rs.close();

				} catch (SQLException e) {
					// e.printStackTrace();
				}

				if (c == 0) {
					actualizo = conexion.actualizarBD("INSERT INTO niveles_mujeres(id_mujer,id_nivel) VALUES('" + idMujer + "','" + idNivel + "')");

				}
			}

			if (actualizo) {
				exito = 1;
			}

		} catch (Exception ee) {
			// e//e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}

		return exito;

	}

	public int crearTema(String nombre, String idCurso) {
		Conexion conexion = new Conexion();
		int exito = 0;
		try {

			boolean actualizo = conexion.actualizarBD("INSERT INTO temas(nombre,id_curso) VALUES('" + nombre.trim() + "'," + idCurso + ")");
			if (actualizo) {
				exito = 1;
			}

		} catch (Exception ee) {
			// e//e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}

		return exito;

	}

	public int crearMC(String idMujer, String idCurso) {
		Conexion conexion = new Conexion();
		int exito = 0;
		try {
			int c = 0;

			ResultSet rs = conexion.consultarBD("SELECT COUNT(*) FROM mujeres_curso WHERE id_mujer= " + idMujer + " AND id_curso=" + idCurso);
			try {
				if (rs.next()) {
					c = rs.getInt(1);
				}
				rs.close();

			} catch (SQLException e) {
				// e.printStackTrace();
			}
			if (c == 0) {

				boolean actualizo = conexion.actualizarBD("INSERT INTO mujeres_curso(id_mujer,id_curso) VALUES('" + idMujer + "'," + idCurso + ")");
				if (actualizo) {
					exito = 1;
				}

			}

		} catch (Exception ee) {
			// e//e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}

		return exito;

	}

	public int editarEncuesta(String id, String encuesta, String fechaDesde, String fechaHasta) {
		Conexion conexion = new Conexion();
		int exito = 0;
		try {

			boolean actualizo = conexion.actualizarBD("UPDATE encuestas SET descripcion='" + encuesta.trim() + "', fecha_desde='" + fechaDesde + "',fecha_hasta='" + fechaHasta + "' WHERE id_encuesta=" + id);
			if (actualizo) {
				exito = 1;
			}

		} catch (Exception ee) {
			// e//e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}

		return exito;

	}

	public int crearEncuesta(String encuesta, String fechaDesde, String fechaHasta) {
		Conexion conexion = new Conexion();
		int exito = 0;
		try {

			boolean actualizo = conexion.actualizarBD("INSERT INTO encuestas(descripcion,fecha_desde,fecha_hasta) VALUES('" + encuesta.trim() + "','" + fechaDesde + "','" + fechaHasta + "')");
			if (actualizo) {
				exito = 1;
			}

		} catch (Exception ee) {
			// e//e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}

		return exito;

	}

	public int crearProyectoLinea(String proyecto, String linea, String financiador) {
		Conexion conexion = new Conexion();
		int exito = 0;
		try {

			int c = 0;

			ResultSet rs = conexion.consultarBD("SELECT COUNT(*) FROM proyecto_linea_finan WHERE id_proyecto= " + proyecto + " AND id_linea = " + linea + " AND id_financiador=" + financiador);

			try {
				if (rs.next()) {
					c = rs.getInt(1);
				}
				rs.close();

			} catch (SQLException e) {
				// e.printStackTrace();
			}

			if (c == 0) {

				boolean actualizo = conexion.actualizarBD("INSERT INTO proyecto_linea_finan(id_proyecto,id_linea,id_financiador) VALUES(" + proyecto + "," + linea + "," + financiador + ")");
				if (actualizo) {
					exito = 1;
				}

			}

		} catch (Exception ee) {
			// e//e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}

		return exito;

	}

	public int crearLinea(String proyecto) {
		Conexion conexion = new Conexion();
		int exito = 0;
		try {

			boolean actualizo = conexion.actualizarBD("INSERT INTO lineas(nombre) VALUES('" + proyecto.trim() + "')");
			if (actualizo) {
				exito = 1;
			}

		} catch (Exception ee) {
			// e//e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}

		return exito;

	}

	public int crearProyecto(String proyecto) {
		Conexion conexion = new Conexion();
		int exito = 0;
		try {

			boolean actualizo = conexion.actualizarBD("INSERT INTO proyectos(nombre) VALUES('" + proyecto.trim() + "')");
			if (actualizo) {
				exito = 1;
			}

		} catch (Exception ee) {
			// e//e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}

		return exito;

	}

	public void actualizarArchivov3(File archivo, String id) {

		Conexion conexion = new Conexion();
		byte[] array = null;

		try {
			FileInputStream is = new FileInputStream(archivo);

			// guarda el archivo

			String[][] condiciones = new String[1][2];
			condiciones[0][0] = "id";
			condiciones[0][1] = "" + id;
			String[] campos = new String[1];
			campos[0] = "array";

			Object[] valores = new Object[1];
			valores[0] = array;
			boolean oka = conexion.actualizarBD3("temas", campos, condiciones, is, (int) archivo.length(), archivo);

			conexion.cerrarConexion();

		} catch (Exception e) {

		}

	}
	
	
	public void actualizarArchivov33(File archivo, String id) {

		Conexion conexion = new Conexion();
		byte[] array = null;

		try {
			FileInputStream is = new FileInputStream(archivo);

			// guarda el archivo

			String[][] condiciones = new String[1][2];
			condiciones[0][0] = "id";
			condiciones[0][1] = "" + id;
			String[] campos = new String[1];
			campos[0] = "array3";

			Object[] valores = new Object[1];
			valores[0] = array;
			boolean oka = conexion.actualizarBD3("temas", campos, condiciones, is, (int) archivo.length(), archivo);

			conexion.cerrarConexion();

		} catch (Exception e) {

		}

	}
	
	public void actualizarArchivov32(File archivo, String id) {

		Conexion conexion = new Conexion();
		byte[] array = null;

		try {
			FileInputStream is = new FileInputStream(archivo);

			// guarda el archivo

			String[][] condiciones = new String[1][2];
			condiciones[0][0] = "id";
			condiciones[0][1] = "" + id;
			String[] campos = new String[1];
			campos[0] = "array2";

			Object[] valores = new Object[1];
			valores[0] = array;
			boolean oka = conexion.actualizarBD3("temas", campos, condiciones, is, (int) archivo.length(), archivo);

			conexion.cerrarConexion();

		} catch (Exception e) {

		}

	}

	public int actualizarArchivoTema(String id, String nombreArchivo, String contenttype) {
		Conexion conexion = new Conexion();
		int exito = 0;
		try {

			boolean actualizo = conexion.actualizarBD("UPDATE temas SET archivo ='" + nombreArchivo.toLowerCase() + "', content_type='" + contenttype + "' WHERE id =" + id);
			if (actualizo) {
				exito = 1;
			}

		} catch (Exception ee) {
			// e//e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}

		return exito;

	}
	
	public int actualizarArchivoTema3(String id, String nombreArchivo, String contenttype) {
		Conexion conexion = new Conexion();
		int exito = 0;
		try {

			boolean actualizo = conexion.actualizarBD("UPDATE temas SET archivo3 ='" + nombreArchivo.toLowerCase() + "', content_type3='" + contenttype + "' WHERE id =" + id);
			if (actualizo) {
				exito = 1;
			}

		} catch (Exception ee) {
			// e//e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}

		return exito;

	}
	
	
	public int actualizarArchivoTema2(String id, String nombreArchivo, String contenttype) {
		Conexion conexion = new Conexion();
		int exito = 0;
		try {

			boolean actualizo = conexion.actualizarBD("UPDATE temas SET archivo2 ='" + nombreArchivo.toLowerCase() + "', content_type2='" + contenttype + "' WHERE id =" + id);
			if (actualizo) {
				exito = 1;
			}

		} catch (Exception ee) {
			// e//e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}

		return exito;

	}

	public void actualizarArchivo(File archivo, String financiador) {

		Conexion conexion = new Conexion();
		byte[] array = null;

		try {
			FileInputStream is = new FileInputStream(archivo);

			// guarda el archivo

			String[][] condiciones = new String[1][2];
			condiciones[0][0] = "id";
			condiciones[0][1] = "" + financiador;
			String[] campos = new String[1];
			campos[0] = "archivo";

			Object[] valores = new Object[1];
			valores[0] = array;
			boolean oka = conexion.actualizarBD3("financiadores", campos, condiciones, is, (int) archivo.length(), archivo);

			conexion.cerrarConexion();

		} catch (Exception e) {

		}

	}
	
	public void actualizarArchivoLogo(File archivo, String financiador) {

		Conexion conexion = new Conexion();
		byte[] array = null;

		try {
			FileInputStream is = new FileInputStream(archivo);

			// guarda el archivo

			String[][] condiciones = new String[1][2];
			condiciones[0][0] = "id";
			condiciones[0][1] = "" + financiador;
			String[] campos = new String[1];
			campos[0] = "archivo";

			Object[] valores = new Object[1];
			valores[0] = array;
			boolean oka = conexion.actualizarBD3("logo_software", campos, condiciones, is, (int) archivo.length(), archivo);

			conexion.cerrarConexion();

		} catch (Exception e) {

		}

	}
	
	
	public int actualizarLogo(String financiador) {
		Conexion conexion = new Conexion();
		int exito = 0;
		try {

			boolean actualizo = conexion.actualizarBD("UPDATE logo_software SET posee_logo ='S' WHERE id =" + financiador);
			if (actualizo) {
				exito = 1;
			}

		} catch (Exception ee) {
			// e//e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}

		return exito;

	}

	public int actualizarFinanciador(String financiador) {
		Conexion conexion = new Conexion();
		int exito = 0;
		try {

			boolean actualizo = conexion.actualizarBD("UPDATE financiadores SET posee_logo ='S' WHERE id =" + financiador);
			if (actualizo) {
				exito = 1;
			}

		} catch (Exception ee) {
			// e//e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}

		return exito;

	}

	public int crearFinanciador(String financiador) {
		Conexion conexion = new Conexion();
		int exito = 0;
		try {

			boolean actualizo = conexion.actualizarBD("INSERT INTO financiadores(nombre) VALUES('" + financiador.trim() + "')");
			if (actualizo) {
				exito = 1;
			}

		} catch (Exception ee) {
			// e//e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}

		return exito;

	}

	public int editarCurso(String id, String curso, String proyecto) {
		Conexion conexion = new Conexion();
		int exito = 0;
		try {

			boolean actualizo = conexion.actualizarBD("UPDATE cursos SET nombre='" + curso.trim() + "', id_proyecto=" + proyecto + " WHERE id=" + id);
			if (actualizo) {
				exito = 1;
			}

		} catch (Exception ee) {
			// e//e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}

		return exito;

	}

	public int crearCurso(String curso, String proyecto) {
		Conexion conexion = new Conexion();
		int exito = 0;
		try {

			boolean actualizo = conexion.actualizarBD("INSERT INTO cursos(nombre,id_proyecto) VALUES('" + curso.trim() + "'," + proyecto + ")");
			if (actualizo) {
				exito = 1;
			}

		} catch (Exception ee) {
			// e//e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}

		return exito;

	}

	public int crearAdmin(String pn, String sn, String pa, String sa, int doc, String correo, String clave) {
		Conexion conexion = new Conexion();
		int exito = 0;
		try {

			Parametro parametro = new Parametro();
			Email email = new Email();

			String[] parametros = parametro.getarametros();
			int c = 0;

			ResultSet rs = conexion.consultarBD("SELECT COUNT(*) FROM administradores WHERE documento= " + doc);
			try {
				if (rs.next()) {
					c = rs.getInt(1);
				}
				rs.close();

			} catch (SQLException e) {
				// e.printStackTrace();
			}

			String asunto = "";
			String mensaje = "";

			if (c == 0) {
				asunto = "Nueva cuenta en sitio Web Fundación Mujer y Futuro";
				mensaje = "<table width='100%' border='0'>" + "<tr>" + "<td colspan='2' align='left' valign='middle'><strong>Sistema de informaci&oacute;n de Fundación Mujer y Futuro </strong></td>" + "</tr>" + "<tr>" + "<td colspan='2'>&nbsp;</td>" + "</tr>" + "<tr>" + "<td colspan='2'><p>Estimado administrador(a) <strong>" + pn + " " + sn + " " + pa + " " + sa + "</strong> se le ha creado una nueva cuenta en sitio Web Fundación Mujer y Futuro. Le recordamos su nueva contraseña, cámbiela cuando desee desde el menú administrador. La contraseña es: " + clave + ".</p>" + "<p>&nbsp; </p></td>" + "</tr>" + "<tr>" + "<td colspan='2'><span class='Estilo6'>* Puedes visitar nuestro portal en cualquier momento dirigi&eacute;ndote a la direcci&oacute;n de internet: <a href='" + parametros[0] + "'>" + parametros[0] + "</a> &oacute; contactarnos a nuestro correo: " + parametros[1] + " </span></td>" + "</tr>" + "</table>";

				try {
					email.enviarEmail(mensaje, asunto, correo);
				} catch (Exception e) {

					// e.printStackTrace();
				}

				boolean actualizo = conexion.actualizarBD("INSERT INTO administradores(primer_nombre,segundo_nombre,primer_apellido,segundo_apellido,documento,clave,correo) VALUES('" + pn + "','" + sn + "','" + pa + "','" + sa + "'," + doc + ",\"" + clave + "\",'" + correo + "')");
				if (actualizo) {
					exito = 1;
				}
			}

		} catch (Exception ee) {
			// e//e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}

		return exito;

	}

	public int getEnviarNuevaClaveAdmin(String correo, int id, String m, String clave) {
		Conexion conexion = new Conexion();
		int exito = 0;
		try {

			Parametro parametro = new Parametro();
			Email email = new Email();

			String[] parametros = parametro.getarametros();
			Administrador admin = new Administrador();

			String asunto = "";
			String mensaje = "";

			if (m.equals("0")) {
				admin.setClave(this.getClaveAleatoria());
			} else {
				admin.setClave(clave);
			}
			asunto = "Nueva clave software Fundación Mujer y Futuro";
			mensaje = "<table width='100%' border='0'>" + "<tr>" + "<td colspan='2' align='left' valign='middle'><strong>Sistema de informaci&oacute;n  Fundación Mujer y Futuro</strong></td>" + "</tr>" + "<tr>" + "<td colspan='2'>&nbsp;</td>" + "</tr>" + "<tr>" + "<td colspan='2'><p>Estimado administrador(a), se le ha asignado una nueva contraseña. Cámbiela cuando desee. La contraseña es: " + admin.getClave() + "</p>" + "<p>&nbsp; </p></td>" + "</tr>" + "<tr>" + "<td colspan='2'><span class='Estilo6'>* Puedes visitar nuestro portal en cualquier momento dirigi&eacute;ndote a la direcci&oacute;n de internet: <a href='" + parametros[0] + "'>" + parametros[0] + "</a> &oacute; contactarnos a nuestro correo: " + parametros[1] + " </span></td></tr>" + "</table>";

			try {
				email.enviarEmail(mensaje, asunto, correo);
			} catch (Exception e) {

				// e.printStackTrace();
			}

			boolean actualizo = conexion.actualizarBD("UPDATE administradores SET clave=(\"" + admin.getClave() + "\") WHERE id_administrador=" + id);
			if (actualizo) {
				exito = 1;
			}

		} catch (Exception ee) {
			// e//e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}

		return exito;

	}

	private String getClaveAleatoria() {
		String clave = "";
		for (int i = 0; i <= 3; i++) {
			int n = (int) (10.0 * Math.random()) + 0;
			clave = clave + String.valueOf(n);

		}
		return clave;

	}

	public int eliminarArchivoPlano(String pArchivo, String idArchivo) {
		Parametro parametro = new Parametro();
		String[] parametros = parametro.getarametros();
		java.io.File directorio = new java.io.File(parametros[5] + pArchivo);
		directorio.delete();

		Conexion conexion = new Conexion();
		conexion.setAutoCommitBD(true);
		int g = 0;
		boolean actualizo = false;
		actualizo = conexion.actualizarBD("DELETE FROM archivos_planos WHERE id_archivo=" + Integer.parseInt(idArchivo));
		// conexion.commitBD();
		conexion.cerrarConexion();
		if (actualizo) {
			g = 1;
		}
		return g;
	}

	public int eliminarPortafolio(String idPortafolio) {
		Conexion conexion = new Conexion();
		conexion.setAutoCommitBD(true);
		int g = 0;
		boolean actualizo = false;

		actualizo = conexion.actualizarBD("DELETE FROM portafolio WHERE id_portafolio=" + Integer.parseInt(idPortafolio));

		conexion.cerrarConexion();
		if (actualizo) {
			g = 1;
		}
		return g;
	}

	public int eliminarMujer(String idAdministrador) {
		Conexion conexion = new Conexion();
		conexion.setAutoCommitBD(true);
		int g = 0;
		boolean actualizo = false;

		actualizo = conexion.actualizarBD("DELETE FROM mujeres WHERE id_mujer=" + Integer.parseInt(idAdministrador));

		conexion.cerrarConexion();
		if (actualizo) {
			g = 1;
		}
		return g;
	}

	public int eliminarMC(String idAdministrador) {
		Conexion conexion = new Conexion();
		conexion.setAutoCommitBD(true);
		int g = 0;
		boolean actualizo = false;

		actualizo = conexion.actualizarBD("DELETE FROM mujeres_curso WHERE id=" + Integer.parseInt(idAdministrador));

		conexion.cerrarConexion();
		if (actualizo) {
			g = 1;
		}
		return g;
	}

	public int eliminarPregunta(String idAdministrador) {
		Conexion conexion = new Conexion();
		conexion.setAutoCommitBD(true);
		int g = 0;
		boolean actualizo = false;

		actualizo = conexion.actualizarBD("DELETE FROM preguntas WHERE id_pregunta=" + Integer.parseInt(idAdministrador));

		conexion.cerrarConexion();
		if (actualizo) {
			g = 1;
		}
		return g;
	}

	public int eliminarOpcion(String idAdministrador) {
		Conexion conexion = new Conexion();
		conexion.setAutoCommitBD(true);
		int g = 0;
		boolean actualizo = false;

		actualizo = conexion.actualizarBD("DELETE FROM opciones_respuesta WHERE id_op_respuesta=" + Integer.parseInt(idAdministrador));

		conexion.cerrarConexion();
		if (actualizo) {
			g = 1;
		}
		return g;
	}

	public int eliminarFinanciadorC(String idAdministrador) {
		Conexion conexion = new Conexion();
		conexion.setAutoCommitBD(true);
		int g = 0;
		boolean actualizo = false;

		int curso = 0;
		ResultSet rs2 = conexion.consultarBD("SELECT id_curso FROM  curso_financiador WHERE id=" + idAdministrador);
		try {
			if (rs2.next()) {
				curso = rs2.getInt(1);
			}
			rs2.close();

		} catch (SQLException e) {
			// e.printStackTrace();
		}

		actualizo = conexion.actualizarBD("DELETE FROM curso_financiador WHERE id=" + Integer.parseInt(idAdministrador));

		int c = 0;
		ResultSet rs = conexion.consultarBD("SELECT COUNT(*) FROM curso_financiador WHERE id_curso =" + curso);
		try {
			if (rs.next()) {
				c = rs.getInt(1);
			}
			rs.close();

		} catch (SQLException e) {
			// e.printStackTrace();
		}

		BigDecimal porcentaje = new BigDecimal(100).divide(new BigDecimal(c), 10, RoundingMode.HALF_UP).setScale(2, RoundingMode.HALF_UP);
		conexion.actualizarBD("UPDATE curso_financiador SET porcentaje=" + porcentaje + " WHERE id_curso=" + curso);

		conexion.cerrarConexion();
		if (actualizo) {
			g = 1;
		}
		return g;
	}

	public int eliminarLineaC(String idAdministrador) {
		Conexion conexion = new Conexion();
		conexion.setAutoCommitBD(true);
		int g = 0;
		boolean actualizo = false;

		int curso = 0;
		ResultSet rs2 = conexion.consultarBD("SELECT id_curso FROM  curso_linea WHERE id=" + idAdministrador);
		try {
			if (rs2.next()) {
				curso = rs2.getInt(1);
			}
			rs2.close();

		} catch (SQLException e) {
			// e.printStackTrace();
		}

		actualizo = conexion.actualizarBD("DELETE FROM curso_linea WHERE id=" + Integer.parseInt(idAdministrador));

		int c = 0;
		ResultSet rs = conexion.consultarBD("SELECT COUNT(*) FROM curso_linea WHERE id_curso =" + curso);
		try {
			if (rs.next()) {
				c = rs.getInt(1);
			}
			rs.close();

		} catch (SQLException e) {
			// e.printStackTrace();
		}

		BigDecimal porcentaje = new BigDecimal(100).divide(new BigDecimal(c), 10, RoundingMode.HALF_UP).setScale(2, RoundingMode.HALF_UP);
		conexion.actualizarBD("UPDATE curso_linea SET porcentaje=" + porcentaje + " WHERE id_curso=" + curso);

		conexion.cerrarConexion();
		if (actualizo) {
			g = 1;
		}
		return g;
	}

	public int eliminarActividad(String id) {
		Conexion conexion = new Conexion();
		conexion.setAutoCommitBD(true);
		int g = 0;
		boolean actualizo = false;

		actualizo = conexion.actualizarBD("DELETE FROM actividades_mujeres WHERE id=" + Integer.parseInt(id));

		conexion.cerrarConexion();

		if (actualizo) {
			g = 1;
		}
		return g;
	}

	public int eliminarParticipacion(String id) {
		Conexion conexion = new Conexion();
		conexion.setAutoCommitBD(true);
		int g = 0;
		boolean actualizo = false;

		actualizo = conexion.actualizarBD("DELETE FROM participaciones_mujeres WHERE id=" + Integer.parseInt(id));

		conexion.cerrarConexion();

		if (actualizo) {
			g = 1;
		}
		return g;
	}

	public int eliminarCapacitacion(String id) {
		Conexion conexion = new Conexion();
		conexion.setAutoCommitBD(true);
		int g = 0;
		boolean actualizo = false;

		actualizo = conexion.actualizarBD("DELETE FROM capacitaciones_mujeres WHERE id=" + Integer.parseInt(id));

		conexion.cerrarConexion();

		if (actualizo) {
			g = 1;
		}
		return g;
	}

	public int eliminarNivel(String id) {
		Conexion conexion = new Conexion();
		conexion.setAutoCommitBD(true);
		int g = 0;
		boolean actualizo = false;

		actualizo = conexion.actualizarBD("DELETE FROM niveles_mujeres WHERE id=" + Integer.parseInt(id));

		conexion.cerrarConexion();

		if (actualizo) {
			g = 1;
		}
		return g;
	}

	public int eliminarTema(String idAdministrador, String ruta) {
		Conexion conexion = new Conexion();
		conexion.setAutoCommitBD(true);
		int g = 0;
		boolean actualizo = false;

		actualizo = conexion.actualizarBD("DELETE FROM temas WHERE id=" + Integer.parseInt(idAdministrador));

		conexion.cerrarConexion();

		if (actualizo) {
			java.io.File archivo = new java.io.File(ruta);

			if (archivo.exists()) {
				archivo.delete();
			}
		}

		if (actualizo) {
			g = 1;
		}
		return g;
	}

	public int eliminarAsistencia(String idAdministrador) {
		Conexion conexion = new Conexion();
		conexion.setAutoCommitBD(true);
		int g = 0;
		boolean actualizo = false;

		actualizo = conexion.actualizarBD("DELETE FROM asistencia WHERE id=" + Integer.parseInt(idAdministrador));

		conexion.cerrarConexion();
		if (actualizo) {
			g = 1;
		}
		return g;
	}

	public int activarEncuesta(String idAdministrador) {
		Conexion conexion = new Conexion();
		conexion.setAutoCommitBD(true);
		int sw = 1;

		List<Object[]> preguntas = getPreguntas(idAdministrador);
		if (preguntas != null && preguntas.size() > 0) {
			for (Object[] pregunta : preguntas) {
				if (pregunta[3] != null && (((String) pregunta[3]).equals("M") || ((String) pregunta[3]).equals("U"))) {
					List<Object[]> opciones = this.getOpciones("" + pregunta[0]);
					if (!(opciones != null && opciones.size() > 0)) {
						sw = 0;
						break;
					}
				}
			}

		} else {
			sw = 0;

		}

		if (sw == 1) {
			boolean actualizo = conexion.actualizarBD("UPDATE encuestas SET activa = 'S' WHERE id_encuesta = " + Integer.parseInt(idAdministrador));
			if (!actualizo) {
				sw = 0;
			}

		}

		return sw;
	}

	public int eliminarEncuesta(String idAdministrador) {
		Conexion conexion = new Conexion();
		conexion.setAutoCommitBD(true);
		int g = 0;
		boolean actualizo = false;

		actualizo = conexion.actualizarBD("DELETE FROM encuestas WHERE id_encuesta=" + Integer.parseInt(idAdministrador));

		conexion.cerrarConexion();
		if (actualizo) {
			g = 1;
		}
		return g;
	}

	public int eliminarProyectoLinea(String idAdministrador) {
		Conexion conexion = new Conexion();
		conexion.setAutoCommitBD(true);
		int g = 0;
		boolean actualizo = false;

		actualizo = conexion.actualizarBD("DELETE FROM proyecto_linea_finan WHERE id=" + Integer.parseInt(idAdministrador));

		conexion.cerrarConexion();
		if (actualizo) {
			g = 1;
		}
		return g;
	}

	public int eliminarLinea(String idAdministrador) {
		Conexion conexion = new Conexion();
		conexion.setAutoCommitBD(true);
		int g = 0;
		boolean actualizo = false;

		actualizo = conexion.actualizarBD("DELETE FROM lineas WHERE id=" + Integer.parseInt(idAdministrador));

		conexion.cerrarConexion();
		if (actualizo) {
			g = 1;
		}
		return g;
	}

	public int eliminarProyecto(String idAdministrador) {
		Conexion conexion = new Conexion();
		conexion.setAutoCommitBD(true);
		int g = 0;
		boolean actualizo = false;

		actualizo = conexion.actualizarBD("DELETE FROM proyectos WHERE id=" + Integer.parseInt(idAdministrador));

		conexion.cerrarConexion();
		if (actualizo) {
			g = 1;
		}
		return g;
	}

	public int eliminarArchivoTema(String id, String ruta) {
		Conexion conexion = new Conexion();
		conexion.setAutoCommitBD(true);
		int exito = 0;
		boolean actualizo = conexion.actualizarBD("UPDATE temas SET archivo = NULL WHERE id =" + id);

		java.io.File archivo = new java.io.File(ruta);
		if (actualizo) {
			if (archivo.exists()) {
				archivo.delete();
			}

			if (actualizo) {
				exito = 1;
			}
		}
		return exito;
	}
	
	
	public int eliminarArchivoTema2(String id, String ruta) {
		Conexion conexion = new Conexion();
		conexion.setAutoCommitBD(true);
		int exito = 0;
		boolean actualizo = conexion.actualizarBD("UPDATE temas SET archivo2 = NULL WHERE id =" + id);

		java.io.File archivo = new java.io.File(ruta);
		if (actualizo) {
			if (archivo.exists()) {
				archivo.delete();
			}

			if (actualizo) {
				exito = 1;
			}
		}
		return exito;
	}
	
	
	public int eliminarArchivoTema3(String id, String ruta) {
		Conexion conexion = new Conexion();
		conexion.setAutoCommitBD(true);
		int exito = 0;
		boolean actualizo = conexion.actualizarBD("UPDATE temas SET archivo3 = NULL WHERE id =" + id);

		java.io.File archivo = new java.io.File(ruta);
		if (actualizo) {
			if (archivo.exists()) {
				archivo.delete();
			}

			if (actualizo) {
				exito = 1;
			}
		}
		return exito;
	}
	
	
	public int eliminarLogoLogo(String id, String ruta) {
		Conexion conexion = new Conexion();
		conexion.setAutoCommitBD(true);
		int exito = 0;
		boolean actualizo = conexion.actualizarBD("UPDATE logo_software SET posee_logo ='N' WHERE id =" + id);

		java.io.File archivo = new java.io.File(ruta);
		if (actualizo) {
			if (archivo.exists()) {
				archivo.delete();
			}

			if (actualizo) {
				exito = 1;
			}
		}
		return exito;
	}

	public int eliminarLogoFinanciador(String id, String ruta) {
		Conexion conexion = new Conexion();
		conexion.setAutoCommitBD(true);
		int exito = 0;
		boolean actualizo = conexion.actualizarBD("UPDATE financiadores SET posee_logo ='N' WHERE id =" + id);

		java.io.File archivo = new java.io.File(ruta);
		if (actualizo) {
			if (archivo.exists()) {
				archivo.delete();
			}

			if (actualizo) {
				exito = 1;
			}
		}
		return exito;
	}

	public int eliminarFinanciador(String idAdministrador, String ruta) {
		Conexion conexion = new Conexion();
		conexion.setAutoCommitBD(true);
		int g = 0;
		boolean actualizo = false;

		actualizo = conexion.actualizarBD("DELETE FROM financiadores WHERE id=" + Integer.parseInt(idAdministrador));

		if (actualizo) {
			java.io.File archivo = new java.io.File(ruta);

			if (archivo.exists()) {
				archivo.delete();
			}
		}

		conexion.cerrarConexion();
		if (actualizo) {
			g = 1;
		}
		return g;
	}

	public int eliminarCurso(String idAdministrador) {
		Conexion conexion = new Conexion();
		conexion.setAutoCommitBD(true);
		int g = 0;
		boolean actualizo = false;

		actualizo = conexion.actualizarBD("DELETE FROM cursos WHERE id=" + Integer.parseInt(idAdministrador));

		conexion.cerrarConexion();
		if (actualizo) {
			g = 1;
		}
		return g;
	}

	public int eliminarAdministrador(String idAdministrador) {
		Conexion conexion = new Conexion();
		conexion.setAutoCommitBD(true);
		int g = 0;
		boolean actualizo = false;

		ResultSet rs = conexion.consultarBD("SELECT COUNT(*) FROM administradores");
		int c = 0;
		try {
			while (rs.next()) {
				c = rs.getInt(1);
			}
			rs.close();
		} catch (SQLException e) {
			// e.printStackTrace();
		}

		if (c > 1) {
			actualizo = conexion.actualizarBD("DELETE FROM administradores WHERE id_administrador=" + Integer.parseInt(idAdministrador));
		}

		conexion.cerrarConexion();
		if (actualizo) {
			g = 1;
		}
		return g;
	}

	public int eliminarCertificado(String id) {
		Conexion conexion = new Conexion();
		conexion.setAutoCommitBD(true);
		int g = 0;
		boolean actualizo = false;

		actualizo = conexion.actualizarBD("DELETE FROM certificados WHERE id_certificado=" + Integer.parseInt(id));

		conexion.cerrarConexion();
		if (actualizo) {
			g = 1;
		}
		return g;
	}

	public int eliminarArchivo(String pArchivo, String idFoto, String ruta) {
		Parametro parametro = new Parametro();
		String[] parametros = parametro.getarametros();
		java.io.File directorio = new java.io.File(pArchivo);
		// java.io.File directorio = new java.io.File(parametros[2] + pArchivo);
		// //antes
		directorio.delete();

		Conexion conexion = new Conexion();
		conexion.setAutoCommitBD(true);
		int g = 0;
		boolean actualizo = false;
		actualizo = conexion.actualizarBD("DELETE FROM repositorio_fotos WHERE id_foto=" + Integer.parseInt(idFoto));
		// conexion.commitBD();

		if (actualizo) {
			g = 1;
		}

		List<RepositorioFotos> fotos = new ArrayList<RepositorioFotos>();

		String sentencia = "";

		sentencia = "SELECT rf.fecha_publicacion, rf.direccion_foto, (eg.primer_nombre||' '|| eg.segundo_nombre|| ' '|| eg.primer_apellido|| ' '|| eg.segundo_apellido) AS nombre, id_foto FROM repositorio_fotos rf, egresados eg WHERE rf.id_egresado = eg.id_egresado" + " UNION ALL" + " SELECT rf.fecha_publicacion, rf.direccion_foto, 'ADMINISTRADOR' AS nombre, id_foto FROM repositorio_fotos rf WHERE rf.id_administrador IS NOT NULL AND id_egresado IS NULL";

		RepositorioFotos foto2 = null;
		ResultSet rs = conexion.consultarBD(sentencia);

		try {
			while (rs.next()) {
				foto2 = new RepositorioFotos();
				foto2.setIdFoto(rs.getInt(4));
				foto2.setNombre(rs.getString(3));
				foto2.setFechaPublicacion(rs.getString(1));
				foto2.setDireccionFoto(rs.getString(2));

				fotos.add(foto2);
			}
			rs.close();
		} catch (SQLException e) {
			// e.printStackTrace();
		} finally {

		}

		int cuenta = 0;
		if (fotos != null && fotos.size() > 0) {
			for (RepositorioFotos p : fotos) {
				actualizo = false;
				cuenta++;
				g = cuenta;
				File f1 = new File(ruta + "/cursos/" + p.getDireccionFoto());
				f1.renameTo(new File(ruta + "/cursos/T" + p.getDireccionFoto()));

				if (!f1.exists()) {
					f1 = new File(ruta + "\\cursos\\" + p.getDireccionFoto());
					f1.renameTo(new File(ruta + "\\cursos\\T" + p.getDireccionFoto()));
				}

				actualizo = conexion.actualizarBD("UPDATE repositorio_fotos SET direccion_foto='curso_" + cuenta + ".jpg' WHERE id_foto=" + p.getIdFoto());
			}

			cuenta = 0;
			for (RepositorioFotos p : fotos) {

				cuenta++;

				File f3 = new File(ruta + "/cursos/T" + p.getDireccionFoto());
				f3.renameTo(new File(ruta + "/cursos/curso_" + cuenta + ".jpg"));

				if (!f3.exists()) {
					f3 = new File(ruta + "\\cursos\\T" + p.getDireccionFoto());
					f3.renameTo(new File(ruta + "\\cursos\\curso_" + cuenta + ".jpg"));
				}

			}

		}

		conexion.cerrarConexion();

		return g;
	}

	public List<RepositorioFotos> getRepositorioFotosEliminar(String tipoUsuario, String usuario) {
		List<RepositorioFotos> fotos = new ArrayList<RepositorioFotos>();
		Conexion conexion = new Conexion();
		String sentencia = "";
		if (tipoUsuario.equals("1")) {
			sentencia = "SELECT rf.fecha_publicacion, rf.direccion_foto, (eg.primer_nombre||' '|| eg.segundo_nombre|| ' '|| eg.primer_apellido|| ' '|| eg.segundo_apellido) AS nombre, id_foto FROM repositorio_fotos rf, egresados eg WHERE rf.id_egresado = eg.id_egresado AND eg.id_egresado=" + usuario;
		} else {
			sentencia = "SELECT rf.fecha_publicacion, rf.direccion_foto, (eg.primer_nombre||' '|| eg.segundo_nombre|| ' '|| eg.primer_apellido|| ' '|| eg.segundo_apellido) AS nombre, id_foto FROM repositorio_fotos rf, egresados eg WHERE rf.id_egresado = eg.id_egresado" + " UNION ALL" + " SELECT rf.fecha_publicacion, rf.direccion_foto, 'ADMINISTRADOR' AS nombre, id_foto FROM repositorio_fotos rf WHERE rf.id_administrador IS NOT NULL AND id_egresado IS NULL";
		}
		RepositorioFotos foto = null;
		ResultSet rs = conexion.consultarBD(sentencia);
		int c = 0;
		try {
			while (rs.next()) {
				foto = new RepositorioFotos();
				foto.setIdFoto(rs.getInt(4));
				foto.setNombre(rs.getString(3));
				foto.setFechaPublicacion(rs.getString(1));
				foto.setDireccionFoto(rs.getString(2));
				fotos.add(foto);
			}
			rs.close();
		} catch (SQLException e) {
			// e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}
		return fotos;
	}

	public List<RepositorioFotos> getRepositorioFotos() {
		List<RepositorioFotos> fotos = new ArrayList<RepositorioFotos>();
		Conexion conexion = new Conexion();
		String sentencia = "SELECT rf.fecha_publicacion, rf.direccion_foto, (eg.primer_nombre||' '|| eg.segundo_nombre|| ' '|| eg.primer_apellido|| ' '|| eg.segundo_apellido) AS nombre FROM repositorio_fotos rf, egresados eg WHERE rf.id_egresado = eg.id_egresado" + " UNION ALL" + " SELECT rf.fecha_publicacion, rf.direccion_foto, 'ADMINISTRADOR' AS nombre FROM repositorio_fotos rf WHERE rf.id_administrador IS NOT NULL AND id_egresado IS NULL";
		RepositorioFotos foto = null;
		ResultSet rs = conexion.consultarBD(sentencia);
		int c = 0;
		try {
			while (rs.next()) {
				foto = new RepositorioFotos();
				foto.setNombre(rs.getString(3));
				foto.setFechaPublicacion(rs.getString(1));
				foto.setDireccionFoto(rs.getString(2));
				fotos.add(foto);
			}
			rs.close();
		} catch (SQLException e) {
			// e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}
		return fotos;
	}

	public int guardarArchivoPlano(String usuario, String archivo) {
		Conexion conexion = new Conexion();
		SimpleDateFormat formato = new SimpleDateFormat("yyyy-MM-dd");
		int g = 0;
		boolean actualizo = false;
		actualizo = conexion.actualizarBD("INSERT INTO archivos_planos(archivo, id_administrador, fecha) VALUES('" + archivo + "'," + usuario + ",'" + formato.format(new Date()) + "' )");
		conexion.cerrarConexion();
		if (actualizo) {
			g = 1;
		}
		return g;

	}

	public int guardarRepositorio(String tipoEgresado, String usuario, String foto) {
		Conexion conexion = new Conexion();
		SimpleDateFormat formato = new SimpleDateFormat("yyyy-MM-dd");
		int g = 0;
		boolean actualizo = false;

		actualizo = conexion.actualizarBD("INSERT INTO repositorio_fotos(direccion_foto, id_administrador, fecha_publicacion) VALUES('" + foto + "',1,'" + formato.format(new Date()) + "')");

		if (actualizo) {
			g = 1;
		}

		List<RepositorioFotos> fotos = new ArrayList<RepositorioFotos>();

		String sentencia = "";

		sentencia = "SELECT rf.fecha_publicacion, rf.direccion_foto, (eg.primer_nombre||' '|| eg.segundo_nombre|| ' '|| eg.primer_apellido|| ' '|| eg.segundo_apellido) AS nombre, id_foto FROM repositorio_fotos rf, egresados eg WHERE rf.id_egresado = eg.id_egresado" + " UNION ALL" + " SELECT rf.fecha_publicacion, rf.direccion_foto, 'ADMINISTRADOR' AS nombre, id_foto FROM repositorio_fotos rf WHERE rf.id_administrador IS NOT NULL AND id_egresado IS NULL";

		RepositorioFotos foto2 = null;
		ResultSet rs = conexion.consultarBD(sentencia);

		try {
			while (rs.next()) {
				foto2 = new RepositorioFotos();
				foto2.setIdFoto(rs.getInt(4));
				foto2.setNombre(rs.getString(3));
				foto2.setFechaPublicacion(rs.getString(1));
				foto2.setDireccionFoto(rs.getString(2));
				fotos.add(foto2);
			}
			rs.close();
		} catch (SQLException e) {
			// e.printStackTrace();
		} finally {

		}

		int cuenta = 0;
		if (fotos != null && fotos.size() > 0) {
			for (RepositorioFotos p : fotos) {
				actualizo = false;
				cuenta++;
				g = cuenta;
				actualizo = conexion.actualizarBD("UPDATE repositorio_fotos SET direccion_foto='curso_" + cuenta + ".jpg' WHERE id_foto=" + p.getIdFoto());
			}

		}

		conexion.cerrarConexion();

		return g;

	}

	public int guardarPlanilla2(String[][] datos, int longitud) throws Exception {
		Conexion conexion = new Conexion();

		int g = 0;

		for (int i = 0; i <= datos.length - 1; i++) {
			conexion.actualizarBD("INSERT INTO asistencia(id_tema,fecha, asistio, horas,nombres_otra,documento_otra,comuna_otra,telefono_otra,fundacion_otra) VALUES ('" + datos[i][5] + "','" + datos[i][2] + "','S','" + datos[i][3] + "','" + datos[i][0] + "','" + datos[i][1] + "','" + datos[i][6] + "','" + datos[i][7] + "','" + datos[i][8] + "')");

		}

		g = 1;

		return g;

	}

	public int guardarPlanilla(String[][] datos, int longitud) throws Exception {
		Conexion conexion = new Conexion();

		int g = 0;

		for (int i = 0; i <= datos.length - 1; i++) {
			conexion.actualizarBD("INSERT INTO asistencia(id_mujer_curso,id_tema,fecha, asistio, horas, id_financiador, id_linea) VALUES ('" + datos[i][0] + "','" + datos[i][5] + "','" + datos[i][2] + "','" + datos[i][1] + "','" + datos[i][3] + "','" + datos[i][6] + "','" + datos[i][7] + "')");

		}

		g = 1;

		return g;

	}

	public int guardarCertificado(String[][] datos, int longitud) throws Exception {
		Conexion conexion = new Conexion();

		int g = 0;

		for (int i = 0; i <= longitud - 1; i++) {
			conexion.actualizarBD("INSERT INTO certificados(tipo_documento,documento,ciudad_documento,nombre_completo,fecha_inicio,fecha_fin,fecha_disponibilidad,tipo_certificado,ciudad_depto_curso,numero_horas) VALUES ('" + datos[i][9] + "','" + datos[i][2] + "','" + datos[i][1] + "','" + datos[i][6] + "','" + datos[i][5] + "','" + datos[i][4] + "','" + datos[i][3] + "','" + datos[i][8] + "','" + datos[i][0] + "','" + datos[i][7] + "')");

		}

		g = 1;

		return g;

	}

	public int guardarSeccion(String titulo, String contenido, String foto, String receptor) throws Exception {
		Conexion conexion = new Conexion();
		SimpleDateFormat formato = new SimpleDateFormat("yyyy-MM-dd");
		int g = 0;
		boolean actualizo = false;
		if (foto == null || foto.equals("null")) {
			foto = "";
		}
		actualizo = conexion.actualizarBD("UPDATE secciones SET titulo_seccion = '" + titulo + "',  direccion_foto_seccion = '" + foto + "', fecha = '" + formato.format(new Date()) + "', contenido_seccion ='" + contenido + "' WHERE id_seccion =" + Integer.parseInt(receptor));

		if (actualizo) {
			g = 1;

		}
		return g;

	}

	public int actualizarLineaC(String id, String valor) throws Exception {
		Conexion conexion = new Conexion();
		conexion.setAutoCommitBD(true);
		int g = 0;
		boolean actualizo = false;

		actualizo = conexion.actualizarBD("UPDATE curso_linea SET porcentaje=" + valor + " WHERE id=" + Integer.parseInt(id));

		conexion.cerrarConexion();

		if (actualizo) {
			g = 1;
		}
		return g;

	}

	public int actualizarFinanciadorC(String id, String valor) throws Exception {
		Conexion conexion = new Conexion();
		conexion.setAutoCommitBD(true);
		int g = 0;
		boolean actualizo = false;

		actualizo = conexion.actualizarBD("UPDATE curso_financiador SET porcentaje=" + valor + " WHERE id=" + Integer.parseInt(id));

		conexion.cerrarConexion();

		if (actualizo) {
			g = 1;
		}
		return g;

	}

	public int actualizarParametro(String id, String titulo, String valor) throws Exception {
		Conexion conexion = new Conexion();

		int g = 0;
		String[] campos = { "titulo", "valor" };
		String[] valores = new String[2];
		String[][] condiciones = new String[1][2];

		valores[0] = titulo;
		valores[1] = valor;

		condiciones[0][0] = "id";
		condiciones[0][1] = "" + id;

		boolean bandera = conexion.actualizarBD2("parametros_globales", campos, valores, condiciones);
		if (bandera) {
			g = 1;
		}

		return g;

	}

	public int eliminarParametro(String id) {
		Conexion conexion = new Conexion();
		conexion.setAutoCommitBD(true);
		int g = 0;
		boolean actualizo = false;

		actualizo = conexion.actualizarBD("DELETE FROM parametros_globales WHERE id=" + Integer.parseInt(id));

		conexion.cerrarConexion();

		if (actualizo) {
			g = 1;
		}
		return g;
	}

	public int crearParametro(String titulo, String valor) {
		Conexion conexion = new Conexion();
		int exito = 0;
		try {

			boolean actualizo = conexion.actualizarBD("INSERT INTO parametros_globales(titulo,valor) VALUES('" + titulo.trim() + "','" + valor.trim() + "')");

			if (actualizo) {
				exito = 1;
			}

		} catch (Exception ee) {
			// ee
		} finally {
			conexion.cerrarConexion();
		}

		return exito;

	}
	
	public String getIdioma() {
		String idioma = "";
		Conexion conexion = new Conexion();
		String sentencia = " SELECT valor FROM parametros_globales WHERE id = 24";

		ResultSet rs = conexion.consultarBD(sentencia);

		try {
			if (rs.next()) {
				idioma = rs.getString(1);
			}
			rs.close();
		} catch (SQLException e) {
			// e
		} finally {
			conexion.cerrarConexion();
		}
		return idioma;
	}
	

	public List<Object[]> getParametrosGlobales() {
		List<Object[]> parametros = new ArrayList<Object[]>();
		Conexion conexion = new Conexion();
		String sentencia = " SELECT * FROM parametros_globales ORDER BY titulo, valor, id";

		Object[] parametro = null;
		ResultSet rs = conexion.consultarBD(sentencia);

		try {
			while (rs.next()) {
				parametro = new Object[3];
				parametro[0] = rs.getObject(1);
				parametro[1] = rs.getObject(2);
				parametro[2] = rs.getObject(3);

				parametros.add(parametro);

			}
			rs.close();
		} catch (SQLException e) {
			// e
		} finally {
			conexion.cerrarConexion();
		}
		return parametros;
	}

	public int actualizarHojaVida(String[] valores, String id) throws Exception {
		String[][] condiciones = new String[1][2];

		Conexion conexion = new Conexion();
		int g = 0;
		boolean actualizo = false;

		condiciones[0][0] = "id_mujer";
		condiciones[0][1] = id;

		String[] campos = {

				"primer_nombre", "segundo_nombre", "primer_apellido", "segundo_apellido", "documento", "fecha_nacimiento", "estado_civil", "correo", "sexo", "hijas", "hijos", "direccion", "telefonos", "tipo_sitio", "id_comuna", "id_barrio", "inscrita", "id_corregimiento", "id_vereda"

		};

		actualizo = conexion.actualizarBD2("mujeres", campos, valores, condiciones);

		if (actualizo) {
			g = 1;

		}
		return g;

	}

	public int actualizarHojaVida2(Object[] valores, String id) throws Exception {
		Conexion conexion = new Conexion();

		int g = 0;
		boolean actualizo = false;

		String[] campos = {

				// "primer_nombre", "segundo_nombre", "primer_apellido",
				// "segundo_apellido", "documento", "fecha_nacimiento",
				// "estado_civil", "correo", "sexo", "hijas", "hijos",
				// "direccion", "telefonos", "tipo_sitio", "nombre_comuna",
				// "numero_comuna", "nivel_educativo", "actividad_economica",
				// "participa_organizacion", "organizaciones", "anos_liderazgo",
				// "meses_liderazgo", "institucion_capacitacion_1",
				// "nivel_capacitacion_1", "institucion_capacitacion_2",
				// "nivel_capacitacion_2", "institucion_capacitacion_3",
				// "nivel_capacitacion_3", "institucion_capacitacion_4",
				// "nivel_capacitacion_4", "institucion_capacitacion_5",
				// "nivel_capacitacion_5", "capacitacion_6",
				// "institucion_capacitacion_6", "nivel_capacitacion_6",
				// "observaciones"
				"primer_nombre", "segundo_nombre", "primer_apellido", "segundo_apellido", "documento", "fecha_nacimiento", "estado_civil", "correo", "sexo", "hijas", "hijos", "direccion", "telefonos", "tipo_sitio", "id_comuna", "id_barrio", "inscrita", "id_corregimiento", "id_vereda"

		};

		String[] campos2 = {

				// "primer_nombre", "segundo_nombre", "primer_apellido",
				// "segundo_apellido", "documento", "fecha_nacimiento",
				// "estado_civil", "correo", "sexo", "hijas", "hijos",
				// "direccion", "telefonos", "tipo_sitio", "nombre_comuna",
				// "numero_comuna", "nivel_educativo", "actividad_economica",
				// "participa_organizacion", "organizaciones", "anos_liderazgo",
				// "meses_liderazgo", "institucion_capacitacion_1",
				// "nivel_capacitacion_1", "institucion_capacitacion_2",
				// "nivel_capacitacion_2", "institucion_capacitacion_3",
				// "nivel_capacitacion_3", "institucion_capacitacion_4",
				// "nivel_capacitacion_4", "institucion_capacitacion_5",
				// "nivel_capacitacion_5", "capacitacion_6",
				// "institucion_capacitacion_6", "nivel_capacitacion_6",
				// "observaciones"
				"primer_nombre", "segundo_nombre", "primer_apellido", "segundo_apellido", "documento", "fecha_nacimiento", "estado_civil", "correo", "sexo", "hijas", "hijos", "direccion", "telefonos", "tipo_sitio", "id_corregimiento", "id_vereda", "inscrita", "id_comuna", "id_barrio"

		};

		String[][] condiciones = new String[1][2];
		condiciones[0][0] = "id";
		condiciones[0][1] = "" + id;

		if (valores != null && ("" + valores[13]).equals("C")) {
			actualizo = conexion.actualizarBD2("mujeres", campos, valores, condiciones);

		} else {
			actualizo = conexion.actualizarBD2("mujeres", campos2, valores, condiciones);
		}

		if (actualizo) {
			g = 1;

		}
		return g;

	}

	public int guardarHojaVida(Object[] valores) throws Exception {
		Conexion conexion = new Conexion();

		int g = 0;
		boolean actualizo = false;

		String[] campos = {

				// "primer_nombre", "segundo_nombre", "primer_apellido",
				// "segundo_apellido", "documento", "fecha_nacimiento",
				// "estado_civil", "correo", "sexo", "hijas", "hijos",
				// "direccion", "telefonos", "tipo_sitio", "nombre_comuna",
				// "numero_comuna", "nivel_educativo", "actividad_economica",
				// "participa_organizacion", "organizaciones", "anos_liderazgo",
				// "meses_liderazgo", "institucion_capacitacion_1",
				// "nivel_capacitacion_1", "institucion_capacitacion_2",
				// "nivel_capacitacion_2", "institucion_capacitacion_3",
				// "nivel_capacitacion_3", "institucion_capacitacion_4",
				// "nivel_capacitacion_4", "institucion_capacitacion_5",
				// "nivel_capacitacion_5", "capacitacion_6",
				// "institucion_capacitacion_6", "nivel_capacitacion_6",
				// "observaciones"
				"primer_nombre", "segundo_nombre", "primer_apellido", "segundo_apellido", "documento", "fecha_nacimiento", "estado_civil", "correo", "sexo", "hijas", "hijos", "direccion", "telefonos", "tipo_sitio", "id_comuna", "id_barrio", "inscrita"

		};

		String[] campos2 = {

				// "primer_nombre", "segundo_nombre", "primer_apellido",
				// "segundo_apellido", "documento", "fecha_nacimiento",
				// "estado_civil", "correo", "sexo", "hijas", "hijos",
				// "direccion", "telefonos", "tipo_sitio", "nombre_comuna",
				// "numero_comuna", "nivel_educativo", "actividad_economica",
				// "participa_organizacion", "organizaciones", "anos_liderazgo",
				// "meses_liderazgo", "institucion_capacitacion_1",
				// "nivel_capacitacion_1", "institucion_capacitacion_2",
				// "nivel_capacitacion_2", "institucion_capacitacion_3",
				// "nivel_capacitacion_3", "institucion_capacitacion_4",
				// "nivel_capacitacion_4", "institucion_capacitacion_5",
				// "nivel_capacitacion_5", "capacitacion_6",
				// "institucion_capacitacion_6", "nivel_capacitacion_6",
				// "observaciones"
				"primer_nombre", "segundo_nombre", "primer_apellido", "segundo_apellido", "documento", "fecha_nacimiento", "estado_civil", "correo", "sexo", "hijas", "hijos", "direccion", "telefonos", "tipo_sitio", "id_corregimiento", "id_vereda", "inscrita"

		};

		if (valores != null && ("" + valores[13]).equals("C")) {
			actualizo = conexion.insertarBD2("mujeres", campos, valores);

		} else {
			actualizo = conexion.insertarBD2("mujeres", campos2, valores);
		}

		if (actualizo) {
			g = 1;

		}
		return g;

	}

	public int guardarPublicacion(int tipoUsuario, int administrador, int egresado, int privacidad, String titulo, String contenido, String foto, String receptor) throws Exception {
		Conexion conexion = new Conexion();
		SimpleDateFormat formato = new SimpleDateFormat("yyyy-MM-dd");
		int g = 0;
		boolean actualizo = false;
		if (receptor.equals("0")) {
			receptor = null;
		}

		Object[] objeto = new Object[7];

		objeto[0] = administrador;
		objeto[1] = privacidad;
		titulo = titulo.replace("“", "\'");
		titulo = titulo.replace("”", "\'");
		objeto[2] = titulo;
		contenido = contenido.replace("“", "\'");
		contenido = contenido.replace("”", "\'");
		objeto[3] = contenido;
		objeto[4] = foto;
		objeto[5] = receptor;
		objeto[6] = formato.format(new Date());

		String[] campos = { "id_administrador", "privacidad_publicacion", "titulo_publicacion", "contenido_publicacion", "direccion_foto_publicacion", "receptor", "fecha" };

		actualizo = conexion.insertarBD2("publicaciones", campos, objeto);

		if (actualizo) {
			g = 1;

		}
		return g;

	}

	public int eliminarPublicacion(int aIdPublicacion) {
		Conexion conexion = new Conexion();
		boolean actualizo = false;
		int g = 0;
		actualizo = conexion.actualizarBD("DELETE FROM publicaciones WHERE id_publicacion='" + aIdPublicacion + "'");

		conexion.cerrarConexion();
		if (actualizo) {
			g = 1;
		}
		return g;

	}

	public List<Publicacion> getPublicaciones(int aEgresado) {
		List<Publicacion> publicaciones = new ArrayList<Publicacion>();
		Conexion conexion = new Conexion();
		String sentencia = "SELECT pu.id_publicacion, pu.id_egresado, id_administrador, (eg.primer_nombre||' '|| eg.segundo_nombre|| ' '|| eg.primer_apellido|| ' '|| eg.segundo_apellido) AS nombre, fecha, titulo_publicacion, contenido_publicacion, direccion_foto_publicacion, privacidad_publicacion  FROM publicaciones pu LEFT JOIN egresados eg  ON  pu.id_egresado = eg.id_egresado WHERE privacidad_publicacion = 1 UNION ALL" + " SELECT pu.id_publicacion, pu.id_egresado, id_administrador, (eg.primer_nombre||' '|| eg.segundo_nombre|| ' '|| eg.primer_apellido|| ' '|| eg.segundo_apellido) AS nombre, fecha, titulo_publicacion, contenido_publicacion, direccion_foto_publicacion, privacidad_publicacion FROM publicaciones pu, egresados eg WHERE privacidad_publicacion =3 AND receptor = " + aEgresado + " AND pu.id_egresado = eg.id_egresado" + " ORDER BY fecha DESC, id_publicacion DESC FIRST 10";
		Publicacion publicacion = null;
		ResultSet rs = conexion.consultarBD(sentencia);
		int c = 0;
		try {
			while (rs.next()) {
				publicacion = new Publicacion();
				publicacion.setIdPublicacion(rs.getInt(1));
				publicacion.setIdEgresado(rs.getInt(2));
				publicacion.setIdAdministrador(rs.getInt(3));
				publicacion.setNombre(rs.getString(4));
				publicacion.setFecha(rs.getString(5));
				publicacion.setTituloPublicacion(rs.getString(6));
				publicacion.setContenidoPublicacion(rs.getString(7));

				publicacion.setPrivacidadPublicacion(rs.getInt(9));

				if (rs.getString(8) == null || rs.getString(8).trim().equals("")) {
					c++;
					// publicacion.setDireccionFotoPublicacion("sinImagen" + c +
					// ".jpg");
				} else {
					publicacion.setDireccionFotoPublicacion(rs.getString(8));
				}

				if (c == 4) {
					c = 0;
				}

				if (publicacion.getIdAdministrador() != 0) {
					publicacion.setNombre("Administrador");

				}

				publicaciones.add(publicacion);
			}
			rs.close();
		} catch (SQLException e) {
			// e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}
		return publicaciones;
	}

	public List<Publicacion> getPublicacionesEgresado(int aEgresado, int tipoUsuario) {
		List<Publicacion> publicaciones = new ArrayList<Publicacion>();
		Conexion conexion = new Conexion();
		String sentencia = "";
		if (tipoUsuario == 2) {
			sentencia = "SELECT pu.id_publicacion, pu.id_egresado, id_administrador, (eg.primer_nombre||' '|| eg.segundo_nombre|| ' '|| eg.primer_apellido|| ' '|| eg.segundo_apellido) AS nombre, fecha, titulo_publicacion, contenido_publicacion, direccion_foto_publicacion, privacidad_publicacion  FROM publicaciones pu, egresados eg  WHERE  pu.id_egresado = eg.id_egresado AND (receptor IS NULL OR receptor = 0) ORDER BY fecha DESC, id_publicacion DESC";
		} else {
			sentencia = "SELECT pu.id_publicacion, pu.id_egresado, id_administrador, (eg.primer_nombre||' '|| eg.segundo_nombre|| ' '|| eg.primer_apellido|| ' '|| eg.segundo_apellido) AS nombre, fecha, titulo_publicacion, contenido_publicacion, direccion_foto_publicacion, privacidad_publicacion  FROM publicaciones pu, egresados eg  WHERE  pu.id_egresado = eg.id_egresado AND eg.id_egresado=" + aEgresado + " ORDER BY fecha DESC, id_publicacion DESC FIRST 10";
		}
		Publicacion publicacion = null;
		ResultSet rs = conexion.consultarBD(sentencia);
		int c = 0;
		try {
			while (rs.next()) {
				publicacion = new Publicacion();
				publicacion.setIdPublicacion(rs.getInt(1));
				publicacion.setIdEgresado(rs.getInt(2));
				publicacion.setIdAdministrador(rs.getInt(3));
				publicacion.setNombre(rs.getString(4));
				publicacion.setFecha(rs.getString(5));
				publicacion.setTituloPublicacion(rs.getString(6));
				publicacion.setContenidoPublicacion(rs.getString(7));

				publicacion.setPrivacidadPublicacion(rs.getInt(9));

				if (rs.getString(8) == null || rs.getString(8).trim().equals("")) {
					c++;
					// publicacion.setDireccionFotoPublicacion("sinImagen" + c +
					// ".jpg");
				} else {
					publicacion.setDireccionFotoPublicacion(rs.getString(8));
				}

				if (c == 4) {
					c = 0;
				}

				publicaciones.add(publicacion);
			}
			rs.close();
		} catch (SQLException e) {
			// e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}
		return publicaciones;
	}

	public Publicacion getNotaPublica(int id) {
		Conexion conexion = new Conexion();
		String sentencia = "SELECT pu.id_publicacion, pu.id_egresado, id_administrador, (eg.primer_nombre||' '|| eg.segundo_nombre|| ' '|| eg.primer_apellido|| ' '|| eg.segundo_apellido) AS nombre, fecha, titulo_publicacion, contenido_publicacion, direccion_foto_publicacion, privacidad_publicacion  FROM publicaciones pu LEFT JOIN egresados eg ON pu.id_egresado = eg.id_egresado WHERE privacidad_publicacion = 2 AND pu.id_publicacion=" + id;
		Publicacion publicacion = new Publicacion();
		ResultSet rs = conexion.consultarBD(sentencia);
		int c = 0;
		try {
			if (rs.next()) {
				publicacion = new Publicacion();
				publicacion.setIdPublicacion(rs.getInt(1));
				publicacion.setIdEgresado(rs.getInt(2));
				publicacion.setIdAdministrador(rs.getInt(3));
				publicacion.setNombre(rs.getString(4));
				publicacion.setFecha(rs.getString(5));
				publicacion.setTituloPublicacion(rs.getString(6));
				publicacion.setContenidoPublicacion(rs.getString(7));

				publicacion.setPrivacidadPublicacion(rs.getInt(9));

				if (rs.getString(8) == null || rs.getString(8).trim().equals("")) {
					c++;
					// publicacion.setDireccionFotoPublicacion("sinImagen" + c +
					// ".jpg");
				} else {
					publicacion.setDireccionFotoPublicacion(rs.getString(8));
				}

				if (c == 4) {
					c = 0;
				}

				if (publicacion.getIdAdministrador() != 0) {
					publicacion.setNombre("Administrador");
				}

			}
			rs.close();
		} catch (SQLException e) {
			// e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}
		return publicacion;
	}

	public String getTextoCortado(String aTexto) {
		String texto = "";
		int longitud = 220;
		if (aTexto != null) {
			if (aTexto.trim().length() >= longitud) {
				String[] vector = aTexto.split("");
				for (int i = 0; i < longitud; i++) {
					texto += vector[i];
				}
				texto += " ...";
			} else {
				texto = aTexto.trim();
			}
		}

		return texto;

	}

	public Seccion getSeccion(int id) {

		Conexion conexion = new Conexion();
		String sentencia = "SELECT * FROM secciones s WHERE s.id_seccion=" + id;

		Seccion seccion = null;
		ResultSet rs = conexion.consultarBD(sentencia);

		try {
			if (rs.next()) {
				seccion = new Seccion();
				seccion.setSeccion(rs.getInt(1));

				seccion.setTitulo(rs.getString(2));
				seccion.setContenido(rs.getString(3));

				if (rs.getString(4) == null || rs.getString(4).trim().equals("")) {

				} else {
					seccion.setDireccionFoto(rs.getString(4));
				}
				seccion.setFecha(rs.getString(5));

			}
			rs.close();
		} catch (SQLException e) {
			// e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}
		return seccion;
	}

	public List<Seccion> getSecciones() {
		List<Seccion> secciones = new ArrayList<Seccion>();
		Conexion conexion = new Conexion();
		String sentencia = "SELECT * FROM secciones s ORDER BY s.id_seccion";

		Seccion seccion = null;
		ResultSet rs = conexion.consultarBD(sentencia);

		try {
			while (rs.next()) {
				seccion = new Seccion();
				seccion.setSeccion(rs.getInt(1));

				seccion.setTitulo(rs.getString(2));
				seccion.setContenido(rs.getString(3));

				if (rs.getString(4) == null || rs.getString(4).trim().equals("")) {

				} else {
					seccion.setDireccionFoto(rs.getString(4));
				}
				seccion.setFecha(rs.getString(5));

				secciones.add(seccion);

			}
			rs.close();
		} catch (SQLException e) {
			// e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}
		return secciones;
	}

	public List<Publicacion> getNotasPublicas() {
		List<Publicacion> publicaciones = new ArrayList<Publicacion>();
		Conexion conexion = new Conexion();
		String sentencia = "SELECT pu.id_publicacion, pu.id_egresado, id_administrador, (eg.primer_nombre||' '|| eg.segundo_nombre|| ' '|| eg.primer_apellido|| ' '|| eg.segundo_apellido) AS nombre, fecha, titulo_publicacion, contenido_publicacion, direccion_foto_publicacion, privacidad_publicacion  FROM publicaciones pu LEFT JOIN egresados eg ON pu.id_egresado = eg.id_egresado WHERE privacidad_publicacion = 2 ORDER BY fecha DESC, id_publicacion DESC";
		// " DESC, id_publicacion DESC";
		Publicacion publicacion = null;
		ResultSet rs = conexion.consultarBD(sentencia);
		int c = 0;
		try {
			while (rs.next()) {
				publicacion = new Publicacion();
				publicacion.setIdPublicacion(rs.getInt(1));
				publicacion.setIdEgresado(rs.getInt(2));
				publicacion.setIdAdministrador(rs.getInt(3));
				publicacion.setNombre(rs.getString(4));
				publicacion.setFecha(rs.getString(5));
				publicacion.setTituloPublicacion(rs.getString(6));
				publicacion.setContenidoPublicacion(rs.getString(7));

				publicacion.setPrivacidadPublicacion(rs.getInt(9));

				if (rs.getString(8) == null || rs.getString(8).trim().equals("")) {
					c++;
					// publicacion.setDireccionFotoPublicacion("sinImagen" + c +
					// ".jpg");
				} else {
					publicacion.setDireccionFotoPublicacion(rs.getString(8));
				}

				if (c == 4) {
					c = 0;
				}

				if (publicacion.getIdAdministrador() != 0) {
					publicacion.setNombre("Administrador");
				}

				publicaciones.add(publicacion);

			}
			rs.close();
		} catch (SQLException e) {
			// e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}
		return publicaciones;
	}

	public List<ArchivoPlano> getArchivosPlanos() {
		List<ArchivoPlano> archivos = new ArrayList<ArchivoPlano>();
		Conexion conexion = new Conexion();
		String sentencia = "SELECT *  FROM archivos_planos a ORDER BY a.fecha DESC, a.id_archivo DESC";
		ArchivoPlano archivo = null;
		ResultSet rs = conexion.consultarBD(sentencia);
		try {
			while (rs.next()) {
				archivo = new ArchivoPlano();
				archivo.setIdArchivo(rs.getInt(1));
				archivo.setArchivo(rs.getString(2));
				archivo.setFecha(rs.getString(3));
				archivos.add(archivo);
			}
			rs.close();
		} catch (SQLException e) {
			// e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}
		return archivos;
	}

	public List<Portafolio> getPortafolios() {
		List<Portafolio> portafolios = new ArrayList<Portafolio>();
		Conexion conexion = new Conexion();
		String sentencia = "SELECT * FROM portafolio a ORDER BY id_portafolio DESC";
		Portafolio portafolio = null;
		ResultSet rs = conexion.consultarBD(sentencia);
		try {
			while (rs.next()) {
				portafolio = new Portafolio();
				portafolio.setIdPortafolio(rs.getInt("id_portafolio"));
				portafolio.setTitulo(rs.getString("titulo_portafolio"));
				portafolio.setContenido(rs.getString("contenido_portafolio"));

				portafolios.add(portafolio);
			}
			rs.close();
		} catch (SQLException e) {
			// e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}
		return portafolios;
	}

	public List<Certificado> getTiposCertificados() {
		List<Certificado> tipos = new ArrayList<Certificado>();
		Conexion conexion = new Conexion();
		String sentencia = "SELECT * FROM tipo_certificacion a ORDER BY nombre_certificacion";
		Certificado tipo = null;
		ResultSet rs = conexion.consultarBD(sentencia);
		try {
			while (rs.next()) {
				tipo = new Certificado();
				tipo.setId(rs.getInt("id"));
				tipo.setNombre(rs.getString("nombre_certificacion"));

				tipos.add(tipo);
			}
			rs.close();
		} catch (SQLException e) {
			// e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}
		return tipos;
	}

	public List<Object[]> getMujeresS(String pn, String sn, String pa, String sa, String doc, String c14, String c15, String c16) {

		Conexion conexion = new Conexion();
		String sentencia = "SELECT * FROM mujeres WHERE 1=1 ";

		if (pn != null && !pn.trim().equals("")) {

			sentencia += " AND UPPER(primer_nombre) LIKE '%" + pn.toUpperCase().trim() + "%'";

		}
		if (sn != null && !sn.trim().equals("")) {

			sentencia += " AND UPPER(segundo_nombre) LIKE '%" + sn.toUpperCase().trim() + "%'";

		}

		if (pa != null && !pa.trim().equals("")) {

			sentencia += " AND UPPER(primer_apellido) LIKE '%" + pn.toUpperCase().trim() + "%'";

		}

		if (sa != null && !sa.trim().equals("")) {

			sentencia += " AND UPPER(segundo_apellido) LIKE '%" + sn.toUpperCase().trim() + "%'";

		}

		if (doc != null && !doc.trim().equals("")) {

			sentencia += " AND documento = " + doc;

		}

		if (c14 != null && !c14.trim().equals("")) {
			if (c14.equals("C")) {
				sentencia += " AND id_comuna IS NOT NULL";
			}
			if (c14.equals("CO")) {
				sentencia += " AND id_corregimiento IS NOT NULL ";
			}

			if (c15 != null && !c15.trim().equals("")) {

				if (c14.equals("C")) {
					sentencia += " AND id_comuna =" + c15;
				}
				if (c14.equals("CO")) {
					sentencia += " AND id_corregimiento= " + c15;
				}

			}

			if (c16 != null && !c16.trim().equals("")) {
				if (c14.equals("C")) {
					sentencia += " AND id_barrio =" + c16;
				}
				if (c14.equals("CO")) {
					sentencia += " AND id_vereda= " + c16;
				}
			}

		}

		sentencia += " ORDER BY primer_nombre, segundo_nombre, primer_apellido, segundo_apellido";

		List<Object[]> mujeres = new ArrayList<Object[]>();
		Object[] mujer = null;
		ResultSet rs = conexion.consultarBD(sentencia);
		try {
			while (rs.next()) {
				mujer = new Object[numeroColumnasMujeres];
				for (int i = 0; i <= numeroColumnasMujeres - 1; i++) {

					mujer[i] = rs.getObject(i + 1);

				}
				mujeres.add(mujer);
			}
			rs.close();
		} catch (SQLException e) {
			// e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}
		return mujeres;
	}

	public Object[] getMujerDoc(String doc) {

		Conexion conexion = new Conexion();
		String sentencia = "SELECT * FROM mujeres a WHERE documento=" + doc + " ORDER BY primer_nombre, segundo_nombre, primer_apellido, segundo_apellido";
		Object[] mujer = null;
		ResultSet rs = conexion.consultarBD(sentencia);
		try {
			while (rs.next()) {
				mujer = new Object[numeroColumnasMujeres];
				for (int i = 0; i <= numeroColumnasMujeres - 1; i++) {

					mujer[i] = rs.getObject(i + 1);
				}

			}
			rs.close();
		} catch (SQLException e) {
			// e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}
		return mujer;
	}

	public Object[] getMujer(String id) {

		Conexion conexion = new Conexion();
		String sentencia = "SELECT * FROM mujeres a WHERE id_mujer=" + id + " ORDER BY primer_nombre, segundo_nombre, primer_apellido, segundo_apellido";
		Object[] mujer = null;
		ResultSet rs = conexion.consultarBD(sentencia);
		try {
			while (rs.next()) {
				mujer = new Object[numeroColumnasMujeres];
				for (int i = 0; i <= numeroColumnasMujeres - 1; i++) {

					mujer[i] = rs.getObject(i + 1);
				}

			}
			rs.close();
		} catch (SQLException e) {
			// e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}
		return mujer;
	}

	public List<Object[]> getMujeresAsistenciaResultado(String curso, String tema, String fechaDesde, String fechaHasta, String tipo, String asisitio, String proyecto, String linea, String financiador, String id_mujer, String c14, String c15, String c16) {

		List<Object[]> mujeres = new ArrayList<Object[]>();
		Conexion conexion = new Conexion();
		String sentencia = " SELECT SUM(a.horas), c.id, c.nombre, mu.id_mujer" + " FROM asistencia a" + " LEFT JOIN mujeres_curso m ON a.id_mujer_curso = m.id" + " LEFT JOIN mujeres mu ON m.id_mujer = mu.id_mujer " + " INNER JOIN temas t ON t.id = a.id_tema " + " INNER JOIN cursos c ON c.id = t.id_curso " + " INNER JOIN proyectos p ON c.id_proyecto = p.id" + " INNER JOIN curso_linea cl ON a.id_linea = cl.id " + " INNER JOIN curso_financiador cf ON a.id_financiador = cf.id" + " INNER JOIN lineas l ON cl.id_linea = l.id " + " INNER JOIN financiadores f ON cf.id_financiador = f.id" + " WHERE mu.id_mujer =  " + id_mujer;

		if (fechaDesde != null && !fechaDesde.trim().equals("")) {

			sentencia += " AND a.fecha >= '" + fechaDesde + "'";

		}

		if (fechaHasta != null && !fechaHasta.trim().equals("")) {

			sentencia += " AND a.fecha <= '" + fechaHasta + "'";
		}

		if (curso != null && !curso.trim().equals("")) {

			sentencia += " AND t.id_curso = '" + curso + "'";
		}

		if (tema != null && !tema.trim().equals("")) {

			sentencia += " AND t.id = '" + tema + "'";
		}

		if (proyecto != null && !proyecto.trim().equals("")) {

			sentencia += " AND p.id = '" + proyecto + "'";
		}

		if (linea != null && !linea.trim().equals("")) {

			sentencia += " AND l.id = '" + linea + "'";
		}

		if (financiador != null && !financiador.trim().equals("")) {

			sentencia += " AND f.id = '" + financiador + "'";
		}

		sentencia += " AND a.asistio = 'S'";
		
		
		if (c14 != null && !c14.trim().equals("")) {
			if (c14.equals("C")) {
				sentencia += " AND mu.id_comuna IS NOT NULL";
			}
			if (c14.equals("CO")) {
				sentencia += " AND mu.id_corregimiento IS NOT NULL ";
			}

			if (c15 != null && !c15.trim().equals("")) {

				if (c14.equals("C")) {
					sentencia += " AND mu.id_comuna =" + c15;
				}
				if (c14.equals("CO")) {
					sentencia += " AND mu.id_corregimiento= " + c15;
				}

			}

			if (c16 != null && !c16.trim().equals("")) {
				if (c14.equals("C")) {
					sentencia += " AND mu.id_barrio =" + c16;
				}
				if (c14.equals("CO")) {
					sentencia += " AND mu.id_vereda= " + c16;
				}
			}

		}

		sentencia += " GROUP BY  c.id, c.nombre, mu.id_mujer ";

		Object[] mujer = null;
		ResultSet rs = conexion.consultarBD(sentencia);
		try {
			while (rs.next()) {
				mujer = new Object[4];
				mujer[0] = rs.getObject(1);
				mujer[1] = rs.getObject(2);
				mujer[2] = rs.getObject(3);
				mujer[3] = rs.getObject(4);

				mujeres.add(mujer);
			}
			rs.close();
		} catch (SQLException e) {
			// e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}
		return mujeres;
	}

	public List<Object[]> getMujeresAsistencia3(String curso, String tema, String fechaDesde, String fechaHasta, String tipo, String asisitio, String proyecto, String linea, String financiador, String documento, String c14, String c15, String c16) {

		List<Object[]> mujeres = new ArrayList<Object[]>();
		Conexion conexion = new Conexion();
		String sentencia = " SELECT a.id, a.id_mujer_curso, a.asistio, a.fecha, a.horas, mu.primer_nombre, mu.segundo_nombre, mu.primer_apellido, mu.segundo_apellido, mu.documento, mu.telefonos, t.nombre nombre_tema, c.nombre nombre_curso, p.nombre proyecto, l.nombre linea, f.nombre financiador, mu.inscrita, mu.id_comuna, mu.id_corregimiento, mu.id_barrio, mu.id_vereda " + " FROM asistencia a" + " LEFT JOIN mujeres_curso m ON a.id_mujer_curso = m.id" + " LEFT JOIN mujeres mu ON m.id_mujer = mu.id_mujer " + " INNER JOIN temas t ON t.id = a.id_tema " + " INNER JOIN cursos c ON c.id = t.id_curso " + " INNER JOIN proyectos p ON c.id_proyecto = p.id " + " INNER JOIN curso_linea cl ON a.id_linea = cl.id " + " INNER JOIN curso_financiador cf ON a.id_financiador = cf.id " + " INNER JOIN lineas l ON cl.id_linea = l.id " + " INNER JOIN financiadores f ON cf.id_financiador = f.id " + " WHERE 1=1";

		if (tipo != null && tipo.equals("1")) {

			sentencia += " AND mu.inscrita = 'S'";

		} else if (tipo != null && tipo.equals("2")) {

			sentencia += " AND mu.inscrita = 'N'";

		}

		if (fechaDesde != null && !fechaDesde.trim().equals("")) {

			sentencia += " AND a.fecha >= '" + fechaDesde + "'";

		}

		if (fechaHasta != null && !fechaHasta.trim().equals("")) {

			sentencia += " AND a.fecha <= '" + fechaHasta + "'";
		}

		if (curso != null && !curso.trim().equals("")) {

			sentencia += " AND t.id_curso = '" + curso + "'";
		}

		if (tema != null && !tema.trim().equals("")) {

			sentencia += " AND t.id = '" + tema + "'";
		}

		if (proyecto != null && !proyecto.trim().equals("")) {

			sentencia += " AND p.id = '" + proyecto + "'";
		}

		if (linea != null && !linea.trim().equals("")) {

			sentencia += " AND l.id = '" + linea + "'";
		}

		if (financiador != null && !financiador.trim().equals("")) {

			sentencia += " AND f.id = '" + financiador + "'";
		}

		if (documento != null && !documento.trim().equals("")) {

			sentencia += " AND (mu.documento = '" + documento + "')";
		}

		if (asisitio != null && !asisitio.trim().equals("0")) {

			sentencia += " AND a.asistio = '" + asisitio + "'";
		}
		
		
		if (c14 != null && !c14.trim().equals("")) {
			if (c14.equals("C")) {
				sentencia += " AND mu.id_comuna IS NOT NULL";
			}
			if (c14.equals("CO")) {
				sentencia += " AND mu.id_corregimiento IS NOT NULL ";
			}

			if (c15 != null && !c15.trim().equals("")) {

				if (c14.equals("C")) {
					sentencia += " AND mu.id_comuna =" + c15;
				}
				if (c14.equals("CO")) {
					sentencia += " AND mu.id_corregimiento= " + c15;
				}

			}

			if (c16 != null && !c16.trim().equals("")) {
				if (c14.equals("C")) {
					sentencia += " AND mu.id_barrio =" + c16;
				}
				if (c14.equals("CO")) {
					sentencia += " AND mu.id_vereda= " + c16;
				}
			}

		}
		
		

		sentencia += " ORDER BY a.fecha DESC, c.nombre, t.nombre, p.nombre, l.nombre, f.nombre, mu.primer_nombre, mu.segundo_nombre, mu.primer_apellido, mu.segundo_apellido";

		Object[] mujer = null;
		ResultSet rs = conexion.consultarBD(sentencia);
		try {
			while (rs.next()) {
				mujer = new Object[23];
				mujer[0] = rs.getObject(1);
				mujer[9] = rs.getObject("id_mujer_curso");

				mujer[1] = rs.getObject("primer_nombre");
				mujer[2] = rs.getObject("segundo_nombre");
				mujer[3] = rs.getObject("primer_apellido");
				mujer[4] = rs.getObject("segundo_apellido");
				mujer[5] = rs.getObject("documento");
				mujer[6] = "";// rs.getObject("nombre_comuna");
				mujer[7] = "";// rs.getObject("numero_comuna");
				mujer[8] = rs.getObject("telefonos");
				// mujer[9] = rs.getObject("inscrita");
				mujer[10] = rs.getObject("inscrita");

				mujer[11] = rs.getObject("asistio");

				if (mujer[11] != null && mujer[11].equals("S")) {
					mujer[11] = "Si";
				} else {
					mujer[11] = "No";
				}

				mujer[12] = rs.getObject("nombre_tema");
				mujer[13] = rs.getObject("nombre_curso");
				mujer[14] = rs.getObject("fecha");
				mujer[15] = rs.getObject("horas");

				mujer[16] = rs.getObject("proyecto");
				mujer[17] = rs.getObject("linea");
				mujer[18] = rs.getObject("financiador");
				// mujer[18] = sentencia;
				
				mujer[19] = rs.getObject("id_comuna");
				mujer[20] = rs.getObject("id_corregimiento");
				mujer[21] = rs.getObject("id_barrio");
				mujer[22] = rs.getObject("id_vereda");
				
				

				mujeres.add(mujer);
			}
			rs.close();
		} catch (SQLException e) {
			// e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}
		return mujeres;
	}

	public List<Object[]> getMujeresAsistencia(String curso, String tema, String fecha, String c14, String c15, String c16) {

		List<Object[]> mujeres = new ArrayList<Object[]>();
		Conexion conexion = new Conexion();
		SimpleDateFormat formato = new SimpleDateFormat("yyy-MM-dd");

		String sentencia = "SELECT a . * , m . * , b.nombre barrio_c, c.nombre vereda_c" +
		" FROM mujeres_curso a, mujeres m" +
		" LEFT JOIN barrios b ON m.id_barrio = b.id" +
				" LEFT JOIN veredas c ON m.id_vereda = c.id" + 
		" WHERE a.id_mujer = m.id_mujer AND a.id_curso=" + curso ;
		
		
		if (c14 != null && !c14.trim().equals("")) {
			if (c14.equals("C")) {
				sentencia += " AND m.id_comuna IS NOT NULL";
			}
			if (c14.equals("CO")) {
				sentencia += " AND m.id_corregimiento IS NOT NULL ";
			}

			if (c15 != null && !c15.trim().equals("")) {

				if (c14.equals("C")) {
					sentencia += " AND m.id_comuna =" + c15;
				}
				if (c14.equals("CO")) {
					sentencia += " AND m.id_corregimiento= " + c15;
				}

			}

			if (c16 != null && !c16.trim().equals("")) {
				if (c14.equals("C")) {
					sentencia += " AND m.id_barrio =" + c16;
				}
				if (c14.equals("CO")) {
					sentencia += " AND m.id_vereda= " + c16;
				}
			}

		}
		
		sentencia += "  AND a.id NOT IN(" +
		"  											SELECT c.id_mujer_curso FROM asistencia c WHERE c.id_tema=" + tema + 
		" AND c.fecha='" + fecha + "' AND c.id_mujer_curso IS NOT NULL" + "  								)" +
		" order by primer_nombre, segundo_nombre, primer_apellido, segundo_apellido";
		Object[] mujer = null;
		ResultSet rs = conexion.consultarBD(sentencia);
		try {
			while (rs.next()) {
				mujer = new Object[13];
				mujer[0] = rs.getObject("id");
				mujer[1] = rs.getObject("primer_nombre");
				mujer[2] = rs.getObject("segundo_nombre");
				mujer[3] = rs.getObject("primer_apellido");
				mujer[4] = rs.getObject("segundo_apellido");
				mujer[5] = rs.getObject("documento");

				if (rs.getObject("nombre_comuna") == null) {
					mujer[6] = "No registrada";
				} else {
					mujer[6] = rs.getObject("nombre_comuna"); // es la etnia
				}

				mujer[7] = rs.getObject("numero_comuna");
				mujer[8] = rs.getObject("telefonos");
				mujer[9] = rs.getObject("inscrita");

				if (rs.getObject("barrio_c") == null) {
					mujer[10] = rs.getObject("vereda_c");
				} else {
					mujer[10] = rs.getObject("barrio_c");
				}

				mujer[11] = rs.getObject("sexo");
				if (rs.getObject("fecha_nacimiento") != null) {
					try {
						mujer[12] = getEdad(formato.parse(rs.getString("fecha_nacimiento")));
					} catch (ParseException e) {
						mujer[12] = null;
					}
				}

				mujeres.add(mujer);
			}
			rs.close();
		} catch (SQLException e) {
			// e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}
		return mujeres;
	}

	public static String getEdad(Date fechaNacimiento) {

		if (fechaNacimiento != null) {
			SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");

			StringBuilder result = new StringBuilder();

			if (fechaNacimiento != null) {

				// result.append(sdf.format(fechaNacimiento));

				// result.append(" (");

				Calendar c = new GregorianCalendar();

				c.setTime(fechaNacimiento);

				result.append(calcularEdad(c));

				result.append(" años");

			}

			return result.toString();

		}

		return "";

	}

	private static int calcularEdad(Calendar fechaNac) {

		Calendar today = Calendar.getInstance();

		int diffYear = today.get(Calendar.YEAR) - fechaNac.get(Calendar.YEAR);

		int diffMonth = today.get(Calendar.MONTH) - fechaNac.get(Calendar.MONTH);

		int diffDay = today.get(Calendar.DAY_OF_MONTH) - fechaNac.get(Calendar.DAY_OF_MONTH);

		// Si está en ese año pero todavía no los ha cumplido

		if (diffMonth < 0 || (diffMonth == 0 && diffDay < 0)) {

			diffYear = diffYear - 1; // no aparecían los dos guiones del

		}
		return diffYear;

	}

	public List<Object[]> getMujeresCurso(String id) {

		List<Object[]> cursos = new ArrayList<Object[]>();
		Conexion conexion = new Conexion();
		String sentencia = "SELECT * FROM mujeres_curso a, mujeres m WHERE a.id_mujer = m.id_mujer AND a.id_curso=" + id + " ORDER BY m.primer_nombre, m.segundo_nombre, m.primer_apellido, m.segundo_apellido";
		Object[] curso = null;
		ResultSet rs = conexion.consultarBD(sentencia);
		try {
			while (rs.next()) {
				curso = new Object[10];
				curso[0] = rs.getObject("id");
				curso[1] = rs.getObject("primer_nombre");
				curso[2] = rs.getObject("segundo_nombre");
				curso[3] = rs.getObject("primer_apellido");
				curso[4] = rs.getObject("segundo_apellido");
				curso[5] = rs.getObject("documento");
				curso[6] = rs.getObject("nombre_comuna");
				curso[7] = rs.getObject("numero_comuna");
				curso[8] = rs.getObject("telefonos");
				curso[9] = rs.getObject("inscrita");
				cursos.add(curso);
			}
			rs.close();
		} catch (SQLException e) {
			// e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}
		return cursos;
	}

	public Object[] getNombrePregunta(String id) {

		Conexion conexion = new Conexion();
		String sentencia = "SELECT * FROM preguntas a WHERE a.id_pregunta=" + id;
		Object[] curso = null;
		ResultSet rs = conexion.consultarBD(sentencia);
		try {
			while (rs.next()) {
				curso = new Object[6]; // ***5

				curso[0] = rs.getObject(1);
				curso[1] = rs.getObject(2);
				curso[2] = rs.getObject(3);
				curso[3] = rs.getObject(4);
				curso[4] = rs.getObject(5);
				curso[5] = rs.getObject(6); // ****NUEW

			}
			rs.close();
		} catch (SQLException e) {
			// e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}
		return curso;
	}
	
	public Object[] getHorasMujerEncuestaActualizar(String encuesta, String mujer, String pregunta, String opcion) {

		// /List<Object[]> cursos = new ArrayList<Object[]>();
		Conexion conexion = new Conexion();
		String sentencia = "SELECT distinct r.* FROM respuestas_encuesta r WHERE id_encuesta = " + encuesta + " and r.id_mujer= " + mujer + " and r.id_pregunta=" + pregunta;
		
		if(opcion!=null){
		sentencia+= " and r.id_opcion="+opcion;
		}else{
			sentencia+= " and r.id_opcion IS NULL";
			
		}
		Object[] curso = null;
		ResultSet rs = conexion.consultarBD(sentencia);
		try {
			if (rs.next()) {
				curso = new Object[8];

				curso[0] = rs.getObject(1);
				curso[1] = rs.getObject(2);
				curso[2] = rs.getObject(3);
				curso[3] = rs.getObject(4);
				curso[4] = rs.getObject(5);
				curso[5] = rs.getObject(6);
				curso[6] = rs.getObject(7);
				curso[7] = rs.getObject(8);

				// cursos.add(curso);
			}
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}
		return curso;
	}
	
	
	
	

	public Object[] getHorasMujerEncuesta(String encuesta, String mujer, String pregunta) {

		// /List<Object[]> cursos = new ArrayList<Object[]>();
		Conexion conexion = new Conexion();
		String sentencia = "SELECT distinct r.* FROM respuestas_encuesta r WHERE id_encuesta = " + encuesta + " and r.id_mujer= " + mujer + " and r.horas is not null and r.id_pregunta=" + pregunta;
		Object[] curso = null;
		ResultSet rs = conexion.consultarBD(sentencia);
		try {
			while (rs.next()) {
				curso = new Object[7];

				curso[0] = rs.getObject(1);
				curso[1] = rs.getObject(2);
				curso[2] = rs.getObject(3);
				curso[3] = rs.getObject(4);
				curso[4] = rs.getObject(5);
				curso[5] = rs.getObject(6);
				curso[6] = rs.getObject(7);

				// cursos.add(curso);
			}
			rs.close();
		} catch (SQLException e) {
			// e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}
		return curso;
	}

	public List<Object[]> getMujeresEncuesta(String encuesta, String mujer) {

		List<Object[]> cursos = new ArrayList<Object[]>();
		Conexion conexion = new Conexion();
		String sentencia = "SELECT distinct m.* FROM respuestas_encuesta r, mujeres m WHERE id_encuesta = " + encuesta + " and r.id_mujer= m.id_mujer and r.horas is not null AND r.id_mujer = " + mujer + " ORDER BY m.primer_nombre, m.segundo_nombre, m.primer_apellido, m.segundo_apellido";
		Object[] curso = null;
		ResultSet rs = conexion.consultarBD(sentencia);
		try {
			while (rs.next()) {
				curso = new Object[5];

				curso[0] = rs.getObject(1);
				curso[1] = rs.getObject(2);
				curso[2] = rs.getObject(3);
				curso[3] = rs.getObject(4);
				curso[4] = rs.getObject(5);

				cursos.add(curso);
			}
			rs.close();
		} catch (SQLException e) {
			// e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}
		return cursos;
	}

	public List<Object[]> getMujeresEncuestav2(String encuesta, String aCurso, String aTema, String aProyecto, String aLinea, String aFinanciador, String aDocumento, String fechaDesde, String fechaHasta, String c14, String c15, String c16) {

		List<Object[]> cursos = new ArrayList<Object[]>();
		Conexion conexion = new Conexion();

		String sentencia = " SELECT distinct mu.* " + " FROM asistencia a" + " LEFT JOIN mujeres_curso m ON a.id_mujer_curso = m.id" + " LEFT JOIN mujeres mu ON m.id_mujer = mu.id_mujer " + " INNER JOIN temas t ON t.id = a.id_tema " + " INNER JOIN cursos c ON c.id = t.id_curso " + " INNER JOIN proyectos p ON c.id_proyecto = p.id " + " INNER JOIN curso_linea cl ON a.id_linea = cl.id " + " INNER JOIN curso_financiador cf ON a.id_financiador = cf.id " + " INNER JOIN lineas l ON cl.id_linea = l.id " + " INNER JOIN financiadores f ON cf.id_financiador = f.id " + " INNER JOIN respuestas_encuesta r ON  r.id_mujer= mu.id_mujer " + " WHERE 1=1 AND r.horas is not null and  r.id_encuesta = " + encuesta;

		// if (tipo != null && tipo.equals("1")) {
		//
		// sentencia += " AND mu.inscrita = 'S'";
		//
		// } else if (tipo != null && tipo.equals("2")) {
		//
		// sentencia += " AND mu.inscrita = 'N'";
		//
		// }

		if (fechaDesde != null && !fechaDesde.trim().equals("")) {

			sentencia += " AND a.fecha >= '" + fechaDesde + "'";

		}

		if (fechaHasta != null && !fechaHasta.trim().equals("")) {

			sentencia += " AND a.fecha <= '" + fechaHasta + "'";
		}

		if (aCurso != null && !aCurso.trim().equals("")) {

			sentencia += " AND t.id_curso = '" + aCurso + "'";
		}

		if (aTema != null && !aTema.trim().equals("")) {

			sentencia += " AND t.id = '" + aTema + "'";
		}

		if (aProyecto != null && !aProyecto.trim().equals("")) {

			sentencia += " AND p.id = '" + aProyecto + "'";
		}

		if (aLinea != null && !aLinea.trim().equals("")) {

			sentencia += " AND l.id = '" + aLinea + "'";
		}

		if (aFinanciador != null && !aFinanciador.trim().equals("")) {

			sentencia += " AND f.id = '" + aFinanciador + "'";
		}

		if (aDocumento != null && !aDocumento.trim().equals("")) {

			sentencia += " AND (mu.documento = '" + aDocumento + "')";
		}

		sentencia += " AND a.asistio = 'S'";
		
		
		if (c14 != null && !c14.trim().equals("")) {
			if (c14.equals("C")) {
				sentencia += " AND mu.id_comuna IS NOT NULL";
			}
			if (c14.equals("CO")) {
				sentencia += " AND mu.id_corregimiento IS NOT NULL ";
			}

			if (c15 != null && !c15.trim().equals("")) {

				if (c14.equals("C")) {
					sentencia += " AND mu.id_comuna =" + c15;
				}
				if (c14.equals("CO")) {
					sentencia += " AND mu.id_corregimiento= " + c15;
				}

			}

			if (c16 != null && !c16.trim().equals("")) {
				if (c14.equals("C")) {
					sentencia += " AND mu.id_barrio =" + c16;
				}
				if (c14.equals("CO")) {
					sentencia += " AND mu.id_vereda= " + c16;
				}
			}

		}
		

		sentencia += " ORDER BY mu.primer_nombre, mu.segundo_nombre, mu.primer_apellido, mu.segundo_apellido";

		Object[] curso = null;
		ResultSet rs = conexion.consultarBD(sentencia);
		try {
			while (rs.next()) {
				curso = new Object[5];

				curso[0] = rs.getObject(1);
				curso[1] = rs.getObject(2);
				curso[2] = rs.getObject(3);
				curso[3] = rs.getObject(4);
				curso[4] = rs.getObject(5);

				cursos.add(curso);
			}
			rs.close();
		} catch (SQLException e) {
			// e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}
		return cursos;
	}

	public List<Object[]> getMujeresEncuesta(String encuesta) {

		List<Object[]> cursos = new ArrayList<Object[]>();
		Conexion conexion = new Conexion();
		String sentencia = "SELECT distinct m.* FROM respuestas_encuesta r, mujeres m" + " WHERE id_encuesta = " + encuesta + " and r.id_mujer= m.id_mujer and r.horas is not null" + " ORDER BY m.primer_nombre, m.segundo_nombre, m.primer_apellido, m.segundo_apellido";
		Object[] curso = null;
		ResultSet rs = conexion.consultarBD(sentencia);
		try {
			while (rs.next()) {
				curso = new Object[5];

				curso[0] = rs.getObject(1);
				curso[1] = rs.getObject(2);
				curso[2] = rs.getObject(3);
				curso[3] = rs.getObject(4);
				curso[4] = rs.getObject(5);

				cursos.add(curso);
			}
			rs.close();
		} catch (SQLException e) {
			// e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}
		return cursos;
	}

	public List<Object[]> getPreguntasResultados(String encuesta) {

		List<Object[]> cursos = new ArrayList<Object[]>();
		Conexion conexion = new Conexion();
		String sentencia = " SELECT DISTINCT p .* , a.id_pregunta tabulador" + " FROM preguntas a, preguntas p" + " WHERE a.id_pregunta_sup = p.id_pregunta" + " AND a.id_encuesta =" + encuesta + " AND a.tipo_respuesta =  'T'";
		Object[] curso = null;
		ResultSet rs = conexion.consultarBD(sentencia);
		try {
			while (rs.next()) {
				curso = new Object[5];

				curso[0] = rs.getObject(1);
				curso[1] = rs.getObject(2);
				curso[2] = rs.getObject(3);
				curso[3] = rs.getObject(4);
				curso[4] = rs.getObject("tabulador"); // EL tabulador es el id
				// de la pregunta para
				// mirar tiempos

				cursos.add(curso);
			}
			rs.close();
		} catch (SQLException e) {
			// e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}
		return cursos;
	}

	public List<Object[]> getPreguntas(String id) {

		List<Object[]> cursos = new ArrayList<Object[]>();
		Conexion conexion = new Conexion();
		String sentencia = "SELECT * FROM preguntas a WHERE a.id_encuesta=" + id + " ORDER BY a.id_pregunta";
		Object[] curso = null;
		ResultSet rs = conexion.consultarBD(sentencia);
		try {
			while (rs.next()) {
				curso = new Object[5];

				curso[0] = rs.getObject(1);
				curso[1] = rs.getObject(2);
				curso[2] = rs.getObject(3);
				curso[3] = rs.getObject(4);
				curso[4] = rs.getObject(5);

				cursos.add(curso);
			}
			rs.close();
		} catch (SQLException e) {
			// e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}
		return cursos;
	}

	public Object[] getOpcion(String id) {

		Conexion conexion = new Conexion();
		String sentencia = "SELECT * FROM opciones_respuesta a WHERE a.id_op_respuesta=" + id;
		Object[] curso = null;
		ResultSet rs = conexion.consultarBD(sentencia);
		try {
			if (rs.next()) {
				curso = new Object[5];

				curso[0] = rs.getObject(1);
				curso[1] = rs.getObject(2);
				curso[2] = rs.getObject(3);
				curso[3] = rs.getObject(4);
				curso[4] = rs.getObject(5);

			}
			rs.close();
		} catch (SQLException e) {
			// e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}
		return curso;
	}

	public List<Object[]> getOpciones(String id) {

		List<Object[]> cursos = new ArrayList<Object[]>();
		Conexion conexion = new Conexion();
		String sentencia = "SELECT * FROM opciones_respuesta a WHERE a.id_pregunta=" + id + " ORDER BY a.id_op_respuesta";
		Object[] curso = null;
		ResultSet rs = conexion.consultarBD(sentencia);
		try {
			while (rs.next()) {
				curso = new Object[5];

				curso[0] = rs.getObject(1);
				curso[1] = rs.getObject(2);
				curso[2] = rs.getObject(3);
				curso[3] = rs.getObject(4);
				curso[4] = rs.getObject(5);

				cursos.add(curso);
			}
			rs.close();
		} catch (SQLException e) {
			// e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}
		return cursos;
	}
	
	


	public List<Object[]> getFinanciadoresCurso(String idCurso) {

		List<Object[]> cursos = new ArrayList<Object[]>();
		Conexion conexion = new Conexion();
		String sentencia = "SELECT a.*, l.nombre, l.archivo FROM curso_financiador a, financiadores l WHERE a.id_financiador = l.id AND a.id_curso=" + idCurso + " ORDER BY l.nombre";
		Object[] curso = null;
		ResultSet rs = conexion.consultarBD(sentencia);
		try {
			while (rs.next()) {
				curso = new Object[6];

				curso[0] = rs.getObject(1);
				curso[1] = rs.getObject(2);
				curso[2] = rs.getObject(3);
				curso[3] = rs.getObject(4);
				curso[4] = rs.getObject(5);
				curso[5] = rs.getBytes(6);

				cursos.add(curso);
			}
			rs.close();
		} catch (SQLException e) {
			// e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}
		return cursos;
	}
	
	
	
	
	
	

	public List<Object[]> getBarriosVeredasTodos(String idTipo) {

		List<Object[]> cursos = new ArrayList<Object[]>();
		Conexion conexion = new Conexion();
		String sentencia = null;

		if (idTipo != null && idTipo.equals("C")) {

			sentencia = "SELECT id, nombre, completo as tipo FROM barrios ORDER BY nombre";

		} else {

			sentencia = "SELECT id, nombre, tipo FROM veredas ORDER BY nombre";

		}
		// sentencia =
		// "SELECT a.*, l.nombre FROM curso_linea a, lineas l WHERE a.id_linea =
		// l.id AND a.id_curso="
		// + idCurso + " ORDER BY l.nombre";

		Object[] curso = null;
		ResultSet rs = conexion.consultarBD(sentencia);
		try {
			while (rs.next()) {
				curso = new Object[3];

				curso[0] = rs.getObject(1);
				curso[1] = rs.getObject(2);
				curso[2] = rs.getObject(3);

				if (idTipo != null && idTipo.equals("C")) {

					if (("" + curso[2]).trim().equals("N")) {

						curso[1] = curso[1] + " ** BARRIO INCOMPLETO **";
					}

				} else {

					if (("" + curso[2]).trim().equals("A")) {

						curso[1] = curso[1] + " ** ASENTAMIENTO **";
					}

				}

				cursos.add(curso);
			}
			rs.close();
		} catch (SQLException e) {
			// e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}
		return cursos;
	}

	public List<Object[]> getBarriosVeredas(String idTipo, String id) {

		List<Object[]> cursos = new ArrayList<Object[]>();
		Conexion conexion = new Conexion();
		String sentencia = null;

		if (idTipo != null && idTipo.equals("C")) {

			sentencia = "SELECT id, nombre, completo as tipo FROM barrios WHERE id_comuna=" + id + "  ORDER BY nombre";

		} else {

			sentencia = "SELECT id, nombre, tipo FROM veredas WHERE id_corregimiento=" + id + " ORDER BY nombre";

		}
		// sentencia =
		// "SELECT a.*, l.nombre FROM curso_linea a, lineas l WHERE a.id_linea =
		// l.id AND a.id_curso="
		// + idCurso + " ORDER BY l.nombre";

		Object[] curso = null;
		ResultSet rs = conexion.consultarBD(sentencia);
		try {
			while (rs.next()) {
				curso = new Object[3];

				curso[0] = rs.getObject(1);
				curso[1] = rs.getObject(2);
				curso[2] = rs.getObject(3);

				if (idTipo != null && idTipo.equals("C")) {

					if (("" + curso[2]).trim().equals("N")) {

						curso[1] = curso[1] + " ** BARRIO INCOMPLETO **";
					}

				} else {

					if (("" + curso[2]).trim().equals("A")) {

						curso[1] = curso[1] + " ** ASENTAMIENTO **";
					}

				}

				cursos.add(curso);
			}
			rs.close();
		} catch (SQLException e) {
			// e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}
		return cursos;
	}

	public List<Object[]> getTipoDirecciones(String idTipo) {

		List<Object[]> cursos = new ArrayList<Object[]>();
		Conexion conexion = new Conexion();
		String sentencia = null;

		if (idTipo != null && idTipo.equals("C")) {

			sentencia = "SELECT * FROM comunas ORDER BY id";

		} else {

			sentencia = "SELECT * FROM corregimientos ORDER BY id";

		}
		// sentencia =
		// "SELECT a.*, l.nombre FROM curso_linea a, lineas l WHERE a.id_linea =
		// l.id AND a.id_curso="
		// + idCurso + " ORDER BY l.nombre";

		Object[] curso = null;
		ResultSet rs = conexion.consultarBD(sentencia);
		try {
			while (rs.next()) {
				curso = new Object[2];

				curso[0] = rs.getObject(1);
				curso[1] = rs.getObject(2);

				cursos.add(curso);
			}
			rs.close();
		} catch (SQLException e) {
			// e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}
		return cursos;
	}

	public List<Object[]> getLineasCurso(String idCurso) {

		List<Object[]> cursos = new ArrayList<Object[]>();
		Conexion conexion = new Conexion();
		String sentencia = "SELECT a.*, l.nombre FROM curso_linea a, lineas l WHERE a.id_linea = l.id AND a.id_curso=" + idCurso + " ORDER BY l.nombre";
		Object[] curso = null;
		ResultSet rs = conexion.consultarBD(sentencia);
		try {
			while (rs.next()) {
				curso = new Object[5];

				curso[0] = rs.getObject(1);
				curso[1] = rs.getObject(2);
				curso[2] = rs.getObject(3);
				curso[3] = rs.getObject(4);
				curso[4] = rs.getObject(5);

				cursos.add(curso);
			}
			rs.close();
		} catch (SQLException e) {
			// e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}
		return cursos;
	}

	public List<Object[]> getActividades(String id) {

		List<Object[]> cursos = new ArrayList<Object[]>();
		Conexion conexion = new Conexion();
		String sentencia = "SELECT a.*, n.nombre FROM actividades_mujeres a, actividades_economicas n WHERE a.id_mujer=" + id + " AND a.id_actividad = n.id ORDER BY n.nombre";
		Object[] curso = null;
		ResultSet rs = conexion.consultarBD(sentencia);
		try {
			while (rs.next()) {
				curso = new Object[7];

				curso[0] = rs.getObject(1);
				curso[1] = rs.getObject(2);
				curso[2] = rs.getObject(3);
				curso[3] = rs.getObject(4);
				curso[4] = rs.getObject(5);
				curso[5] = rs.getObject(6);
				curso[6] = rs.getObject(7);
				cursos.add(curso);
			}
			rs.close();
		} catch (SQLException e) {
			// e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}
		return cursos;
	}

	public List<Object[]> getParticipaciones(String id) {

		List<Object[]> cursos = new ArrayList<Object[]>();
		Conexion conexion = new Conexion();
		String sentencia = "SELECT a.*, n.nombre, c.nombre FROM participaciones_mujeres a, organizaciones n, cargos c WHERE a.id_mujer=" + id + " AND a.id_cargo = c.id AND a.id_organizacion = n.id   ORDER BY a.tipo, n.nombre, c.nombre";
		Object[] curso = null;
		ResultSet rs = conexion.consultarBD(sentencia);
		try {
			while (rs.next()) {
				curso = new Object[8];

				curso[0] = rs.getObject(1);
				curso[1] = rs.getObject(2);
				curso[2] = rs.getObject(3);
				curso[3] = rs.getObject(4);
				curso[4] = rs.getObject(5);
				curso[5] = rs.getObject(6);
				curso[6] = rs.getObject(7);
				curso[7] = rs.getObject(8);
				cursos.add(curso);
			}
			rs.close();
		} catch (SQLException e) {
			// e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}
		return cursos;
	}

	public List<Object[]> getCapacitaciones(String id) {

		List<Object[]> cursos = new ArrayList<Object[]>();
		Conexion conexion = new Conexion();
		String sentencia = " SELECT a.*, c.nombre, l.nombre FROM capacitaciones_mujeres a" + " LEFT JOIN  capacitaciones c ON a.id_capacitacion = c.id " + " LEFT JOIN  lineas l ON a.id_linea = l.id " + " WHERE a.id_mujer=" + id + " ORDER BY c.nombre, l.nombre";
		Object[] curso = null;
		ResultSet rs = conexion.consultarBD(sentencia);
		try {
			while (rs.next()) {
				curso = new Object[10];

				curso[0] = rs.getObject(1);
				curso[1] = rs.getObject(2);
				curso[2] = rs.getObject(3);
				curso[3] = rs.getObject(4);
				curso[4] = rs.getObject(5);
				curso[5] = rs.getObject(6);
				curso[6] = rs.getObject(7);
				curso[7] = rs.getObject(8);
				curso[8] = rs.getObject(9);
				curso[9] = rs.getObject(10);
				cursos.add(curso);
			}
			rs.close();
		} catch (SQLException e) {
			// e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}
		return cursos;
	}

	public List<Object[]> getNiveles(String id) {

		List<Object[]> cursos = new ArrayList<Object[]>();
		Conexion conexion = new Conexion();
		String sentencia = "SELECT a.*, n.nombre FROM niveles_mujeres a, niveles_educativos n WHERE a.id_mujer=" + id + " AND a.id_nivel = n.id ORDER BY n.nombre";
		Object[] curso = null;
		ResultSet rs = conexion.consultarBD(sentencia);
		try {
			while (rs.next()) {
				curso = new Object[5];

				curso[0] = rs.getObject(1);
				curso[1] = rs.getObject(2);
				curso[2] = rs.getObject(3);
				curso[3] = rs.getObject(4);
				curso[4] = rs.getObject(5);
				cursos.add(curso);
			}
			rs.close();
		} catch (SQLException e) {
			// e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}
		return cursos;
	}

	public List<Object[]> getActividades() {

		List<Object[]> cursos = new ArrayList<Object[]>();
		Conexion conexion = new Conexion();
		String sentencia = "SELECT a.*, p.valor FROM actividades_economicas a, parametros_globales p WHERE a.parametro_usado = p.id";
		Object[] curso = null;
		ResultSet rs = conexion.consultarBD(sentencia);
		try {
			while (rs.next()) {

				curso = new Object[5];

				curso[0] = rs.getObject(1);
				curso[1] = rs.getObject(2);
				curso[2] = rs.getObject(3);
				curso[3] = rs.getObject(4);
				curso[4] = rs.getObject(5);

				cursos.add(curso);
			}
			rs.close();
		} catch (SQLException e) {
			// e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}
		return cursos;
	}

	public List<Object[]> getCargos() {

		List<Object[]> cursos = new ArrayList<Object[]>();
		Conexion conexion = new Conexion();
		String sentencia = "SELECT * FROM cargos";
		Object[] curso = null;
		ResultSet rs = conexion.consultarBD(sentencia);
		try {
			while (rs.next()) {
				curso = new Object[3];

				curso[0] = rs.getObject(1);
				curso[1] = rs.getObject(2);
				curso[2] = rs.getObject(3);

				cursos.add(curso);
			}
			rs.close();
		} catch (SQLException e) {
			// e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}
		return cursos;
	}

	public List<Object[]> getOrganizaciones() {

		List<Object[]> cursos = new ArrayList<Object[]>();
		Conexion conexion = new Conexion();
		String sentencia = "SELECT * FROM organizaciones";
		Object[] curso = null;
		ResultSet rs = conexion.consultarBD(sentencia);
		try {
			while (rs.next()) {
				curso = new Object[3];

				curso[0] = rs.getObject(1);
				curso[1] = rs.getObject(2);
				curso[2] = rs.getObject(3);

				cursos.add(curso);
			}
			rs.close();
		} catch (SQLException e) {
			// e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}
		return cursos;
	}

	public List<Object[]> getCapacitaciones() {

		List<Object[]> cursos = new ArrayList<Object[]>();
		Conexion conexion = new Conexion();
		String sentencia = " SELECT id, nombre, justificable, 'C' FROM capacitaciones" + " UNION ALL " + " SELECT id, nombre, 'N', 'L' FROM lineas" + " ORDER BY nombre";

		Object[] curso = null;
		ResultSet rs = conexion.consultarBD(sentencia);
		try {
			while (rs.next()) {
				curso = new Object[4];

				curso[0] = rs.getObject(1);
				curso[1] = rs.getObject(2);
				curso[2] = rs.getObject(3);
				curso[3] = rs.getObject(4);

				cursos.add(curso);
			}
			rs.close();
		} catch (SQLException e) {
			// e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}
		return cursos;
	}

	public List<Object[]> getNiveles() {

		List<Object[]> cursos = new ArrayList<Object[]>();
		Conexion conexion = new Conexion();
		String sentencia = "SELECT * FROM niveles_educativos";
		Object[] curso = null;
		ResultSet rs = conexion.consultarBD(sentencia);
		try {
			while (rs.next()) {
				curso = new Object[3];

				curso[0] = rs.getObject(1);
				curso[1] = rs.getObject(2);
				curso[2] = rs.getObject(3);

				cursos.add(curso);
			}
			rs.close();
		} catch (SQLException e) {
			// e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}
		return cursos;
	}

	public List<Object[]> getTemas(String id) {

		List<Object[]> cursos = new ArrayList<Object[]>();
		Conexion conexion = new Conexion();
		String sentencia = "SELECT * FROM temas a WHERE a.id_curso=" + id + " ORDER BY a.nombre";
		Object[] curso = null;
		ResultSet rs = conexion.consultarBD(sentencia);
		try {
			while (rs.next()) {
				curso = new Object[12];

				curso[0] = rs.getObject(1);
				curso[1] = rs.getObject(2);
				curso[2] = rs.getObject(3);
				
				curso[3] = rs.getObject(4);
				curso[4] = rs.getBytes(5);
				curso[5] = rs.getObject(6);

				//nuevos los 6 sigtes
				curso[6] = rs.getObject(7);
				curso[7] = rs.getBytes(8);
				curso[8] = rs.getObject(9);

				curso[9] = rs.getObject(10);
				curso[10] = rs.getBytes(11);
				curso[11] = rs.getObject(12);

				
				
				cursos.add(curso);
			}
			rs.close();
		} catch (SQLException e) {
			// e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}
		return cursos;
	}

	public Object[] getCursoTema(String id) {

		Conexion conexion = new Conexion();
		String sentencia = "SELECT c.nombre, t.nombre FROM cursos c, temas t  WHERE c.id = t.id_curso AND t.id =   " + id;
		Object[] curso = null;
		ResultSet rs = conexion.consultarBD(sentencia);
		try {
			if (rs.next()) {
				curso = new Object[2];

				curso[0] = rs.getObject(1);
				curso[1] = rs.getObject(2);

			}
			rs.close();
		} catch (SQLException e) {
			// e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}
		return curso;
	}

	public Object[] getNombreEncuesta(String id) {

		Conexion conexion = new Conexion();
		String sentencia = "SELECT * FROM encuestas a WHERE a.id_encuesta =  " + id;
		Object[] curso = null;
		ResultSet rs = conexion.consultarBD(sentencia);
		try {
			if (rs.next()) {
				curso = new Object[5];

				curso[0] = rs.getObject(1);
				curso[1] = rs.getObject(2);
				curso[2] = rs.getObject(3);
				curso[3] = rs.getObject(4);
				curso[4] = rs.getObject(5);

			}
			rs.close();
		} catch (SQLException e) {
			// e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}
		return curso;
	}

	public List<Object[]> getEncuestasVigentesActivas() {

		List<Object[]> cursos = new ArrayList<Object[]>();
		Conexion conexion = new Conexion();
		String sentencia = "SELECT * FROM encuestas a WHERE a.activa = 'S' AND a.fecha_desde <= current_date AND fecha_hasta >=  current_date ORDER BY a.descripcion ASC ";
		Object[] curso = null;
		ResultSet rs = conexion.consultarBD(sentencia);
		try {
			while (rs.next()) {
				curso = new Object[5];

				curso[0] = rs.getObject(1);
				curso[1] = rs.getObject(2);
				curso[2] = rs.getObject(3);
				curso[3] = rs.getObject(4);
				curso[4] = rs.getObject(5);

				cursos.add(curso);
			}
			rs.close();
		} catch (SQLException e) {
			// e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}
		return cursos;
	}

	public List<Object[]> getEncuestas() {

		List<Object[]> cursos = new ArrayList<Object[]>();
		Conexion conexion = new Conexion();
		String sentencia = "SELECT * FROM encuestas a ORDER BY a.fecha_desde DESC, a.fecha_hasta DESC, a.descripcion ASC ";
		Object[] curso = null;
		ResultSet rs = conexion.consultarBD(sentencia);
		try {
			while (rs.next()) {
				curso = new Object[5];

				curso[0] = rs.getObject(1);
				curso[1] = rs.getObject(2);
				curso[2] = rs.getObject(3);
				curso[3] = rs.getObject(4);
				curso[4] = rs.getObject(5);

				cursos.add(curso);
			}
			rs.close();
		} catch (SQLException e) {
			// e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}
		return cursos;
	}

	public List<Object[]> getProyectosLineas() {

		List<Object[]> resultados = new ArrayList<Object[]>();
		Conexion conexion = new Conexion();
		String sentencia = "  SELECT pl.id, p.nombre , l.nombre, f.nombre FROM proyecto_linea_finan pl, lineas l, proyectos p, financiadores f" + " WHERE pl.id_linea = l.id AND  pl.id_proyecto = p.id AND pl.id_financiador = f.id  ORDER BY p.nombre, l.nombre, f.nombre";
		Object[] res = null;
		ResultSet rs = conexion.consultarBD(sentencia);
		try {
			while (rs.next()) {
				res = new Object[4];

				res[0] = rs.getObject(1);
				res[1] = rs.getObject(2);
				res[2] = rs.getObject(3);
				res[3] = rs.getObject(4);

				resultados.add(res);
			}
			rs.close();
		} catch (SQLException e) {
			// e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}
		return resultados;
	}

	public List<Object[]> getLineas() {

		List<Object[]> lineas = new ArrayList<Object[]>();
		Conexion conexion = new Conexion();
		String sentencia = "SELECT * FROM lineas a ORDER BY a.nombre";
		Object[] linea = null;
		ResultSet rs = conexion.consultarBD(sentencia);
		try {
			while (rs.next()) {
				linea = new Object[2];

				linea[0] = rs.getObject(1);
				linea[1] = rs.getObject(2);

				lineas.add(linea);
			}
			rs.close();
		} catch (SQLException e) {
			// e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}
		return lineas;
	}

	public List<Object[]> getProyectos() {

		List<Object[]> proyectos = new ArrayList<Object[]>();
		Conexion conexion = new Conexion();
		String sentencia = "SELECT * FROM proyectos a ORDER BY a.nombre";
		Object[] proyecto = null;
		ResultSet rs = conexion.consultarBD(sentencia);
		try {
			while (rs.next()) {
				proyecto = new Object[2];

				proyecto[0] = rs.getObject(1);
				proyecto[1] = rs.getObject(2);

				proyectos.add(proyecto);
			}
			rs.close();
		} catch (SQLException e) {
			// e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}
		return proyectos;
	}

	public void guardarArchivoDisco(String directorio_ruta_con_nombre_archivo, byte[] array) {

		if (array != null) {
			FileOutputStream fileOuputStream = null;
			try {
				fileOuputStream = new FileOutputStream(directorio_ruta_con_nombre_archivo);
				fileOuputStream.write(array);
			} catch (Exception e) {

			} finally {
				try {
					fileOuputStream.close();
				} catch (IOException e) {

				}
			}
		}

	}
	
	public Object[] getLogos(Integer aId) {
		Conexion conexion = new Conexion();
		String sentencia = "SELECT * FROM logo_software a WHERE id =" + aId;
		Object[] financiador = null;
		ResultSet rs = conexion.consultarBD(sentencia);
		try {
			while (rs.next()) {
				financiador = new Object[4];

				financiador[0] = rs.getObject(1);
				financiador[1] = rs.getObject(2);
				financiador[2] = rs.getObject(3);
				financiador[3] = rs.getBytes(4); // archivo

			}
			rs.close();
		} catch (SQLException e) {
			// e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}
		return financiador;
	}
	
	public Object[] getLogo(Integer aId) {
		Conexion conexion = new Conexion();
		String sentencia = "SELECT * FROM logo_software a WHERE id =" + aId;
		Object[] financiador = null;
		ResultSet rs = conexion.consultarBD(sentencia);
		try {
			while (rs.next()) {
				financiador = new Object[4];

				financiador[0] = rs.getObject(1);
				financiador[1] = rs.getObject(2);
				financiador[2] = rs.getObject(3);
				financiador[3] = rs.getBytes(4); // archivo

			}
			rs.close();
		} catch (SQLException e) {
			// e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}
		return financiador;
	}

	public Object[] getFinanciador(Integer aId) {
		Conexion conexion = new Conexion();
		String sentencia = "SELECT * FROM financiadores a WHERE id =" + aId;
		Object[] financiador = null;
		ResultSet rs = conexion.consultarBD(sentencia);
		try {
			while (rs.next()) {
				financiador = new Object[4];

				financiador[0] = rs.getObject(1);
				financiador[1] = rs.getObject(2);
				financiador[2] = rs.getObject(3);
				financiador[3] = rs.getBytes(4); // archivo

			}
			rs.close();
		} catch (SQLException e) {
			// e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}
		return financiador;
	}
	
	
	public Object[] getLogosss() {

	
		Conexion conexion = new Conexion();
		String sentencia = "SELECT * FROM logo_software a ORDER BY a.nombre";
		Object[] financiador = null;
		ResultSet rs = conexion.consultarBD(sentencia);
		try {
			if (rs.next()) {
				financiador = new Object[4];

				financiador[0] = rs.getObject(1);
				financiador[1] = rs.getObject(2);
				financiador[2] = rs.getObject(3);

				financiador[3] = rs.getBytes(4); // archivo

		
			}
			rs.close();
		} catch (SQLException e) {
			// e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}
		return financiador;
	}

	public List<Object[]> getFinanciadores() {

		List<Object[]> financiadores = new ArrayList<Object[]>();
		Conexion conexion = new Conexion();
		String sentencia = "SELECT * FROM financiadores a ORDER BY a.nombre";
		Object[] financiador = null;
		ResultSet rs = conexion.consultarBD(sentencia);
		try {
			while (rs.next()) {
				financiador = new Object[4];

				financiador[0] = rs.getObject(1);
				financiador[1] = rs.getObject(2);
				financiador[2] = rs.getObject(3);

				financiador[3] = rs.getBytes(4); // archivo

				financiadores.add(financiador);
			}
			rs.close();
		} catch (SQLException e) {
			// e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}
		return financiadores;
	}

	public Object[] getTema(String id) {

		Conexion conexion = new Conexion();
		String sentencia = "   SELECT *  FROM temas WHERE id=" + id;
		Object[] curso = null;
		ResultSet rs = conexion.consultarBD(sentencia);
		try {
			if (rs.next()) {
				curso = new Object[12];

				curso[0] = rs.getObject(1);
				curso[1] = rs.getObject(2);
				curso[2] = rs.getObject(3);
				
				curso[3] = rs.getObject(4);
				curso[4] = rs.getBytes(5);
				curso[5] = rs.getObject(6);


				//6  nuevos
				curso[6] = rs.getObject(7);
				curso[7] = rs.getBytes(8);
				curso[8] = rs.getObject(9);

				
				curso[9] = rs.getObject(10);
				curso[10] = rs.getBytes(11);
				curso[11] = rs.getObject(12);

			}
			rs.close();
		} catch (SQLException e) {
			// e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}
		return curso;
	}

	public Object[] getCursoCompleto(String id) {

		Conexion conexion = new Conexion();
		String sentencia = "   SELECT a.*, p.nombre  FROM cursos a, proyectos p" + " WHERE a.id_proyecto = p.id AND a.id=" + id + " ORDER BY a.nombre";
		Object[] curso = null;
		ResultSet rs = conexion.consultarBD(sentencia);
		try {
			if (rs.next()) {
				curso = new Object[6];

				curso[0] = rs.getObject(1);
				curso[1] = rs.getObject(2);
				curso[2] = rs.getObject(3);

				curso[3] = rs.getObject(4);
				// curso[4] = rs.getObject(5);
				// curso[5] = rs.getObject(6);

			}
			rs.close();
		} catch (SQLException e) {
			// e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}
		return curso;
	}

	public List<Object[]> getCursos() {

		List<Object[]> cursos = new ArrayList<Object[]>();
		Conexion conexion = new Conexion();
		String sentencia = "   SELECT a.*, p.nombre  FROM cursos a, proyectos p" + " WHERE a.id_proyecto = p.id " + " ORDER BY a.id DESC";

		// antes era por nombre order by ahora por id desc
		Object[] curso = null;
		ResultSet rs = conexion.consultarBD(sentencia);
		try {
			while (rs.next()) {
				curso = new Object[6];

				curso[0] = rs.getObject(1);
				curso[1] = rs.getObject(2);
				curso[2] = rs.getObject(3);

				curso[3] = rs.getObject(4);
				// curso[4] = rs.getObject(5);
				// curso[5] = rs.getObject(6);

				cursos.add(curso);
			}
			rs.close();
		} catch (SQLException e) {
			// e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}
		return cursos;
	}

	public List<Object[]> getMujeres() {

		List<Object[]> mujeres = new ArrayList<Object[]>();
		Conexion conexion = new Conexion();
		String sentencia = "SELECT * FROM mujeres a ORDER BY primer_nombre, segundo_nombre, primer_apellido, segundo_apellido";
		Object[] mujer = null;
		ResultSet rs = conexion.consultarBD(sentencia);
		try {
			while (rs.next()) {
				mujer = new Object[numeroColumnasMujeres + 1];
				for (int i = 1; i <= numeroColumnasMujeres; i++) {

					mujer[i] = rs.getObject(i);
				}

				mujeres.add(mujer);
			}
			rs.close();
		} catch (SQLException e) {
			// e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}
		return mujeres;
	}

	public List<Administrador> getAdministradores() {
		List<Administrador> administradores = new ArrayList<Administrador>();
		Conexion conexion = new Conexion();
		String sentencia = "SELECT * FROM administradores a ORDER BY primer_nombre, segundo_nombre, primer_apellido, segundo_apellido";
		Administrador admin = null;
		ResultSet rs = conexion.consultarBD(sentencia);
		try {
			while (rs.next()) {
				admin = new Administrador();
				admin.setIdAdministrador(rs.getInt("id_administrador"));
				admin.setPrimerApellido(rs.getString("primer_apellido"));
				admin.setCorreo(rs.getString("correo"));
				admin.setDocumento(rs.getInt("documento"));
				admin.setPrimerNombre(rs.getString("primer_nombre"));
				admin.setSegundoApellido(rs.getString("segundo_apellido"));
				admin.setSegundoNombre(rs.getString("segundo_nombre"));

				administradores.add(admin);
			}
			rs.close();
		} catch (SQLException e) {
			// e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}
		return administradores;
	}

	public List<Certificado> getCertificados(String tipoCertificado, String documento, String nombre, String fechaI, String fechaF) {
		List<Certificado> certificados = new ArrayList<Certificado>();
		Certificado certificado = null;
		Conexion conexion = new Conexion();
		String sentencia = "SELECT c .* , t.nombre_certificacion FROM certificados c, tipo_certificacion t WHERE c.tipo_certificado = t.id ";

		if (tipoCertificado != null && !tipoCertificado.trim().equals("0")) {

			sentencia += " AND c.tipo_certificado='" + tipoCertificado + "'";
		}

		if (documento != null && !documento.trim().equals("")) {

			sentencia += " AND c.documento='" + documento + "'";
		}

		if (nombre != null && !nombre.trim().equals("")) {

			sentencia += " AND UPPER(c.nombre_completo) LIKE '%" + nombre.trim().toUpperCase() + "%'";
		}

		if (fechaI != null && !fechaI.trim().equals("")) {

			sentencia += " AND c.fecha_inicio >='" + fechaI + "'";
		}

		if (fechaF != null && !fechaF.trim().equals("")) {

			sentencia += " AND c.fecha_fin <='" + fechaF + "'";
		}

		ResultSet rs = conexion.consultarBD(sentencia);
		try {
			while (rs.next()) {
				certificado = new Certificado();
				certificado.setCiudadDepartamentoCurso(rs.getString("ciudad_depto_curso"));
				certificado.setCiudadDocumento(rs.getString("ciudad_documento"));
				certificado.setDocumento(rs.getLong("documento"));
				certificado.setFechaDisponibilidad(rs.getString("fecha_disponibilidad"));
				certificado.setFechaFin(rs.getString("fecha_fin"));
				certificado.setFechaInicio(rs.getString("fecha_inicio"));
				certificado.setId(rs.getInt("id_certificado"));
				certificado.setNombre(rs.getString("nombre_completo"));
				certificado.setTipoCertificado(rs.getString("nombre_certificacion"));
				certificado.setTipoDocumento(rs.getString("tipo_documento"));
				certificado.setNumeroHoras(rs.getInt("numero_horas"));
				certificados.add(certificado);

			}
			rs.close();
		} catch (SQLException e) {
			// e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}
		return certificados;
	}

	public Certificado getCertificado(int id) {
		Certificado certificado = null;
		Conexion conexion = new Conexion();
		String sentencia = "SELECT c .* , t.nombre_certificacion FROM certificados c, tipo_certificacion t WHERE c.tipo_certificado = t.id AND c.id_certificado =" + id;

		ResultSet rs = conexion.consultarBD(sentencia);
		try {
			while (rs.next()) {
				certificado = new Certificado();
				certificado.setCiudadDepartamentoCurso(rs.getString("ciudad_depto_curso"));
				certificado.setCiudadDocumento(rs.getString("ciudad_documento"));
				certificado.setDocumento(rs.getLong("documento"));
				certificado.setFechaDisponibilidad(rs.getString("fecha_disponibilidad"));
				certificado.setFechaFin(rs.getString("fecha_fin"));
				certificado.setFechaInicio(rs.getString("fecha_inicio"));
				certificado.setId(rs.getInt("id_certificado"));
				certificado.setNombre(rs.getString("nombre_completo"));
				certificado.setTipoCertificado(rs.getString("nombre_certificacion"));
				certificado.setTipoDocumento(rs.getString("tipo_documento"));
				certificado.setNumeroHoras(rs.getInt("numero_horas"));

			}
			rs.close();
		} catch (SQLException e) {
			// e.printStackTrace();
		} finally {
			conexion.cerrarConexion();
		}
		return certificado;
	}

	public static void main(String[] args) {

		String sarta = "5-dfvp-9";
		String[] varios = sarta.split("-dfvp-");
		for (int i = 0; i <= varios.length - 1; i++) {
			System.out.println(varios[i]);
		}

		// SimpleDateFormat formato = new SimpleDateFormat("yyy-MM-dd");
		//
		// AdministrarPublicaciones obj = new AdministrarPublicaciones();
		//
		// try {
		// getEdad(formato.parse("1985-01-19"));
		// } catch (ParseException e) {
		// // TODO Auto-generated catch block
		// e.printStackTrace();
		// }

	}
}
