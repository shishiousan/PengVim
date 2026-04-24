(identifier) @variable
(string_literal) @string
(number_literal) @number
(boolean_literal) @boolean
(comment) @comment

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
 ] @type

[
 "contains"
 "private"
 "public"
 ] @keyword.import

[
 (none)
 "implicit"
 ] @attribute

[
 "endfunction"
 "endprogram"
 "endsubroutine"
 "function"
 "procedure"
 "subroutine"
 ] @keyword.function

[
  "end"
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
 "%"
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

; (end_module_procedure_statement) @keyword
; (end_submodule_statement) @keyword
; (end_module_statement) @keyword
; (end_subroutine_statement) @keyword
; (end_interface_statement) @keyword
; (end_function_statement) @keyword
; (end_do_loop_statement) @keyword

(parameters
  (identifier) @parameter)

(program_statement
  (name) @parameter)

(module_statement
  (name) @parameter)

(submodule_statement
  (module_name) (name) @parameter)

(end_program_statement
  (name) @parameter)

(end_module_statement
  (name) @parameter)

(end_submodule_statement
  (name) @parameter)

(end_interface_statement
  (name) @parameter)

(end_type_statement
  (name) @parameter)
