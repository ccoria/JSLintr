
var jslintr_v8 = function (src_string) {
    var options = {rhino: true, passfail: false}
    var lint_was_ok = JSLINT(src_string, options);

    if (lint_was_ok) {
    	print("OK");
    } else {
        var errors = JSLINT.errors;
    	print(errors.length + " errors found:\n")
	
    	for (var i = 0; i < errors.length; i++) {
    	    //debug_options(errors[i]);
	    
    	    // To handle when jslint stops scan a file (too many errors)
    	    if (errors[i] !== null) {
    	        var line = parseInt(errors[i].line, 10) - 1;
                print("\t" + line + ":" + errors[i].reason);
            }
    	}
    }
};

jslintr_v8( read(arguments) );
