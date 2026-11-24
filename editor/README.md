# Blyx LinearFit

Train, merge and deploy a single-feature least-squares or ridge regression with an unpenalized intercept.

This extension includes the Blyx LinearFit 0.1.1 source, a runnable example and completions for its public functions. It uses the Blyx Language extension for syntax highlighting and execution.

## Bilinear regression on paired features

Train a bilinear regression with factored examples, resume SGD, predict new pairs and query individual coefficients without allocating a dense weight matrix. [Commands and worked example](https://github.com/Rahulchaube1/blyx-linearfit/blob/v0.2.0/SCALE.md) · [Measurements and source data](https://www.blyx-lang.space/articles/training-in-factors)

## Run in the editor

1. Open an empty file named `linearfit-demo.blyx`.
2. Type `blyx-linearfit-demo` and select **LinearFit — runnable example**. You can also use **Snippets: Fill File with Snippet**.
3. Choose **Blyx: Run File** from the command palette. Change an argument near the end of `fn main()` to try another input.

Expected output

```text
2
11
```

## Use LinearFit in a project

Extract the starter into a new folder. It contains `main.blyx`, the licensed framework source in `vendor/linearfit`, and a VS Code task. With the Blyx 0.2.1 compiler and host toolchain installed, run `blyxc native-run main.blyx` from that folder. Type `blyx-linearfit-` in a Blyx file to see the framework completions. [Download the starter ZIP](https://github.com/Rahulchaube1/blyx-linearfit/releases/download/v0.2.0/blyx-linearfit-starter-0.2.0.zip)

[API and input requirements](https://www.blyx-lang.space/packages/linearfit) · [Framework source](https://github.com/Rahulchaube1/blyx-linearfit/tree/v0.2.0) · [Report an issue](https://github.com/Rahulchaube1/blyx-linearfit/issues)

[GitHub Sponsors](https://github.com/sponsors/Rahulchaube1) · [Buy Me a Coffee](https://buymeacoffee.com/rahulchaube)
