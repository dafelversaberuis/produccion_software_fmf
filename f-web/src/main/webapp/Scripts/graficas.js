function graficaT(identificador, grafica, discriminacion) {
	var chart;
	var datos;
	var ejex;
	var ejey;
	var titulo;
	var poblacion;


//	poblacion = parseInt(document.getElementById('hdnC1P').value) + parseInt(document.getElementById('hdnC2P').value)
//			+ parseInt(document.getElementById('hdnC3P').value) + parseInt(document.getElementById('hdnC4P').value)
//			+ parseInt(document.getElementById('hdnC5P').value);

	ejey = "NUMERO DE INSCRITOS";
	if (parseInt(discriminacion) == 1) {
ejex="ITEMS VER TABLA";
titulo="No. INSCRITOS VS ITEMS";
if(parseInt(document.getElementById('hdnNumeroResultados').value)>0){
	for(i=1; i<=parseInt(document.getElementById('hdnNumeroResultados').value); i++){
	
		datos = datos + "<set label='It "+ i +"' name='"+document.getElementById('hdnPrograma'+i).value+"' value='" + document.getElementById('hdnInscritosPrograma'+i).value + "' isSliced='0'/>";											 
	
	}

	
}


	}



	switch (grafica) {

	
	case '3':

		chart = new FusionCharts("../graficas/Bar2D.swf", identificador, "500", "280", "0", "0");
		chart.setDataXML("<chart palette='3' caption='" + titulo + "' xAxisName='" + ejex + "' yAxisName='" + ejey
				+ "' showValues='1' decimals='0' formatNumberScale='0' chartRightMargin='30'>" + datos + "</chart>");

		chart.render(identificador);
		break;

	case '2':
		chart = new FusionCharts("../graficas/Pie3D.swf", identificador, "500", "280", "0", "0");
		chart.setDataXML("<graph showNames='1'  caption='" + titulo + "' decimalPrecision='0'   palette='3' >" + datos +

		"</graph>");

		chart.render(identificador);
		break;
		
	case '1':
	chart = new FusionCharts("../graficas/Column3D.swf", identificador, "500", "280", "0", "0");
		chart.setDataXML("<chart palette='3' caption='" + titulo + "' xAxisName='" + ejex + "' yAxisName='" + ejey
				+ "' showValues='1' decimals='0' formatNumberScale='0' chartRightMargin='30'>" + datos + "</chart>");

		chart.render(identificador);
		break;

	}

	
//	if (parseInt(pregunta) == 18) {
//		document.getElementById('leyenda1').innerHTML = "* Indicad. generados a partir de egresados registrados y no registrados. Población: "
//				+ poblacion + " egresado(s)";
//	}else if (parseInt(pregunta) == 19) {
//		document.getElementById('leyenda1').innerHTML = "";
//	} else {
//		document.getElementById('leyenda1').innerHTML = "* Indicad. generados a partir  de egresados registrados que han respondido 'que hacen'. Población: "
//				+ poblacion + " egresado(s)";
//	}

}
