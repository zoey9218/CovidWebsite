package com.CSCI4050.TermProject.CovidWebsite.controllers;

import com.CSCI4050.TermProject.CovidWebsite.entities.AccountEntity;
import com.CSCI4050.TermProject.CovidWebsite.repository.AccountRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class UserDataController {

    @Autowired
    AccountRepository accountRepo;

    @RequestMapping(value = "/userData", method = RequestMethod.GET)
    public String showUserData(ModelMap model) {
        model.addAttribute("accountForm", accountRepo.findAll());
        return "userData";
    }

    @RequestMapping(value = "/delete", method = RequestMethod.GET)
    public String deleteUserData(@RequestParam("email") String email, Model model) {
        AccountEntity accountForm = accountRepo.findByEmail(email);

        accountRepo.delete(accountForm);
        model.addAttribute("accountForm", accountRepo.findAll());
        return "redirect:/userData";
    }

    @RequestMapping(value = "/suspend", method = RequestMethod.GET)
    public String suspendUser(@RequestParam("email") String email, Model model) {
        AccountEntity accountForm = accountRepo.findByEmail(email);

        model.addAttribute("accountForm", accountRepo.findAll());
        accountForm.setSuspended(true);
        accountRepo.save(accountForm);
        return "redirect:/userData";
    }

    @RequestMapping(value = "/unsuspend", method = RequestMethod.GET)
    public String unsuspendUser(@RequestParam("email") String email, Model model) {
        AccountEntity accountForm = accountRepo.findByEmail(email);

        model.addAttribute("accountForm", accountRepo.findAll());
        accountForm.setSuspended(false);
        accountRepo.save(accountForm);
        return "redirect:/userData";
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
