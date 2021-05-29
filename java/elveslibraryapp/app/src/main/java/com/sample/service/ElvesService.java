package com.sample.service;

import com.sample.model.Elves;
import com.sample.repository.ElvesRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ElvesService {

    @Autowired
    ElvesRepository elvesRepository;

    public Elves getElvesByName(String name) {
        return elvesRepository.findByName(name);
    }
}
