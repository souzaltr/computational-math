function atividade4 ()
  alpha = 1;
  x0 = 3;
  gradient = @(x0) -2 * cos(x0 - (x0.^2 / 10)) * (1 - (x0./5));
  maxIterations = 1000;
  tolerance = 10.^-5;

  [currentX, iterations, grad] = gradientMethod(x0, alpha, gradient, maxIterations, tolerance);

  fprintf('O mínimo é: %.6f\n O gradiente no ponto ótimo é: %.6f\n Iterações feitas: %d', currentX, grad, iterations);
endfunction

function [x1, iterations, grad] = gradientMethod (x0, alpha, g, maxIterations, tolerance)
    currentX = x0;

    for iterations = 1 : maxIterations

        grad = g(currentX);

        x1 = currentX - alpha * grad;

        if abs(x1 - currentX) <= tolerance
            currentX = x1;
            return;
        endif
        currentX = x1;
    endfor
endfunction
