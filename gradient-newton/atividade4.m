function atividade4 ()
  alpha = 0.5;
  maxIterations = 1000;
  tolerance = 10.^-3;

  %VETOR COLUNA do ponto inicial
  x0 = [3;
        0];

  % Minha funcao
  F = @(x) (sin(3 * pi * x(1)))^2 + ((x(1) - 1)^2) * (1 + (sin(3 * pi * x(2)))^2) + ...
           ((x(2) - 1)^2) * (1 + (sin(2 * pi * x(2)))^2);
  % Gradiente - vetor coluna com as derivadas parciais, cada linha do vetor sendo em relacao a uma variavel
  gradient = @(x) [

       2*sin(3*pi*x(1)) * cos(3*pi*x(1))*3*pi + (2*x(1) - 2) * (1 + sin(3*pi*x(2))^2); ...

       2*sin(3*pi*x(2)) * cos(3*pi*x(2)) * 3 * pi * (x(1)-1)^2 + ...
       (2*x(2)-2) * (1+ sin(2*pi*x(2))^2) + 2*sin(2*pi*x(2)) * cos(2*pi*x(2))*2*pi*(x(2) - 1)^2];

  % Matriz Hessiana - matriz quadrada, sendo [Fxx , Fxy; Fxx, Fyy]
  hessian = @(x) [

       18 * pi^2 * cos(6 * pi * x(1)) + 2 * (1 + sin(3 * pi * x(2))^2), ...
       6 * pi * (x(1) - 1) * sin(6 * pi * x(2)); ...

       6 * pi * (x(1) - 1) * sin(6 * pi * x(2)), ...
       18 * pi^2 * (x(1) - 1)^2 * cos(6 * pi * x(2)) + 2 * (1 + sin(2* pi * x(2))^2) + ...
       8*pi*(x(2) - 1) * sin(4*pi*x(2)) + 8*pi^2*(x(2) - 1)^2 * cos(4*pi*x(2))];

  % Chamada do metodo numerico do Gradiente
  [x_opt, f_opt, iterations, allX, allFX] = gradientMethod(x0, alpha, F, gradient, maxIterations, tolerance);

  fprintf('METODO GRADIENTE\n\n');
  fprintf('O ponto minimo encontrado: [%.6f; %.6f]\n', x_opt(1), x_opt(2));
  fprintf('O gradiente no ponto encontrado e: [%.6f; %.6f] \nIteracoes feitas: %d\n', gradient(x_opt), iterations);
  fprintf('Valor de f(x1, x2) no ponto otimo: %.6f\n', f_opt);
  fprintf('Distância do ponto otimo [1;1]: %.6f\n\n', norm(x_opt - [1;1]));

  % Chamada do metodo numerico de Newton
  [x_newton, f_newton, newton_iterations, allX_newton, allFX_newton] = newtonMethod(x0, alpha, F, gradient, hessian, maxIterations, tolerance);
  fprintf('METODO NEWTON\n\n');
  fprintf('O ponto minimo encontrado: [%.6f; %.6f]\n', x_newton(1), x_newton(2));
  fprintf('O gradiente no ponto encontrado e: [%.6f; %.6f] \nIteracoes feitas: %d\n', gradient(x_newton), iterations);
  fprintf('Valor de f(x1, x2) no ponto otimo: %.6f\n', f_newton);
  fprintf('Distância do ponto otimo [1;1]: %.6f\n', norm(x_newton - [1;1]));

  % Plotagens da convergencia da funcao, das variaveis e 3d animado
  % PARA PLOTAR OS DADOS DO OUTRO METODO BASTA ALTERAR OS ARGUMENTOS (allFX , allX, iterations)
  plotConvergence(allFX);
  plotConvergenceX(allX);
  plot3D(F, allX, allFX, iterations);
endfunction

function [x_final, f_final, iterations, allX, allFX] = gradientMethod (x0, alpha, f, grad, maxIterations, tolerance)
    currentX = x0;
    allX = zeros(maxIterations+1 , length(x0));
    allFX = zeros(maxIterations+1 , 1);

    allX(1, :) = x0;
    allFX(1) = f(x0);

    for iterations = 1 : maxIterations

        g = grad(currentX);

        x1 = currentX - alpha * g;

        allX(iterations+1 , :) = x1;
        allFX(iterations+1) = f(x1);

        if max(abs(x1 - currentX)) <= tolerance
           currentX = x1;
           break;
        endif
        currentX = x1;
    endfor

    allX = allX(1 : iterations+1, :);
    allFX = allFX(1 : iterations+1);
    x_final = currentX;
    f_final = f(currentX);
endfunction

function [x_final, f_final, iterations, allX, allFX] = newtonMethod(x0, alpha, f, grad, hess, maxIterations, tolerance)
    currentX = x0;
    allX = zeros(maxIterations+1 , length(x0));
    allFX = zeros(maxIterations+1 , 1);

    allX(1, :) = x0;
    allFX(1) = f(x0);

    for iterations = 1 : maxIterations

        g = grad(currentX);
        H = hess(currentX);

        x1 = currentX - alpha * (H \ g);

        allX(iterations+1 , :) = x1;
        allFX(iterations+1) = f(x1);

        if max(abs(x1 - currentX)) <= tolerance
           currentX = x1;
           break;
        endif
        currentX = x1;
    endfor

    allX = allX(1 : iterations+1, :);
    allFX = allFX(1 : iterations+1);
    x_final = currentX;
    f_final = f(currentX);
endfunction

function plotConvergence(allFX)
  figure(1);
  clf;

  plot(allFX, '-o', 'LineWidth', 2.0, 'MarkerSize', 6);

  format_title = sprintf('Exercicio 8 - Grafico de convergencia de f(x1, x2)');
  title(format_title, 'FontSize', 18);

  xlabel('Iteracoes', 'FontSize', 16);
  ylabel('f(x1, x2)', 'FontSize', 16);
  legend('Valor avaliado de f(x1, x2)', 'FontSize', 14);
  grid on;
endfunction

function plotConvergenceX(allX)
  figure(2);
  clf;

  plot(allX, '-o', 'LineWidth', 2.0, 'MarkerSize', 6);

  format_title = sprintf('Exercicio  8 - Grafico de convergencia de X');
  title(format_title, 'FontSize', 18);

  xlabel('Iteracoes', 'FontSize', 16);
  ylabel('f(x1, x2)', 'FontSize', 16);
  legend('x1', 'x2', 'FontSize', 14);
  grid on;
endfunction

function plot3D(F, allX, allFX, iterations)
    figure(3);
    clf;

    % Vetores do intervalo de -10 a 10 com 100 pontos linearmente espacados
    axisX = linspace(-10, 10, 100);
    axisY = linspace(-10, 10, 100);

    % Matriz com zeros que ira armazenar nossos resultados da funcao
    Z = zeros(length(axisY), length(axisX));

    % Loop para preencher a matriz com os valores de f(x1, x2)
    for i = 1 : length(axisX)
        % Preenchimento com Z(j, i) pois octave espera o preenchimento em linha
        for j = 1 : length(axisY)
          Z(j, i) = F([axisX(i); axisY(j)]);
        end
    end

    % Plota a superficie - surf espera que as colunas de Z sejam o eixo x e linhas o eixo y
    surf(axisX, axisY, Z', 'FaceAlpha', 1);
    hold on;
    grid on;
    view(150, 45);
    xlabel('x1');
    ylabel('x2');
    zlabel('f(x1, x2)');
    title('Grafico animado da otimizacao - Funcao Levy n.13', 'FontSize', 14);
    colormap jet;


    % Plota o rastro
    plot3(allX(:, 1), allX(:, 2), allFX, 'r-', 'linewidth', 3);

    % Plota a bolinha
    point = plot3(allX(1,1), allX(1,2), allFX(1), 'ro', 'MarkerFaceColor', 'r', 'MarkerSize', 10);
    legend('Superficie da funcao', 'Rastro', 'Ponto ótimo estimado', 'FontSize', 14);
    pause(1.5);

    % Loop de animacao, usando o set para atualizar os argumentos na chamada de point
    for i = 2 : iterations + 1
      set(point, 'XData', allX(i,1), 'YData', allX(i,2), 'ZData', allFX(i));
      title(sprintf('Grafico animado da otimizacao - Funcao Levy n.13\nIteração: %d', i-1), 'FontSize', 14);
      pause(1.3);
    end
endfunction
