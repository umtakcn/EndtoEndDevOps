package com.sample.controller;

import com.sample.model.Elves;
import com.sample.model.ElvesTypes;
import com.sample.service.ElvesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class ElvesController {

    @Autowired
    ElvesService elvesService;

    @GetMapping("/")
    public String index(Model model) {
        model.addAttribute("elves", ElvesTypes.values());
        return "index";
    }

    @GetMapping("/select")
    public String greeting(@RequestParam(name="name") String name, Model model) {
        Elves elves = elvesService.getElvesByName(name);
        model.addAttribute("name", name);
        model.addAttribute("definitions", elves.getDefinitions());
        return "definitions";
    }

}
