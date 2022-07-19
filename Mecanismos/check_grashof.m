function classe = check_grashof(mecanismo)

    maior = mecanismo(1);
    indice_maior = 1;
    menor = mecanismo(1);
    indice_menor = 1;

    % descobrir elos maior e menor e seus respectivos indices dentro do vetor
    for i = 1:3
        if (mecanismo(i+1) > mecanismo(i))
            maior = mecanismo(i+1);
            indice_maior = i+1;
        end
        if (mecanismo(i+1) < mecanismo(i))
            menor = mecanismo(i+1);
            indice_menor = i+1;
        end
    end
   
    % descobrir elo adjascente 1 e seu respectivo índice dentro do vetor
    for i = 1:4
        if (i ~= indice_maior & i ~= indice_menor)
            adjascente1 = mecanismo(i);
            indice_adjascente1 = i;
        end
    end

    % descobrir elo adjascente 2
    for i = 1:4
        if (i ~= indice_maior & i ~= indice_menor & i ~= indice_adjascente1)
            adjascente2 = mecanismo(i);
        end
    end
   
    % checar condição de Grashof e retornar resultado
    if (maior + menor < adjascente1 + adjascente2)
        classe = 'Grashof Classe 1';
    else
        if (maior + menor == adjascente1 + adjascente2)
            classe = 'Grashof Classe 2';
        else
            classe = 'Não Grashof (Classe 3)';
        end
    end
end