package com.CSCI4050.TermProject.CovidWebsite.repository;

import java.util.Optional;

import com.CSCI4050.TermProject.CovidWebsite.entities.AccountEntity;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface AccountRepository extends CrudRepository<AccountEntity, Long> {

    Optional<AccountEntity> findById(Long Id);

    AccountEntity findByUserName(String userName);

    AccountEntity findByPassword(String password);

    AccountEntity findByEmail(String email);

    AccountEntity findByVerificationCode(String verificationCode);

    AccountEntity findByResetPasswordToken(String resetPasswordToken);


}