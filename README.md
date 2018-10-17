# CustomPreprocessor

CustomPreprocessor is a python script that parses and substitutes custom macros definitions, using it own style in order to differentiate from C-style macros.

## How to use

The usage is simple, just call the script with python 3 in the following way:  

```
python(3) CustomPreprocessor.py InputFile.prep -o OutputFile 
```

The output file is optional and, if not present, it will save as the input file minus the .prep extension.  

The input file should have a .prep extension.


## Syntax

The syntax is simple and very C-like:  
  
Defining:
- The line should start with '$', with or without a space before.  
- The '$' should be followed by "def ".
- Then a definition name.  
- After the definition name, a '(' should be used to indicate the args.  
- Then the args (if any) should be declared, separated by ','.  
- A ')' should be used to indicate that the arguments ended.  
- Then ": " should be used to indicate the end of the definition. This should include the space.  
- After that, the replacement expression can be declared. In order to use any arguments, prepend the arg with a '!'.  
- If the line ends with '\', the following line is considered too.  
  
Usage:  
- The line should start with '$', with or without spaces before.  
- The '$' should be followed by "use ".  
- After the use keyword, the definition name that you would like to call.  
- After the definition name, a '(' should be used to indicate the args.  
- Then the args (if any) should be passed, separated by ','.  
- A ')' should be used to indicate that the arguments ended.  

### Example

The following example with an interface declaration in Objective-C:  
```
$def define_interface(a, b): @interface !a : !b @end
```
It starts with "$def" because it's an instruction to the preprocessor.  
The definition name is "simple_macro".  
To use, an argument should be passed, that's 'a'.  
The ": " separates the definition and the replacement.  
"@interface !a : !b @end" is the replacement itself. Important to notice that the "!a" and "!b" will be replace with whatever is passed to "a" and "b".  
  
To use it:
```
$use define_interface(MyClassName, NSObject)
```

After processed, this line will be replaced with:  
```
@interface MyClassName : NSObject @end
```
  
Instructions can also be expanded, recursively:  
```
$def define_view(a): $use define_interface(!a, UIView)
```

In order for this one to work, the previous example should be declared in a previous line.  

If now I use it as following:  
Instructions can also be expanded, recursively:  
```
$use define_view(SomeClassView)
```

First, it will expand into:  
```
$use define_interface(SomeClassView, UIView)
```

This will be evaluated for a second time, expanding as following:  
```
@interface SomeClassView : UIView @end
```

Definitions can also be multi-line:  
```
$def define_interface(a): \
class !a { \
    friend !a call(const !a& other); \
};
```

If used like following:  
```
$use define_interface(Number)
```

Will expand to:  
```
class Number {
    friend Number call(const Number& other);
};
```

For this to work, the '\' should be the last thing in the line.  
  
Keep in mind that the '$' should be at the start of a line. If there is a non space character before it, the instruction will not be evaluated.  
  
This project includes an "example" folder, with a valid file with a ".prep" file that can be parsed.  
  
The required extension ".prep" is to prevent the user to override files accidentally.  
The script can be easily modified to remove it.
