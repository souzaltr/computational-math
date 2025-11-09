function atividade2 ()
  x0 = [1; 1]; % Enunciado definiu x1 = x2 = 1

  tolerance = 10.^-5;

  max_iterations = 1000;

  [x1, iterations, all_roots, all_functions] = newton_raphson(x0, tolerance, max_iterations);

  for cont = 1 : iterations
      fprintf('x= %.6f | y= %.6f   f1(x,y)= %.6f | f2(x,y)= %.6f\n',
      all_roots(cont, 1), all_roots(cont, 2), all_functions(cont, 1), all_functions(cont, 2));
  end

  fprintf('\nRaiz x encontrada: %.6f\n', x1(1));
  fprintf('Raiz y encontrada: %.6f\n', x1(2));
  fprintf('Iteracoes necessarias: %d\n', iterations);

  plot_convergence(all_functions);
  plot_convergence_x1(all_roots);
end

function [x1, iterations, all_roots, all_functions] = newton_raphson (x0, tolerance, max_iterations)

  all_roots = zeros (max_iterations+1, 2);
  all_functions = zeros (max_iterations+1, 2);

  all_roots(1, :) = x0;

  for iterations = 1 : max_iterations

    J = jacobian_matrix(x0);
    f = myfunctions(x0);
    x1 = x0 - (J \ f);

    all_roots(iterations+1, :) = x1;
    all_functions(iterations, :) = f;

    if max(abs(x1 - x0)) <= tolerance
      break;
    end
    x0 = x1;
  end

  all_roots = all_roots (1 : iterations, :);
  all_functions = all_functions(1 : iterations, :);
end

function f = myfunctions (x0)
  x1 = x0(1);
  x2 = x0(2);

  f1 = 2 * x1 - 4 * x1 * x2 + 2 * x2^2;
  f2 = 3 * x2^2 + 6 * x1 - x1^2 - 4 * x1 * x2 - 5;
  f = [f1; f2];
end

function J = jacobian_matrix (x0)
  x1 = x0(1);
  x2 = x0(2);

  deriv_f1_x1 = 2 - 4 * x2;
  deriv_f1_x2 = -4 * x1 + 4 * x2;

  deriv_f2_x1 = 6 - 2 * x1 - 4 * x2;
  deriv_f2_x2 = 6 * x2 - 4 * x1;
  J = [ deriv_f1_x1, deriv_f1_x2; deriv_f2_x1, deriv_f2_x2];
end

function plot_convergence(all_functions)
  figure(1);
  clf;

  plot(all_functions, '-o', 'LineWidth', 2.0, 'MarkerSize', 6);

  format_title = sprintf('Exercicio 3 - Grafico de convergencia de f(x,y)');
  title(format_title, 'FontSize', 18);

  xlabel('Iteracoes', 'FontSize', 16);
  ylabel('f(x,y)', 'FontSize', 16);
  legend('f1(x,y)', 'f2(x,y)', 'FontSize', 14);
  grid on;
end

function plot_convergence_x1 (all_roots)
  figure(2);
  clf;

  plot(all_roots,'-o', 'LineWidth', 2.0, 'MarkerSize', 6);

  format_title = sprintf('Exercicio 3 - Grafico de convergencia de x1');
  title(format_title, 'FontSize', 18);

  xlabel('Iteracoes', 'FontSize', 16);
  ylabel('Valor da raiz aproximada', 'FontSize', 16);
  legend('x', 'y', 'FontSize', 14);
  grid on;
end
