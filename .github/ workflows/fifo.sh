seq_stats () {
     AWK_PROG = '' ' 
    BEGIN { 
        missing_list = ""; 
    } 
    { 
        if (min == "") {min = max = $ 1}; 
        if ($ 1> max) {max = $ 1}; 
        if ($ 1 <min) {min = $ 1}; 
        suma + = $ 1; 
        observado + = 1;

        ## si hay una brecha, almacene los números que faltan 
        if ($ 1-prev> 1) { 
            for (i = prev + 1; i <$ 1; i ++) { 
                missing_list = missing_list "," i; 
            }; 
        }; 
        prev = $ 1 
    } 
    END { 
        esperado = (max-min + 1); 
        faltante = (esperado-observado); 
        printf "observado:% d \ nmin:% d \ nmax:% d \ nmissing:% d \ nmissing_p:% .5f \ n", 
        observado, min, max, faltante, (100.0 * (faltante / esperado)); 
        printf "missing_list:% s \ n", missing_list; 
    } 
    '' ' 
    ordenar -g | awk "$ AWK_PROG"
}
