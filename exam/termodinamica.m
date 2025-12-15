function termodinamica ()
  xI = 0.1;
  xS = 2.0;

  maxIteracoes= 1000;

  tolerancia = 10^-4;


  [xr, iteracoesFeitas, todosX, todosFx] = falsaPosicao (maxIteracoes, xI, xS, tolerancia)

  for cont = 1 : iteracoesFeitas
    fprintf('x = %.4f | f(x) = %.4f\n', todosX(cont), todosFx(cont));
  end

  graficoConvergenciaX (todosX, iteracoesFeitas);
  graficoConvergenciaFx (todosFx, iteracoesFeitas);
  graficoAnimado (todosX, xI, xS, iteracoesFeitas);

endfunction

function f = funcao (x)
  f = (1/0.03) .* (10.*x) .* ((10.*x) ./ (10 + 2.*x)).^(2/3) * (0.001)^(1/2) - 20;
endfunction

function [xr, iteracoesFeitas, todosX, todosFx] = falsaPosicao (maxIteracoes, xI, xS, tolerancia)
  xr = inf;

  todosX = zeros(1, maxIteracoes);
  todosFx = zeros(1, maxIteracoes);

  for iteracoesFeitas = 1 : maxIteracoes
    antigoXR = xr;

    xr = xS - funcao(xS) * (xI - xS) / (funcao(xI) - funcao(xS));
    todosFx(iteracoesFeitas) = funcao(xr);
    todosX(iteracoesFeitas) = xr;

    if abs(xr - antigoXR) < tolerancia
      break
    end

    if funcao(xI) * funcao(xr) < 0
        xS= xr;
            else xI = xr;
    end

  endfor

  todosFx= todosFx(1: iteracoesFeitas);
  todosX= todosX(1: iteracoesFeitas);

endfunction

function graficoConvergenciaX (todosX, iteracoesFeitas)

  figure(1);

  plot(todosX, '-bo', 'linewidth', 2.5);
  xlim([1 iteracoesFeitas]);

  titulo= sprintf('grafico convergencia de x', 'fontsize', 20);
  title(titulo);
  xlabel('iteracoes','fontsize', 18);
  ylabel('valor de x', 'fontsize', 18);
  legend('valores de x', 'fontsize', 18);
  grid on;

endfunction

function graficoConvergenciaFx (todosFx, iteracoesFeitas)

  figure(2);

  plot(todosFx, '-bo', 'linewidth', 2.5);
  xlim([1 iteracoesFeitas]);
  ylim([min(todosFx)+1 max(todosFx)+1]);

  titulo= sprintf('grafico convergencia de f(x)', 'fontsize', 20);
  title(titulo);
  xlabel('iteracoes','fontsize', 18);
  ylabel('valor de f(x)', 'fontsize', 18);
  legend('valores de f(x)', 'fontsize', 18);
  grid on;

endfunction

function graficoAnimado (todosX, xI, xS, iteracoesFeitas)
    figure(3);

    for cont = 1 : iteracoesFeitas
        clf;
        hold on;

        curva = linspace(0, 2.5, 200);
        plot(curva, funcao(curva), 'b-', 'linewidth', 2.0);

        plot(todosX(cont), funcao(todosX(cont)), 'o', 'markersize', 5.0, 'markerfacecolor', 'r');
        hold off;

        titulo= sprintf('grafico animado de f(x)\n f(x) = %.4f\n iteracao: %d', funcao(todosX(cont)), cont);
        title(titulo, 'fontsize', 20);
        xlabel('valor de x','fontsize', 18);
        ylabel('valor de f(x)', 'fontsize', 18);
        legend('funcao', 'raiz estimada', 'fontsize', 18);
        grid on;
        pause(1.0);
    end

endfunction

