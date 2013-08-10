---
layout: default
title: "Lesson Three: Eight Queens"
---

The problem called eight queens can be summarized in the following question:
how can you place eight queens on a chess board without any two being able to
capture each other? Two queens can capture one another if they are either on
the same row, or on the same column, or in the same diagonal.

There is much to be written up on this (you may want to check Wikipedia for a
detailed treatment), which I do not intend to repeat here. Although this problem
obviously appeared first in the context of chess, its generalization to placing
_n_ queens on an _n_-by-_n_ board is thoroughly studied in algorithmic complexity
theory. To avoid making debatable statements, I will just note that it is not
trivial to solve.

The non-triviality has two origins:

1.  there are multiple solutions to this problem (among which rotation and reflection define some symmetry groups), and
1.  although you may come up with some reasonable heuristic to provide _one_ good configuration, you need to explore (part of) the search space of 64 choose 8 possible configurations to provide _all_ possible good configurations. (In the next lesson, I will take a look at _n_ choose _k_ in more detail.)

The goodness of a solution that enumerates all possible good configurations is determined by how efficiently it cuts the search branches when exploring the solution space. Making clever choices here can be orders of magnitude more efficient than a naive brute-force approach.

What I mean by brute-force approach is the following. We assign an integer to each of the positions on the chess board from 1 to 64. We then enumerate all the possible ways in which eight of these 64 integers may be selected, and verify if the selected eight positions constitute a good configuration. This is obviously not something anyone would want to implement and try, because it would take a lot of time to run, and we would know that much of that time is spent on verifying configurations that would turn out to be wrong after looking at as few as two or three positions included.

If we apply a more clever encoding, we can save some verification work. We don't want to place queens in the same row or column, so we may use a permutation of integers from 1 to 8 to encode a possible configuration as follows. Let the first integer be the number of the row in which we place the queen in the first column. Let the second integer be the number of the row in which we place the queen in the second column. And so on. This leaves us with checking only the diagonal conflicts.

But we can do even better. What if we build our permutations recursively, and we check for diagonal conflicts already in partial permutations? The following implementation does that when called as `(eight-queens '(1 2 3 4 5 6 7 8) () () ())` and prints all good configurations.

    (defun eight-queens (numbers prefix diag-codes diag-codes-minus)
      (if (null numbers)
        (print prefix)
        (dolist (item numbers)
          (let ((n (+ 1 (length prefix))))
            (if (and (null (find (+ item n) diag-codes))
                     (null (find (- item n) diag-codes-minus)))
                (eight-queens (remove item numbers)
                  (append prefix (list item))
                  (cons (+ item n) diag-codes)
                  (cons (- item n) diag-codes-minus))
                ()))))) 

Some notes are in order here. First, a proper implementation would probably give you an interface like `(eight-queens)` or `(n-queens 8)` rather than exposing the internal helpers. It is an easy exercise to change this code into any of those via e.g. `labels` and some additional statements. Second, permutations might be constructed in reverse order, as well, to replace the `append` with a `cons`. Third, I need to explain how the diagonal conflict check works. Note that being on the same diagonal means that either the sum or the difference of the two coordinates of a position matches with those of another. So we not only build the permutation in `prefix`, but also the sums and differences of coordinates of positions in the `prefix`. That allows to check for diagonal conflicts of a candidate position to be added to the prefix given the sum and the difference of the coordinates of the candidate position.

A fun fact for closing: you have probably already noticed that the above code provides solutions to the n-queens problem, despite its name. So how many solutions do 5-queens and 6-queens have?

