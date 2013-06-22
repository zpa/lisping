(defun split (pivot numbers smaller larger)
  (if (null numbers)
      (list smaller pivot larger)
      (let ((n (first numbers)))
        (if (< n pivot)
            (split pivot (rest numbers) (cons n smaller) larger)
            (split pivot (rest numbers) smaller (cons n larger))))))

(defun qsort (numbers)
  (if (null numbers)
    ()
    (let ((split-numbers (split (first numbers) (rest numbers) () ())))
      (append (qsort (first split-numbers))
              (cons (first numbers) (qsort (third split-numbers)))))))
