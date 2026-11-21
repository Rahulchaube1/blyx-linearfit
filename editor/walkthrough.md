## Train a one-feature regression

Provide aligned finite x and y values. At least two rows are required. Set ridge to zero for ordinary least squares, or choose a positive penalty for shrinkage. The centered model keeps predictions stable for features with large offsets.

1. Open an empty file named `linearfit-demo.blyx`.
2. Type `blyx-linearfit-demo` and select **LinearFit — runnable example**. You can also use **Snippets: Fill File with Snippet**.
3. Choose **Blyx: Run File** from the command palette. Change an argument near the end of `fn main()` to try another input.

Expected output

```text
2
11
```

[Work through the example in the browser](https://www.blyx-lang.space/play?example=package-linearfit)
