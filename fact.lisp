(defun fact (n)
  (if (> 2 n)
    1
    (* n (fact (- n 1)))))

