function engenhariaNaval()

 #{
  Um engenheiro naval precisa determinar a profundidade de submersão 'h' (em metros) de uma boia esférica.
  O equilíbrio de forças resulta na equação não-linear f(h) = h^3 - 0.2h^2 + 0.05h - 1.2 = 0
  Utilize o Método da Bissecção para encontrar o valor de 'h' no intervalo de busca [1.0, 1.5],
  com uma tolerância de 10^-5 e um máximo de 1000 iterações. Qual é o valor da raiz encontrada?
 #}

  hInferior = 1.0;
  hSuperior = 1.5;

  maxIteracoes = 1000;

  tolerancia = 10.^-5;

  [raiz, iteracoesFeitas, todosH, todosfH] = bissecao (hInferior, hSuperior, maxIteracoes, tolerancia);

  for cont = 1 : iteracoesFeitas
    fprintf('h= %.4f | f(h) = %.4f\n' , todosH(cont), todosfH(cont));
  end

  fprintf('Raiz estimada: %.4f' , raiz);

  %graficoConvergenciaH(todosH, iteracoesFeitas);
  %graficoConvergenciafH(todosfH, iteracoesFeitas);
  graficoAnimado(todosH,iteracoesFeitas, hInferior, hSuperior);

endfunction

function f = funcao(h)
  f = h.^3 - 0.2*h.^2 + 0.05*h - 1.2;
endfunction

function [raiz, iteracoesFeitas, todosH, todosfH] = bissecao (hInferior, hSuperior, maxIteracoes, tolerancia)

  hr = inf;
  todosH = zeros(1, maxIteracoes);
  todosfH = zeros(1, maxIteracoes);

  for iteracoesFeitas = 1 : maxIteracoes
    hrAnterior = hr;

    hr = (hInferior + hSuperior) / 2;

    todosH(iteracoesFeitas) = hr;
    todosfH(iteracoesFeitas) = funcao(hr);

    if abs(hr- hrAnterior) < tolerancia
      break;
    end

    if funcao(hInferior) * funcao(hr) < 0
      hSuperior = hr;
    else
      hInferior = hr;
    end

  endfor

  todosH = todosH(1:iteracoesFeitas);
  todosfH = todosfH(1:iteracoesFeitas);
  raiz = hr;

endfunction

function graficoConvergenciaH(todosH, iteracoesFeitas)
  figure(1);

  plot(todosH, 'go-', 'LineWidth', 2.0, 'Markersize', 3, 'MarkerFaceColor', 'g');

  xlim([0 iteracoesFeitas]);
  grid on;

  titulo = sprintf('grafico de convergencia de h');
  title(titulo, 'Fontsize', 18);
  xlabel('Iteracoes', 'Fontsize', 16);
  ylabel('Valor estimado de h', 'Fontsize', 16);
  legend('valor de h', 'Fontsize', 16);

endfunction

function graficoConvergenciafH(todosfH, iteracoesFeitas)
  figure(2);

  plot(todosfH, 'go-', 'LineWidth', 2.0, 'Markersize', 3, 'MarkerFaceColor', 'g');

  xlim([0 iteracoesFeitas]);
  grid on;

  titulo = sprintf('grafico de convergencia de f(h)');
  title(titulo, 'Fontsize', 18);
  xlabel('Iteracoes', 'Fontsize', 16);
  ylabel('Valor estimado de f(h)', 'Fontsize', 16);
  legend('valor de f(h)', 'Fontsize', 16);

endfunction

function graficoAnimado(todosH, iteracoesFeitas, hInferior, hSuperior)
  figure(3);

  for i = 1 : iteracoesFeitas
    clf;
    hold on;

    curva = linspace(hInferior,hSuperior, 100);
    plot(curva, funcao(curva), 'g-', 'LineWidth', 2.0);

    plot(todosH(i), funcao(todosH(i)), 'ko','Markersize', 5.0, 'MarkerFaceColor', 'r');
    hold off;

    titulo = sprintf('grafico de convergencia de f(h)\n valor de f(h) = %.4f\n iteracao: %d', todosH(i), i);
    title(titulo, 'Fontsize', 18);
    xlabel('Valor de h', 'Fontsize', 16);
    ylabel('Valor estimado de f(h)', 'Fontsize', 16);
    legend('valor de h', 'valor de f(h)', 'Fontsize', 16);
    grid on;
    pause(0.2);
  end

  endfunction
