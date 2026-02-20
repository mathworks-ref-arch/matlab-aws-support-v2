classdef BuilderStub
    % A simple "builder" stub whose methods match option field names.
    % Each method records the received (already-converted) value and returns
    % the builder (to mimic chained builder API). build() returns a containers.Map
    % with all captured values (methodName -> value).

    % Copyright 2025 The MathWorks, Inc.

    properties (Access = private)
        Store containers.Map
    end

    methods
        function obj = BuilderStub()
            obj.Store = containers.Map('KeyType','char','ValueType','any');
        end

        % --- methods used by tests; names must match option fields ---
        function obj = Name(obj, val),        obj.Store('Name')        = val; end
        function obj = Alias(obj, val),       obj.Store('Alias')       = val; end
        function obj = Enabled(obj, val),     obj.Store('Enabled')     = val; end
        function obj = RawObj(obj, val),      obj.Store('RawObj')      = val; end
        function obj = Dbl(obj, val),         obj.Store('Dbl')         = val; end
        function obj = Sng(obj, val),         obj.Store('Sng')         = val; end
        function obj = I8(obj, val),          obj.Store('I8')          = val; end
        function obj = U8(obj, val),          obj.Store('U8')          = val; end
        function obj = I16(obj, val),         obj.Store('I16')         = val; end
        function obj = U16(obj, val),         obj.Store('U16')         = val; end
        function obj = I32(obj, val),         obj.Store('I32')         = val; end
        function obj = U32(obj, val),         obj.Store('U32')         = val; end
        function obj = I64(obj, val),         obj.Store('I64')         = val; end
        function obj = U64(obj, val),         obj.Store('U64')         = val; end
        function obj = Numbers(obj, val),     obj.Store('Numbers')     = val; end
        function obj = Mixed(obj, val),       obj.Store('Mixed')       = val; end
        function obj = DictNonEmpty(obj, val),obj.Store('DictNonEmpty')= val; end
        function obj = DictEmpty(obj, val),   obj.Store('DictEmpty')   = val; end
        function obj = Struct(obj, val),      obj.Store('Struct')      = val; end

        function obj = Throw(~, ~)
            error('Stub:Throw','Simulated builder method failure.');
        end

        function out = build(obj)
            % Return captured data
            out = obj.Store;
        end
    end
end