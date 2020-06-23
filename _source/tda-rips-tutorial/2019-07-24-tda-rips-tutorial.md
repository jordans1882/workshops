---
layout: post
title: "Rips Filtration Tutorial for the R-TDA Package"
author: "Robin Belton and Ben Holmgren"
date: "July 22, 2019"
---

{% include lib/mathjax.html %}


```
## Warning: package 'SVGMapping' is not available (for R version 3.6.1)
```

```
## Error in library(p, character.only = TRUE): there is no package called 'SVGMapping'
```


Introduction
============
Our ultimate goal is to understand Persistent Homology and be able to compute Persistence
Diagrams using the R-TDA package. In order to get there, we must first understand filtrations.
In this tutorial, we will work with the Vietoris Rips Filtration, or Rips Filtration for short.
Suppose we are given a finite set of points in $$\mathbb{R}^n$$ denoted by $$S$$. The set of points,
$$S$$, is topologically uninteresting. How can we make $$S$$ topologically interesting? Yes, you
guessed it - we can construct a Rips complex from the points in $$S$$!  The Rips Filtration is a
specific nested sequence of Rips Complexes over $$S$$ that can be later used to compute Persistent
Homology.

Objectives
==========
**TODO: Make objectives stronger.**

* Gain familiarity on $n$-simplices and simplicial complexes.
* Be able to construct a Rips Complex and Rips Filtration from a finite set of points in
$$\mathbb{R}^n$$.
* Learn a few exciting applications of the Rips Filtration.
* Compute a Rips Filtration from a finite set of points in $$\mathbb{R}^n$$ using the R-TDA package.

Theory
======

First we breifly describe the mathematical foundations behind a Rips Filtration including
simplicial complexes, filtrations, and the Rips complex.

### Triangle Appreciation

We construct a Rips Complex from simplices of varying dimensions which are dimensional
generalizations of triangles. More specifically, an *$$n$$-simplex* is the convex hull of $$n+1$$
affinely independent points.

![plot of chunk simplices_img](/figure/./2019-07-24-tda-rips-tutorial/simplices_img-1.png)


A simplicial complex is a nice way of combining simplices. In particular, a *simplicial complex*
is a finite collection of simplices, $$K$$, such that (1) if $$\sigma \in K$$ and $$\tau\leq \sigma$$,
then $$\tau \in K$$, and (2) if $$\sigma, \sigma'\in K$$, then $$\sigma\cap \sigma'$$ is either empty
or a face of both.

<center>

![](images/simplicialcomplex.svg){width=450px}

</center>

### Rips Complex

Now we explain how to construct a Rips complex from a finite set of points. Let $$S$$ be finite set
of points in $$\mathbb{R}^n$$. Let $$r\geq 0$$. The Rips complex of $$S$$ and $$r$$ is the abstract
simplicial complex of $$\text{VR}(r)$$, which consists of all subsets of diameter at most $$r$$:

$$ \text{VR}(r):=\{\sigma\subset S \mid \text{ diam}(\sigma)\leq r\}. $$

**TODO: Add definitions of ASC and faces, Change VR(r) to VR(S,r).**

Geometrically, this means we consider balls of radius, $$\frac{r}{2}$$, centered at each point in
$$S$$. Whenever $d$ balls have pairwise intersections, we add a $$d-1$$ simplex. For this tutorial,
we will use the standard Euclidan distance (unless stated otherwise) to compute a Rips complex. However, one could use any metric.

**Note:** Many people also define $$\text{VR}(r) :=\{\sigma\subset S \mid \text{diam}(\sigma)\leq 2r\}$$.
However, the algorithms used in the R-TDA package use the first definition.

<center>

![](images/ripscomplex.svg){width=500px}

</center>

### Filtrations

A *filtration* of a simplicial complex, $$K$$, is a nested sequence of subcomplexes starting at the
empty set and ending with the full simplicial complex i.e.,

$$\emptyset \subset K_1 \subset K_2 \subset ... \subset K.$$

<center>

![Example: Builing a Bobcat!](images/bobcat.svg){width=500px}

</center>

Going back to the Rips complex, we consider $$r$$ to be a free parameter. If we vary $$r$$, we get
different Rips complexes. There is often not a best choice for $$r$$, so why not look at all of
them!? Observe if we increase $$r$$, then we get a family of nested Rips complexes which gives rise
to the *Rips filtration*.

Let's work through an example. Let $$S:=\{(0,0),(1,0),(0,2),(1,2),(3,1)\}\subset \mathbb{R}^2$$. We
want to compute a Rips filtration on $$S$$ for all $$r\geq 0$$. Observe:

* when $$r=1$$, the balls of radius $$\frac{1}{2}$$ centered at $$(0,0)$$ and $$(1,0)$$ intersect which
means we add a 1-simplex between $$(0,0)$$ and $$(1,0)$$. Similarly, we add a 1-simplex between
$$(0,2)$$ and $$(1,2)$$.
* when $$r=2$$, we add a two more 1-simplices between $$(0,0), (0,2)$$, and $$(1,2), (1,0)$$.
* when $$r=\sqrt{5}$$, we add a 3-simplex and a 2-simplex.
* when $$r=\sqrt{10}$$, we add a 4-simplex.

Here is an illustration of the Rips filtration on $S$.

<center>

![](images/ripsfilt2.png){width=700px}

</center>

Applications of Rips Complexes and Filtrations
==============================================

Now that we have discussed the theory, let's talk about some of the applications! A Rips
filtration is used on point cloud data. A common form of these types of data are location data.
For example:

* Galaxy Data which provides coordinates of stars in different galaxies
* GPS coordinates of Airports on Earth

The Rips complex provides information on how close the data points are to each other. The
topological information given by taking a Rips filtration can be studied using Persistent
Homology (see next tutorial) which is often used to analyze these types of data.

Furthermore, Rips complexes are used in shape reconstruction. They are nice to use since these
complexes do not favor a specific type of alignment of the input. **TODO: Add citation to Attali paper.**

**Maybe add fractal dimension?**

These are just a few of the applications. There are many more!

Computing the Rips Filtration using the R-TDA Package
=====================================================

### Toy Example
First, let's go back to the example where $$S:=\{(0,0),(1,0),(0,2),(1,2),(3,1)\}$$. We will compute the Rips filtration using the R-TDA package.


```r
library(TDA) # upload TDA package

S <- cbind(c(0,1,0,1,3),c(0,0,2,2,1)) # write S into R

r <- 4 # limit of the filtration

maxdimension <- 2 # components , loops, and voids

S_RipsFilt <- ripsFiltration(S, maxdimension, r, dist = "euclidean")
```

Great! So how do we interpret the output?

The ripsFiltration function returns a list with a complex list, filtration values vector, a logical variable that states whether or not the values are in increasing order, and a matrix of the coordinates of the vertices if the Euclidean distance is used. The $i^{th}$ element of the complex are the vertices of the $i^{th}$ simplex. Additionally, the $i^{th}$ entry of the filtration values is the filtration value for when the $i^{th}$ simplex appears. See **TODO: reference CRAN documentation.** Let's check this out.


```r
S_RipsFilt$cmplx[[16]] #Access vertices for the 16th simplex in the list
```

```
## [1] 4 3 2 1
```

```r
S_RipsFilt$values[16] #Access filtration value for the 16th simplex in the list
```

```
## [1] 2.236068
```

Our output tells us that we add a 3-simplex when $$r=\sqrt{5}$$. This is exactly what we found
when we worked through this example by hand. Accessing the other complex and filtration value elements will help us verify the rest of the filtration computation we did earlier.

If we want to visualize the Rips complex when $$r = 2$$, we can run the following code.


```r
# Plot Rips Complex when r=2.

r <- 2 # limit of the filtration
maxdimension <- 2 # allow components, loops, and voids

S_RipsFilt <- ripsFiltration(S, maxdimension, r, dist = "euclidean")

lim <- rep(c(-1, 4), 2)
plot(NULL, type = "n", xlim = lim[1:2], ylim = lim[3:4],
     main = "Rips Complex for r = 2", xlab = "", ylab = "")
for (idx in seq(along = S_RipsFilt[["cmplx"]])) {
  polygon(S[S_RipsFilt[["cmplx"]][[idx]], , drop = FALSE],
          col = "pink", border = NA, xlim = lim[1:2], ylim = lim[3:4])
}
for (idx in seq(along = S_RipsFilt[["cmplx"]])) {
  polygon(S[S_RipsFilt[["cmplx"]][[idx]], , drop = FALSE],
          col = NULL, xlim = lim[1:2], ylim = lim[3:4])
}
points(S, pch = 16)
```

![plot of chunk visualization](/figure/./2019-07-24-tda-rips-tutorial/visualization-1.png)

### Non Euclidean Distance Example
Now we will compute a Rips filtration on $S$, but this time using the **TODO** distance.

### Providence Coffee Shops Location Data
Lastly, we will work through an example with real data!

References
==========


