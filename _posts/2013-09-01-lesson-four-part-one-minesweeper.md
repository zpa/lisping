---
layout: default
title: "Lesson Four, Part One: Minesweeper, Problem Statement
---

After having read much of
[Peter Seibel's excellent book](http://www.gigamonkeys.com/book/) on Lisp,
I thought it is time to take on a more difficult task. My friend, Peter,
deserves credit for pointing me to the problem described [here](http://dp.iit.bme.hu/dp06a/dp06a-nhf.html), which appears just what I was looking for.
For those who can't read Hungarian, or who are reluctant to wander in one-click distance, I give a description below. Before we get to that, however, let me
mention that this problem was given to students at the 2006/2007 autumn class
of Declarative Programming at
[Budapest University of Technology and Economics](http://www.bme.hu/?language=en).

You surely know the game Minesweeper, included for a long time with every
Windows installation. In the game, you are presented a rectangular table
divided into square fields, each of which appears empty at the beginning.
Any field in the table may hide exactly one mine. You are given the total
number of mines placed in random fields in the table, and your objective is
to locate all of them. You can explore the fields by clicking on them.
When you click on any field two things can happen. If you click on a field that
hides a mine, the game is over. If, on the other hand, you click on a field
that does not hide a mine, the field will display a number between 0 and 8,
indicating the number of neighboring fields that hide a mine. You have located
all the mines once you clicked on all fields in the table except for the
ones that hide the mines. If you can do that before a timer expires, you win.

The problem to solve can be stated as follows.
Given a partially explored table and the total number of mines, list all the
possible mine configurations.

You are given a text file as the input, with the following structure:

    5 5
    4
    1 3 0
    2 5 1
    ...

where the first row describes the dimensions of the table (number of rows,
number of columns), and the second row gives the total number of mines,
and all other rows describe already explored fields (row index, column
index, number of neighboring mines).

The output should list each possible table configuration with the given number
of mines. Sample input files are available from [here](http://dp.iit.bme.hu/dp06a/dp06a-nhf-ker.zip).

Regardless of how advanced your programming language is, the first thing you
need is an idea to build an algorithm on. There are no easy wins here: you need
a carefully designed search procedure. There appear two handles on this
problem: explored fields and mines, each of which could be used as cornerstones
to organize your search around.
I figured
that if I try to find mine locations, all I need is a set of well defined and simple
rules to update the state of the table, which will lead to simple and efficient
code. On the other hand, it was not obvious at first how one can organize the search around the explored fields, so I started with the mine-oriented approach.

It turned out, I would have been better off choosing the field-oriented one.
But let's not jump to conclusions yet. In part two of this lesson, I will
discuss how I solved this problem in Lisp.

