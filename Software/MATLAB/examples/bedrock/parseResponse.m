function parsedData = parseResponse(responseMessage)

% Copyright 2025 The MathWorks, Inc.

    % Split the response by commas to separate each item
    items = strsplit(responseMessage, ',');
    
    % Initialize a cell array to store parsed data
    parsedData = cell(length(items), 2);
    
    % Loop through each item to extract the object type and quantity
    for index = 1:length(items)
        % Trim whitespace and split by the colon to separate name and quantity
        parts = strtrim(strsplit(items{index}, ':'));
        
        if length(parts) == 2
            objectType = strtrim(parts{1});
            quantityStr = strtrim(parts{2});
            
            % Handle ranges in quantities
            if contains(quantityStr, '-')
                quantityRange = str2double(strsplit(quantityStr, '-'));
            else
                quantityRange = str2double(quantityStr);
            end
            
            % Store the data in the cell array
            parsedData{index, 1} = objectType;
            parsedData{index, 2} = quantityRange;
        end
    end
end