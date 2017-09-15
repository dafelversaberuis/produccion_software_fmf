package beans;

import com.elibom.client.ElibomRestClient;


public class prueba {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		//BigDecimal porcentaje = new BigDecimal(100).divide(new BigDecimal(1),10,RoundingMode.HALF_UP).setScale(2, RoundingMode.HALF_UP);
		
	System.setProperty("jsse.enableSNIExtension", "false"); // if you are using Java 7
		
	  ElibomRestClient elibom = new ElibomRestClient("dannypipe@gmail.com", "KGr49L9KLO");
    
    String deliveryId = elibom.sendMessage("573015018048", "dfvergel");
    System.out.println(deliveryId);
    
    
  }
		


}
