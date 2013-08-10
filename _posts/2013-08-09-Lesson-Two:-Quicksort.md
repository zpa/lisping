---
layout: default
title: "Lesson Two: Quicksort"
---

After having completed `fact`, or first Lisp function, let us look for a more ambitious challenge: implementing a sorting algorithm. Why not deal with quicksort while we are at it?

I assume you more or less know how quicksort is supposed to work. The brief sketch of the algorithm is the following: we take an arbitrary pivot element from the set to be ordered, and we split the set of remaining elements to two sets. The first one contains elements that are smaller than the pivot, and the second one holds the rest. We then recursively apply this scheme on the first and second sets, and obtain the result as a concatenation of (1) the sorted first set, (2) the pivot element and (3) the sorted second set.

It sounds pretty straightforward. After some thinking I arrived to the conclusion that splitting a set using an externally specified reference as the pivot is an operation that I will find useful when implementing quicksort. How do we do that in Lisp?

    (defun split (pivot numbers smaller larger)
      (if (null numbers)
          (list smaller pivot larger)
          (let ((n (first numbers)))
            (if (< n pivot)
                (split pivot (rest numbers) (cons n smaller) larger)
                (split pivot (rest numbers) smaller (cons n larger))))))

Let us take a closer look at how it works. It requires the `pivot` to be specified, as well as the set of `numbers` that we would like to split. Note that I am consistently using the word set, but the code presented above requires a sequence which can be given as an argument to `first` and `rest`. A list, that is.

`split` processes the list of numbers recursively so that at each recursive call the first element of numbers is added to either `smaller` or `larger`, depending on whether it is smaller than the pivot. When there are no more numbers left, `split` returns a list of three _things_: a list of smaller elements, the pivot element, and a list of the rest of the elements. Note that the first and third elements of the list returned are also lists. Perhaps closer to the Lisp Way would be to use Lisp's support for returning multiple values (`values`), but let us not bother for now.

`split` requires empty lists to be specified as inputs for parameters `smaller` and `larger`. Which looks pretty much like a detail that should not be exposed to the outside world. Closer to the Lisp Way would be to add a wrapper around split that does not force you to follow this convention, and define `split` as a 'local' function via `labels`. Again, let us not bother for now.

Having a useful tool like split makes it very easy to implement quicksort as follows:

    (defun qsort (numbers)
      (if (null numbers)
        ()
        (let ((split-numbers (split (first numbers) (rest numbers) () ())))
          (append (qsort (first split-numbers))
                  (cons (first numbers) (qsort (third split-numbers)))))))

Note how this code corresponds to the informal description of the algorithm I gave above. So that was fun!

...but wait a minute. Does it indeed take 13 lines of code in Lisp to implement quicksort? It didn't leave me sleep well, and when a friend pointed me to a five-liner implementation of quicksort in Haskell, I decided that I could do better than this.

Clearly, the weak spot is `split`, because the code of `qsort` looks fairly lean already, corresponding closely to how the algorithm can be described. A better solution is to have Lisp do the work for us, instead of implementing `split`. We need a way to select elements from a list based on some property, and the good news is, Common Lisp offers a number of ways to do that. Here is an improved implementation of quicksort using one of them, `remove-if`:

    (defun qsort (numbers)
      (if (null numbers)
        ()
        (let ((smaller (remove-if #'(lambda (n) (> n (first numbers))) (rest numbers)))
            (larger (remove-if #'(lambda (n) (<= n (first numbers))) (rest numbers))))
          (append (qsort smaller) (cons (first numbers) (qsort larger))))))

Nice.

One last note: `remove-if` has no idea itself how to decide what to remove from our list. Its power is in allowing the condition to be externally specified via an appropriate function. If the function returns `T`, then the condition is understood to be true for the given element. All `remove-if` does is to iterate through the list and check what the condition returns for the next element to decide the fate of that element. The function I used above for this purpose is a `lambda` function: basically an anonymous-function defined inline. Lisp provides a large number of utilities like `remove-if`, most of which can be adapted to the problem at hand in a similar functional manner. Studying them gets you closer to the Lisp Way.

