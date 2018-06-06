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

@WebServlet("/imprimirAsistencia3.jsp")
public class ImprimirAsistencia3 extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 7706945334120128074L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		try {

			String meses[] = { " ", "Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre" };

			String reporte = new String();
			reporte = "listarAsistenciaRegistrada.jasper";

			String curso = request.getParameter("curso");
			String tema = request.getParameter("tema");
			String fecha_desde = request.getParameter("fecha_desde");
			String fecha_hasta = request.getParameter("fecha_hasta");
			String tipo = request.getParameter("tipo");
			String asistio_mujer = request.getParameter("asistio_mujer");
			String proyecto = request.getParameter("proyecto");
			String linea = request.getParameter("linea");
			String financiador = request.getParameter("financiador");
			String documento = request.getParameter("documento");
			
			String c14 = request.getParameter("c14");
			String c15 = request.getParameter("c15");
			String c16 = request.getParameter("c16");

			// Object[] informacion = bAdministrarPublicaciones.getCursoTema(tema);
			// Object[] cursoCompleto =
			// bAdministrarPublicaciones.getCursoCompleto(curso);

			// out.println("curso fecha tema "curso+curso+" * "+fecha+" * "+tema);

			List<Object[]> cursos = new AdministrarPublicaciones().getMujeresAsistencia3(curso, tema, fecha_desde, fecha_hasta, tipo, asistio_mujer, proyecto, linea, financiador, documento,c14,c15,c16);
			List<Asistencia> asistencia = new ArrayList<Asistencia>();

			int cuenta_si = 0;
			int cuenta_no = 0;
			int cuenta_todas = 0;

			if (cursos != null && cursos.size() > 0) {
				for (Object[] o : cursos) {
					Asistencia objeto = new Asistencia();
					cuenta_todas++;
					objeto.setValor(o);

					if (o[11] != null && o[11].equals("Si")) {
						cuenta_si++;
						;
					} else {
						cuenta_no++;
					}

					asistencia.add(objeto);
				}

				String id = request.getParameter("i");
				String ruta_servidor_plantilla = request.getRealPath("/reportes/");
				String logo = request.getRealPath("/home_files/");
				Map pars = new HashMap();
				pars.put("cuenta_si", cuenta_si);
				pars.put("cuenta_no", cuenta_no);
				pars.put("cuenta_todas", cuenta_todas);
				pars.put("variable", "este es el valor");
				pars.put("logo", logo + "/logo_original.png");
				
				
				
			//*******************NUEVO LO GO DE BD
				try {
					logo = request.getRealPath("/imagenes/logosLogos/");
					Object[] logoReal = new AdministrarPublicaciones().getLogo(1);
					byte[] archivoLogoReal = (byte[]) logoReal[3];
					if (archivoLogoReal != null) {
						new AdministrarPublicaciones().guardarArchivoDisco(logo + "/logo_financiador_OK.jpg", archivoLogoReal);
						pars.put("logo", logo + "/logo_financiador_OK.jpg");
					}
				} catch (Exception e) {
					logo = request.getRealPath("/home_files/");
					pars.put("logo", logo + "/logo_original.png");
				}
				//********************************************

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
