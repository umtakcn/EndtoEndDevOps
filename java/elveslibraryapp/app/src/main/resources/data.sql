INSERT INTO elves (id, name) VALUES
  (1, 'Vanyar'),
  (2, 'Noldor'),
  (3, 'Teleri');

INSERT INTO definition (id, value) VALUES
  (1, 'The Vanyar, also called the Fair Elves, Light-elves, and Spear-elves, were the first and smallest of the Kindreds of the Eldar.'),
  (2, 'The Ñoldor or in Third Age Middle-earth meaning those with knowledge, were the second clan of the Elves, alson known as ME'),
  (3, 'The Teleri, meaning Those who come last, were the third of the Elf clans who came to Aman. Those who came to Aman became known as the Falmari.');

INSERT INTO elves_definitions (elves_id, definitions_id) VALUES
  (1, 1),
  (2, 2),
  (3, 3);
