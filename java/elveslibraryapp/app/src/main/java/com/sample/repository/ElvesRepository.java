package com.sample.repository;

import com.sample.model.Elves;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ElvesRepository extends JpaRepository<Elves, Long> {
    Elves findByName(String name);
}
