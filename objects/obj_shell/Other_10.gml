variable_global_set("sh_help", function(arg0)
{
    if (array_length(arg0) > 1)
    {
        var helpFunction = arg0[1];
        
        if (array_contains(allFunctions, helpFunction))
        {
            if (variable_struct_exists(functionData, helpFunction))
            {
                var metadata = variable_struct_get(functionData, helpFunction);
                var output = helpFunction;
                
                if (variable_struct_exists(metadata, "arguments"))
                {
                    for (var i = 0; i < array_length(metadata.arguments); i++)
                        output += (" " + metadata.arguments[i]);
                }
                
                if (variable_struct_exists(metadata, "description"))
                    output += (" - " + metadata.description);
                
                output += "\n";
                
                if (variable_struct_exists(metadata, "argumentDescriptions"))
                {
                    for (var i = 0; i < array_length(metadata.argumentDescriptions); i++)
                    {
                        var argName = metadata.arguments[i];
                        var desc = metadata.argumentDescriptions[i];
                        output += (argName + " - " + desc + "\n");
                    }
                }
                
                return output;
            }
            else
            {
                return helpFunction + "\nNo additional information present";
            }
        }
        else
        {
            return "No command [" + helpFunction + "] exists.";
        }
    }
    else
    {
        var output = "List of available commands:\n";
        var hiddenCount = 0;
        
        for (var i = 0; i < array_length(availableFunctions); i++)
        {
            var functionName = availableFunctions[i];
            var hidden = false;
            var metadata = variable_struct_get(functionData, functionName);
            
            if (!is_undefined(metadata))
            {
                if (variable_struct_exists(metadata, "hidden"))
                {
                    hidden = metadata.hidden;
                    hiddenCount += 1;
                }
            }
            
            if (!hidden)
            {
                var terminator = "";
                
                if (((i - hiddenCount) % 2) == 0)
                {
                    var paddingWidth = (width / 2) - (anchorMargin + string_width(functionName));
                    var spaceCount = paddingWidth / string_width(" ");
                    
                    repeat (spaceCount)
                        terminator += " ";
                }
                else
                {
                    terminator = "\n";
                }
                
                output += (functionName + terminator);
            }
        }
        
        return output;
    }
});
variable_global_set("meta_help", function()
{
    return 
    {
        arguments: ["<command name>"],
        suggestions: [availableFunctions],
        description: "display available commands",
        argumentDescriptions: ["optional name of a command to display detailed help information for."]
    };
});
variable_global_set("sh_clear", function(arg0)
{
    if (array_length(arg0) > 1 && arg0[1] == "all")
    {
        array_resize(output, 0);
        array_resize(history, 0);
        return "";
    }
    else
    {
        array_push(output, ">" + consoleString);
        draw_set_font(consoleFont);
        var _newLinesCount = floor(visibleHeight / string_height(prompt));
        
        repeat (_newLinesCount)
            array_push(output, "\n");
        
        return "";
    }
});
variable_global_set("meta_clear", function()
{
    return 
    {
        arguments: ["<all>"],
        suggestions: [["all"]],
        description: "clear the console window",
        argumentDescriptions: ["If provided, previous console output and command history will be deleted."]
    };
});