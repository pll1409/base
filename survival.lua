local cfg = {}

-- Taxa de decaimento para zerar em 30 minutos
cfg.hunger_per_minute = 8.33  -- 3.33% por minuto (100/30 = ~3.33)
cfg.thirst_per_minute = 8.33   -- 3.33% por minuto (100/30 = ~3.33)

-- Fator de dano quando fome/sede está acima de 100%
cfg.overflow_damage_factor = 0.1

return cfg