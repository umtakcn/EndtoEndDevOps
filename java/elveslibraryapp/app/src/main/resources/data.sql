INSERT INTO elves (id, name) VALUES
  (1, 'Noldor'),
  (2, 'Teleri'),
  (3, 'Vanyar');

INSERT INTO definition (id, source, value) VALUES
  (1, 'https://www.definitions.net/definition/Noldor', 'In the works of J. R. R. Tolkien, the Noldor (also spelled Ñoldor, meaning those with knowledge in Quenya) are High Elves of the Second Clan who migrated to Valinor and lived in Eldamar'),
  (2, 'https://www.definitions.net/definition/Teleri', 'In the works of J. R. R. Tolkien, the Teleri, Those who come last in Quenya (singular Teler) were the third of the Elf clans who came to Aman'),
  (3, 'https://www.glyphweb.com/arda/t/teleri.php', 'The third and greatest of the three Elf-kindreds of the Great Journey, from whom the Nandor and the Sindar were descended. The Teleri came last to Aman, and dwelt in Alqualondë on the western shores of the Great Sea.');

INSERT INTO elves_definitions (elves_id, definitions_id) VALUES
  (1, 1),
  (2, 2),
  (2, 3);