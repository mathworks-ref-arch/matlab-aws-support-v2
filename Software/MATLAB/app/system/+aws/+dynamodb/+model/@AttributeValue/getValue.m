function value = getValue(obj)
% GETVALUE Retrieves the value of the attribute
%
% This method returns the value of the AttributeValue object.
%
% Example:
%   attrValue = AttributeValue(javaAttributeValueObject);
%   value = attrValue.getValue();
%
% Note: The method should handle different attribute types and return the appropriate MATLAB type.

% Copyright 2025 The MathWorks, Inc.

if isempty(obj.Handle)
    logObj = Logger.getLogger();
    write(logObj, 'error', 'Handle is empty, cannot get value');
    value = [];
else
    % Example for string values, extend with other types as needed
    type = string(obj.Handle.type().toString());

    switch type
        case 'S'
            value = obj.Handle.s();

        case 'N'
            value = obj.Handle.n();
        case 'B'
            value = obj.Handle.b();
        case {'SS','NS','BS'}
            ss = obj.Handle.ss();
            iterator = ss.iterator();
            setSize = ss.size();
            cellArray = cell(1,setSize);
            index = 1;
            while iterator.hasNext()
                cellArray{index+1} = char(iterator.next());
            end
            value = cellArray;

        case 'BOOL'
            value = obj.Handle.bool();
        case 'NUL'
            value = obj.Handle.nul();
        case 'M'
            value = obj.Handle.m();
        case 'L'
            value = obj.Handle.l();
        otherwise
            error("invalid data returned");
    end
    value = string(value);
end
end