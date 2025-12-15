function circuito()
  x0 = 0.7;

  tolerancia = 10.^-5;

  maxIteracoes = 1000;

  [x, iteracoesFeitas, todosX, todosFx] = newton_raphson(x0, tolerancia, maxIteracoes);

  for cont = 1 : iteracoesFeitas + 1
      fprintf('x= %.4f | f(x) = %.4f\n', todosX(cont), todosFx(cont));
  end

  fprintf('\nRaiz x encontrada: %.4f\n', x);
  fprintf('Iteracoes necessarias: %d\n', iteracoesFeitas);

  convergenciaX(todosX, iteracoesFeitas);
  convergenciaFx(todosFx, iteracoesFeitas);

endfunction

function y = f(x)
  Is = 1e-12;
  nVt = 0.026;
  R = 1000;
  y = Is * (exp(x/nVt) - 1) + (x - 5)/R;
endfunction

function J = jacobiano(x)
  Is = 1e-12;
  nVt = 0.026;
  R = 1000;
  J = (Is / nVt) * exp(x / nVt) + (1/R);
  endfunction

function [x1, cont, todosX, todosFx] = newton_raphson(x0, tolerancia, maxIteracoes)
  todosX = zeros(1+maxIteracoes,1);
  todosFx = zeros(1+maxIteracoes,1);

  todosX(1) = x0;
  todosFx(1) = f(x0);

  for cont = 1 : maxIteracoes
    J = jacobiano(x0);
    x1 = x0 - (f(x0) / jacobiano(x0));

    todosX(cont+1) = x1;
    todosFx(cont+1) = f(x1);

    if abs(x1 - x0) < tolerancia
      break;
    end

    x0 = x1;
   end
    todosX = todosX(1:cont+1);
    todosFx = todosFx(1:cont+1);

endfunction

function convergenciaX(todosX, iteracoesFeitas)
  figure(1);

  plot(todosX, 'bo-', 'linewidth', 2.0);
  xlim([1 iteracoesFeitas]);
  titulo = sprintf('convergencia de x');
  title(titulo, 'fontsize', 18);
  xlabel('iteracoes', 'fontsize', 14);
  ylabel('raiz estimada', 'fontsize', 14);
  legend('valores de x', 'fontsize', 10);
  grid on;

endfunction

function convergenciaFx(todosFx, iteracoesFeitas)
  figure(2);

  plot(todosFx, 'bo-', 'linewidth', 2.0);
  xlim([1 iteracoesFeitas]);
  titulo = sprintf('convergencia de f(x)');
  title(titulo, 'fontsize', 18);
  xlabel('iteracoes', 'fontsize', 14);
  ylabel('raiz estimada', 'fontsize', 14);
  legend('valores de f(x)', 'fontsize', 10);
  grid on;

  endfunction
