package com.CSCI4050.TermProject.CovidWebsite.controllers;

import com.CSCI4050.TermProject.CovidWebsite.entities.AccountEntity;
import com.CSCI4050.TermProject.CovidWebsite.repository.AccountRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.argon2.Argon2PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class LoginController {

    @Autowired
    private AccountRepository accountRepo;

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String showLoginPage(ModelMap model) {
        model.addAttribute("login", new AccountEntity());
        return "login";
    }

    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public Object submitLoginIn(@ModelAttribute("login") AccountEntity accountForm, Model model) {

        AccountEntity accountInstance = accountRepo.findByEmail(accountForm.getEmail().toLowerCase());

        // Password Verifier using Argon2
        Argon2PasswordEncoder argon2PasswordEncoder = new Argon2PasswordEncoder();


//        // Checks to see if the Email input field is empty
//        if (accountForm.getEmail().isEmpty()) {
//            model.addAttribute("emailEmpty", "*Please enter an email");
//        }
//
//        // Checks to see if the password input field is empty
//        if (accountForm.getPassword().isEmpty()) {
//            model.addAttribute("passwordEmpty", "*Please enter a password");
//            return "/login";
//        }

        // Checks to see if the email exists in the database; checks to see if the password is associated with the email; if not throw an error found in jsp
        if (accountInstance == null ||
                !argon2PasswordEncoder.matches(accountForm.getPassword(), accountInstance.getPassword()) ||
                accountForm.getEmail().isEmpty() ||
                accountForm.getPassword().isEmpty()) {

            System.out.println("Invalid Email or Password");
            model.addAttribute("invalidEmailPassword", "*Invalid Email or Password");
            // return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(null);
            return "/login";
        }

        // Checks to see if the email is verified, if not throw error found in jsp
        if (accountInstance.isEnabled() == false) {
            System.out.println("Cant login cause not verified");
            model.addAttribute("notVerified", "*The associated email is not verified");
            return "/login";
        }

        if(accountInstance.isSuspended() == true){
            System.out.println("This account is suspended; Please contact an administrator");
            model.addAttribute("suspended", "*This account is suspended; Please contact an administrator");
            return "/login";
        }

        if(!(accountInstance == null ||
                !argon2PasswordEncoder.matches(accountForm.getPassword(), accountInstance.getPassword()) ||
                accountForm.getEmail().isEmpty() ||
                accountForm.getPassword().isEmpty()) && !(accountInstance.isEnabled() == false)){

            System.out.println("account exist");
            model.addAttribute("account", accountInstance);
            return "welcome";
        }
        return null;

    }

}
