package com.CSCI4050.TermProject.CovidWebsite.repository;

import java.util.List;
import java.util.Optional;
import com.CSCI4050.TermProject.CovidWebsite.entities.RequestEntity;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface RequestRepository extends CrudRepository<RequestEntity, Integer> {

    RequestEntity findById(Long Id);


}
