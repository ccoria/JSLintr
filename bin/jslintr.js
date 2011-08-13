
var file_name = arguments;
print("\nAnalyzing: " + file_name);
print("\n=================================")
var file = readFile(arguments);
var options = {rhino: true, passfail: false}

// finally passing JSLINT
if (false === JSLINT(file, options)) {
	var errors = JSLINT.errors;
	print(errors.length + " errors found!")
	
	for (var i = 0; i < errors.length; i++) {
		print(errors[i].reason);
	}
}