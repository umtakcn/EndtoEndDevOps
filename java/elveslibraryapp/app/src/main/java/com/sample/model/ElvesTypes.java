package com.sample.model;

public enum ElvesTypes {
    VANYAR("Vanyar"),
    NOLDOR("Noldor"),
    TELERI("Teleri");

    private String name;

    ElvesTypes(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return name;
    }
}
