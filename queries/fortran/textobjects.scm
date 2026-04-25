; Author: Shion Shimizu 
; update: 2026-04-25

; class objects

((program
  (program_statement)
  .
  (_)+ @class.inner
  . 
  (end_program_statement))) @class.outer

((derived_type_definition
  (derived_type_statement)
  .
  (_)+ @class.inner
  . 
  [
  (derived_type_procedures)
  (end_type_statement)
  ])) @class.outer

((derived_type_procedures
  (contains_statement)
  .
  (_)+ @class.inner
  . 
  ))

((module
  (module_statement)
  .
  (_)+ @class.inner
  . 
  (end_module_statement))) @class.outer

((submodule
  (submodule_statement)
  .
  (_)+ @class.inner
  . 
  (end_submodule_statement))) @class.outer

((interface
  (interface_statement)
  .
  (_)+ @class.inner
  . 
  (end_interface_statement))) @class.outer

; function objects

((function
  (function_statement)
  .
  (_)+ @function.inner
  .
  (end_function_statement))) @function.outer

((subroutine
   (subroutine_statement)
   .
   (_)+ @function.inner
   .
   (end_subroutine_statement))) @function.outer
  
((module_procedure
   (module_procedure_statement)
   .
   (_)+ @function.inner
   .
   (end_module_procedure_statement))) @function.outer

; loop objects

((do_loop
  (do_statement)
  . 
  (_)+ @loop.inner
  .
  (end_do_loop_statement))) @loop.outer

; conditional objects

(if_statement) @conditional.outer

((if_statement
   (parenthesized_expression)
   . 
   (_)+ @conditional.inner
   .
   [
    (elseif_clause)
    (else_clause)
    (end_if_statement)
   ]))

((elseif_clause 
  (parenthesized_expression)
  . 
  (_)+ @conditional.inner
  .
  ))

((else_clause 
  . 
  (_)+ @conditional.inner
  .
  ))

(select_case_statement) @conditional.outer

(select_case_statement
   (selector)
   . 
   (_)+ @conditional.inner
   .
   [
   (end_select_statement)
   (case_statement)
   ]) @conditional.outer

((case_statement 
  (_)
  . 
  (_)+ @conditional.inner
  .
  ))

(select_type_statement) @conditional.outer

(select_type_statement
   (selector)
   . 
   (_)+ @conditional.inner
   .
   [
   (end_select_statement)
   (type_statement)
   ]) @conditional.outer

((type_statement 
  (_)
  . 
  (_)+ @conditional.inner
  .
  ))

; block objects

((block_construct
   .
   (_)+ @block.inner
   .
   (end_block_construct_statement))) @block.outer
