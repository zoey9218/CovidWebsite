package com.CSCI4050.TermProject.CovidWebsite.entities;

import javax.persistence.Embeddable;
import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import java.util.Date;

@Embeddable
public class CreditEntity {

//    @Min(13)@Max(16)
    private String ccNumber;

    private String ccDate;

    private String cc_CVC;

    private String ccName;

    private Integer paymentAmount = 0;


    // Getter and Setters

    public String getCcNumber() {
        return ccNumber;
    }

    public void setCcNumber(String ccNumber) {
        this.ccNumber = ccNumber;
    }

    public String getCcDate() {
        return ccDate;
    }

    public void setCcDate(String ccDate) {
        this.ccDate = ccDate;
    }

    public String getCc_CVC() {
        return cc_CVC;
    }

    public void setCc_CVC(String cc_CVC) {
        this.cc_CVC = cc_CVC;
    }

    public String getCcName() {
        return ccName;
    }

    public void setCcName(String ccName) {
        this.ccName = ccName;
    }

    public Integer getPaymentAmount() {
        return paymentAmount;
    }

    public void setPaymentAmount(Integer paymentAmount) {
        this.paymentAmount = paymentAmount;
    }




}
