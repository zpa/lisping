(defun qsort (numbers)
  (if (null numbers)
    ()
    (let ((smaller (remove-if #'(lambda (n) (> n (first numbers))) (rest numbers)))
        (larger (remove-if #'(lambda (n) (<= n (first numbers))) (rest numbers))))
      (append (qsort smaller) (cons (first numbers) (qsort larger))))))

