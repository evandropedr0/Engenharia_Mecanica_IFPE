% Exercício 2:

% Condição de Grashof
% Elo Maior + Elo Menor <= Soma dos Elos Adjacentes


% d = input('Insira o valor do Elo MAIOR: ')
% a = input('Insira o valor do Elo MENOR: ')
% b = input('Insira o Valor do Elo ADJACENTE 1: ')
% c = input('Insira o Valor do Elo ADJACENTE 2: ')

% GRASHOF

Mecanismo_a = [152.4,50.8,177.8,228.6];
classe_a = check_grashof(Mecanismo_a)

Mecanismo_b = [177.8,228.6,76.2,203,2];
classe_b = check_grashof(Mecanismo_b)

Mecanismo_c = [76.2,254.0,152.4,203.2];
classe_c = check_grashof(Mecanismo_c)

Mecanismo_d = [203.2,127.0,177.8,152.4];
classe_d = check_grashof(Mecanismo_d)

Mecanismo_e = [203.2,127.0,203.2,152.4];
classe_e = check_grashof(Mecanismo_e)

Mecanismo_f = [127.0,203.2,203.2,228.6];
classe_f = check_grashof(Mecanismo_f)

Mecanismo_g = [152.4,203.2,203.2,128.6];
classe_g = check_grashof(Mecanismo_g)

Mecanismo_h = [508.4,254.0,254.0,254.0];
classe_h = check_grashof(Mecanismo_h)

Mecanismo_i = [101.6,127.0,50.8,127.0];
classe_i = check_grashof(Mecanismo_i)

Mecanismo_j = [508.0,254.0,127.0,254.0];
classe_j = check_grashof(Mecanismo_j)

Mecanismo_k = [101.6,156.4,254.0,177.8];
classe_k = check_grashof(Mecanismo_k)

Mecanismo_l = [228.6,177.8,254.0,177.8];
classe_l = check_grashof(Mecanismo_l)

Mecanismo_m = [228.6,177.8,279.4,203.2];
classe_m = check_grashof(Mecanismo_m)

Mecanismo_n = [228.6,177.8,279.4,152.4];
classe_n = check_grashof(Mecanismo_n)
