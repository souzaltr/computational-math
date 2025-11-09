function atividade1 ()
  x_lower=0.0;
  x_upper=5.0;

  tolerance = 10.^-5;

  max_iterations = 1000;

  [root, iterations, all_xr, all_fxr] = bisection_method(x_lower, x_upper, tolerance, max_iterations);

  fprintf('Resultado\n\n');

  for cont = 1 : iterations
    fprintf('x= %.6f | f(x) = %.6f\n', all_xr(cont), all_fxr(cont));
  endfor

  fprintf('Raiz aproximada encontrada: %.6f\n', root);
  fprintf('Numero de iteracoes: %d\n', iterations);

  plot_convergence(all_fxr);
  plot_convergence_x(root, all_xr);
  plot_animation(all_xr, iterations);
end

function [root, iterations, all_xr, all_fxr] = bisection_method(x_lower, x_upper, tolerance, max_iterations)

  xr = inf;
  fxlower = myfunction(x_lower);

  all_xr = zeros(1,max_iterations);
  all_fxr = zeros(1,max_iterations);

  for iterations = 1:max_iterations

    previous_xr = xr;

    xr = (x_lower+x_upper)/2;

    variation= abs(xr-previous_xr);

    fxr = myfunction(xr);

    all_xr(iterations) = xr;
    all_fxr(iterations) = fxr;

    if (variation < tolerance)
      break
    endif

    if  (fxlower * fxr < 0)
      x_upper = xr;

      elseif  (fxlower * fxr > 0)
        x_lower = xr;
        fxlower = fxr;

        elseif (fxlower * fxr == 0)
          break
    endif
  end

  root = xr;
  all_xr = all_xr(1:iterations);
  all_fxr = all_fxr(1:iterations);
end

function y = myfunction(x)
y= 16 .* x .* sin(x./10) - (37/2);
end

function plot_convergence(all_fxr)
  figure(1);
  clf;

  plot(all_fxr, 'go-', 'LineWidth', 2.0, 'MarkerSize', 3, 'MarkerFaceColor', 'g');

  format_title = sprintf('Exercicio 7 - Grafico de convergencia de f(x)');
  title(format_title, 'FontSize', 18);

  xlabel('Iteracoes', 'FontSize', 16);
  ylabel('f(x)', 'FontSize', 16);
  legend('f(x)', 'FontSize', 14);
  grid on;

end

function plot_convergence_x(root, all_xr)
  figure(2);
  clf;

  plot(all_xr, 'go-', 'LineWidth', 2.0, 'MarkerSize', 3, 'MarkerFaceColor', 'g');
  hold on;
  plot(xlim, [root root], 'k--');
  hold off;

  format_title = sprintf('Exercicio 7 - Grafico de convergencia de x');
  title(format_title, 'FontSize', 18);
  xlabel('Iteracoes','FontSize', 16);
  ylabel('Valor da raiz aproximada', 'FontSize', 16);
  legend('Valor de entrada x', '', 'FontSize', 14);
  grid on;
end

function plot_animation(all_xr, iterations)
  figure(3);

  for cont = 1: iterations
    clf;
    hold on;

    x_curve = linspace(0.0, 5.0, 100);
    plot(x_curve, myfunction(x_curve), 'g-', 'LineWidth', 2.0);

    current_xr = all_xr(cont);

    plot(current_xr, myfunction(current_xr), 'ko', 'MarkerSize', 5, 'MarkerFaceColor', 'black');

    hold off;

    title_str = sprintf('Exercicio 7 - Grafico Animado - Iteracao %d de %d\n Raiz estimada -> %.6f', cont, iterations, current_xr);
    title(title_str, 'FontSize', 18);
    xlabel('x', 'FontSize', 16);
    ylabel('Valor de f(x)', 'FontSize', 16);
    legend('Função f(x)', 'Posicao estimada da raiz de f(x)', 'FontSize', 14, 'Location', 'northwest');
    grid on;
    pause(0.2);
  endfor
end
