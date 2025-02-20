install.packages("dplyr")
install.packages("ggplot2")
install.packages("tidyr")
install.packages("scales")
  
  ## Precariedad por variables sociodemográficas
  
  ```{r}
precariedad_cruzada <- Base %>%
  group_by(CH04, CH06, NIVEL_ED) %>% 
  summarise(asalariados = sum(PONDERA [CAT_OCUP == 3],na.rm = T),
            registrados = sum(PONDERA[CAT_OCUP == 3 & PP07H == 1],na.rm = T),
            no_registrados = sum(PONDERA[CAT_OCUP == 3 & PP07H == 2],na.rm = T),
            inestables= sum(PONDERA[CAT_OCUP == 3 & PP07E == c(1,2,3)],na.rm = T),
            #empezamos con informalidad, dejo sólo 2 condiciones y después vemos si incorporamos las demás:
            informales_1 = sum(PONDERA[CAT_OCUP == 4],na.rm = T), #T.fam.sin rem.
            informales_2 = sum(PONDERA[CAT_OCUP == 3& PP04C99==1],na.rm = T), 
            total_informales = sum(informales_1| informales_2,na.rm = T),
            precarios_total = sum(no_registrados| inestables| total_informales,na.rm = T),
            #calculamos tasas
            tasa_no_registro= no_registrados/asalariados,
            tasa_inestabilidad= inestables/asalariados,
            tasa_informalidad= total_informales/asalariados,
            tasa_precariedad= precarios_total/asalariados)
```
