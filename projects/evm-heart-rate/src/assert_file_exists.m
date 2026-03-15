function assert_file_exists(p)
%ASSERT_FILE_EXISTS Throw a readable error if file is missing.
if ~isfile(p)
    error("Missing file: %s\nPut required inputs under the data/ folder (excluded from git).", p);
end
end
