(identifier) @variable
(string_literal) @string
(number_literal) @number
(boolean_literal) @boolean
(comment) @comment
"%" @number
"null" @function

[
 (intrinsic_type)
 "allocatable"
 "attributes"
 "device"
 "dimension"
 "endtype"
 "global"
 "grid_global"
 "host"
 "import"
 "in"
 "inout"
 "intent"
 "optional"
 "out"
 "pointer"
 "type"
 "value"
 "generic"
 (end_type_statement)
 ] @type

[
 "contains"
 "private"
 "public"
 "abstract"
 "extends"
 "deferred"
 "non_overridable"
 ] @keyword.import

[
 (none)
 "implicit"
 "pass"
 ] @attribute

[
 "endfunction"
 "endprogram"
 "endsubroutine"
 "function"
 "procedure"
 "subroutine"
 "result"
 ] @keyword.function

[
  "module"
  "endmodule"
  "submodule"
  "endsubmodule"
  "bind"
  "call"
  "class"
  "continue"
  "cycle"
  "enumerator"
  "equivalence"
  "exit"
  "format"
  "goto"
  "include"
  "interface"
  "endinterface"
  "only"
  "parameter"
  "procedure"
  "endprocedure"
  "print"
  "program"
  "endprogram"
  "read"
  "return"
  "stop"
  "use"
  "write"
  "enum"
  "endenum"
  (default)
  (procedure_qualifier)
  (end_module_procedure_statement) 
  (end_submodule_statement) 
  (end_module_statement) 
  (end_subroutine_statement) 
  (end_interface_statement) 
  (end_function_statement) 
  (end_do_loop_statement) 
  (end_if_statement)
  (end_select_statement)
  (end_program_statement)
] @keyword

"return" @keyword.return

[
 "else"
 "elseif"
 "elsewhere"
 "endif"
 "endwhere"
 "if"
 "then"
 "where"
  "selectcase"
  "case"
  "select"
  "endselect"
  "selecttype"
  "classis"
  "typeis"
 ] @keyword.conditional

[
 "do"
 "enddo"
 "forall"
 "while"
 ] @keyword.repeat

[
 "*"
 "+"
 "-"
 "/"
 "="
 "<"
 ">"
 "<="
 ">="
 "=="
 "/="
 "//"
 "=>"
 ] @operator

[
 "\\.and\\."
 "\\.not\\."
 "\\.or\\."
 "\\.lt\\."
 "\\.gt\\."
 "\\.ge\\."
 "\\.le\\."
 "\\.eq\\."
 "\\.eqv\\."
 "\\.neqv\\."
 "\\.ne\\."
 ] @keyword.operator

;; Brackets
[
 "("
 ")"
 "["
 "]"
 "<<<"
 ">>>"
 ] @punctuation.bracket

;; Delimiter
[
 "::"
 ","
 (preproc_ifdef)
 ] @punctuation.delimiter


(function_statement
  (name) @function)

(end_function_statement
  (name) @function)

(subroutine_statement
  (name) @function)

(module_procedure_statement
  (name) @function)

(end_subroutine_statement
  (name) @function)

(end_module_procedure_statement
  (name) @function)

(subroutine_call
  (identifier) @function)

(keyword_argument
  name: (identifier) @keyword)

(derived_type_member_expression
  (type_member) @property)

(parameters
  (identifier) @namespace)

(program_statement
  (name) @namespace)

(end_program_statement
  (name) @namespace)

(module_statement
  (name) @namespace)

(end_module_statement
  (name) @namespace)

(submodule_statement
  (module_name) (name) @namespace)

(end_submodule_statement
  (name) @namespace)

(interface_statement
  (name) @namespace)

(end_interface_statement
  (name) @namespace)

(derived_type_statement 
  (type_name) @namespace)

(end_type_statement
  (name) @namespace)

(preproc_ifdef
  (identifier) @punctuation.delimiter)
