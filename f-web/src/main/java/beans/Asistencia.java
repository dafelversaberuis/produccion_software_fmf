package beans;

import java.util.List;

public class Asistencia {

	private Object[] valor;

	private List<Asistencia> hijos;

	public Object[] getValor() {
		return valor;
	}

	public void setValor(Object[] valor) {
		this.valor = valor;
	}

	public List<Asistencia> getHijos() {
		return hijos;
	}

	public void setHijos(List<Asistencia> hijos) {
		this.hijos = hijos;
	}

}
