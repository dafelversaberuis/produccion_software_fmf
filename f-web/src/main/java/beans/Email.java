package beans;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class Email {

	private static final String	SMTP_HOST_NAME	= "smtp.gmail.com";
	private static final int		SMTP_HOST_PORT	= 465;
	private static final String	SMTP_AUTH_USER	= "quimerapps@gmail.com";
	private static final String	SMTP_AUTH_PWD		= "mariacamila12";

	public static void main(String[] args) throws Exception {
		new Email().enviarEmail("ESTO ES UN CORREO AUTOMATICO2", "ASUNTO2", "dafelver@hotmail.com");

	}

	public void enviarEmail(String Mensaje, String Asunto, String Correo) throws Exception {
		Properties props = new Properties();

		props.put("mail.transport.protocol", "smtps");
		props.put("mail.smtps.host", SMTP_HOST_NAME);
		props.put("mail.smtps.auth", "true");
		props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		props.put("mail.smtps.quitwait", "false");

		Session mailSession = Session.getDefaultInstance(props);

		// si se quiere que el programa muestre paso a paso el proceso de como se
		// envia, se descomentarea la sig linea
		mailSession.setDebug(false);
		Transport transport = mailSession.getTransport();

		MimeMessage message = new MimeMessage(mailSession);
		message.setSubject(Asunto, "UTF-8");

		// con texto html simple
		message.setContent(Mensaje, "text/html; charset=UTF-8");

		// SI QUEREMOS USAR A CALUMET COMO FROM PERO LO ENVIA ES EL SERVIDOR DE
		// GMAIL
		message.setFrom(new InternetAddress(SMTP_AUTH_USER, "Fundación Mujer y Futuro"));

		// PARA MANDAR CORREO DE UNO EN UNO
		message.addRecipient(Message.RecipientType.TO, new InternetAddress(Correo));

		transport.connect(SMTP_HOST_NAME, SMTP_HOST_PORT, SMTP_AUTH_USER, SMTP_AUTH_PWD);

		transport.sendMessage(message, message.getRecipients(Message.RecipientType.TO));

		transport.close();
	}
}