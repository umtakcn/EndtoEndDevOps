package com.sample.model;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
public class Elves {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    long id;

    String name;

    @OneToMany(targetEntity = Definition.class, cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    List<Definition> definitions = new ArrayList<>();

    public Elves() {

    }

    public Elves(String name) {
        this.name = name;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public List<Definition> getDefinitions() {
        return definitions;
    }

    public void setDefinitions(List<Definition> definitions) {
        this.definitions = definitions;
    }
}
