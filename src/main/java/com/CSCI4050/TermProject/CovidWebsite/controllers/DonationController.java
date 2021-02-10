package com.CSCI4050.TermProject.CovidWebsite.controllers;

import com.CSCI4050.TermProject.CovidWebsite.entities.AccountEntity;
import com.CSCI4050.TermProject.CovidWebsite.entities.CreditEntity;
import com.CSCI4050.TermProject.CovidWebsite.entities.RequestEntity;
import com.CSCI4050.TermProject.CovidWebsite.repository.AccountRepository;
import com.CSCI4050.TermProject.CovidWebsite.repository.RequestRepository;
import org.apache.coyote.Request;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.argon2.Argon2PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

@Controller
public class DonationController {

    @Autowired
    RequestRepository requestRepo;

    @Autowired
    AccountRepository accountRepo;

    @RequestMapping(value = "/donation/{userNameParameter}", method = RequestMethod.GET)
    public String showDonationData(@PathVariable("userNameParameter") String userName, ModelMap model) {
        model.addAttribute("requestForm", requestRepo.findAll());
        AccountEntity accountInstance = accountRepo.findByUserName(userName);
        model.addAttribute("account", accountInstance);

        return "donation";
    }

    @RequestMapping(value = "/donate/{userNameParameter}/{id}", method = RequestMethod.GET)
    public String donateMoney(@PathVariable("id") Long id, @PathVariable("userNameParameter") String userName, Model model) {
        RequestEntity requestForm = requestRepo.findById(id);
        AccountEntity accountInstance = accountRepo.findByUserName(userName);


        model.addAttribute("requestForm", requestForm);
        model.addAttribute("creditCardForm", new CreditEntity());
        model.addAttribute("account", accountInstance);

        return "checkout";
    }

    @RequestMapping(value = "/donate/{userNameParameter}/{id}", method = RequestMethod.POST)
    public String saveCreditCard(@ModelAttribute("creditCardForm")CreditEntity creditForm, @PathVariable("id") Long id, @PathVariable("userNameParameter") String userName, Model model) {
        AccountEntity accountInstance = accountRepo.findByUserName(userName);
        RequestEntity request = requestRepo.findById(id);
        model.addAttribute("creditCardForm", new CreditEntity());


        int difference;
        int saltLength = 16; // salt length in bytes
        int hashLength = 32; // hash length in bytes
        int parallelism = 1; // currently not supported by Spring Security
        int memory = 4096; // memory costs
        int iterations = 3;

        Argon2PasswordEncoder argon2PasswordEncoder = new Argon2PasswordEncoder(saltLength, hashLength, parallelism,
                memory, iterations);

        String encodeCC_Number = argon2PasswordEncoder.encode(creditForm.getCcNumber());

//        if(request)


        accountInstance.setCreditCard(creditForm);


        if(accountInstance.getCreditCard().getCc_CVC().isEmpty()){
            model.addAttribute("cvcEmpty", "*Required");

        }
        if(accountInstance.getCreditCard().getPaymentAmount() == null || accountInstance.getCreditCard().getPaymentAmount() == 0){
            model.addAttribute("ccpaymentNumber", "*Required");
        }
        if(accountInstance.getCreditCard().getCcNumber().isEmpty()){
            model.addAttribute("ccnumberEmpty", "*Required");
        }
        if(accountInstance.getCreditCard().getCcDate().isBlank()){
            model.addAttribute("ccdateEmpty", "*Required");
        }
        if(accountInstance.getCreditCard().getCcName().isEmpty()){
            model.addAttribute("ccnameEmpty", "*Required");
            return "checkout";
        }

        difference = request.getAmount() - accountInstance.getCreditCard().getPaymentAmount();

        if(difference > 0){
            request.setAmount(difference);
            request.setActive(true);
            accountInstance.getCreditCard().setPaymentAmount(accountInstance.getCreditCard().getPaymentAmount());
            accountInstance.getCreditCard().setCcNumber(encodeCC_Number);
            accountInstance.getCreditCard().setCc_CVC(creditForm.getCc_CVC());
            model.addAttribute("successful", "You have successfully donated $" + accountInstance.getCreditCard().getPaymentAmount());
            model.addAttribute("requestForm", requestRepo.findAll());
            model.addAttribute("account", accountInstance);

            accountRepo.save(accountInstance);
            return "donation";

        }
        if(difference < 0){
            model.addAttribute("tooMuch", "You have donated more money then requested");
            return "checkout";
        }
        if(difference == 0){

            request.setActive(false);
            request.setAmount(difference);
            accountInstance.getCreditCard().setPaymentAmount(accountInstance.getCreditCard().getPaymentAmount());
            accountInstance.getCreditCard().setCcNumber(encodeCC_Number);
            accountInstance.getCreditCard().setCc_CVC(creditForm.getCc_CVC());
            model.addAttribute("successful", "You have successfully donated $" + accountInstance.getCreditCard().getPaymentAmount());
            model.addAttribute("requestForm", requestRepo.findAll());
            model.addAttribute("account", accountInstance);
            accountRepo.save(accountInstance);
            return "donation";
        }


        return null;
    }

    // Both methods work for deleting a user out of the database

    // @RequestMapping(value = "/userData/delete/{email}", method =
    // RequestMethod.GET)
    // public String deleteUserData(@PathVariable("email") String email, Model
    // model) {
    // AccountEntity accountForm = accountRepo.findByEmail(email);

    // accountRepo.delete(accountForm);
    // model.addAttribute("accountForm", accountRepo.findAll());
    // return "userData";
    // }
}
