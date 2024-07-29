/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package register;

import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.AddressException;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.util.Properties;
import java.util.Random;
import model.Account;

/**
 *
 * @author KimHo
 */
public class EmailService {

    public String getRandom() {
        Random rnd = new Random();
        int number = rnd.nextInt(999999);

        return String.format("%06d", number);
    }

    public boolean sendEmail(Account a) {
        String toEmail = a.getEmail();
        String fromEmail = "quangvu1922@gmail.com";
        String password = "gdku hrng jcef abaz";
        boolean test = false;

        try {
            Properties props = new Properties();
            props.setProperty("mail.smtp.auth", "true");
            props.setProperty("mail.smtp.host", "smtp.gmail.com");
            props.setProperty("mail.smtp.port", "587");
            props.setProperty("mail.smtp.starttls.enable", "true");

            Session session = Session.getInstance(props, new jakarta.mail.Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(fromEmail, password);
                }
            });

            MimeMessage message = new MimeMessage(session);

            message.setFrom(new InternetAddress(fromEmail));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));

            message.setSubject("user Email Verification");
            message.setText("Registered successfully. Please verify your account using this code: " + a.getCode());

            Transport.send(message);
            test = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return test;
    }

    public static void sendEmailForContact(String host, String port,
            final String username, final String password, String toAddress,
            String subject, String message) throws AddressException, MessagingException {

        Properties prop = new Properties();
        prop.put("mail.smtp.host", host);
        prop.put("mail.smtp.port", port);
        prop.put("mail.smtp.auth", "true");
        prop.put("mail.smtp.starttls.enable", "true");
        prop.put("mail.smtp.ssl.trust", host);

        // Use javax.mail.Authenticator instead of java.net.Authenticator
        jakarta.mail.Authenticator auth = new jakarta.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        };
        Session session = Session.getInstance(prop, auth);
        MimeMessage mimeMessage = new MimeMessage(session);

        mimeMessage.setFrom(new InternetAddress(username));
        mimeMessage.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toAddress));
        mimeMessage.setSubject(subject, "UTF-8");
        mimeMessage.setText(message, "UTF-8");
        Transport.send(mimeMessage);
    }
}
