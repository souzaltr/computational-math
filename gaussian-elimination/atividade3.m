function atividade3 ()
    A = [ 1  1 -3;
         2  0  1;
        -7 -2  1];

    B = [-17;
          12;
         -11];

    num_lines = size(A,1);

    printf('Augmented Matrix A|B\n');
    AB = [A B]

    printf('\nA|B matrix after partial pivoting\n');
    AB_pivot = pivot(AB, num_lines)

    printf('\nSolution after Gaussian elimination\n');
    solution = gaussianElimination(AB, num_lines)
end

function AB = pivot(AB, num_lines)
    %Loop to the next to last column of the original matrix A.
    for i = 1 : num_lines - 1
        %Returns the index of max absolute value in the range (below and the main diagonal) of column 'i'.
        [~, idx_max_value] = max(abs(AB(i:end, i)));

        %Get the line of pivot element (the element on the main diagonal).
        temp = AB(i, :);

        %Pivot between the line of the max absolute value and the line of the element on main diagonal.
        AB(i, :) = AB(idx_max_value + i - 1, :);
        AB(idx_max_value + i - 1, :) = temp;
    end
end

function solution = gaussianElimination(AB, num_lines)
    %Loop over the columns, going from the first to the penultimate
    for i = 1 : num_lines - 1
        %Loop over the rows below the current pivot element 'i'. Eliminating elements below it.
        for j = i + 1 : num_lines
        factor= AB(j,i) / AB(i,i);
        AB(j, :) = AB(j, :) - factor * AB(i, :);
        end
    end

    solution = zeros(num_lines , 1);
    %Calculates the last element of the solution vector.
    solution(num_lines) = AB(num_lines, end) / AB(num_lines, num_lines);

    %Backward substitution loop.
    for i = num_lines - 1 : -1 : 1
      %Calculates terms already solved (to the right of the current pivot)
      calculated_term = AB(i, i+1 : num_lines) * solution(i+1: num_lines);
      solution(i) = ( AB(i, end ) - calculated_term) / AB(i,i);
    end
end
