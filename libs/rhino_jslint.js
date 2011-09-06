
var file_name = arguments;
var file = readFile(arguments);
var options = {rhino: true, passfail: false}
var lint_was_ok = JSLINT(file, options);


var debug_options = function (object) {
    for (prop in object) {
        if (object.hasOwnProperty(prop)) {
            print(prop + "=" + object[prop]);
        }
    }
};

if (lint_was_ok) {
	print("OK");
} else {
	var errors = JSLINT.errors;
	print(errors.length + " errors found:\n")
	
	for (var i = 0; i < errors.length; i++) {
	    //debug_options(errors[i]);
	    
	    // To handle when jslint stops scan a file (too many errors)
	    if (errors[i] !== null) {
            print("\t" + errors[i].reason);
        }
	}
}