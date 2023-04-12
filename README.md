# Some user tree experiment thing

A simple experiment in the field of recursive tree traversal in haskell with a slant towards user authorization.

There is a [`Task`](./src/Projects/Task.hs) example that shows how we can create the recursive data structure as an optionally annotated fixed point type using the library [fixplate](https://hackage.haskell.org/package/fixplate).

We build a [demo tree](./src/Projects/Demo.hs) of this type to [report on using the generic traversals provided by fixplate](./src/Projects/Reporting.hs) and some [mocked data handling](./src/Projects/Database.hs). The results are then [printed out in a nice readable way](./src/Projects/PrettyPrint.hs).

```txt
\-- Epic: Budget: -14974.83, Net: +2221.81, Difference: +17196.64
     |-- Task 1 (1): Budget: -7026.08, Net: +2713.17, Difference: +9739.25
     |-- Task 2 (2): Budget: -871.68, Net: -1831.61, Difference: -959.93
     \-- Big Task: Budget: -7077.07, Net: +1340.25, Difference: +8417.32
          |-- Sub-Task 1 (4): Budget: -3823.39, Net: +1956.61, Difference: +5780.00
          \-- Sub-Task 2 (5): Budget: -3253.68, Net: -616.36, Difference: +2637.32
```

The second example takes this in the direction of user authorization. The goal of the example was to make a tree that represented user roles and permissions. Here, a role is a group that can contain more roles and/or leaf permissions. A permission is a leaf item that contains only the permission string.

The following tree is implemented in [`Auth/Demo`](./src/Auth/Demo.hs)

```txt
Roles and Permissions
 \-- Super Admin
      |-- create-all
      |-- delete-all
      \-- Admin
           |-- read-all
           |-- update-all
           |-- create-company
           |-- delete-company
           |-- Company Admin
           |    |-- read-company
           |    |-- update-company
           |    |-- create-user
           |    |-- read-user
           |    |-- update-user
           |    \-- delete-user
           \-- User
                |-- read-user
                \-- update-user
```

This can then be traversed in different ways

```txt
anyAuth ["create-all", "create-user"] accTree
 \-- Super Admin: True
      \-- Admin: True
           |-- Company Admin: True
           \-- User: False

allAuth ["create-company", "create-user"] accTree
 \-- Super Admin: True
      \-- Admin: True
           |-- Company Admin: False
           \-- User: False
```

So why would we want to do this though? Normal recursion on a data structure would work fine here. The fixedplate library phrases it well:

> There are many advantages of using fixed-point types instead of explicit recursion:
>
> - we can easily add attributes to the nodes of an existing tree;
> - there is no need for a custom type class, we can build everything on the top of Functor, Foldable and Traversable, for which GHC can derive the instances for us;
> - we can provide interesting recursion schemes
> - some operations can retain the structure of the tree, instead flattening it into a list;
> - it is relatively straightforward to provide generic implementations of the zipper, tries, tree drawing, hashing, etc...

Basically, we put in the effort up front to translate our data into a fixed-point type which allows us to define any number of interesting ways to traverse the type later, including changing the underlying semantics (e.g. by using `Any` vs `All`).
