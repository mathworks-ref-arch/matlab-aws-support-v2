classdef TestBuildUtil < matlab.unittest.TestCase
    % TestBuildUtil
    % Consolidated tests for aws.internal.builder.build and converters.
    %
    % Coverage:
    %   - Builder dispatch & chaining
    %   - All numeric classes: double, single, int8/uint8, int16/uint16,
    %     int32/uint32, int64/uint64 (verifying boxed Java types; primitive
    %     getters return MATLAB double)
    %   - Arrays & cell arrays -> java.util.ArrayList
    %   - dictionary -> java.util.HashMap (empty & mixed)
    %   - Unsupported MATLAB type -> error (no identifier)
    %   - Builder method that throws -> error rethrown
    %   - Struct -> java.util.HashMap (skips if converter not fixed)
    %
    % Notes on MATLAB/Java interop:
    %   Calling .xxxValue() on boxed Java numerics returns a Java primitive,
    %   which MATLAB represents as double. This is by design; tests compare
    %   accordingly.

    % Copyright 2025 The MathWorks, Inc.

    methods(Test, TestTags = {'Unit'})
        function testBuilderSimpleStringAndChar(testCase)
            builder = BuilderStub();
            opts = struct();
            opts.Name = "Alice";    % string
            opts.Alias = 'Alicia';  % char

            h = aws.internal.builder.build(builder, opts);

            testCase.verifyTrue(isKey(h, 'Name'));
            testCase.verifyTrue(isKey(h, 'Alias'));

            testCase.verifyClass(h('Name'),  'string');
            testCase.verifyEqual(string(h('Name')),  "Alice");

            testCase.verifyClass(h('Alias'), 'char');
            testCase.verifyEqual(string(h('Alias')), "Alicia");
        end

        function testBuilderLogicalAndJavaObject(testCase)
            builder = BuilderStub();
            opts = struct();
            opts.Enabled = true;                   % logical -> java.lang.Boolean
            opts.RawObj  = java.lang.Object();     % passthrough

            h = aws.internal.builder.build(builder, opts);

            testCase.verifyClass(h('Enabled'), 'java.lang.Boolean');
            % booleanValue returns MATLAB logical
            testCase.verifyEqual(h('Enabled').booleanValue(), true);

            testCase.verifyClass(h('RawObj'), 'java.lang.Object');
        end

        function testBuilderNumericScalars_AllClasses(testCase)
            builder = BuilderStub();
            opts = struct();
            opts.Dbl   = double(3.14);
            opts.Sng   = single(2.5);
            opts.I8    = int8(-8);
            opts.U8    = uint8(8);
            opts.I16   = int16(-16);
            opts.U16   = uint16(16);
            opts.I32   = int32(-32);
            opts.U32   = uint32(32);
            opts.I64   = int64(-64);
            opts.U64   = uint64(64);

            h = aws.internal.builder.build(builder, opts);

            % Double (boxed Double; primitive -> MATLAB double)
            testCase.verifyClass(h('Dbl'), 'java.lang.Double');
            testCase.verifyEqual(h('Dbl').doubleValue(), 3.14, 'AbsTol', 1e-12);

            % Float (boxed Float; .floatValue() -> MATLAB double)
            testCase.verifyClass(h('Sng'), 'java.lang.Float');
            valS = h('Sng').floatValue();
            testCase.verifyEqual(valS, 2.5, 'AbsTol', 1e-6);
            % alternatively:
            % testCase.verifyEqual(single(valS), single(2.5));

            % Byte (boxed Byte; .byteValue() -> MATLAB double)
            testCase.verifyClass(h('I8'), 'java.lang.Byte');
            testCase.verifyEqual(h('I8').byteValue(), double(int8(-8)));

            testCase.verifyClass(h('U8'), 'java.lang.Byte');
            testCase.verifyEqual(h('U8').byteValue(), double(int8(8)));
            % NOTE: For uint8 > 127, Java byte will wrap; consider mapping to Short
            % if unsigned semantics are required.

            % Short (boxed Short; .shortValue() -> MATLAB double)
            testCase.verifyClass(h('I16'), 'java.lang.Short');
            testCase.verifyEqual(h('I16').shortValue(), double(int16(-16)));

            testCase.verifyClass(h('U16'), 'java.lang.Short');
            testCase.verifyEqual(h('U16').shortValue(), double(int16(16)));

            % Integer (boxed Integer; .intValue() -> MATLAB double)
            testCase.verifyClass(h('I32'), 'java.lang.Integer');
            testCase.verifyEqual(h('I32').intValue(), double(int32(-32)));

            testCase.verifyClass(h('U32'), 'java.lang.Integer');
            testCase.verifyEqual(h('U32').intValue(), double(int32(32)));

            % Long (boxed Long; .longValue() -> MATLAB double)
            testCase.verifyClass(h('I64'), 'java.lang.Long');
            testCase.verifyEqual(h('I64').longValue(), double(int64(-64)));

            testCase.verifyClass(h('U64'), 'java.lang.Long');
            testCase.verifyEqual(h('U64').longValue(), double(int64(64)));
        end

        function testArraysBecomeArrayList(testCase)
            builder = BuilderStub();
            opts = struct();

            % Numeric row vector -> ArrayList of java.lang.Double
            opts.Numbers = [10 20 30];

            % Cell array mixed -> ArrayList (elements individually converted)
            opts.Mixed = { "x", 7, true };

            h = aws.internal.builder.build(builder, opts);

            % Numbers
            testCase.verifyClass(h('Numbers'), 'java.util.ArrayList');
            testCase.verifyEqual(h('Numbers').size(), 3);
            for k = 0:2
                elem = h('Numbers').get(k);
                testCase.verifyClass(elem, 'double');
            end
            testCase.verifyEqual(h('Numbers').get(0), 10);
            testCase.verifyEqual(h('Numbers').get(1), 20);
            testCase.verifyEqual(h('Numbers').get(2), 30);

            % Mixed
            testCase.verifyClass(h('Mixed'), 'java.util.ArrayList');
            testCase.verifyEqual(h('Mixed').size(), 3);
            testCase.verifyClass(h('Mixed').get(0), 'char');
            testCase.verifyClass(h('Mixed').get(1), 'double');
            testCase.verifyClass(h('Mixed').get(2), 'logical');
        end

        function testDictionaryToHashMap_NonEmptyAndEmpty(testCase)
            % Requires R2022b+ (dictionary)
            builder = BuilderStub();

            % Non-empty: includes scalar; and array wrapped in cell per code path
            D = dictionary(...
                ["Region","Thresholds","Label"], ...
                { "us-east-1", {[1 2 3]}, "prod" } ...
                );

            % Empty dictionary
            E = dictionary(string.empty, cell.empty);

            opts = struct();
            opts.DictNonEmpty = D;
            opts.DictEmpty    = E;

            h = aws.internal.builder.build(builder, opts);

            % Non-empty checks
            testCase.verifyClass(h('DictNonEmpty'), 'java.util.HashMap');
            testCase.verifyTrue(h('DictNonEmpty').containsKey("Region"));
            testCase.verifyTrue(h('DictNonEmpty').containsKey("Thresholds"));
            testCase.verifyTrue(h('DictNonEmpty').containsKey("Label"));

            vRegion = h('DictNonEmpty').get("Region");
            testCase.verifyClass(vRegion, 'java.util.ArrayList');
            testCase.verifyEqual(string(vRegion), "[us-east-1]");

            vLabel = h('DictNonEmpty').get("Label");
            testCase.verifyClass(vLabel, 'java.util.ArrayList');
            testCase.verifyEqual(string(vLabel), "[prod]");

            vThresh = h('DictNonEmpty').get("Thresholds");
            testCase.verifyClass(vThresh, 'java.util.ArrayList');
            testCase.verifyEqual(vThresh.size(), 1);
            testCase.verifyClass(vThresh.get(0), 'java.lang.Object[]');

            % Empty dictionary checks
            testCase.verifyClass(h('DictEmpty'), 'java.util.HashMap');
            testCase.verifyEqual(h('DictEmpty').size(), 0);
        end

        function testUnsupportedTypeErrors(testCase)
            import matlab.unittest.constraints.Throws

            builder = BuilderStub();
            opts = struct();
            opts.When = datetime('now');  % Not supported -> triggers error in matlabToJava
            testCase.verifyError(@() aws.internal.builder.build(builder, opts), 'aws:builder:UnsupportedType');
        end

        function testBuilderMethodThrowsAndIsRethrown(testCase)
            builder = BuilderStub();
            opts = struct();
            opts.Throw = "boom";

            % Most robust: assert identifier
            testCase.verifyError(@() aws.internal.builder.build(builder, opts), 'aws:builder:UnknownField');

        end

        function testStructToHashMap(testCase)
            % This test assumes convertStructToJavaMap is fixed as:
            %  - use fields = fieldnames(matlabStruct)
            %  - use val = matlabStruct.(key) inside the loop
            % If not fixed, we skip the test to avoid failing the suite.
            builder = BuilderStub();
            S = struct('A', 1, 'B', "x", 'C', true);
            opts = struct();
            opts.Struct = S;

            h = aws.internal.builder.build(builder, opts);


            testCase.verifyClass(h('Struct'), 'java.util.HashMap');
            testCase.verifyEqual(h('Struct').get('A'), 1);
            testCase.verifyEqual(string(h('Struct').get('B')), "x");
            testCase.verifyTrue(h('Struct').get('C'));
        end
    end
end