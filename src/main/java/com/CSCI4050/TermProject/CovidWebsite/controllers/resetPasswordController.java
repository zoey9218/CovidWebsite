package com.CSCI4050.TermProject.CovidWebsite.controllers;

import com.CSCI4050.TermProject.CovidWebsite.entities.AccountEntity;
import com.CSCI4050.TermProject.CovidWebsite.repository.AccountRepository;
import com.CSCI4050.TermProject.CovidWebsite.servlets.Utility;
import net.bytebuddy.utility.RandomString;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.repository.query.Param;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMailMessage;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.argon2.Argon2PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.security.auth.login.AccountNotFoundException;
import javax.servlet.http.HttpServletRequest;
import java.io.UnsupportedEncodingException;

@Controller
public class resetPasswordController {

    @Autowired
    private AccountRepository accountRepo;

    @Autowired
    private JavaMailSender mailSender;


    @RequestMapping(value = "/send_Email", method = RequestMethod.GET)
    public String showResetPasswordPage(ModelMap model) {
        model.addAttribute("resetPassword", new AccountEntity());
        return "reset_password_form";
    }

    @RequestMapping(value = "/send_Email", method = RequestMethod.POST)
    public String submitResetPasswordPage(@ModelAttribute("resetPassword") AccountEntity accountForm, ModelMap model, HttpServletRequest request) {
        model.addAttribute("resetPassword", new AccountEntity());

        String email = accountForm.getEmail();
        String resetPasswordToken = RandomString.make(45);

        try {
            updateResetPassword(resetPasswordToken, email);
            String resetPasswordLink = Utility.getSiteURL(request) + "/reset_password?token=" + resetPasswordToken;

            sendResetPasswordLink(email, resetPasswordLink);

            model.addAttribute("success", "We have sent a reset password link to your email!");
        } catch (AccountNotFoundException | UnsupportedEncodingException | MessagingException e) {
            e.printStackTrace();

        }


        return "reset_password_form";
    }

    @RequestMapping(value = "/reset_password", method = RequestMethod.GET)
    public String showEditPasswordPage(@Param(value = "token") String token, ModelMap model) {
        AccountEntity accountInstance = accountRepo.findByResetPasswordToken(token);
        model.addAttribute("resetPassword", new AccountEntity());

        if (accountInstance == null) {
            model.addAttribute("errorMessage", "Invalid Token");
            return "resetPasswordError";
        }

        model.addAttribute("token", token);
        model.addAttribute("title", "Reset Your Password");
        return "passwordForm";
    }

    @RequestMapping(value = "/reset_password", method = RequestMethod.POST)
    public String submitResetPassword(@ModelAttribute("editProfile") AccountEntity accountForm, @Param(value = "token") String token, ModelMap model) {
        AccountEntity accountInstance = accountRepo.findByResetPasswordToken(token);

        if(!accountForm.getPassword().matches(accountForm.getConfirmPassword())){
            model.addAttribute("passwordNoMatch", "The two passwords do not match");
            model.addAttribute("title", "Reset Your Password");
            model.addAttribute("resetPassword", new AccountEntity());
            return "passwordForm";
        }
        else{
            updatePassword(accountInstance, accountForm.getPassword());
            return "redirect:/login";
        }
//        accountInstance.setPassword(accountForm.getPassword());
//        accountRepo.save(accountInstance);


    }


    // Reset Password Methods
    private void sendResetPasswordLink(String email, String resetPasswordLink) throws UnsupportedEncodingException, MessagingException {

        AccountEntity accountInstance = accountRepo.findByEmail(email);
        String senderName = "DawgsvsCovid Support";
        String subject = "Reset Password";
        String content = "<p>Hello " + accountInstance.getFirstName() + ",</p>"
                + "<p>You have requested to reset your password.</p>"
                + "<p>Click the link below to change your password:</p>"
                + "<p><a href=\"" + resetPasswordLink + "\">Change my password</a></p>";


        MimeMessage message = mailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(message);
        helper.setFrom("DawgsvsCovid@gmail.com", senderName);
        helper.setTo(email);

        helper.setSubject(subject);
        helper.setText(content, true);

        mailSender.send(message);


    }


    public void updateResetPassword(String resetPasswordToken, String email) throws AccountNotFoundException {
        AccountEntity accountInstance = accountRepo.findByEmail(email);

        if (accountInstance != null) {
            accountInstance.setResetPasswordToken(resetPasswordToken);
            accountRepo.save(accountInstance);
        } else {
            throw new AccountNotFoundException("Could not find any account with the email: " + email);
        }

    }

    public AccountEntity get(String resetPasswordToken) {
        return accountRepo.findByResetPasswordToken(resetPasswordToken);
    }

    public void updatePassword(AccountEntity account, String newPassword) {

        int saltLength = 16; // salt length in bytes
        int hashLength = 32; // hash length in bytes
        int parallelism = 1; // currently not supported by Spring Security
        int memory = 4096; // memory costs
        int iterations = 3;

        Argon2PasswordEncoder argon2PasswordEncoder = new Argon2PasswordEncoder(saltLength, hashLength, parallelism,
                memory, iterations);

        String encodePassword = argon2PasswordEncoder.encode(newPassword);

        account.setPassword(encodePassword);
        account.setResetPasswordToken(null);
        accountRepo.save(account);

    }

}
