(function) @function.outer

((function
  (function_statement)
  .
  (_) @_start
  (_)? @_end 
  .
  (end_function_statement))
  (#make-range! "function.inner" @_start @_end))
  
(do_loop_statement) @loop.outer

(if_statement) @conditional.outer
