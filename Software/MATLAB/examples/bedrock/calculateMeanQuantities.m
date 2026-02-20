function quantities = calculateMeanQuantities(parsedData)

% Copyright 2025 The MathWorks, Inc.

    % Initialize arrays to store quantities
    itemNames = parsedData(:, 1);
    quantities = zeros(size(parsedData, 1), 1);

    % Calculate mean quantity for each item
    for index = 1:size(parsedData, 1)
        quantity = parsedData{index, 2};
        if length(quantity) == 2
            % If it's a range, take the mean of the range
            quantities(index) = mean(quantity);
        else
            % If it's a single number, use it directly
            quantities(index) = quantity;
        end
    end   

end
