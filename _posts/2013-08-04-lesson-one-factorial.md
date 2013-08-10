---
layout: default
title: "Lesson One: Factorial"
---

In what follows I will assume that you have been able to launch a Lisp REPL (Read-Eval-Print-Loop), which is basically an interpreter, and you are waiting eagerly at the command prompt to begin hacking.

As a sort of tradition, introductory texts on programming languages explain the reader how to wield the new language so as to cause the computer to display "Hello, World!" or the equivalent thereof. Since neither

    "Hello, World!"

nor

    (format t "Hello, World!")

look exciting even though each one makes the Lisp REPL display the desired greeting, I decided to take a more ambitious first step: writing a function to compute the factorial of a number.

To do that, I need to know how to define a (recursive) function with one parameter. If we stop here for a moment and look at the two ways to implement "Hello, World!" above, we should notice that the difference between them is that #2 looks like a function call, while #1 does not. In #2, ```format``` is the name of the function, and the rest within the parentheses are its actual parameters.

Now I know what I need in the end: I want to be able to write

    (fact 5)

and have the REPL return with the factorial of the number 5, that is, 120. So far so good.

Luckily, the Lisp syntax required to define a function is not complicated at all. Essentially, you need something like

    (defun <function name> (<parameters>) <body>)

Let's try that!

    (defun fact (n)
      if (> 2 n)
      (1)
      (* n fact (- n 1)))

Nice try; however, the REPL will have problems with it. Unfortunately, it is not going to tell you that "hey, looks like you're trying write in two languages at the same time", but you'll see warnings about undefined variables `if` and `fact`, and an error about an illegal function call `(1)`. Now what?

The problem with `if` is that it should follow the same syntax as that of a function call. So you'll need to change the code such that the `if` structure is in another parentheses. The problem with `fact` is pretty much the same. If you now hope that getting these two problems right will also eliminate the third...

    (defun fact (n)
      (if (> 2 n)
        (1)
        (* n (fact (- n 1)))))

...you will be sorry to learn that it won't. In a number of languages you are allowed to use parentheses in expressions relatively freely. For example, you may change `2 + 3 * 5` to `2 + (3 * 5)` just to visually stress the priorities of operations. Also, you may just write `(2) + (3 * 5)` if you want to express some semantics that the two terms in parens may have. But Lisp is different.

In Lisp, `1` stands for the number one, while `(1)` stands for an s-expression that in this particular case will be considered a Lisp form, and the REPL will try to evaluate it. You now see why the REPL complains about an illegal function call: what we wrote means we wanted to call the function `1` without parameters. Unfortunately no such function exists, moreover, this is also an illegal function name, because it can be interpreted as a decimal number. (As a side note, it is worth studying the rules determining which names are valid choices for a function.) Let's fix this last problem and see what happens.

    (defun fact (n)
      (if (> 2 n)
        1
        (* n (fact (- n 1)))))

You'll probably get a warning that you are trying to redefine `fact`, but that's fine, because that's exactly what we are after now.

Before we call it a day, let's check something fun. If you wrote factorial calculation in other languages, you probably tested which is the largest number the factorial of which may be represented, at least approximately, within the limits of the numerical representation. So, what is this number for Lisp?

You would think at first that Lisp probably uses the same floating point representation as any other language for a ton of reasons, and I can assure you that you are right. However, the above function *will not use floating point representation* to compute the result, but Lisp's bignum representation instead. Give it a try.

