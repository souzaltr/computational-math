function atividade3 ()
    A = [ 1  1 -3;
         2  0  1;
        -7 -2  1];

    B = [-17;
          12;
         -11];

    Aa = [A B];

    Aa = pivot(A)

    Aa = gaussian_elimination(Aa)
end

function Aa = pivot(Aa)
    %Loop to the last column of the original matrix A.
    for i = 1 : size(Aa,1) - 1
        %Returns the index of max absolute value in the range (below and the main diagonal) of column 'i'.
        [~, idx_max_value] = max(abs(Aa(i:end, i)));

        %Get the line of pivot element (the element on the main diagonal).
        temp = Aa(i, :);

        %Pivot between the line of the max absolute value and the line of the element on main diagonal.
        Aa(i, :) = Aa(idx_max_value + i - 1, :);
        Aa(idx_max_value + i - 1, :) = temp;
    end
end

function Aa = gaussian_elimination(Aa)
    solution = zeros (size(Aa,1) , 1);

    for i = 1 : size(Aa,1) - 1
        for j = 1 : size(Aa,1) - i
        factor= Aa(i+1,i) / Aa(i,i);
        Aa(i+j, :) = Aa(i+j, :) - factor * Aa(i, :);
        end
    end
end



