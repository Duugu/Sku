------------------------------------------------------------------------------------------------------------------
SkuAuras.DefaultAuras = {

}
--setmetatable(SkuAuras.DefaultAuras, SkuPrintMTWo)

SkuAuras.AuraSets = {
   
   priestShadow = {
      tooltip = {
         "Aura set für Schatten Priester\r\nEigene Buffs und Debuffs:\r\n- Inneres feuer verloren\r\n- Schattenschild verloren\r\n- Schattengestalt verloren\r\n- Geschwächte Seele verloren\r\nBuffs und Debuffs Gruppe:\r\n- Machtwort Seelenstärke verloren\r\n- Schattenschutz verloren\r\nEigene Cooldowns:\r\n- Verblassen\r\n- Psychischer Schrei\r\n- Gedankenschlag\r\n- Stille\r\n- Furchtzauberschutz\r\n- Schattengeist\r\n- Vampirumarmung\r\nDebuffs auf Gegner:\r\n- Untote fesseln ausgelaufen\r\n- Schattenwort Schmerz ausgelaufen",
         },
      friendlyName = "Priester Schatten",
      auras = {
         --AURAS
         -- Inneres feuer			aura verloren selbst
         ["Wenn;Quelle;gleich;selbst;und;ereignis;gleich;aura verloren;und;zauber name;gleich;Inneres Feuer;oder;zauber name;gleich;Verbessertes inneres Feuer;dann;audio ausgabe;aura;sound#dang;zauber name;"] = {
            ["friendlyNameShort"] = "Inneres feuer verloren selbst",
            ["enabled"] = true,
            ["type"] = "if",
            ["attributes"] = {
               ["sourceUnitId"] = {
                  {
                     "is", -- [1]
                     "player", -- [2]
                  }, -- [1]
               },
               ["event"] = {
                  {
                     "is", -- [1]
                     "SPELL_AURA_REMOVED", -- [2]
                  }, -- [1]
               },
               ["spellName"] = {
                  {
                     "is", -- [1]
                     "spell:Inneres Feuer", -- [2]
                  }, -- [1]
                  {
                     "is", -- [1]
                     "spell:Verbessertes inneres Feuer", -- [2]
                  }, -- [2]
               },
            },
            ["actions"] = {
               "notifyAudio", -- [1]
            },
            ["outputs"] = {
               "output:sounddang", -- [1]
               "output:spellName", -- [2]
            },
         },
         -- Weakened Soul			aura verloren selbst
         ["Wenn;Quelle;gleich;selbst;und;ereignis;gleich;aura verloren;und;zauber name;gleich;Geschwächte Seele;dann;audio ausgabe;aura;sound#dang;zauber name;"] = {
            ["friendlyNameShort"] = "Geschwächte Seele verloren selbst",
            ["enabled"] = true,
            ["type"] = "if",
            ["attributes"] = {
               ["sourceUnitId"] = {
                  {
                     "is", -- [1]
                     "player", -- [2]
                  }, -- [1]
               },
               ["event"] = {
                  {
                     "is", -- [1]
                     "SPELL_AURA_REMOVED", -- [2]
                  }, -- [1]
               },
               ["spellName"] = {
                  {
                     "is", -- [1]
                     "spell:Geschwächte Seele", -- [2]
                  }, -- [1]
               },
            },
            ["actions"] = {
               "notifyAudio", -- [1]
            },
            ["outputs"] = {
               "output:sounddang", -- [1]
               "output:spellName", -- [2]
            },
         },
         -- Schattenschild		aura verloren selbst	
         ["Wenn;Quelle;gleich;selbst;und;ereignis;gleich;aura verloren;und;zauber name;gleich;Schattenschild;dann;audio ausgabe;aura;sound#dang;zauber name;"] = {
            ["friendlyNameShort"] = "Schattenschild verloren selbst",
            ["enabled"] = true,
            ["type"] = "if",
            ["attributes"] = {
               ["sourceUnitId"] = {
                  {
                     "is", -- [1]
                     "player", -- [2]
                  }, -- [1]
               },
               ["event"] = {
                  {
                     "is", -- [1]
                     "SPELL_AURA_REMOVED", -- [2]
                  }, -- [1]
               },
               ["spellName"] = {
                  {
                     "is", -- [1]
                     "spell:Schattenschild", -- [2]
                  }, -- [1]
               },
            },
            ["actions"] = {
               "notifyAudio", -- [1]
            },
            ["outputs"] = {
               "output:sounddang", -- [1]
               "output:spellName", -- [2]
            },
         },
         -- Schattengestalt		aura verloren selbst
         ["Wenn;Quelle;gleich;selbst;und;ereignis;gleich;aura verloren;und;zauber name;gleich;Schattengestalt;dann;audio ausgabe;aura;sound#dang;zauber name;"] = {
            ["friendlyNameShort"] = "Schattengestalt verloren selbst",
            ["enabled"] = true,
            ["type"] = "if",
            ["attributes"] = {
               ["sourceUnitId"] = {
                  {
                     "is", -- [1]
                     "player", -- [2]
                  }, -- [1]
               },
               ["event"] = {
                  {
                     "is", -- [1]
                     "SPELL_AURA_REMOVED", -- [2]
                  }, -- [1]
               },
               ["spellName"] = {
                  {
                     "is", -- [1]
                     "spell:Schattengestalt", -- [2]
                  }, -- [1]
               },
            },
            ["actions"] = {
               "notifyAudio", -- [1]
            },
            ["outputs"] = {
               "output:sounddang", -- [1]
               "output:spellName", -- [2]
            },
         },	
         -- Machtwort: Seelenstärke	aura verloren gruppe
         ["Wenn;zauber name;gleich;Machtwort: Seelenstärke;oder;zauber name;gleich;Machtwort: Seelenstärke;oder;zauber name;gleich;Verbessertes Machtwort: Seelenstärke;oder;zauber name;gleich;Gebet der Seelenstärke;oder;zauber name;gleich;Heiliges Wort: Seelenstärke;und;ereignis;gleich;aura verloren;und;Quelle;gleich;gruppenmitglied;dann;audio ausgabe;aura;sound#bring;zauber name;ereignis;"] = {
            ["friendlyNameShort"] = "Machtwort Seelenstärke verloren gruppe";
            ["enabled"] = true,
            ["type"] = "if",
            ["attributes"] = {
               ["spellName"] = {
                  {
                     "is", -- [1]
                     "spell:Machtwort: Seelenstärke", -- [2]
                  }, -- [1]
                  {
                     "is", -- [1]
                     "spell:Verbessertes Machtwort: Seelenstärke", -- [2]
                  }, -- [1]
                  {
                     "is", -- [1]
                     "spell:Gebet der Seelenstärke", -- [2]
                  }, -- [1]
                  {
                     "is", -- [1]
                     "spell:Heiliges Wort: Seelenstärke", -- [2]
                  }, -- [1]
               },
               ["event"] = {
                  {
                     "is", -- [1]
                     "SPELL_AURA_REMOVED", -- [2]
                  }, -- [1]
               },
               ["sourceUnitId"] = {
                  {
                     "is", -- [1]
                     "party", -- [2]
                  }, -- [1]
               },
            },
            ["actions"] = {
               "notifyAudio", -- [1]
            },
            ["outputs"] = {
               "output:sounddang", -- [1]
               "output:spellName", -- [2]
               "output:event", -- [3]
            },
         },
         -- Schattenschutz	aura verloren gruppe
         ["Wenn;zauber name;gleich;Schattenschutz;oder;zauber name;gleich;Gebet des Schattenschutzes;und;ereignis;gleich;aura verloren;und;Quelle;gleich;gruppenmitglied;dann;audio ausgabe;aura;sound#bring;zauber name;ereignis;"] = {
            ["friendlyNameShort"] = "Schattenschutz verloren gruppe";
            ["enabled"] = true,
            ["type"] = "if",
            ["attributes"] = {
               ["spellName"] = {
                  {
                     "is", -- [1]
                     "spell:Schattenschutz", -- [2]
                  }, -- [1]
                  {
                     "is", -- [1]
                     "spell:Gebet des Schattenschutzes", -- [2]
                  }, -- [1]
               },
               ["event"] = {
                  {
                     "is", -- [1]
                     "SPELL_AURA_REMOVED", -- [2]
                  }, -- [1]
               },
               ["sourceUnitId"] = {
                  {
                     "is", -- [1]
                     "party", -- [2]
                  }, -- [1]
               },
            },
            ["actions"] = {
               "notifyAudio", -- [1]
            },
            ["outputs"] = {
               "output:sounddang", -- [1]
               "output:spellName", -- [2]
               "output:event", -- [3]
            },
         },

         --COOLDOWNS
         -- Verblassen			cd bereit
         ["Wenn;zauber name;gleich;Verblassen;oder;zauber name;gleich;Verbessertes Verblassen;und;ereignis;gleich;zauber cooldown ende;und;Quelle;gleich;selbst;dann;audio ausgabe;zauber name;ereignis;"] = {
            ["friendlyNameShort"] = "verblassen cooldown",
            ["enabled"] = true,
            ["type"] = "if",
            ["attributes"] = {
               ["spellName"] = {
                  {
                     "is", -- [1]
                     "spell:Verblassen", -- [2]
                  }, -- [1]
                  {
                     "is", -- [1]
                     "spell:Verbessertes Verblassen", -- [2]
                  }, -- [2]
               },
               ["event"] = {
                  {
                     "is", -- [1]
                     "SPELL_COOLDOWN_END", -- [2]
                  }, -- [1]
               },
               ["sourceUnitId"] = {
                  {
                     "is", -- [1]
                     "player", -- [2]
                  }, -- [1]
               },
            },
            ["actions"] = {
               "notifyAudio", -- [1]
            },
            ["outputs"] = {
               "output:sounddang", -- [1]
               "output:spellName", -- [1]
               "output:event", -- [2]
            },
         },
         -- Schattengeist			cd bereit
         ["Wenn;zauber name;gleich;Schattengeist;oder;zauber name;gleich;Verbesserter Schattengeist;und;ereignis;gleich;zauber cooldown ende;und;Quelle;gleich;selbst;dann;audio ausgabe;zauber name;ereignis;"] = {
            ["friendlyNameShort"] = "Schattengeist cooldown",
            ["enabled"] = true,
            ["type"] = "if",
            ["attributes"] = {
               ["spellName"] = {
                  {
                     "is", -- [1]
                     "spell:Schattengeist", -- [2]
                  }, -- [1]
                  {
                     "is", -- [1]
                     "spell:Verbesserter Schattengeist", -- [2]
                  }, -- [2]
               },
               ["event"] = {
                  {
                     "is", -- [1]
                     "SPELL_COOLDOWN_END", -- [2]
                  }, -- [1]
               },
               ["sourceUnitId"] = {
                  {
                     "is", -- [1]
                     "player", -- [2]
                  }, -- [1]
               },
            },
            ["actions"] = {
               "notifyAudio", -- [1]
            },
            ["outputs"] = {
               "output:sounddang", -- [1]
               "output:spellName", -- [1]
               "output:event", -- [2]
            },
         },	


         -- Psychischer Schrei		cd bereit	
         ["Wenn;zauber name;gleich;Vampirumarmung;oder;zauber name;gleich;Verbesserte Vampirumarmung;und;ereignis;gleich;zauber cooldown ende;und;Quelle;gleich;selbst;dann;audio ausgabe;zauber name;ereignis;"] = {
            ["friendlyNameShort"] = "Vampirumarmung cooldown",
            ["enabled"] = true,
            ["type"] = "if",
            ["attributes"] = {
               ["spellName"] = {
                  {
                     "is", -- [1]
                     "spell:Vampirumarmung", -- [2]
                  }, -- [1]
                  {
                     "is", -- [1]
                     "spell:Verbesserte Vampirumarmung", -- [2]
                  }, -- [2]
               },
               ["event"] = {
                  {
                     "is", -- [1]
                     "SPELL_COOLDOWN_END", -- [2]
                  }, -- [1]
               },
               ["sourceUnitId"] = {
                  {
                     "is", -- [1]
                     "player", -- [2]
                  }, -- [1]
               },
            },
            ["actions"] = {
               "notifyAudio", -- [1]
            },
            ["outputs"] = {
               "output:sounddang", -- [1]
               "output:spellName", -- [1]
               "output:event", -- [2]
            },
         },
            
         -- Psychischer Schrei		cd bereit	
         ["Wenn;zauber name;gleich;Psychischer Schrei;oder;zauber name;gleich;Verbesserter psychischer Schrei;und;ereignis;gleich;zauber cooldown ende;und;Quelle;gleich;selbst;dann;audio ausgabe;zauber name;ereignis;"] = {
            ["friendlyNameShort"] = "Psychischer Schrei cooldown",
            ["enabled"] = true,
            ["type"] = "if",
            ["attributes"] = {
               ["spellName"] = {
                  {
                     "is", -- [1]
                     "spell:Psychischer Schrei", -- [2]
                  }, -- [1]
                  {
                     "is", -- [1]
                     "spell:Verbesserter psychischer Schrei", -- [2]
                  }, -- [2]
               },
               ["event"] = {
                  {
                     "is", -- [1]
                     "SPELL_COOLDOWN_END", -- [2]
                  }, -- [1]
               },
               ["sourceUnitId"] = {
                  {
                     "is", -- [1]
                     "player", -- [2]
                  }, -- [1]
               },
            },
            ["actions"] = {
               "notifyAudio", -- [1]
            },
            ["outputs"] = {
               "output:sounddang", -- [1]
               "output:spellName", -- [1]
               "output:event", -- [2]
            },
         },

         -- Furchtzauberschutz		cd bereit	
         ["Wenn;zauber name;gleich;Furchtzauberschutz;und;ereignis;gleich;zauber cooldown ende;und;Quelle;gleich;selbst;dann;audio ausgabe;zauber name;ereignis;"] = {
            ["friendlyNameShort"] = "Furchtzauberschutz cooldown",
            ["enabled"] = true,
            ["type"] = "if",
            ["attributes"] = {
               ["spellName"] = {
                  {
                     "is", -- [1]
                     "spell:Furchtzauberschutz", -- [2]
                  }, -- [1]
               },
               ["event"] = {
                  {
                     "is", -- [1]
                     "SPELL_COOLDOWN_END", -- [2]
                  }, -- [1]
               },
               ["sourceUnitId"] = {
                  {
                     "is", -- [1]
                     "player", -- [2]
                  }, -- [1]
               },
            },
            ["actions"] = {
               "notifyAudio", -- [1]
            },
            ["outputs"] = {
               "output:sounddang", -- [1]
               "output:spellName", -- [1]
               "output:event", -- [2]
            },
         },	
         -- Gedankenschlag		cd bereit	
         ["Wenn;zauber name;gleich;Gedankenschlag;oder;zauber name;gleich;Verbesserter Gedankenschlag;und;ereignis;gleich;zauber cooldown ende;und;Quelle;gleich;selbst;dann;audio ausgabe;zauber name;ereignis;"] = {
            ["friendlyNameShort"] = "Gedankenschlag cooldown",
            ["enabled"] = true,
            ["type"] = "if",
            ["attributes"] = {
               ["spellName"] = {
                  {
                     "is", -- [1]
                     "spell:Gedankenschlag", -- [2]
                  }, -- [1]
                  {
                     "is", -- [1]
                     "spell:Verbesserter Gedankenschlag", -- [2]
                  }, -- [2]
               },
               ["event"] = {
                  {
                     "is", -- [1]
                     "SPELL_COOLDOWN_END", -- [2]
                  }, -- [1]
               },
               ["sourceUnitId"] = {
                  {
                     "is", -- [1]
                     "player", -- [2]
                  }, -- [1]
               },
            },
            ["actions"] = {
               "notifyAudio", -- [1]
            },
            ["outputs"] = {
               "output:sounddang", -- [1]
               "output:spellName", -- [1]
               "output:event", -- [2]
            },
         },
         -- Stille			cd bereit		
         ["Wenn;zauber name;gleich;Stille;und;ereignis;gleich;zauber cooldown ende;und;Quelle;gleich;selbst;dann;audio ausgabe;zauber name;ereignis;"] = {
            ["friendlyNameShort"] = "Stille cooldown",
            ["enabled"] = true,
            ["type"] = "if",
            ["attributes"] = {
               ["spellName"] = {
                  {
                     "is", -- [1]
                     "spell:Stille", -- [2]
                  }, -- [1]
               },
               ["event"] = {
                  {
                     "is", -- [1]
                     "SPELL_COOLDOWN_END", -- [2]
                  }, -- [1]
               },
               ["sourceUnitId"] = {
                  {
                     "is", -- [1]
                     "player", -- [2]
                  }, -- [1]
               },
            },
            ["actions"] = {
               "notifyAudio", -- [1]
            },
            ["outputs"] = {
               "output:sounddang", -- [1]
               "output:spellName", -- [1]
               "output:event", -- [2]
            },
         },
               
         --DOTS
         -- Schattenwort: Schmerz		aura verloren alle	
         ["Wenn;zauber name;gleich;Schattenwort: Schmerz;oder;zauber name;gleich;Verbessertes Schattenwort: Schmerz;und;ereignis;gleich;aura verloren;und;Quelle;gleich;alle;dann;audio ausgabe;aura;sound#brang;zauber name;ereignis;"] = {
            ["friendlyNameShort"] = "Schattenwort Schmerz ausgelaufen gegner",
            ["enabled"] = true,
            ["type"] = "if",
            ["attributes"] = {
               ["spellName"] = {
                  {
                     "is", -- [1]
                     "spell:Schattenwort: Schmerz", -- [2]
                  }, -- [1]
                  {
                     "is", -- [1]
                     "spell:Verbessertes Schattenwort: Schmerz", -- [2]
                  }, -- [2]
               },
               ["event"] = {
                  {
                     "is", -- [1]
                     "SPELL_AURA_REMOVED", -- [2]
                  }, -- [1]
               },
               ["sourceUnitId"] = {
                  {
                     "is", -- [1]
                     "all", -- [2]
                  }, -- [1]
               },
            },
            ["actions"] = {
               "notifyAudio", -- [1]
            },
            ["outputs"] = {
               "output:soundbrang", -- [1]
               "output:spellName", -- [2]
               "output:event", -- [3]
            },
         },	
         -- Untote fesseln		aura verloren alle	
         ["Wenn;zauber name;gleich;Untote fesseln;und;ereignis;gleich;aura verloren;und;Quelle;gleich;alle;dann;audio ausgabe;aura;sound#brang;zauber name;ereignis;"] = {
            ["friendlyNameShort"] = "Untote fesseln ausgelaufen gegner",
            ["enabled"] = true,
            ["type"] = "if",
            ["attributes"] = {
               ["spellName"] = {
                  {
                     "is", -- [1]
                     "spell:Untote fesseln", -- [2]
                  }, -- [1]
               },
               ["event"] = {
                  {
                     "is", -- [1]
                     "SPELL_AURA_REMOVED", -- [2]
                  }, -- [1]
               },
               ["sourceUnitId"] = {
                  {
                     "is", -- [1]
                     "all", -- [2]
                  }, -- [1]
               },
            },
            ["actions"] = {
               "notifyAudio", -- [1]
            },
            ["outputs"] = {
               "output:soundbrang", -- [1]
               "output:spellName", -- [2]
               "output:event", -- [3]
            },
         },	
      },
   },
}