
var file_name = arguments;
var file = readFile(arguments);
var options = {rhino: true, passfail: false}
var lint_was_ok = JSLINT(file, options);

if (lint_was_ok) {
	print("OK");
} else {
	var errors = JSLINT.errors;
	print(errors.length + " errors found:\n")
	
	for (var i = 0; i < errors.length; i++) {
		print("\t" + errors[i].reason);
	}
}