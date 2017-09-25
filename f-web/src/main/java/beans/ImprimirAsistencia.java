package beans;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.jasperreports.engine.JasperRunManager;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;

@WebServlet("/imprimirAsistencia.jsp")
public class ImprimirAsistencia extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = -8229643807196316718L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		try {

			String meses[] = { " ", "Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre" };

			String reporte = new String();
			reporte = "ListarAsistencia.jasper";

			String curso = request.getParameter("curso");
			String fecha = request.getParameter("fecha");
			String tema = request.getParameter("tema");
			String financiador = request.getParameter("financiador");
			String linea = request.getParameter("linea");
			String horas = request.getParameter("horas");
			String logo_f = "";

			byte[] archivoLogo = null;

			Object[] informacion = new AdministrarPublicaciones().getCursoTema(tema);
			Object[] cursoCompleto = new AdministrarPublicaciones().getCursoCompleto(curso);

			List<Object[]> lineas = new AdministrarPublicaciones().getLineasCurso(curso);
			if (lineas != null && lineas.size() > 0 && linea != null && cursoCompleto != null) {
				for (Object[] l : lineas) {
					if (Integer.parseInt("" + l[0]) == Integer.parseInt(linea)) {
						cursoCompleto[4] = "" + l[4];
						break;
					}
				}
			}

			List<Object[]> financiadores = new AdministrarPublicaciones().getFinanciadoresCurso(curso);
			if (financiadores != null && financiadores.size() > 0 && financiador != null && cursoCompleto != null) {
				for (Object[] l : financiadores) {
					if (Integer.parseInt("" + l[0]) == Integer.parseInt(financiador)) {
						cursoCompleto[5] = "" + l[4];
						logo_f = l[2] + "";

						archivoLogo = (byte[]) l[5];

						break;
					}
				}
			}

			// out.println("curso fecha tema "curso+curso+" * "+fecha+" * "+tema);

			List<Object[]> cursos = new AdministrarPublicaciones().getMujeresAsistencia(curso, tema, fecha);
			List<Asistencia> asistencia = new ArrayList<Asistencia>();
			if (cursos != null && cursos.size() > 0) {
				for (Object[] o : cursos) {
					Asistencia objeto = new Asistencia();
					objeto.setValor(o);
					asistencia.add(objeto);
				}

				String id = request.getParameter("i");
				String ruta_servidor_plantilla = request.getRealPath("/reportes/");
				String logo = request.getRealPath("/home_files/");
				String logo2 = request.getRealPath("/imagenes/logosFinanciadores/");
				Map pars = new HashMap();
				pars.put("variable", "este es el valor");
				pars.put("logo", logo + "/logo_original.png");

				if (archivoLogo != null) {
					new AdministrarPublicaciones().guardarArchivoDisco(logo2 + "/logo_financiador_" + logo_f + ".jpg", archivoLogo);
				}

				pars.put("logo_f", logo2 + "/logo_financiador_" + logo_f + ".jpg");
				pars.put("fecha", fecha);
				pars.put("tema", informacion);
				pars.put("horas", horas);
				pars.put("cursoCompleto", cursoCompleto);

				//

				// Cuando se quiere usar un listado
				// A la linea de bytes el ultimo parametro se cambia por datasource
				// y se descomentarea la siguiente linea y se le pasa el listado armado
				// un List<>
				JRBeanCollectionDataSource dataSource = new JRBeanCollectionDataSource(asistencia);

				// Si se quiere usar una conexion se pasa como parmetro un objeto de
				// conexion this.con ó
				// Connection conexion algo asi
				// y el ultimo parametro se de bytes se cambia por la conexion

				// Si solo son parametros, sin conexion ni lista solo como ultimo
				// parametro en la
				// linea de bytes lo siguiente: new JREmptyDataSource()

				byte[] bytes = JasperRunManager.runReportToPdf(ruta_servidor_plantilla + "/" + reporte, pars, dataSource);

				/* Indicamos que la respuesta va a ser en formato PDF */

				response.setContentType("application/pdf");
				response.setContentLength(bytes.length);
				ServletOutputStream ouputStream = response.getOutputStream();
				ouputStream.write(bytes, 0, bytes.length);

				/* Limpiamos y cerramos flujos de salida */

				ouputStream.flush();
				ouputStream.close();

			} else {
				// out.println("NO SE PUEDE MOSTRAR REPORTE");

			}

		} catch (Exception e) {
			// out.println("NO SE PUEDE MOSTRAR REPORTE");
		}

	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		super.doPost(req, resp);
	}
}
