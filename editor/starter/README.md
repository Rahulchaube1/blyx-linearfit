# LinearFit starter

Train, merge and deploy a single-feature least-squares or ridge regression with an unpenalized intercept.

Open the extracted folder in VS Code. With Blyx 0.2.1 and its host toolchain installed, choose **Terminal → Run Task → Run LinearFit** or run the following command in this directory.

```sh
blyxc native-run main.blyx
```

Expected output

```text
2
11
```

The vendor directory contains the framework source for 0.1.1 and its license texts. [Read the API guide](https://www.blyx-lang.space/packages/linearfit) · [View the release](https://github.com/Rahulchaube1/blyx-linearfit/releases/tag/v0.2.0)

## Scale example

Train a bilinear regression with factored examples, resume SGD, predict new pairs and query individual coefficients without allocating a dense weight matrix. Install this compiler and run the editable example from the starter directory.

~~~sh
cargo install --locked --git https://github.com/Rahulchaube1/blyxxxx --rev 120d6b6ec6df09ff018d7c18752fb3297b5e629d blyxc
blyxc native-run scale_example.blyx
~~~
