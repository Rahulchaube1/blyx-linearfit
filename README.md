<img src="assets/logo.png" width="88" height="88" alt="Blyx LinearFit logo">

# Blyx LinearFit

Train, merge and deploy a single-feature least-squares or ridge regression with an unpenalized intercept. Train on one numerical feature with an intercept. Retain a compact state for an incoming stream, merge states from separate batches, or fit vectors in one call. The command-line program trains from a real CSV and can make a prediction in the same invocation.

## Use it in a project

Install [Blyx 0.2.1](https://github.com/Rahulchaube1/blyxxxx/releases/tag/v0.2.1), Rust 1.85 or newer, and a host linker for native compilation. From the directory containing your entry file, pin the library with Git.

```sh
git clone --depth 1 --branch v0.1.0 https://github.com/Rahulchaube1/blyx-linearfit.git vendor/linearfit
```

Save this program as `main.blyx` beside `vendor` and run `blyxc native-run main.blyx`.

```blyx
use vendor::linearfit::linearfit;
fn main() {
    let training = lf_fit([1, 2, 3, 4], [3, 5, 7, 9], 0.0);
    println!(at(training, 2));
    println!(lf_predict(training, 5.0));
}
```

Expected output:

```text
2
11
```

[Run this example in your browser](https://www.blyx-lang.space/play?example=package-linearfit)

## Command-line tool

Extract [the release archive](https://github.com/Rahulchaube1/blyx-linearfit/releases/tag/v0.1.0) for Windows x64, Linux x64 or Apple Silicon macOS. Verify the archive against `SHA256SUMS`. The archive includes example CSV files. In PowerShell start the executable with `.\linearfit.exe`. The x64 Windows executable uses the Microsoft Visual C++ runtime.

```sh
./linearfit fixtures/line.csv --predict 5
```

## API and data contract

| Function | Result |
| --- | --- |
| `lf_fit(xs, ys, penalty)` | Fit aligned finite vectors and return [mean_x, mean_y, slope]. |
| `lf_start()`, `lf_update(state, x, y)`, `lf_merge(a, b)` | Start, update or merge disjoint training batches. |
| `lf_finish(state, penalty)` | Finalize a reusable model after at least two observations. |
| `lf_predict(model, x)` | Evaluate mean_y + slope × (x − mean_x). |

The slope is Sxy/(Sxx + penalty). The objective is the sum of squared errors plus penalty × slope². A penalty of zero gives ordinary least squares. A positive penalty gives a constant predictor when x never varies. Constant x with zero penalty, a negative penalty, and invalid or unrepresentable input return an empty model. An invalid prediction returns NaN. Keeping the model centered avoids explicitly forming a large intercept.

The CLI accepts the literal header `x,y` and two unquoted numeric columns per nonblank row. It reads a UTF-8 file, supports LF and CRLF, and reports the physical line of invalid data. Its JSON report includes the training row count, means, slope, ridge penalty and optional prediction. Exit status is 0 for a fit, 2 for a data or option error and 4 for an I/O failure. The library keeps constant training state. The CLI reads the input file into memory.

## Contribute

Clone this repository, run `blyxc native-run tests.blyx` and `blyxc native-run example.blyx`, and include a failing example with any behavior change. Include the compiler version, inputs and expected output in bug reports. [Open a package issue](https://github.com/Rahulchaube1/blyx-linearfit/issues) · [Blyx handbook](https://doc.blyx-lang.space/guide/training-and-monitoring) · [Ecosystem catalog](https://www.blyx-lang.space/packages)
