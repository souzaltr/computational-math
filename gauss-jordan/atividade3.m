function atividade3 ()
    A = [ 1  1 -3 ;
          2  0  1 ;
         -7 -2  1 ];

    B = [ -17;
           12;
          -11];

    aumentada= [A B];
    linhas = size(aumentada,1);

    printf("Matriz aumentada A|B: \n\n");
    aumentada

    printf("\n\nMatriz aumentada A|B após pivotamento: \n\n");
    aumentada = pivotamento(aumentada, linhas)

    printf('\nSistema linear a ser resolvido: \n\n');
    for i = 1 : linhas
        for j = 1 : size(A,2)
            coef = A(i,j);
            if j == 1
                if coef < 0
                    fprintf('-%.2fx%d ', abs(coef), j);
                else
                    fprintf('%.2fx%d ', coef, j);
                end
            else
                if coef < 0
                    fprintf('- %.2fx%d ', abs(coef), j);
                else
                    fprintf('+ %.2fx%d ', coef, j);
                end
            end
        end
        printf(' = %.2f', B(i));
        printf('\n');
    end

    printf("\n\nMatriz aumentada A|B após gaussJordan: \n\n");
    aumentada = gaussJordan(aumentada, linhas)

    printf('\n\nThe independent terms of the solution are:\n\n');
    for i = 1 : linhas
      fprintf('x%d = %.2f\n', i, aumentada(i,end));
    end

end

function aumentada = pivotamento (aumentada, linhas)

    for cont = 1 : linhas - 1
        linhaPivo = aumentada(cont, :);

        [~,indiceMaiorElemento] = max(abs(aumentada(cont:end , cont)));
        indiceMaiorElemento = indiceMaiorElemento + cont -1;
        if indiceMaiorElemento != cont
        temp = aumentada(indiceMaiorElemento, :);

        aumentada(indiceMaiorElemento, :) = linhaPivo;
        aumentada(cont, :) = temp;
        end

    end
end

function aumentada = gaussJordan(aumentada, linhas)

    for cont = 1 : linhas
        aumentada(cont, :) = aumentada(cont, :) / aumentada(cont, cont);

        for i = cont + 1 : linhas
            aumentada(i, :) = aumentada(i, :) - aumentada(i, cont) * aumentada(cont, :);
        end
    end

    for cont = linhas : -1 : linhas - 1
      for i = cont - 1 : -1 : 1
        aumentada(i, :) = aumentada(i, :) - aumentada(i, cont) * aumentada(cont, :);
      end
    end
end
