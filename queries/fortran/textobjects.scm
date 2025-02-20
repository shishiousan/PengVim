(derived_type_definition) @class.outer

((derived_type_definition
  (derived_type_statement)
  .
  (_) @_start
  (_)? @_end
  . 
  [
  (derived_type_procedures)
  (end_type_statement)
  ]) 
  (#make-range! "class.inner" @_start @_end))

((derived_type_procedures
  (contains_statement)
  .
  (_) @_start
  (_)? @_end
  . 
  )
  (#make-range! "class.inner" @_start @_end))

(program) @class.outer

((program
  (program_statement)
  .
  (_) @_start
  (_)? @_end
  . 
  (end_program_statement)) 
  (#make-range! "class.inner" @_start @_end)) 

(module) @class.outer

((module
  (module_statement)
  .
  (_) @_start
  (_)? @_end
  . 
  (end_module_statement)) 
  (#make-range! "class.inner" @_start @_end)) 

(module) @class.outer

(submodule) @class.outer

((submodule
  (submodule_statement)
  .
  (_) @_start
  (_)? @_end
  . 
  (end_submodule_statement)) 
  (#make-range! "class.inner" @_start @_end)) 

(interface) @class.outer

((interface
  (interface_statement)
  .
  (_) @_start
  (_)? @_end
  . 
  (end_interface_statement)) 
  (#make-range! "class.inner" @_start @_end)) 

(function) @function.outer

((function
  (function_statement)
  .
  (_) @_start
  (_)? @_end 
  .
  (end_function_statement))
  (#make-range! "function.inner" @_start @_end))

(subroutine) @function.outer

((subroutine
   (subroutine_statement)
   .
   (_) @_start
   (_)? @_end
   .
   (end_subroutine_statement))
   (#make-range! "function.inner" @_start @_end))
  
(module_procedure) @function.outer

((module_procedure
   (module_procedure_statement)
   .
   (_) @_start
   (_)? @_end
   .
   (end_module_procedure_statement))
   (#make-range! "function.inner" @_start @_end))

(do_loop_statement) @loop.outer

((do_loop_statement
  (_)
  . 
  (_) @_start
  (_)? @_end
  .
  (end_do_loop_statement))
  (#make-range! "loop.inner" @_start @_end))

(if_statement) @conditional.outer

; NOTE: this does not work when the inner has only one line

((if_statement
   (parenthesized_expression)
   . 
   (_) @_start
   (_)? @_end
   .
   [
    (elseif_clause)
    (else_clause)
    (end_if_statement)
   ])
   (#make-range! "conditional.inner" @_start @_end))

((elseif_clause 
  (parenthesized_expression)
  . 
  (_) @_start
  (_)? @_end 
  .
  )
  (#make-range! "conditional.inner" @_start @_end))

((else_clause 
  . 
  (_) @_start
  (_)? @_end 
  .
  )
  (#make-range! "conditional.inner" @_start @_end))

(select_case_statement) @conditional.outer

(select_case_statement
   (selector)
   . 
   (_) @_start 
   (_)? @_end
   .
   [
   (end_select_statement)
   (case_statement)
   ]
   (#make-range! "conditional.inner" @_start @_end))

((case_statement 
  (_)
  . 
  (_) @_start
  (_)? @_end 
  .
  )
  (#make-range! "conditional.inner" @_start @_end))

(select_type_statement) @conditional.outer

(select_type_statement
   (selector)
   . 
   (_) @_start 
   (_)? @_end
   .
   [
   (end_select_statement)
   (type_statement)
   ]
   (#make-range! "conditional.inner" @_start @_end))

((type_statement 
  (_)
  . 
  (_) @_start
  (_)? @_end 
  .
  )
  (#make-range! "conditional.inner" @_start @_end))

(block_construct) @block.outer

((block_construct
   .
   (_) @_start
   (_)? @_end
   .
   (end_block_construct_statement))
   (#make-range! "block.inner" @_start @_end))
