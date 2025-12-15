function posicaoBraco()
  x0= [-1.5; 1.5];

  maxIteracoes = 1000;

  tolerancia= 10^-5;

  [x1, iteracoesFeitas, todosX, todosFx] = newtonRaphson (x0, maxIteracoes, tolerancia);

  for cont = 1 : iteracoesFeitas + 1
      fprintf('x= %.4f | y= %.4f| f1(x,y) = %.4f  f2(x,y) = %.4f\n', todosX(cont,1), todosX(cont,2),
      todosFx(cont,1), todosFx(cont,2));
  end

  fprintf('\nRaiz x encontrada: %.4f\n', x1);
  fprintf('Iteracoes necessarias: %d\n', iteracoesFeitas);

  convergenciaX(todosX, iteracoesFeitas);
  convergenciaFx(todosFx, iteracoesFeitas);
endfunction

function y = funcao(x)
 x1 = x(1);
 x2 = x(2);

 y = [ x1^2 + x2^2 - 4; exp(x1) + x2 - 1];
endfunction

function J = jacobiano(x)
 x1 = x(1);
 x2 = x(2);

 J= [2*x1, 2*x2; exp(x1), 1];
endfunction

function [x1, i, todosX, todosFx] = newtonRaphson (x0, maxIteracoes, tolerancia)

    todosFx = zeros(maxIteracoes+1, length(x0));
    todosX = zeros(maxIteracoes+1, length(x0));

    todosFx(1,:) = funcao(x0);
    todosX(1, :) = x0;

    for i = 1 : maxIteracoes + 1

      x1 = x0 - (jacobiano(x0) \ funcao(x0));
      todosFx(i+1,:) = funcao(x1);
      todosX(i+1, :) = x1;

      if max(abs(x1-x0)) < tolerancia
        break;
      end

      x0 = x1;
    end
    todosFx = todosFx(1:i+1, :);
    todosX = todosX(1:i+1, :);

endfunction

function convergenciaX(todosX, iteracoesFeitas)
  figure(1);

  plot(todosX, 'bo-', 'linewidth', 2.0);
  titulo = sprintf('convergencia de x');
  title(titulo, 'fontsize', 18);
  xlabel('iteracoes', 'fontsize', 14);
  ylabel('raiz estimada', 'fontsize', 14);
  legend('valores de x', 'valores de y','fontsize', 10);
  grid on;

endfunction

function convergenciaFx(todosFx, iteracoesFeitas)
  figure(2);

  plot(todosFx, 'bo-', 'linewidth', 2.0);
  titulo = sprintf('convergencia de f(x)');
  title(titulo, 'fontsize', 18);
  xlabel('iteracoes', 'fontsize', 14);
  ylabel('raiz estimada', 'fontsize', 14);
  legend('valores de f1(x)', 'valores de f1(x)', 'fontsize', 10);
  grid on;

  endfunction
