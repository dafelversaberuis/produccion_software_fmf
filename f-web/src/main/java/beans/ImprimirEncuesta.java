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

@WebServlet("/imprimirEncuesta.jsp")
public class ImprimirEncuesta extends HttpServlet {


	/**
	 * 
	 */
	private static final long serialVersionUID = 5273249543707188327L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		try {

			String meses[] = { " ", "Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre" };

			String reporte = new String();
			reporte = "listarEncuesta.jasper";

			List<Asistencia> listado = new ArrayList<Asistencia>();
			Asistencia p = null;
			String id = request.getParameter("encuesta");

			Object[] encuesta = new AdministrarPublicaciones().getNombreEncuesta(id);

			List<Object[]> preguntas = new AdministrarPublicaciones().getPreguntas(id);
			int j = 0;
			if (preguntas != null && preguntas.size() > 0) {
				for (Object[] pregunta : preguntas) {
					p = new Asistencia();
					p.setValor(pregunta);

					if (pregunta[3].equals("U") || pregunta[3].equals("M")) {

						List<Object[]> opciones = new AdministrarPublicaciones().getOpciones("" + pregunta[0]);
						if (opciones != null && opciones.size() > 0) {
							p.setHijos(new ArrayList<Asistencia>());
							for (Object[] o : opciones) {
								Asistencia hijo = new Asistencia();
								hijo.setValor(o);
								p.getHijos().add(hijo);
							}

						}

					}

					listado.add(p);

				}

				String ruta_servidor_plantilla = request.getRealPath("/reportes/");
				String logo = request.getRealPath("/home_files/");
				Map pars = new HashMap();
				pars.put("variable", "este es el valor");
				pars.put("logo", logo + "/logo_original.png");
				pars.put("encuesta", encuesta);
				pars.put("SUBREPORT_DIR", ruta_servidor_plantilla + "/");
				
				
				
				
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
				JRBeanCollectionDataSource dataSource = new JRBeanCollectionDataSource(listado);

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
				//out.println("NO SE PUEDE MOSTRAR REPORTE");

			}

		} catch (Exception e) {
			//out.println("NO SE PUEDE MOSTRAR REPORTE");
		}

	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		super.doPost(req, resp);
	}
}
