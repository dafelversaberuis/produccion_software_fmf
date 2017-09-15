package beans;

public class Certificado {

	private int			id;
	private int			numeroHoras;
	private String	ciudadDepartamentoCurso;
	private String	ciudadDocumento;
	private long			documento;
	private String	fechaDisponibilidad;
	private String	fechaInicio;
	private String	fechaFin;
	private String	nombre;
	private String	tipoCertificado;
	private String	tipoDocumento;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getCiudadDepartamentoCurso() {
		return ciudadDepartamentoCurso;
	}

	public void setCiudadDepartamentoCurso(String ciudadDepartamentoCurso) {
		this.ciudadDepartamentoCurso = ciudadDepartamentoCurso;
	}

	public String getCiudadDocumento() {
		return ciudadDocumento;
	}

	public void setCiudadDocumento(String ciudadDocumento) {
		this.ciudadDocumento = ciudadDocumento;
	}

	public long getDocumento() {
		return documento;
	}

	public void setDocumento(long documento) {
		this.documento = documento;
	}

	public String getFechaDisponibilidad() {
		return fechaDisponibilidad;
	}

	public void setFechaDisponibilidad(String fechaDisponibilidad) {
		this.fechaDisponibilidad = fechaDisponibilidad;
	}

	public String getFechaInicio() {
		return fechaInicio;
	}

	public void setFechaInicio(String fechaInicio) {
		this.fechaInicio = fechaInicio;
	}

	public String getFechaFin() {
		return fechaFin;
	}

	public void setFechaFin(String fechaFin) {
		this.fechaFin = fechaFin;
	}

	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public String getTipoCertificado() {
		return tipoCertificado;
	}

	public void setTipoCertificado(String tipoCertificado) {
		this.tipoCertificado = tipoCertificado;
	}

	public String getTipoDocumento() {
		return tipoDocumento;
	}

	public void setTipoDocumento(String tipoDocumento) {
		this.tipoDocumento = tipoDocumento;
	}

	public int getNumeroHoras() {
		return numeroHoras;
	}

	public void setNumeroHoras(int numeroHoras) {
		this.numeroHoras = numeroHoras;
	}

}
