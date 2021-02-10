package com.CSCI4050.TermProject.CovidWebsite.controllers;

import com.CSCI4050.TermProject.CovidWebsite.entities.AccountEntity;
import com.CSCI4050.TermProject.CovidWebsite.entities.RequestEntity;
import com.CSCI4050.TermProject.CovidWebsite.repository.AccountRepository;

import com.CSCI4050.TermProject.CovidWebsite.servlets.Utility;
import net.bytebuddy.utility.RandomString;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.repository.query.Param;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.argon2.Argon2PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import java.io.UnsupportedEncodingException;

@Controller
public class WelcomeController {

    @Autowired
    AccountRepository accountRepo;

    @Autowired
    private JavaMailSender mailSender;

    @Autowired
    private RegistrationController registrationController;

//    public WelcomeController(RegistrationController registrationController){
//        this.registrationController = registrationController;
//    }

    @RequestMapping(value = "/welcome", method = RequestMethod.GET)
    public String showWelcomePage() {
        return "welcome";
    }

    @RequestMapping(value = "/welcome/{userNameParameter}", method = RequestMethod.GET)
    public String showWelcomePage2(@PathVariable("userNameParameter") String userName, Model model) {
        AccountEntity accountInstance = accountRepo.findByUserName(userName);

        model.addAttribute("account", accountInstance);

        return "welcome";
    }


    @RequestMapping(value = "edit/{emailParameter}", method = RequestMethod.GET)
    public String getEditUserData(@PathVariable("emailParameter") String email, Model model) {

        AccountEntity accountInstance = accountRepo.findByEmail(email);
        model.addAttribute("editProfile", new AccountEntity());
        model.addAttribute("accountInstance", accountInstance);

        return "editProfile";
    }


    @RequestMapping(value = "edit/{emailParameter}", method = RequestMethod.POST)
    public Object enterEditUserData(@ModelAttribute("editProfile") AccountEntity accountForm, @PathVariable("emailParameter") String email, Model model, HttpServletRequest request) throws UnsupportedEncodingException, MessagingException {

        AccountEntity accountInstance = accountRepo.findByEmail(email); // Grabs the instance of the email specified (gets all information associated with email)

        AccountEntity userNameChecker = accountRepo.findByUserName(accountForm.getUserName());
        AccountEntity emailChecker = accountRepo.findByEmail(accountForm.getEmail());


        // Password encoder called when registration happens
        int saltLength = 16; // salt length in bytes
        int hashLength = 32; // hash length in bytes
        int parallelism = 1; // currently not supported by Spring Security
        int memory = 4096; // memory costs
        int iterations = 3;

        Argon2PasswordEncoder argon2PasswordEncoder = new Argon2PasswordEncoder(saltLength, hashLength, parallelism,
                memory, iterations);
        String encodePassword = argon2PasswordEncoder.encode(accountForm.getPassword());


        // Need to fix these conditional statements
        if (emailChecker != null) {
            model.addAttribute("editProfile", new AccountEntity());
            model.addAttribute("accountInstance", accountInstance);
            model.addAttribute("emailExists", "*Email already Exist");
        }
        if (userNameChecker != null) {
            model.addAttribute("editProfile", new AccountEntity());
            model.addAttribute("accountInstance", accountInstance);
            model.addAttribute("usernameExists", "*Username already Exist");
        }

        if (accountForm.getFirstName().isEmpty()) {
            model.addAttribute("editProfile", new AccountEntity());
            model.addAttribute("accountInstance", accountInstance);
            model.addAttribute("firstNameEmpty", "*Required");
        }
        if (accountForm.getLastName().isEmpty()) {
            model.addAttribute("editProfile", new AccountEntity());
            model.addAttribute("accountInstance", accountInstance);
            model.addAttribute("lastNameEmpty", "*Required");
        }
        if (accountForm.getAge() == null) {
            model.addAttribute("editProfile", new AccountEntity());
            model.addAttribute("accountInstance", accountInstance);
            model.addAttribute("ageEmpty", "*Required");
        }
        if (accountForm.getEmail().isEmpty()) {
            model.addAttribute("editProfile", new AccountEntity());
            model.addAttribute("accountInstance", accountInstance);
            model.addAttribute("emailEmpty", "*Required");
        }
        if (accountForm.getUserName().isEmpty()) {
            model.addAttribute("editProfile", new AccountEntity());
            model.addAttribute("accountInstance", accountInstance);
            model.addAttribute("userNameEmpty", "*Required");
        }


        if (accountForm.getConfirmPassword().isEmpty()) {
            model.addAttribute("editProfile", new AccountEntity());
            model.addAttribute("accountInstance", accountInstance);
            model.addAttribute("confirmPasswordEmpty", "*Required");
        }

        if (accountForm.getPassword().isEmpty()) {
            model.addAttribute("editProfile", new AccountEntity());
            model.addAttribute("accountInstance", accountInstance);
            model.addAttribute("passwordEmpty", "*Required");
        }

        if (!argon2PasswordEncoder.matches(accountForm.getCurrentPassword(), accountInstance.getPassword())) {
            if (accountForm.getCurrentPassword().isEmpty()) {
                model.addAttribute("editProfile", new AccountEntity());
                model.addAttribute("accountInstance", accountInstance);
                model.addAttribute("currentPasswordEmpty", "*Required");

            } else {
                model.addAttribute("currentPasswordNoMatch", "Wrong account password");
                model.addAttribute("editProfile", new AccountEntity());
                model.addAttribute("accountInstance", accountInstance);
            }
//            return "editProfile";


        }

        if (!accountForm.getPassword().matches(accountForm.getConfirmPassword())) {

            model.addAttribute("confirmPasswordNoMatch", "Did not confirm new passwords correctly");
            model.addAttribute("editProfile", new AccountEntity());
            model.addAttribute("accountInstance", accountInstance);
            return "editProfile";
        }


        if (!(emailChecker != null)
                && !(userNameChecker != null)
                && !(accountForm.getPassword().isEmpty())
                && !(!accountForm.getPassword().matches(accountForm.getConfirmPassword()))
                && !(!argon2PasswordEncoder.matches(accountForm.getCurrentPassword(), accountInstance.getPassword()))
                && !(accountForm.getConfirmPassword().isEmpty())
                && !(accountForm.getFirstName().isEmpty())
                && !(accountForm.getLastName().isEmpty())
                && !(accountForm.getAge() == null)
                && !(accountForm.getEmail().isEmpty())
                && !(accountForm.getUserName().isEmpty())) {

            String randomVerificationCode = RandomString.make(64);
            accountInstance.setVerificationCode(randomVerificationCode);

            String siteURL = Utility.getSiteURL(request);
            accountInstance.setPassword(encodePassword);
            accountInstance.setEmail(accountForm.getEmail().toLowerCase());
            accountInstance.setFirstName(accountForm.getFirstName());
            accountInstance.setLastName(accountForm.getLastName());
            accountInstance.setAge(accountForm.getAge());
            accountInstance.setUserName(accountForm.getUserName());
            accountInstance.setEnabled(false);
            accountRepo.save(accountInstance);
            registrationController.sendVerificationEmail(accountInstance, siteURL);
            return "editProfileSuccess";
        }
        return "editProfile";

    }


    @GetMapping("/verifyEditedEmail")
    public String verifyEditedEmail(@Param("code") String code, Model model) {
        boolean verified = registrationController.verify(code);
        String pageTitle = verified ? "Verification Succeeded!" : "Verification Failed";
        model.addAttribute("pageTitle", pageTitle);
        return verified ? "verifySuccess" : "verifyFail";
    }


}
